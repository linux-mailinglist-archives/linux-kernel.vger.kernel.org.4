Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831986E1207
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDMQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDMQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:16:53 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6BCF;
        Thu, 13 Apr 2023 09:16:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vg0Kxv8_1681402607;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg0Kxv8_1681402607)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 00:16:48 +0800
Message-ID: <699f01a7-8c0e-98d9-d2c7-eaf08552f543@linux.alibaba.com>
Date:   Fri, 14 Apr 2023 00:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: linux-next: manual merge of the erofs tree with the vfs-idmapping
 tree
To:     Mark Brown <broonie@kernel.org>, Gao Xiang <xiang@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230413144651.3519980-1-broonie@kernel.org>
 <4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2023/4/13 23:49, Mark Brown wrote:
> On Thu, Apr 13, 2023 at 03:46:51PM +0100, broonie@kernel.org wrote:
> 
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
> 
> No, that's wrong.  This:

Thanks.  Actually I didn't update the corresponind xattr patches (just
rebase some older commits, also I'd like to avoid in the future, but
sometimes it's impossible at least if some RVB is added...)

I think it could be resolved as before by Stephen:
https://lore.kernel.org/r/20230412101942.75e3efa9@canb.auug.org.au

And which looks the same as below:

> 
> diff --cc fs/erofs/xattr.c
> index 015462763bdd5,a04724c816e5f..0000000000000
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@@ -483,12 -517,28 +513,25 @@@ static int xattr_entrylist(struct xattr
>    {
>    	struct listxattr_iter *it =
>    		container_of(_it, struct listxattr_iter, it);
> - 	unsigned int prefix_len;
> - 	const char *prefix;
> + 	unsigned int base_index = entry->e_name_index;
> + 	unsigned int prefix_len, infix_len = 0;
> + 	const char *prefix, *infix = NULL;
>   -	const struct xattr_handler *h;
> +
> + 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
> + 		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
> + 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
> + 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
> +
> + 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
> + 			return 1;
> + 		infix = pf->prefix->infix;
> + 		infix_len = pf->infix_len;
> + 		base_index = pf->prefix->base_index;
> + 	}
>    
> - 	prefix = erofs_xattr_prefix(entry->e_name_index, it->dentry);
>   -	h = erofs_xattr_handler(base_index);
>   -	if (!h || (h->list && !h->list(it->dentry)))
> ++	prefix = erofs_xattr_prefix(base_index, it->dentry);
>   +	if (!prefix)
>    		return 1;
>   -
>   -	prefix = xattr_prefix(h);
>    	prefix_len = strlen(prefix);
>    
>    	if (!it->buffer) {

Thanks,
Gao Xiang

