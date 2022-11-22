Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184A9633960
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKVKKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKVKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:12 -0500
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 02:10:10 PST
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FA2545A3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:10:10 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id B7A935E8AB;
        Tue, 22 Nov 2022 11:00:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669111209;
        bh=gdo4vgWV8tXNuK/w1oRYXeG/YbiAC9Xkv0incWmwWPA=;
        h=From:To:CC:Subject:Date:From;
        b=CnYh0QcxCL0AUHn2PJFVyzpcsVUUV4l7cW96wyZXwCj3oPgfJqr8ym3dP1ge4iea1
         /WiDzVtwGEotIfpkZBt4uXkhcGGBEXHMMoKuKy63uC+m90Vgr0Yh5t6PN4jnW9BTnP
         I8xpyUgi0N003wA7LoshBNjHwmY2a/dky1WK3WTPrOwBEM0bjB3Rj43VTJaHSS6fNQ
         z9xYtOm+FTsyAma4qe2o25FJ9CPWQLtm/+XJGCnVMnZFSjNQ6YORNOpSpiH+/uEJ53
         Dala/yAKrKDlx+0xCTa14KYsIg6+/3fHwGvZNyZJcHv+mOrJseBUCIFhKP9/MR2E0a
         tIRlJdLJZgRwg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 22 Nov 2022 11:00:00 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Tue, 22 Nov 2022 10:59:59 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] mfd: da9062: Make the use of IRQ optional
Date:   Tue, 22 Nov 2022 10:58:30 +0100
Message-ID: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the core functionality of the MFD DA9061/62 IRQ isn't needed. This
series removes the requirement for an IRQ. This is done by modifing the
MFD driver and regulator driver to setup the device without IRQ. This
makes the DA9061/62 chip useable for designs which haven't connected
the IRQ pin.

I tested it with a DHCOM i.MX6ULL, which is powered by a DA9061.

In this series, the DT binding file is also adapted.

Christoph Niedermaier (3):
  dt-bindings: mfd: da9062: Move IRQ to optional properties
  mfd: da9062: Remove IRQ requirement
  regulator: da9062: Make the use of IRQ optional
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/mfd/da9062.txt | 11 +--
 drivers/mfd/da9062-core.c                        | 98 ++++++++++++++++++------
 drivers/regulator/da9062-regulator.c             |  7 +-
 3 files changed, 82 insertions(+), 34 deletions(-)

-- 
2.11.0

