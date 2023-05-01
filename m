Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263E56F3122
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjEAMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjEAMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:45:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE619A4
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:44:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b8b19901fso2898343b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682945067; x=1685537067;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+/m/Q8rJDfBtNlvA5MoeSZihLHMU+hMCap0lrbB/rs=;
        b=cwwHyIgX4KWvvBvY8nSBkLAFNRsKMYzp6WW1Di0i93YYJQgPlYiPsZZCu6Q8jvx894
         ycO1ma38TjwwxCTgtSZueTlcY4Th+uxr3S4GZBnOqQEH/2pBTsxgbr9pWx/8L3JZczbj
         MnpoznAqXqI5UK+Sm37GsXne1PqltuZm1m4Xu8tVG+/im46OIrq2m1j0tSR/GAxO8Bh4
         VdlXDlQkolJTQQTRdSXDTZdb4WP2mQUEn80kYCVF+/O11w7FZ444LzumBUmo4iRb4nVZ
         uU5vUU+SbF4ykTZ8FxZUOcJJPtSPqDIpmNPWpIGo5upiSDMbV64yvLxaou3JoJtoNA5f
         aYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945067; x=1685537067;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+/m/Q8rJDfBtNlvA5MoeSZihLHMU+hMCap0lrbB/rs=;
        b=PEF+KGHXH9n4k9qkFvuq0bnzeD8O5FVV8myNWv6hRSJJaTKByk76mdMFIeTj3Lgd6s
         exLM/7Kdt8ODg4UhpRf5sFyfE4AkGQvm4YXRMkI2z4DW6pEnJqhxUuky6Ons4UGG82S9
         ryOBiqiHFflLmhVxQ8gpCRbIvTJcLOQ/mWpXNjiS0ik3e3AUVgZnSj9YnpcZfNs87jVQ
         kj+Oz7MOykCT/F+P6TH2gN3NmvwZpcOuOudo46rSTuaXf2JTZBWi34JKtAKLzEAjTM3C
         gqiqVsp2crz8m8vYYi2I8k4pC7UmyeaGF2ObgY2JDsER7BPSFOOzaIi5FsNLaDUdvq+2
         TAQg==
X-Gm-Message-State: AC+VfDwyFClBZuXXm7ygP9Xm1DvktAyym6a6X0FI4ZBXKWVSUezGgbKO
        gWWABZPBRvCH9x2u42LtmeNnbg==
X-Google-Smtp-Source: ACHHUZ7UwoeVcV7NcPNRh+PYPFK4S9ad6FQ4bVggkB4CDQoyhbAx7EDtp4SCD00iu4lmGkebBwMNsA==
X-Received: by 2002:a05:6a20:6f03:b0:f8:b39b:b24e with SMTP id gt3-20020a056a206f0300b000f8b39bb24emr14578405pzb.11.1682945067231;
        Mon, 01 May 2023 05:44:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v17-20020a62c311000000b005a8bf239f5csm19690294pfg.193.2023.05.01.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:44:26 -0700 (PDT)
Date:   Mon, 01 May 2023 05:44:26 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 05:44:09 PDT (-0700)
Subject:     Re: [PATCH v6 4/4] risc/purgatory: Add linker script
In-Reply-To: <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
CC:     ebiederm@xmission.com, prudo@linux.vnet.ibm.com, dyoung@redhat.com,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, nathan@kernel.org, trix@redhat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, bhe@redhat.com, prudo@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        zwisler@google.com, rostedt@goodmis.org, horms@kernel.org,
        ndesaulniers@google.com, llvm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        ribalda@chromium.org, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ribalda@chromium.org
Message-ID: <mhng-6809e805-0a92-401b-af74-fef93eeda1ae@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2023 05:38:22 PDT (-0700), ribalda@chromium.org wrote:
> If PGO is enabled, the purgatory ends up with multiple .text sections.
> This is not supported by kexec and crashes the system.
>
> Cc: stable@vger.kernel.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  arch/riscv/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index 5730797a6b40..cf3a44121a90 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>  CFLAGS_string.o := -D__DISABLE_EXPORTS
>  CFLAGS_ctype.o := -D__DISABLE_EXPORTS
>
> +# When profile optimization is enabled, llvm emits two different overlapping
> +# text sections, which is not supported by kexec. Remove profile optimization
> +# flags.
> +KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
>  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
