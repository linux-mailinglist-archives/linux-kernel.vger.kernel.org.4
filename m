Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8968C5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBFSc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBFScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:32:21 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9DA2E82B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:32:13 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so3449763oti.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5Dop0JJ1yXeqdmayLcKzOJgB2NB2hJjMqigFOhcalc=;
        b=UWPCVmXV/OVoiqbJXD3UrCLx/AzD90fZvAgKXN07YWo7ZM0hnGBzv3N7N6DTj4INRQ
         8M1wip0CDevWGv0pSfEE2MMb8Yuhm73cDrHJv87cBfUMpowVSn1ci05HZrA/ES2x0d6J
         jtNVGzKqu+KLrnlf/6LRb62WcqZECL1uaydVH/70g1/IEu4ump4xZQ958qhnExd4LRzn
         pP2uArcM5sueX5SC/kTh5OXypAzQt157cK3Yn9j9rqKUOaZB2WgyD/hB2+u9SXLB29yq
         Cgx+HbAiZoa7mBeoznOJyq+ynURWgfwIzXGcHs5mF3qbX4EwqjysS08FFO8Z/IdTflO6
         5R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5Dop0JJ1yXeqdmayLcKzOJgB2NB2hJjMqigFOhcalc=;
        b=JBBfS+IiAxuZiq5Cs/k8CaUjULuX0Va7MF+NBDlx+hDATOhsjgA9AoWz9XjwzcTBUO
         jCBDuNQwYZkFenrEagKQvECt+VVyn8zAlbQFkOw3wxISC/uxttczIQuKCssGGeWO78Xd
         XLtel3DHtjzi6QtDKZbCcGTZhbbK5ch6d6pA0FgEthg4tNYeRfkHhS17NoBauUlebEzW
         l8jy/aUc7NN/euZltVAEkkV9m/hhLdUA8/aixEZVmHgmtLMU0Cszpgn7wur+/3HQqnY6
         BU7Y0r+of8zoQze3tG6/14NmYrtnWOPWanUjtTFQyxNktbIQZpvWnS2Cr9j4feq24eMY
         Gs0A==
X-Gm-Message-State: AO0yUKV6m+Ie1EgVZWAMOym4AwYzCQ7MSURgjDmxUDK8OnsJp6gdBDPQ
        vwCvoxlqVTjv3EtkkhMIwcQCkg==
X-Google-Smtp-Source: AK7set9yreks8FLO+D7nQBY1YwZqgq43bkFaoHhBymtpwNvXXWloyHw4v2EoZjTPAoJCNpyRi1HW5A==
X-Received: by 2002:a9d:177:0:b0:68d:a785:5f5f with SMTP id 110-20020a9d0177000000b0068da7855f5fmr334566otu.2.1675708333198;
        Mon, 06 Feb 2023 10:32:13 -0800 (PST)
Received: from fedora.. ([186.122.48.201])
        by smtp.gmail.com with ESMTPSA id x39-20020a056830246700b0068bb7bd2668sm5201636otr.73.2023.02.06.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:32:12 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 1/1] spi: intel: Remove DANGEROUS tag from pci driver
Date:   Mon,  6 Feb 2023 15:31:43 -0300
Message-Id: <20230206183143.75274-2-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206183143.75274-1-mauro.lima@eclypsium.com>
References: <20230206183143.75274-1-mauro.lima@eclypsium.com>
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

Modern CPUs exposes this controller as PCI device that only uses
hardware sequencing capabilities which is safer than software
sequencing.
Leave the platform driver as *DANGEROUS* and update help text since
most of these controllers are using software sequencing.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/Kconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 87fc2bd16b72..3a362c450cb6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -447,7 +447,7 @@ config SPI_INTEL
 	tristate
 
 config SPI_INTEL_PCI
-	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
+	tristate "Intel PCH/PCU SPI flash PCI driver"
 	depends on PCI
 	depends on X86 || COMPILE_TEST
 	depends on SPI_MEM
@@ -455,8 +455,9 @@ config SPI_INTEL_PCI
 	help
 	  This enables PCI support for the Intel PCH/PCU SPI controller in
 	  master mode. This controller is present in modern Intel hardware
-	  and is used to hold BIOS and other persistent settings. Using
-	  this driver it is possible to upgrade BIOS directly from Linux.
+	  and is used to hold BIOS and other persistent settings. This
+	  driver only supports hardware sequencing mode. Using this
+	  driver it is possible to upgrade BIOS directly from Linux.
 
 	  Say N here unless you know what you are doing. Overwriting the
 	  SPI flash may render the system unbootable.
@@ -471,10 +472,10 @@ config SPI_INTEL_PLATFORM
 	select SPI_INTEL
 	help
 	  This enables platform support for the Intel PCH/PCU SPI
-	  controller in master mode. This controller is present in modern
-	  Intel hardware and is used to hold BIOS and other persistent
-	  settings. Using this driver it is possible to upgrade BIOS
-	  directly from Linux.
+	  controller in master mode that is used to hold BIOS and other
+	  persistent settings. Most of these controllers are using
+	  software sequencing mode. Using this driver it is possible to
+	  upgrade BIOS directly from Linux.
 
 	  Say N here unless you know what you are doing. Overwriting the
 	  SPI flash may render the system unbootable.
-- 
2.39.1

