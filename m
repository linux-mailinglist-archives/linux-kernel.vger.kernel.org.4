Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3382F73B439
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjFWJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFWJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:57:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253AD3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:57:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9bff0a543so5816115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687514272; x=1690106272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pQzPxsmpV8ILmUDokZDt4x2j1OZGQdakvLzX04+Ejg=;
        b=DRlPNLsK/mZ3irMEYdZmnmDdlPds7DvI5au6/NXLEmObZ0q2j+riTTvnF4pnaba5Eb
         DH2TXjFL5OFBSrzNE1j4a5aGqGz48UHjYrVhZd3wVtPnW2C22JGEuGjsrq+JpfMRJV2k
         MkWPC6wPxJC27j2xRo0NYQY4kjlkcSDEwr9JRvSSwtmlCEF3IowczoAHbtWW345VGYQr
         DLQu/ZwtBg6Q81ga1VMS7w7OdSttnxx7sF4T278R3LjJ8THYdUsFWjekXwF9VxCxViVY
         kF8/QayqIlynx9XhIUmUIXrLU/LQ5y0rz+dMU2qOPVvjSn5y1zTvusx3LzoxEB2uMWUr
         2K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514272; x=1690106272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pQzPxsmpV8ILmUDokZDt4x2j1OZGQdakvLzX04+Ejg=;
        b=lNV5WPXqNV7ZjXUvt2QPs4+lOb9G5XxDJVqsANDACktR5NUxykLExPKUF4773SOsVi
         XEDepEpV3yYnXk/A+ziwiFoBl0JCf2OPZTmjfQWcDh28bPskBTLS5u070ue4XoRw45KP
         /1yS8og7Wi3muhhsCh6aMzfZFaVnnT2rVSnVkVFe5NHPFBUAes8rmMk1vPd8ei95YUMF
         VGgj7MwTuQFx+pAbcKW9PiDCXdmAL/wK1+/6/UdacmI7mZ4+ebpsKnpvC0oszjmi8led
         8Jf1d7hugwZQRHfcbGuL6XQhWXjvS8SXCc+PunUUc9iBGNv8c/GSPDUjIbth6RWO1VL5
         TXJg==
X-Gm-Message-State: AC+VfDwoN8Jgmo/VGF3cOs+qw/RMkcJWF77Ns7q9bvLuLxyk1CIo0stE
        /C0nOIdmXeK0KRygxYefoMPdUg==
X-Google-Smtp-Source: ACHHUZ7JjYmbOrvMcpUGZTC3uEGAoLXqDRseSay3/vHcvG0f5A9N3KF1iNgjt3GTjbTfRCaqYSCqCQ==
X-Received: by 2002:a05:600c:230b:b0:3f1:6fb3:ffcc with SMTP id 11-20020a05600c230b00b003f16fb3ffccmr17377352wmo.22.1687514272211;
        Fri, 23 Jun 2023 02:57:52 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s9-20020a7bc389000000b003fa745f3264sm1824671wmj.43.2023.06.23.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:57:52 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 3/3] Documentation: riscv: Update boot image header since EFI stub is supported
Date:   Fri, 23 Jun 2023 11:55:47 +0200
Message-Id: <20230623095547.51881-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623095547.51881-1-alexghiti@rivosinc.com>
References: <20230623095547.51881-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI stub is supported on RISC-V so update the documentation that
explains how the boot image header was reused to support it.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/riscv/boot-image-header.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
index a4a45310c4c4..df2ffc173e80 100644
--- a/Documentation/riscv/boot-image-header.rst
+++ b/Documentation/riscv/boot-image-header.rst
@@ -28,11 +28,11 @@ header in future.
 Notes
 =====
 
-- This header can also be reused to support EFI stub for RISC-V in future. EFI
-  specification needs PE/COFF image header in the beginning of the kernel image
-  in order to load it as an EFI application. In order to support EFI stub,
-  code0 should be replaced with "MZ" magic string and res3(at offset 0x3c) should
-  point to the rest of the PE/COFF header.
+- This header is also reused to support EFI stub for RISC-V. EFI specification
+  needs PE/COFF image header in the beginning of the kernel image in order to
+  load it as an EFI application. In order to support EFI stub, code0 is replaced
+  with "MZ" magic string and res3(at offset 0x3c) points to the rest of the
+  PE/COFF header.
 
 - version field indicate header version number
 
-- 
2.39.2

