Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9873E23E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFZOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:36:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883219F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:36:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f90b8ace97so48017145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687790189; x=1690382189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyS6js1uEQcGpjrlLFsApXkwWbdmfkq2O19nl/ntD9I=;
        b=0rRx16vPEz4otpjwTB2+xwwCPkN6laJ920t/o9tdeRTI3/IWz7rHFhmjtl4BtcLvbK
         8sd8i1ixF3tILm07mAiNcvuah+F64takI0yNg5lzTCOlWuLa+ihQipMWAUO2Kp7G97oA
         Kl18TQkv7lLhVwW0P5B06IdBRRNGQMkZCAXjn1QX/rmD9XuGHUQIL4tjK7oqW4c6xyS2
         XvOUThw0ASzBjXMK30mELoMgSwN7Os79KpEA2iYAlHD4pXmyBqLFFyOM2aiuoARShzqT
         tWGzwRLzkTbjzHvkL55xqVOVYZF9H4OdGqOpt8tX1uNXHuhNDjLsqM3YFqXjdOr1B+kV
         GlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790189; x=1690382189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyS6js1uEQcGpjrlLFsApXkwWbdmfkq2O19nl/ntD9I=;
        b=Q+SwvJTH1fqYNLCKe3NVkGHuzAYIz/4fX+QlvG2AIx/V9Zy6znR2JMgXsqILY08kaZ
         xGJH8FaNKXy554onlOIo2oT2ZrCPEqMy8Fg0XcSxbg5/Lp70YC3TYb6ITBGVFjYxec0G
         ptboiBI5SXwBzDbuBCUJlEnOrT/j7EhdZfsmmH3Qef3SzY6UaAyd96S+No0byaYH+hYR
         LYjk6VkIlq6stCDwvZKtIqeV3tuWaY1jQr3JfD1CxWFguUzFtS4Jr+yOg5isyjul/imr
         HkRvVFSSx8B0IdVptCWMi7niL3CQVLpsJyqeqr20Ir2evdgEZsj2/JgK8UGNe7o53paA
         RWHQ==
X-Gm-Message-State: AC+VfDzvTGu8jRX/KPt6KTHhHpu8QWmWElt4bdagCLQ/2OwNcKYplM2F
        h7O1BsR43OD3m2+b/OikGwjP+w==
X-Google-Smtp-Source: ACHHUZ5trI2VVLtdJQUt4Re6CkgIlyCdijkloV8ba7d0Pgi+frLUfcc37GZ0qPHllho9aVsX9sOgmw==
X-Received: by 2002:a1c:6a12:0:b0:3fa:934c:8356 with SMTP id f18-20020a1c6a12000000b003fa934c8356mr3011833wmc.10.1687790188830;
        Mon, 26 Jun 2023 07:36:28 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f8f8fc3c32sm7934552wmk.31.2023.06.26.07.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:36:28 -0700 (PDT)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 1/3] Documentation: arm: Add bootargs to the table of added DT parameters
Date:   Mon, 26 Jun 2023 16:36:24 +0200
Message-Id: <20230626143626.106584-1-alexghiti@rivosinc.com>
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
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
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

