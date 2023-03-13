Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7356B772D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCMMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCMMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:07:36 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94852A6D5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:07:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VdmSlH4_1678709252;
Received: from 30.97.49.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdmSlH4_1678709252)
          by smtp.aliyun-inc.com;
          Mon, 13 Mar 2023 20:07:33 +0800
Message-ID: <691acb44-aaa6-10a8-4b03-d2a3b68421e5@linux.alibaba.com>
Date:   Mon, 13 Mar 2023 20:07:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] erofs: avoid hardcoded blocksize for subpage block
 support
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230306100200.117684-1-jefflexu@linux.alibaba.com>
 <20230306100200.117684-2-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230306100200.117684-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 18:01, Jingbo Xu wrote:
> As the first step of converting hardcoded blocksize to that specified in
> on-disk superblock, convert all call sites of hardcoded blocksize to
> sb->s_blocksize except for:
> 
> 1) use sbi->blkszbits instead of sb->s_blocksize in
> erofs_superblock_csum_verify() since sb->s_blocksize has not been
> updated with the on-disk blocksize yet when the function is called.
> 
> 2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
> since the inode operated on may be an anonymous inode in fscache mode.
> Currently the anonymous inode is allocated from an anonymous mount
> maintained in erofs, while in the near future we may allocate anonymous
> inodes from a generic API directly and thus have no access to the
> anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
> anonymous inodes in fscache mode.
> 
> Be noted that this patch only gets rid of the hardcoded blocksize, in
> preparation for actually setting the on-disk block size in the following
> patch.  The hard limit of constraining the block size to PAGE_SIZE still
> exists until the next patch.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

...

>   static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
>   {
> +	size_t len = (1 << EROFS_SB(sb)->blkszbits) - EROFS_SUPER_OFFSET;


Here len could be < 0, I think we could calculate crc32 as below:

	size_t len = 1 << EROFS_SB(sb)->blkszbits;

...

	if (len > EROFS_SUPER_OFFSET)             (>= 2k)
		len -= EROFS_SUPER_OFFSET;

Thanks,
Gao Xiang
