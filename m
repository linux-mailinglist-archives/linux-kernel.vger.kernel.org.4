Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9EE5FDE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJMQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJMQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:20:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1C7C758
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:20:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sc25so4984607ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oe+qcm/PeDU+N6DKOzPNoq0R6lraKt7XT7JYVGPicCk=;
        b=dU6DDiJS3KATjyTwxYnnqe1e3pSXmti7gfPF1hRPvo80QB7/94M+1V4ZbT9KpjWLHa
         7K30CxBz4iJaAUHZQud/XSCDLlbebrFo+UmMAvKzSavYda19Y3C4+azTB1qPhDNzvb2w
         D3gO8IApfyYlbgR03kpc5iobxijl6FpE5FPVg3cMHJXvoMWg05GuRRbFM4ds8xPVeFWv
         K9c3cpT9gGg5WdRUvX7O8r200KM/GWUMvmJn3GXPyDVffpo8EwjKxbrKlrQnJGzViPlW
         GUEVeCent4sYDYyGK2BAqc3VE29z7/qlqk/WUG4kVU8IQ4AQAY2feLULAU/4bumyf0A8
         rkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oe+qcm/PeDU+N6DKOzPNoq0R6lraKt7XT7JYVGPicCk=;
        b=VXtUwCdDJhiVoLFlPWIDwy/Cgd82Y2E7pQNgAMUEMPMzkyIJ0yZJD/XzfoDWNbBVeR
         KYf3yra8TxqWwe1nxCMZvAyVFNlJ7hBMu+U+ow+6XcI8R+BAsjpRPL2g4R6Hajv3vX5L
         JWwXKAcAjIIftiI+leI+t0MR1rHx1eBtLvk9dEzGXUfUf0ryO2LF0eNK+thdPPdEJOYt
         lSRc+YXsf05XG/i23hRrm4pKuvW5VOqGse/BB/U5bOAzcPDMr+iikSkaQbCQl+KQK07V
         pGDYvDYUM2mpiciwlGSLvck7jvMD4+wqMWuCInjQLq6es+2IJqoq5F1x0tnB1un0Ik7m
         Vekg==
X-Gm-Message-State: ACrzQf1VenARnMYhElqZwkIjce6+VQa/sW4yBb7wTwoNcauZ1E6dDWFv
        rjMyKFxVr59yA6N69taKrQwWKA==
X-Google-Smtp-Source: AMsMyM6TQsm0jAFDWeOa0K25dqufGBQqbnTfJUZpgBInYPUQ7lJ0E71e+lbcS3jq4i/FQq4vysCQCA==
X-Received: by 2002:a17:907:2e0b:b0:78d:387d:1579 with SMTP id ig11-20020a1709072e0b00b0078d387d1579mr352263ejc.761.1665678039938;
        Thu, 13 Oct 2022 09:20:39 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id t29-20020a056402241d00b0045ce419ecffsm80529eda.58.2022.10.13.09.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:20:39 -0700 (PDT)
Date:   Thu, 13 Oct 2022 18:20:38 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH 0/8] riscv: improve boot time isa extensions handling
Message-ID: <20221013162038.ehseju2neic2xu5z@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:10PM +0800, Jisheng Zhang wrote:
> Generally, riscv ISA extensions are fixed for any specific hardware
> platform, that's to say, the hart features won't change any more
> after booting, this chacteristic make it straightforward to use
> static branch to check one specific ISA extension is supported or not
> to optimize performance.
> 
> However, some ISA extensions such as SVPBMT and ZICBOM are handled
> via. the alternative sequences.
> 
> Basically, for ease of maintenance, we prefer to use static branches
> in C code, but recently, Samuel found that the static branch usage in
> cpu_relax() breaks building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]. As
> Samuel pointed out, "Having a static branch in cpu_relax() is
> problematic because that function is widely inlined, including in some
> quite complex functions like in the VDSO. A quick measurement shows
> this static branch is responsible by itself for around 40% of the jump
> table."
> 
> Samuel's findings pointed out one of a few downsides of static branches
> usage in C code to handle ISA extensions detected at boot time:
> static branch's metadata in the __jump_table section, which is not
> discarded after ISA extensions are finalized, wastes some space.
> 
> I want to try to solve the issue for all possible dynamic handling of
> ISA extensions at boot time. Inspired by Mark[2], this patch introduces
> riscv_has_extension_*() helpers, which work like static branches but
> are patched using alternatives, thus the metadata can be freed after
> patching.
> 
> [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> [2]https://lore.kernel.org/linux-arm-kernel/20220912162210.3626215-8-mark.rutland@arm.com/
> 
> 
> Jisheng Zhang (8):
>   riscv: move riscv_noncoherent_supported() out of ZICBOM probe
>   riscv: cpufeature: detect RISCV_ALTERNATIVES_EARLY_BOOT earlier
>   riscv: hwcap: make ISA extension ids can be used in asm
>   riscv: cpufeature: extend riscv_cpufeature_patch_func to all ISA
>     extensions
>   riscv: introduce riscv_has_extension_[un]likely()
>   riscv: fpu: switch has_fpu() to riscv_has_extension_likely()
>   riscv: cpu_relax: switch to riscv_has_extension_likely()
>   riscv: remove riscv_isa_ext_keys[] array and related usage
> 
>  arch/riscv/include/asm/errata_list.h    |  9 +--
>  arch/riscv/include/asm/hwcap.h          | 94 ++++++++++++++-----------
>  arch/riscv/include/asm/switch_to.h      |  3 +-
>  arch/riscv/include/asm/vdso/processor.h |  2 +-
>  arch/riscv/kernel/cpufeature.c          | 78 +++-----------------
>  arch/riscv/kernel/setup.c               |  4 ++
>  6 files changed, 71 insertions(+), 119 deletions(-)
> 
> -- 
> 2.37.2
>

This series also needs a KVM patch like below.

Thanks,
drew

From 7069a6fa488ec4efad190884fe5fcf4a1c37753a Mon Sep 17 00:00:00 2001
From: Andrew Jones <ajones@ventanamicro.com>
Date: Thu, 13 Oct 2022 18:16:10 +0200
Subject: [PATCH] riscv: KVM: Switch has_svinval() to
 riscv_has_extension_unlikely()
Content-type: text/plain

Switch has_svinval() from static branch to the new helper
riscv_has_extension_unlikely().

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/tlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 309d79b3e5cd..aa3da18ad873 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -15,8 +15,7 @@
 #include <asm/hwcap.h>
 #include <asm/insn-def.h>
 
-#define has_svinval()	\
-	static_branch_unlikely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_SVINVAL])
+#define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
 
 void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 					  gpa_t gpa, gpa_t gpsz,
-- 
2.37.3

