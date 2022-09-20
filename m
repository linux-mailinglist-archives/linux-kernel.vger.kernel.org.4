Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A075BEA36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiITP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiITP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3667161
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC05623C6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCBAC433C1;
        Tue, 20 Sep 2022 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663687747;
        bh=iemDLGibnYPEk7i75AVZGHMGMYVcXO83jgs70f+7FdQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VAxAfo7Fi/OX46FTZhU+eAZJohoeaIbR3adQU2skZk43WqBOx9C0byz1p7r5TYDPR
         VBb2iS6ApBX6Ld/BIbTFba+t9pMLwYJDDVFSzgh/ytaIfv9cFWV+tF/vb9H02lpkeW
         A5VBd4N+3SkrBmh01BK2Sqch0oagthB/XE0IpCy3mVCMTaBGorh0ohJySjmvzQc6b4
         1WiNXIjLy3MXKLakH8dC3IKJ5jHVTjeogMx6mk6/rVtwkGzKZT/i46ILng19BLWX9e
         5yvYC3zD8YjvIp0DRbeKbmRJLvamsKcOUDVdBrjKmeGHRRkbvJGJYflVBB5+L4b57y
         IaWxm6LlDhEzg==
Message-ID: <fadeeb4e-2769-a0c9-aee5-612de712aec6@kernel.org>
Date:   Tue, 20 Sep 2022 23:29:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3] f2fs: fix some error handling case in gc
Content-Language: en-US
To:     "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     niuzhiguo84@gmail.com, xiuhong.wang@unisoc.com
References: <1663637258-21987-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1663637258-21987-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 9:27, zhiguo.niu wrote:
> During GC, if segment type stored in SSA and SIT is inconsistent,
> we set SBI_NEED_FSCK first and then stop checkpoint, this will
> cause the following issues:
> 1. SBI_NEED_FSCK can not be set to flash truly because of checkpoint
> has been stopped.
> 2. Will cause more EIO error if user use f2fs because of CP_ERROR_FLAG
> has been set in f2fs_stop_checkpoint, this is not reasonable.
> 
> So we fix this error handling case by recording current victim segment
> as invalid for gc and do not stop checkpoint.
> 1. SBI_NEED_FSCK will still be set but not do f2fs_stop_checkpoint for
> f2fs.fsck to have opportunity to fix the inconsistent segment type
> in SSA and SIT.
> 2. Let user can still use fs, avoid EIO error for some operations such
> as read and write,etc.
> 3. If current segment has inconsistent segment type in SSA and SIT,
> we add this segment segno in SIT_I(sbi)->invalid_segmap to skip this
> segment to avoid deadloop in gc,similar as commit bbf9f7d90f21 ("f2fs:
> Fix indefinite loop in f2fs_gc()")
> 
> Fixes: 793ab1c8a792 ("f2fs: fix to avoid deadloop in foreground GC")
> Signed-off-by: zhiguo.niu <zhiguo.niu@unisoc.com>
> ---
> changes of v3: keep "set SBI_NEED_FSCK and f2fs_err()" as before and
> do not depend on CONFIG_F2FS_CHECK_FS as Chao's suggestion.
> ---
> ---
>   fs/f2fs/gc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d5fb426e0747..f354883872f6 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1703,7 +1703,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>   			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
>   				 segno, type, GET_SUM_TYPE((&sum->footer)));
>   			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			f2fs_stop_checkpoint(sbi, false);

f2fs_stop_checkpoint() was added in commit 793ab1c8a792 ("f2fs: fix to avoid
deadloop in foreground GC"), in order to avoid deadlock issue reported in
bugzilla, it needs to check this patch w/ the fuzzed image.

Bug 203211:
https://bugzilla.kernel.org/show_bug.cgi?id=203211

Fuzzed image:
https://bugzilla.kernel.org/attachment.cgi?id=282203

Thanks,

> +#ifdef CONFIG_F2FS_CHECK_FS
> +			if (!test_bit(segno, SIT_I(sbi)->invalid_segmap))
> +				set_bit(segno, SIT_I(sbi)->invalid_segmap);
> +#endif
>   			goto skip;
>   		}
>   
