Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03396E4FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjDQSDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjDQSDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:03:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B206A63
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754622; x=1713290622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9e21tFRFiV9+9wH7e2y0RyrvY6ylThwIDqV0ywj2WJU=;
  b=fGXZRV/AhywUfoeHlObNIgHy1b101t2ikzkdUfnWm1ezD7tRMsSSBFu9
   7Xo33waHuY8yft3yX0RnSEvOMGW3egoM4j6GSdrUMJL/mweykU1qF2ZhD
   YRcmDf3lSMJJ9+q7g8up3SFwsJx2Jq6IN1DcG55OmuGz2GhO7KZX6CAMM
   ZrCopHscAZ6PQVN2klEd7cXFDLg7nkGQRPIzBD7oXAX4l2gbKvBBrH4GD
   wqraiTJ/XQpuHcFHkqB3eQL6dtt0OsAoK0Fo3fpDSkT6GYGN5HScG4OEQ
   4m23HDKARKZd1XVJ30kutq08bZY1ptxyKNSrgsj0oJY3i4XqGCbWaX0A4
   w==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="221268893"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:42 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:40 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Power down serdes lanes and CMUs initially
Date:   Mon, 17 Apr 2023 20:03:28 +0200
Message-ID: <20230417180335.2787494-1-daniel.machon@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to lower the power consumption of the Sparx5
switch chip, by configuring optimal quiet mode for serdes lanes, as well
as powering down unused CMUs (Clock Multiplier Unit). Before this series,
serdes lane quiet mode were not optimally configured, and all the CMUs were
powered on by default. This uses needless power.

Each serdes lane is provided a CMU clock, depending on the serdes mode
and the serdes index. CMUs will now be powered on individually, when
needed. The amount of power saved varies, depending on the port
configuration. As a reference, this change saves about 1W on
sparx5_pcb135 and 2W on sparx5_pcb134.

Patch #1: Adds the required registers.
Patch #2: Configures optimal quiet mode for all serdes lanes.
Patch #3: Reorders CMU functions.
Patch #4: Configures CMUs to be powered down by default.

Patch #5: Adds the serdes mode and index to CMU index map, and configures the
          individual CMU when the corresponding serdes lane is configured.

Patch #6: Removes the code that unconditionally powered on all CMUs
Patch #7: Adds a check that serdesmode is not unset when a CMU is configured.

Daniel Machon (7):
  phy: sparx5-serdes: add registers required for SD/CMU power down
  phy: sparx5-serdes: configure optimal qiet mode for serdes lanes
  phy: sparx5-serdes: reorder CMU functions
  phy: sparx5-serdes: power down all CMUs by default
  phy: sparx5-serdes: power on CMUs individually
  phy: sparx5-serdes: remove power up of all CMUs
  phy: sparx5-serdes: do not reconfigure serdes if serdesmode is unset

 drivers/phy/microchip/sparx5_serdes.c      | 426 +++++++++++++--------
 drivers/phy/microchip/sparx5_serdes.h      |   1 -
 drivers/phy/microchip/sparx5_serdes_regs.h | 106 +++++
 3 files changed, 370 insertions(+), 163 deletions(-)

--
2.34.1
