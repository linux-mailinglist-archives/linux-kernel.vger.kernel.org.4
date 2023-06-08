Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD767283BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjFHP2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbjFHP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:28:23 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863D2D7E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:28:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62884fa0e53so6035036d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686238097; x=1688830097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVT+E1lTqgVRqOMiUmOOqGCFZYtg8Gx2wGfwkHkIhvU=;
        b=OFvpyrq/lBDNV1vdcmrMuXjLEhmg/ybSi729m+uNossAYd0shYaefVa/nGTQGZUN+I
         4UlLlEQq/1ayEmGII7lyf8sKBD0xYfs3Hq1EDnrH+RfoDddi2B66B6s6czcPF9Fjtmuh
         g5nu+hCcDcmPNYD8jX8AtcU7MLzNbWZQBVLkRaQOlcDTLe9KAfiC1fKd+A4E/dBaGgvC
         joHvAcWMV1365pR1u+FHY7dEPZyuLOlUh2K3SOMKn/Rmn/MUwLpDXp6dvZa87DDuWR2H
         PVOUXIA4X1heq4LRcsD+0n0VTrAfurE+cgotRdo8G6Vfsxoa8U7gHfLqus6aupkp6rNz
         dwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686238097; x=1688830097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVT+E1lTqgVRqOMiUmOOqGCFZYtg8Gx2wGfwkHkIhvU=;
        b=TBrcq+nmxmFVMykKTkuZHONK0k67ELFzh8mLDa2J7DHmQgFvLR6xiDKAeE7/6L609F
         Z3nNLyO5HiGJSDTkseu4QO8Gu+BsPeB6+0RmoFefD2LON7QuwJv8J+Om26YaBrjOvI+d
         VosoL56+qWQJ8CxH1GBD77d/NQThiKBJNJUSPMZKwM8qxB62PoZL9eaVXIeA0pziHnf1
         vXzZnehVFgmwpl3mPTznb1eUd9NDxBXa0jYH9Ld1npUiUSY4n9i59zMY7HyhB153U79m
         qPqSwDOZR7nIFZhPTp9qyYSkEzpjF+jtcPhQlY6RO+pDbOnbs/Zk+Qe4KDywrZasipvB
         rMCA==
X-Gm-Message-State: AC+VfDzW/xQEPhWCe/h71PeSknyAUChzYkwXPeLAn4AyCBBZazWL3TTl
        fKLqXJ+foj4pZOdm0SRVprAScvioFI++DYmHgTzRYw==
X-Google-Smtp-Source: ACHHUZ6P2k2Tgyu/59Khxh6JHCZIquDvMKZdtfOoKcWOpAmaVJ+SduwImO/96dcKIS5uRClkC7pY3wVfpuk4MWCqgaU=
X-Received: by 2002:a05:6214:5010:b0:62b:4e33:a16f with SMTP id
 jo16-20020a056214501000b0062b4e33a16fmr2439142qvb.28.1686238097551; Thu, 08
 Jun 2023 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org>
In-Reply-To: <20230607-arm64-flush-svcr-v1-1-7821a6199e0a@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 8 Jun 2023 17:28:06 +0200
Message-ID: <CADYN=9+OckUJ2x4FuMKAgxekhWibySZzMz=r-JbaCVZWyG8_GA@mail.gmail.com>
Subject: Re: [PATCH] arm64/fpsimd: Exit streaming mode when flushing tasks
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 22:42, Mark Brown <broonie@kernel.org> wrote:
>
> Ensure there is no path where we might attempt to save SME state after we
> flush a task by updating the SVCR register state as well as updating our
> in memory state. I haven't seen a specific case where this is happening or
> seen a path where it might happen but for the cost of a single low overhead
> instruction it seems sensible to close the potential gap.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Applied this onto todays next tag next-20230608 and ran
kselftest-arm64 on a FVP model.
I still see the "BUG: KFENCE: memory corruption in
fpsimd_release_task+0x1c/0x3c".

I'm trying to use the latest kselftest from today with older next tags
trying to find when
this issue started to happen.

Cheers,
Anders


> ---
>  arch/arm64/kernel/fpsimd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 2fbafa5cc7ac..1627e0efe39a 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1649,6 +1649,7 @@ void fpsimd_flush_thread(void)
>
>                 fpsimd_flush_thread_vl(ARM64_VEC_SME);
>                 current->thread.svcr = 0;
> +               sme_smstop_sm();
>         }
>
>         current->thread.fp_type = FP_STATE_FPSIMD;
>
> ---
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
> change-id: 20230607-arm64-flush-svcr-47cc76a8cbbc
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>
