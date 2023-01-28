Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619A67F6B0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjA1J1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjA1J1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:27:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A5102
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 01:27:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7108B8015A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CB3C433EF;
        Sat, 28 Jan 2023 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674898062;
        bh=4Dv7QkvdER9TZanR4lMkHN9joTX2h7mC+e7lcohFgbI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GjRuREBY9L0bvO/gx9+DDQqZKXHgGn6nDQ8XbVYfw3ZmV0aSdb58JCybzbnoPh5/T
         hCx/O0VRt1II2PR13pwLibEo8UXxn5Pb8r5JihHX3BOWMvJzg30b5hSi4OygArueEw
         go6vBMt9jSx/9h8IP65bWP+WwM9XWkBUooNr9oOL1aEznFIw8W9RyTM6rj/H7Uzf8C
         JRvTyTsFR4NLhVLq154FbC49yGvqP3IP2WWDfvoZsjrJ7e97Lr7H6am9JoR27lmfjP
         VsJYMy46jG0ByVmWgeojgKMRVsLpBjXTqRJv1Vzm0t2iwzILtgG/VzohWIfmocgJGp
         8DQSDWI68//Vg==
Message-ID: <d8f0f611-8281-6a55-cf17-6cfedb606802@kernel.org>
Date:   Sat, 28 Jan 2023 17:27:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] f2fs: add sanity check for ipu_policy
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230120134029.69200-1-frank.li@vivo.com>
 <20230120134029.69200-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230120134029.69200-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 21:40, Yangtao Li wrote:
> Disallow the value set beyond the range, and disallow to change
> the value in lfs mode.

IMO, it's better to merge this patch into 1/4.

> 
> BTW, convert open code to use BIT().

How about using one patch to change 1 << xx to BIT(xx) for all cases
of f2fs rather than one by one?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.h |  1 +
>   fs/f2fs/sysfs.c   | 11 ++++++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 0b0eb8f03cba..d73e988566a5 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -681,6 +681,7 @@ enum {
>   	F2FS_IPU_ASYNC,
>   	F2FS_IPU_NOCACHE,
>   	F2FS_IPU_HONOR_OPU_WRITE,
> +	F2FS_IPU_MAX,
>   };
>   
>   #define F2FS_IPU_POLICY(name)					\
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index bdc761f36310..576e6416ffb9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -452,7 +452,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   	if (ret < 0)
>   		return ret;
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
> -	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
> +	if (a->struct_type == FAULT_INFO_TYPE && t >= BIT(FAULT_MAX))
>   		return -EINVAL;
>   	if (a->struct_type == FAULT_INFO_RATE && t >= UINT_MAX)
>   		return -EINVAL;
> @@ -706,6 +706,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "ipu_policy")) {
> +		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
> +			return -EINVAL;
> +		if (t >= BIT(F2FS_IPU_MAX))
> +			return -EINVAL;
> +		SM_I(sbi)->ipu_policy = (unsigned int)t;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
