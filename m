Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5366E9AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDTRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDTRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:37:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F114C3B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:36:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b7b54642cso1045892b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682012205; x=1684604205;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnRCEEUMbL4VHxSaKuZGWLgXCAjCR6wrwzaIjE1iCNc=;
        b=R65bYw0uCjFnuSxJCWbKs3W5rtP8+s5sqP9IWJY2VXqMV3Bw692qEAZMhGcGKa74Dm
         5sS9JGCcN8YHkjMPD7u4bbM8Jgk10We8g7MAc8i8Vd80uKUDCiqijpr0uc40cTejJZ8y
         n9L8MmHQPckBEeKfkFxnlulbIhnoV3C2K5N9O53C03m7twso2qJtWJKyfZYyRek7IC63
         uQluDwqpqgFdhPOt7AUB4P90/PGdC4CfXcW7uZWBeMxOdX4n5p9mrrFXEFq5v3Rfw0GL
         NCDaAfyuvV+vLOhUXCrrctANTzOux6safOuXraVUlS1J/OweSNg+yuC/czBK/vUct7O8
         hqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012205; x=1684604205;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnRCEEUMbL4VHxSaKuZGWLgXCAjCR6wrwzaIjE1iCNc=;
        b=CvwHRQHhZ4Gk1PaNhcSwzoxm3lvVzLc3DM0o/io+9weaj9zTgEYT34I9vaUlP45c9a
         7PZL6lz3JKqkgOTl4k+5/Z2NpwlP/rRYkDvm2Liv/Tk5/B86XDRjbyw9gt25VTxlw3ui
         N9ucsCeDo9ZaW26nNHzkmeMPZVPteEYU7GoS9rn7jxjiniBgvNZlkESRx7uh9r/Odtpw
         vk0CetqZ2xwH7K+4JRyWaH209yUwDK8BhvIQUK8Fkw58qwxO0m/J9/kWUCMhWBqay01k
         B2XdHJE2lp2Ni7Kx9C2cvMl+BjImoSD9yoLhNEtZGGVcz5yRE0Lp73c6sUbRuly/3ssI
         7TLA==
X-Gm-Message-State: AAQBX9cNaHdggO7ykAH4JbiLnSN4UvghB0vQs+23cZdH/1P/Sjnn7nN0
        OQKLKq3jgtPoSM+7fQGWdnBV5w==
X-Google-Smtp-Source: AKy350baT6KGrtGFPNL5kKO3PBM13yh+t73vTItdwumjVN+2TW8bKUrE5c9iopnLCN+wQT6ScUYU2g==
X-Received: by 2002:a05:6a00:1144:b0:63f:120a:1d96 with SMTP id b4-20020a056a00114400b0063f120a1d96mr1084389pfm.11.1682012205312;
        Thu, 20 Apr 2023 10:36:45 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id j16-20020aa783d0000000b0063efe2f3ecdsm1489431pfn.204.2023.04.20.10.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:36:44 -0700 (PDT)
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 0/6] RISC-V kasan rework
Message-Id: <168201218500.13763.4099213624397858271.b4-ty@rivosinc.com>
Date:   Thu, 20 Apr 2023 10:36:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 08:52:26 +0100, Alexandre Ghiti wrote:
> As described in patch 2, our current kasan implementation is intricate,
> so I tried to simplify the implementation and mimic what arm64/x86 are
> doing.
> 
> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
> instrumentation: all kasan configurations were tested on a large ubuntu
> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
> 
> [...]

Applied, thanks!

[1/6] riscv: Split early and final KASAN population functions
      https://git.kernel.org/palmer/c/cd0334e1c091
[2/6] riscv: Rework kasan population functions
      https://git.kernel.org/palmer/c/96f9d4daf745
[3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
      https://git.kernel.org/palmer/c/401e84488800
[4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
      https://git.kernel.org/palmer/c/617955ca6e27
[5/6] riscv: Fix ptdump when KASAN is enabled
      https://git.kernel.org/palmer/c/ecd7ebaf0b5a
[6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
      https://git.kernel.org/palmer/c/864046c512c2

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

