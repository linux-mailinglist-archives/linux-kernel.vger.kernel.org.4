Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEB61A17B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiKDTts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKDTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:49:46 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D5BE09
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:49:44 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h10so3888349qvq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xGSGXGZQEff5krqyQd+s6hk5UW3mqSBj41TQ1U2uPHM=;
        b=k6woOhyB/rwLPf6UeUnssyahQq5VM1lJdF89aZcIDKVQ8YkEHfdNc+21YhGxC4zUOO
         KiOrrPC4HcpBAKLMmhPbCZ7mdwUBDEtGQtsjc5lkgC9YxrNgBcLQpH9c2TKsU52XJTYJ
         3uJdSBlEpFVTeLu1qn0ZaVUzgNt1aJjVk8Ql7WItk/G4GuY3rQ2nKyOTz9b4lCSZyk7C
         uffxJMzkOwCLKL5VSIjsBP+oM7a4+kM0dZVligTPZCCbfM9ynFk/99zaKHdU44nxwfRR
         Spdy1Tf/pdHJ6kLF86QZotMXSAqUxIa22um0DaH7t1A+3wwX0KUULsgDIS2KMrSk4iw4
         h5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGSGXGZQEff5krqyQd+s6hk5UW3mqSBj41TQ1U2uPHM=;
        b=L5aItQ4ifNI5O/ILG1wbPSmJvGsPD8yNatjONs1nqGHgaKrxDZmG4EOoIsLUzcHSkB
         aDwoZJmUQ96JmCJXL1uOBxyOQy5rYGNMlZ9KXVx9dHbwjhXrwH/uf45NWift+Z8Y2Ii/
         n1D6QWEUWiVOzf3QpYytSLFGHSy1ljpmWcaneO0jDMvCJ7/v0nzY2jdZaEcEkV6N+mZh
         z0zLuCREISzimqB4Jke8y4YnvaFNhEzipq9Bkj0A+aj6ZNVRkdoqvtxdV5qtVB/1vo4h
         eLWV0S9eODj1Zp2xk8sGF1q8L2xSgH0JZtXXqrtRdmjOtF+CMysDlYy72K3PikyNxmWR
         kQFg==
X-Gm-Message-State: ACrzQf3lYVJGyLnnoxeVyTydEOJ6mV+djPGZwd2UEUfnQaHHftdl5ije
        bKttO2bnnA/0UVY8lQ2pLk8B9g==
X-Google-Smtp-Source: AMsMyM4TX+MjUeivu1bdtFqBLQEpJVDi+fyaBHbX/Sg4qWUthM5x/Dgbom3s+jaFIcs/w4dnmFXwHg==
X-Received: by 2002:a05:6214:29c9:b0:4bb:b957:cd4a with SMTP id gh9-20020a05621429c900b004bbb957cd4amr33584296qvb.108.1667591384169;
        Fri, 04 Nov 2022 12:49:44 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b0039492d503cdsm138771qta.51.2022.11.04.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:49:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] mtd: onenand: omap2: add dependency on GPMC
Date:   Fri,  4 Nov 2022 15:49:34 -0400
Message-Id: <20221104194934.384371-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
OMAP GPMC driver, so the latter cannot be module if OneNAND driver is
built-in:

  /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
  onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mtd/nand/onenand/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index 34d9a7a82ad4..fa94c514626d 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -26,6 +26,7 @@ config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
 	depends on OF || COMPILE_TEST
+	depends on OMAP_GPMC || !OMAP_GPMC
 	help
 	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
 	  via the GPMC memory controller.
-- 
2.34.1

