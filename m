Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0461354A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJaMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJaMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:05:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0A60F8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:05:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t4so5777078lfp.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=im04qyPAn8tCHIuMabqLBjj1JwjY25RVw1Ozonz9fJM=;
        b=XLYM+XGdfDc/af3vkU0Bq3WtwAX8SvE8qu51z7PM29Hwizi8eYbb3ONprTQe3vQZ5/
         pNJBpPo91YbC5CVWeUmpgS13lqu6ZQAE3E0rysVWt3dBTZMMXZ4NcdBjcsgcUnLenOtv
         Cp1V8WhbSSGKhwT5V4gKxuvQ5uq7La42DqHaSkvol9AthWOZKYfYdaLNNtTZm3n0cNFT
         6fII8VUnsxSPGhdMNY5xu2y64WXDzCbUeLiyMKdZYZSAV5f2u/MCh6M+LvoyS2aUxROu
         AMnipBglP2SGv+5z/v8qqDTH0yTPgY2SL7dqbMtcVGrtB6OM8ROmX/POCLQ5TTi5A3Rh
         QZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im04qyPAn8tCHIuMabqLBjj1JwjY25RVw1Ozonz9fJM=;
        b=zqoispdPjpQs++yBzcNADgFhcyXEM8OsTgM/ar/uWLcRAWZs1QZ3UQAdj8J+1s/pjf
         LLNiC+AY08dZHAqA8+ZMdO1A84CYStag2LGmf4uWXSb6E8X83Kw0nesT0CZLkmlhFi6K
         +Fe7D7wHJs53us3oHJjqeEPH0oQFDCwWXtNJqPluOzugerSArGHSL5GSxaqwzo5zaRu1
         bsMMn/6+7XtUxUakRJK/KyZDsNIT5aaYNno9iosKSohsBU4oKQO1AEU8jUKCvIAbwJJD
         rhi2DkQMFTYGhsdX7oH4sqlMnQBRsYOSjCf4kxdRQovNlLD7oEAy+77rVOZOfRbM5vBn
         7SjA==
X-Gm-Message-State: ACrzQf0WWJiejCgcPJd1vP/jx4cPjwn2jqCAnIwu/HTem4fC81Yl5Fbv
        MMVSgokOX5KekgjH7g+krNGjiDFmP0tt8aQiGR4=
X-Google-Smtp-Source: AMsMyM5Jk9GCRj92jf0wG9KEm0Y8ktDypoXC1R2fmnXi9rseTuB2YPvKrUCm+OQMZq4YnxNzwHingQYV+mdueyyc0hA=
X-Received: by 2002:a05:6512:31c9:b0:4a2:5349:7103 with SMTP id
 j9-20020a05651231c900b004a253497103mr5039858lfe.497.1667217908830; Mon, 31
 Oct 2022 05:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
In-Reply-To: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Mon, 31 Oct 2022 20:04:32 +0800
Message-ID: <CAJy-Amn68GwogGADZqo81RkKyRosbGYw_L9ehuUvmzvvL56LrQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: fix undefined behavior in bit shift for intel_detect_tlb
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, pawan.kumar.gupta@linux.intel.com,
        pbonzini@redhat.com, chenyi.qiang@intel.com,
        jithu.joseph@intel.com, alexs@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 7:43 PM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> Shifting signed 32-bit value by 31 bits is undefined, so changing
> significant bit to unsigned. The UBSAN warning calltrace like below:
>
> UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/intel.c:948:21
> left shift of 1 by 31 places cannot be represented in type 'int'
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7d/0xa5
>  dump_stack+0x15/0x1b
>  ubsan_epilogue+0xe/0x4e
>  __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
>  intel_detect_tlb+0x114/0xbd0
>  identify_boot_cpu+0x29/0x9e
>  check_bugs+0x2f/0x15a5
>  start_kernel+0xc3f/0xc78
>  x86_64_start_reservations+0x24/0x2a
>  x86_64_start_kernel+0xed/0xf8
>  secondary_startup_64_no_verify+0xe5/0xeb
>  </TASK>
>
> Fixes: e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Alex Shi <alexs@kernel.org>

> ---
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 2d7ea5480ec3..121c1c38162a 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -945,7 +945,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
>
>                 /* If bit 31 is set, this is an unknown format */
>                 for (j = 0 ; j < 3 ; j++)
> -                       if (regs[j] & (1 << 31))
> +                       if (regs[j] & (1U << 31))
>                                 regs[j] = 0;
>
>                 /* Byte 0 is level count, not a descriptor */
> --
> 2.25.1
>
