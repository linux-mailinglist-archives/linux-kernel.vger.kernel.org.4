Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ABF737C18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjFUHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjFUHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:22:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B861A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:22:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f8775126d3so3163770e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687332158; x=1689924158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJtAM0L0emx8T5IXtJyi6+wwS3eppT8Ww5R/dqqSfCU=;
        b=xAn7hv2GhspML86OK+9CMBbl4yllWSvz7GtWiNe5kWjztw7kYR099vtWl+qdLljqDR
         xX7L1O5Q9ekcZ4EAiT0t0Br4tUilHxRM2Qs1tLI95j+VUC7elWKK+D+5gBTOqwqcXNWl
         xaEngegewU7PBuQXtJJqZQJ4Y6V3eBJk2hhBefjIVlziB/IvGBf9z0Y/k0LmhJ5HQzhB
         ytKekaJBpOXeqZVMBh+2+UkNz+ob2SF1DEI7+Q2Lo2CAU2SyKvrj6WbICyFtU+XzC3Ef
         OsdlarEYl64xwYAcKUOwVE+3iS1H+DWlq+LtRT+z5Wp9FNBMoKEDcl0w30pLE0dlzuqs
         cziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687332158; x=1689924158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJtAM0L0emx8T5IXtJyi6+wwS3eppT8Ww5R/dqqSfCU=;
        b=F2/z8uPWIHcTsppSOLDTJGFxioTlmGernhQvJRjyojvAG3W4AYujoZx07pSI6ZQ6ZR
         C/nedqqDs5MjIM5Kw8PPg6eNfu6ym/fFP1YE2rIAAiu4n2gqeEkFKvxmcfUv3Urnri3q
         /DwGGWXV5Rzg3DqSTFI+JzSsgbm5pFDyCekSUiEjHO10gaV0TyLjRd/QV0ecSs2dwfhc
         tT0L3sYF2kxnv/Qf/Vga3Ny6KwRd1RXZfMCR5YQAf38x2GI/+K7gqGwshxZjYNrU4svZ
         aR4/CmhCuoMaj7yx2iTP65+96sRDNFpFPDqvodsV0cxM52aM6hu5eYpncuzcVJRIJuqa
         xu/g==
X-Gm-Message-State: AC+VfDzuuhTRhaU3ZBxxfFO5hFsi75+gchGK9bnepo7qVNHdteSPdGR3
        s0EhcEhR/gK+uQ2dz3gPAtOxaQ==
X-Google-Smtp-Source: ACHHUZ5ldRVlcEfwc998L1BxSn/pP/SIE+aK6aDHYb8bc7cN5x1dLZ7PwHw26+4Fnw1q0bmaT1Yr2Q==
X-Received: by 2002:a19:9142:0:b0:4f6:394d:96c2 with SMTP id y2-20020a199142000000b004f6394d96c2mr8645566lfj.29.1687332158089;
        Wed, 21 Jun 2023 00:22:38 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcd14000000b003f7f2a1484csm4192394wmj.5.2023.06.21.00.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:22:37 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 1/3] Documentation: arm: Add bootargs to the table of added DT parameters
Date:   Wed, 21 Jun 2023 09:22:32 +0200
Message-Id: <20230621072234.9900-1-alexghiti@rivosinc.com>
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

