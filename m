Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5760C1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJYCz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiJYCzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4E13DE5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F3B0B819AC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE55C433D7;
        Tue, 25 Oct 2022 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666666518;
        bh=Muo9o2epnSLH7SzCZQsP556aks1UdauUOFGhRbrdGo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ppmycjqVUF3ze848ZhKyx4+YzVUHg3kN6VNFcAS1lZxhmXOeP3cLOuQuSkDEBRQv0
         Ru7Aqr80r68MK/BiNXz7+SRjwjyfjaSVJn1yRw6iM6DO9T6QV1INpbh6htCPo/QHY6
         3D/GpvZZHUQaQtlEU5AOfhD5bZJnLB2oH28ygn7kBHGtktRhSkrgj65Pl83gqGTa/k
         ew0w5THqCfiI6UE6UYTXA1yAp54hgMd9oLTDycd+qq5WOi3/wIf5UyOGY8BXkizn7n
         dkRZT2G7M21AHNuHOYIPH5RW9wSmB/Z+/N8HhAu7sB+kNEapsS55UOgV3Qn4G22TvL
         1hw9LikDwmmdQ==
Message-ID: <a3644a20-731f-70b8-a21f-de6ab6e7bb6c@kernel.org>
Date:   Tue, 25 Oct 2022 10:55:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] f2fs: remove batched_trim_sections node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221021153825.79614-1-frank.li@vivo.com>
 <20221021153825.79614-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021153825.79614-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/21 23:38, Yangtao Li wrote:
> This testing sysfs node has been deprecated for a long time,
> let's remove it.

Can you please merge this patch w/

[PATCH 1/2] f2fs: fix to correct invalid batched_trim_sections node

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h  | 3 ---
>   fs/f2fs/sysfs.c | 5 -----
>   2 files changed, 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6355a5683b7..9c480835adab 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1062,9 +1062,6 @@ struct f2fs_sm_info {
>   	/* a threshold to reclaim prefree segments */
>   	unsigned int rec_prefree_segments;
>   
> -	/* for batched trimming */
> -	unsigned int trim_sections;		/* # of sections to trim */
> -
>   	struct list_head sit_entry_set;	/* sit entry set list */
>   
>   	unsigned int ipu_policy;	/* in-place-update policy */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 3005e2783a25..926b7a844362 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -488,9 +488,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   			return -EINVAL;
>   	}
>   
> -	if (!strcmp(a->attr.name, "batched_trim_sections"))
> -		return -EINVAL;
> -
>   	if (!strcmp(a->attr.name, "gc_urgent")) {
>   		if (t == 0) {
>   			sbi->gc_mode = GC_NORMAL;
> @@ -790,7 +787,6 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
>   F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
>   F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
> -F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
>   F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
> @@ -919,7 +915,6 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(max_discard_issue_time),
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(pending_discard),
> -	ATTR_LIST(batched_trim_sections),
>   	ATTR_LIST(ipu_policy),
>   	ATTR_LIST(min_ipu_util),
>   	ATTR_LIST(min_fsync_blocks),
