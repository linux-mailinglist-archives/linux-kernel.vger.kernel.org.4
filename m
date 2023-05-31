Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6AC717A20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjEaIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjEaIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:32:16 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5066107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:32:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VjwzqAQ_1685521932;
Received: from 30.221.128.130(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VjwzqAQ_1685521932)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 16:32:13 +0800
Message-ID: <a111bd89-df32-c88c-62c9-59b90b5fda9a@linux.alibaba.com>
Date:   Wed, 31 May 2023 16:32:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ocfs2: check new file size on fallocate call
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Heming Zhao <heming.zhao@suse.com>,
        akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20230529152645.32680-1-lhenriques@suse.de>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230529152645.32680-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/23 11:26 PM, Luís Henriques wrote:
> When changing a file size with fallocate() the new size isn't being
> checked.  In particular, the FSIZE ulimit isn't being checked, which makes
> fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fixes
> this issue.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index efb09de4343d..b173c36bcab3 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
>  	struct ocfs2_space_resv sr;
>  	int change_size = 1;
>  	int cmd = OCFS2_IOC_RESVSP64;
> +	int ret = 0;
>  
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>  		return -EOPNOTSUPP;
>  	if (!ocfs2_writes_unwritten_extents(osb))
>  		return -EOPNOTSUPP;
>  
> -	if (mode & FALLOC_FL_KEEP_SIZE)
> +	if (mode & FALLOC_FL_KEEP_SIZE) {
>  		change_size = 0;
> +	} else {
> +		ret = inode_newsize_ok(inode, offset + len);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		cmd = OCFS2_IOC_UNRESVSP64;
