Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A0638666
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKYJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiKYJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:41:12 -0500
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7C3AC2E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:41:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VVewUrY_1669369264;
Received: from 30.221.133.6(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VVewUrY_1669369264)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 17:41:05 +0800
Message-ID: <711323de-5a9f-db09-6105-319ff1ff52c1@linux.alibaba.com>
Date:   Fri, 25 Nov 2022 17:41:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] ocfs2: fix infinite loop for orphan entry list
Content-Language: en-US
To:     lihongweizz <lihongweizz@inspur.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20221125034118.427-1-lihongweizz@inspur.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20221125034118.427-1-lihongweizz@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/22 11:41 AM, lihongweizz wrote:
> Orphan file may be in the recover list already when the ip_next_orphan
> is NULL (for example, orphan file is second tail elementof recover
> list). In this scenario, the file could be added to the list twice
> and infinite loop happened. So we need another pointer value here(EFAULT)
>  instead of NULL for the list tail element.
> 

Don't understand how it happens. Is this a real issue you encountered?
When queue orphans, it will bypass those already in recover list.

Thanks,
Joseph

> Signed-off-by: lihongweizz <lihongweizz@inspur.com>
> ---
>  fs/ocfs2/journal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 126671e..4620013 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -2207,7 +2207,7 @@ static int ocfs2_recover_orphans(struct ocfs2_super *osb,
>  				 enum ocfs2_orphan_reco_type orphan_reco_type)
>  {
>  	int ret = 0;
> -	struct inode *inode = NULL;
> +	struct inode *inode = ERR_PTR(-EFAULT);
>  	struct inode *iter;
>  	struct ocfs2_inode_info *oi;
>  	struct buffer_head *di_bh = NULL;
> @@ -2224,7 +2224,7 @@ static int ocfs2_recover_orphans(struct ocfs2_super *osb,
>  	if (ret)
>  		mlog_errno(ret);
>  
> -	while (inode) {
> +	while (!IS_ERR(inode)) {
>  		oi = OCFS2_I(inode);
>  		trace_ocfs2_recover_orphans_iput(
>  					(unsigned long long)oi->ip_blkno);
