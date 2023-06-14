Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F97730621
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbjFNRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFNRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:37:03 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE9119;
        Wed, 14 Jun 2023 10:37:03 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-777ac4344f9so262076239f.0;
        Wed, 14 Jun 2023 10:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764222; x=1689356222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htWbyJD2n8RFcV5K4ncv4g5SpZeEJ2ahD8odx4XGKqw=;
        b=MVPT+PbwEzWFtiviMuhSY1JUEs3Kq60Ul5HDK7cslzx0HUtaMguClr3ssWDfTepbtL
         ovw71FO+uB/p10MXXU5wV+FIxm0Alg9Xfg1lqmgaPK/yDdgBhQd5vPYVh0wLIgVDZZx3
         dPAmXJguxPARU7QCPufSpOAUCeK5cRMp0B6imZW0V4ANInZvTJ7ajB0Inm4x0EjGp6Es
         Wbhnm26b0wmsT+fHGwEX6zAjQiYHHqHxJy3s6z89Aw7MPCfImieSNgdkVd2ObcJP/Wk8
         /e4hxQL0Ul5uq82/NO0aycsMoBsd7TRX8K5nZ45NaS1+aftC4UtV28u1uZweZBmA1YUo
         9jHg==
X-Gm-Message-State: AC+VfDwcJODNBTdZeVedeemosg2fCE7nVno9zr4sK1JIqQHyCEtHpDaH
        1c7wQsyEdYn4wtgKgzUORw==
X-Google-Smtp-Source: ACHHUZ4vr3xNzpq9w6LSGrgva6wTJyFPGqe9G/sPXOrmaY8BYB8TJO4CxLbWsDOLGNnSMzeY3U7/Ow==
X-Received: by 2002:a6b:db14:0:b0:777:b765:661a with SMTP id t20-20020a6bdb14000000b00777b765661amr15349944ioc.14.1686764222059;
        Wed, 14 Jun 2023 10:37:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t13-20020a5edd0d000000b0076373f90e46sm5518847iop.33.2023.06.14.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:37:01 -0700 (PDT)
Received: (nullmailer pid 2431248 invoked by uid 1000);
        Wed, 14 Jun 2023 17:36:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: octeon: Fix cvmx_writeq_csr/cvmx_readq_csr on 32-bit builds
Date:   Wed, 14 Jun 2023 11:36:31 -0600
Message-Id: <20230614173633.2430653-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test 32-bit builds have an error in cvmx_writeq_csr/cvmx_readq_csr:

arch/mips/include/asm/octeon/cvmx.h:282:24: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

As the default for allyesconfig/allmodconfig is 32-bit, fixing these
functions for 32-bit is needed to enable Cavium Octeon drivers for
COMPILE_TEST.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/include/asm/octeon/cvmx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 72e775bf31e6..2265a92995a8 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -279,7 +279,7 @@ static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
 
 static inline void cvmx_writeq_csr(void __iomem *csr_addr, uint64_t val)
 {
-	cvmx_write_csr((__force uint64_t)csr_addr, val);
+	cvmx_write_csr((__force uintptr_t)csr_addr, val);
 }
 
 static inline void cvmx_write_io(uint64_t io_addr, uint64_t val)
@@ -296,7 +296,7 @@ static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
 
 static inline uint64_t cvmx_readq_csr(void __iomem *csr_addr)
 {
-	return cvmx_read_csr((__force uint64_t) csr_addr);
+	return cvmx_read_csr((__force uintptr_t) csr_addr);
 }
 
 static inline void cvmx_send_single(uint64_t data)
-- 
2.39.2

