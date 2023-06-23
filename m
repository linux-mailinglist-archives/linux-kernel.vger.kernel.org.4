Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C973B433
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjFWJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjFWJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:55:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95331E7D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:55:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so505593e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687514150; x=1690106150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJtAM0L0emx8T5IXtJyi6+wwS3eppT8Ww5R/dqqSfCU=;
        b=NKkG8bNv3EO4QeYMT85sNX4yymCntNQSlDHlNCBUiXhJCFZLTYnc1fxigDu1UDYqjT
         x/WHlYdO1RARm72vbFOKJXt7Xi2B+Gc7a/WaQSbrVle9IwixizNMq29S5TYpy7Lsr2La
         iuQ1s6+4Jt+oah+t9i0eHptytK7zsSCgpuxYNEom/yED+at5UjJcN8Tkw48lkezSp3ZW
         CgEHz9obTkkSzWUlis3Ov9jN3wq4G5X/i2+Uqp2Q8SdXAU4otfDnNsnspefpXF63Vo3w
         juyH31zimZv063v6oUxIjqsuPXY+ALHeFtdf+vqPr3TRwAXtLlJc5Cz6sDKOFfu7VbTq
         FOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514150; x=1690106150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJtAM0L0emx8T5IXtJyi6+wwS3eppT8Ww5R/dqqSfCU=;
        b=I51SIwv610EqYS8ozNHSlwZBmSnrMenkdml+1d5kaUd+exwECv7gYeiXVVaAiyw52H
         x6IKReEbBVm6JFrbTJ7l0hisGICe2VDqmMCZqpeknjZqyO8x5WSBjr2h2Fn27p33C7lM
         TYNhhiCY/gREkFwe7cE5pnMdWmMaBASRHYrsgyTfMCvIIH0it+c9xDIsvRKYjbDnfIGY
         uJSxHuXh7uK0uLFQ+eCkMQV+lDhVR1ifhn06dV63hB6d3xwDck+B5cEcpCQkfdF2E51h
         Ihf3vwsKcBjbz0qmFv6qRYXlXu/HkNXQHO7sa/bAfa9sk0YDP3+Hk70lY+BlpOd+ybwL
         tryg==
X-Gm-Message-State: AC+VfDwrpGpMxQ9D929LWmVINg653N3dSlcmY8KGvffOm57a+F5bXhpx
        +Mm5JMRcXzyFG9EaIzH4V3Vu+Q==
X-Google-Smtp-Source: ACHHUZ56QVDSKsm4uhHAhKIZIWN2wRB+s5t+Y+A8bNdb79k8zsowL0ID1EaqAwo4QKkcWaDAMc8Rsw==
X-Received: by 2002:a19:2d01:0:b0:4f8:7568:e94b with SMTP id k1-20020a192d01000000b004f87568e94bmr7651114lfj.56.1687514149706;
        Fri, 23 Jun 2023 02:55:49 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003f7f87ba116sm1876221wmk.19.2023.06.23.02.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:55:49 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 1/3] Documentation: arm: Add bootargs to the table of added DT parameters
Date:   Fri, 23 Jun 2023 11:55:45 +0200
Message-Id: <20230623095547.51881-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
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

The bootargs node is also added by the EFI stub in the function
update_fdt(), so add it to the table.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/arm/uefi.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
index baebe688a006..2b7ad9bd7cd2 100644
--- a/Documentation/arm/uefi.rst
+++ b/Documentation/arm/uefi.rst
@@ -50,7 +50,7 @@ The stub populates the FDT /chosen node with (and the kernel scans for) the
 following parameters:
 
 ==========================  ======   ===========================================
-Name                        Size     Description
+Name                        Type     Description
 ==========================  ======   ===========================================
 linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
 
@@ -67,4 +67,6 @@ linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
 
 kaslr-seed                  64-bit   Entropy used to randomize the kernel image
                                      base address location.
+
+bootargs                    String   Kernel command line
 ==========================  ======   ===========================================
-- 
2.39.2

