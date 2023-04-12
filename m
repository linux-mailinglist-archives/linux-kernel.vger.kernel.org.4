Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BA6DFDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjDLSpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDLSpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:11 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4B61B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:10 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1842eb46746so14785314fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325109; x=1683917109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yYB+UjJ5L6aV3imoGiJTko2w0CvVVRSooT6AuiAzyA=;
        b=UPBfEiuB141JD/GXIrwt1YK0IqNU31AQsFYZPMxST7mtTUkUIBz3ZeAm4bS3Pk5j0f
         n+A0ASxR98pgRMV0FPqJo/FUBmSaCGvGOhEnmb2MSDDUxCfFPb2W4xW2HwZQeor+EC4o
         pVmfVfIu4DJC8gOR0L/mRn60h9QGKrwqsQB6Z6Z6KsFCxHGz+F+9gBTTm6m0lrfavKQF
         R9Cr8FFG+UzTfnQr0drhQYNUVWUshzRjPE+rSLpFSUDmRbJuoa/ZWeEEn1Jb3SiC8rO+
         FHhEewf4EdlsrOsogtmESpZOLk68uoU9tO2oLLQymnmJP20+WAiQkZqg8ukHFFxIAfAs
         ATkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325109; x=1683917109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yYB+UjJ5L6aV3imoGiJTko2w0CvVVRSooT6AuiAzyA=;
        b=H7UmIf2/m7y0qtMa2BwadG0QYCdlDNQLp2VN247Ola9C+BmapnqBIY9aFQOmjuCP3S
         Z6vTs6XLha+vHWTWdNdU2KV2BJjiHJjduX8kndaBTHpxj7KZ1DoUzzTzo05ah0p/RgD4
         Ag9vzEWuev4fDyAK3GsNHI+Ul4kDekrE+J9IDjlljd5PFc8MeVCzthg23NbAE0vwEU14
         KCpquOdPVBoAWTYNyeJ8ssYJIDbNgBQKm7r+QhPRbHa5h1FbDrrsWTAeg84vlpiT9KEL
         wXmLLcsKgURJLSiWsHEYGDQGfQs3xQfoda2Nh7d9gmn9+lrOXZFjNOuEhwy+6aqa9XKu
         CBbA==
X-Gm-Message-State: AAQBX9e+9r/9HvqPIHkR1H1R6pyE0JJhaqdLOoouJkwXyJfO+NOcBDqH
        9heOqfFrWoeIRK1rKJWuqXobm5dylA==
X-Google-Smtp-Source: AKy350YRKSJWxnLhr7cX/ZTZ3Lbtd1LHNM+7o1WR73Jx76Jixnn/SHnEsIulBHrPl7q8QsdEjcxpHg==
X-Received: by 2002:a05:6870:969e:b0:180:13a4:425e with SMTP id o30-20020a056870969e00b0018013a4425emr4222567oaq.30.1681325109407;
        Wed, 12 Apr 2023 11:45:09 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:08 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 0/6] x86/boot: Clean up handling of boot_params pointer
Date:   Wed, 12 Apr 2023 14:44:56 -0400
Message-Id: <20230412184502.145289-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On entry from the bootloader, RSI contains the pointer to the boot_params
data structure.  The pointer is passed to x86_64_start_kernel(), which
requires preserving RSI all the way though the early boot asm code.
Change it to copy the boot_params data as soon as possible, which also
has the benefit of not needing to remap the real mode data pages if
memory encryption is enabled.

Note: The memory encryption changes are untested due to lack of hardware.

Brian Gerst (6):
  x86/boot: Move sanitize_boot_params()
  x86/boot: Remove extra call to copy_bootdata()
  x86/boot: Clean up get_cmd_line_ptr()
  x86/boot: Move copy_bootdata() to very early boot.
  x86/boot: Use copied boot data in __startup_64()
  x86/boot: Use copied boot data in sme_enable()

 arch/x86/include/asm/mem_encrypt.h |  4 +-
 arch/x86/include/asm/setup.h       |  9 +++--
 arch/x86/kernel/head64.c           | 59 ++++++++++-------------------
 arch/x86/kernel/head_64.S          | 26 +++----------
 arch/x86/kernel/setup.c            |  2 +-
 arch/x86/mm/mem_encrypt_amd.c      | 61 ------------------------------
 arch/x86/mm/mem_encrypt_identity.c | 42 ++++++++++----------
 arch/x86/xen/enlighten_pv.c        |  2 +-
 8 files changed, 58 insertions(+), 147 deletions(-)

-- 
2.39.2

