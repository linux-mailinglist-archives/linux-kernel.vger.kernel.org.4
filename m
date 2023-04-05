Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389F6D7290
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjDECoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjDECoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8163A9F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577B9622B7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51673C433EF;
        Wed,  5 Apr 2023 02:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680662651;
        bh=B0fG8cDrSJuSDznhEKKjqRypY7IlcyPQWYknjOL91/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TqDL4650iHQQ4XJgPKE6jUNLNPE07IhUmhp0txUNL9Nc6Soy58PxSjBscDuItmmzb
         QOm2cMUtVMJ3/o6kSrAFMX+RwgcddNIZtiZJPavoohuC8MFmO+tBq/SG8wD9bgiVCs
         ruFaipp0phX492gv3+yNPwyOzJniOJ04cNyMeYxBdV0bHrtciiKlrNDK4jfKxwHOXJ
         6HuXo4xAqweFzIJTv6udZ3fe/NyPRGPL3UGx//vx46L6a9YE7uCjw/iXienGwbd3HT
         EV6TrRLdE5YdL6T1ZEBeH0C3fhdaAlBwNFm2mcRerT/8Yu5c2IkhnO0YWAYnFaddFV
         fZkgcY5tAn0iw==
Message-ID: <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
Date:   Wed, 5 Apr 2023 10:44:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: convert to use sysfs_emit
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230331113305.77217-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230331113305.77217-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 19:33, Yangtao Li wrote:
> Let's use sysfs_emit.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/sysfs.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 9ddc6ee19433..2c0b2cb05a3a 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -312,19 +312,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>   
>   	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
>   		struct ckpt_req_control *cprc = &sbi->cprc_info;
> -		int len = 0;
>   		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
>   		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
>   
> -		if (class == IOPRIO_CLASS_RT)
> -			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
> -		else if (class == IOPRIO_CLASS_BE)
> -			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
> -		else
> +		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
>   			return -EINVAL;
>   
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
> -		return len;
> +		return sysfs_emit(buf, "%s,%d\n", class == IOPRIO_CLASS_RT ? "rt" : "be", data);

Exceed 80 columns.

Thanks,

>   	}
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
