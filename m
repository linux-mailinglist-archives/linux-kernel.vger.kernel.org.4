Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C718680D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjA3MJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjA3MIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:08:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9A1CF68
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080504; x=1706616504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nh6/usZ2THZBSY98qO/fgkA7zKcsohS6tiOaRuCPZGk=;
  b=TbxPWJ4eoweYuSxWm4F/Jeh/OjEtIfX9GHaBMoz05i84nW3RDbuZZ7M7
   gAERwrXHbNtBYe6BhEzCtw2vJsSo1pICFfvH8KLdMI1793CBCrsyehffM
   YJUyIjuB+P3hXclKo9KHPLTT0h5ubZRvGjKtkV9dO+k+Dw9GvDOA4fc3Y
   Et7SDFU5/0JQWjWqNtAm1yHlU38gCpdOSuuPMz1hidlkP3qPTmNRFrowX
   mViWkh6Q6/C8qk14aWgYvGPEzkaIs3i9MrkF1kTzMImRh2ebjEss5v7XY
   DDw5AN23qO9Cc4xvZp80aMwHUpu3l8VWXqQjXNSclU1MC+xKpeEco30Ap
   A==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="198784198"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:20 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/8] ASoC: mchp-spdifrx: add runtime PM support and fixes
Date:   Mon, 30 Jan 2023 14:06:39 +0200
Message-ID: <20230130120647.638049-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds runtime PM support for Microchip SPDIFRX driver.
Along with it I added few fixes identified while going though the code
and playing with Microchip SPDIFRX controller.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ASoC: mchp-spdifrx: fix controls which rely on rsr register
  ASoC: mchp-spdifrx: fix return value in case completion times out
  ASoC: mchp-spdifrx: fix controls that works with completion mechanism
  ASoC: mchp-spdifrx: disable all interrupts in
    mchp_spdifrx_dai_remove()
  ASoC: mchp-spdifrx: use unsigned long to store clk_get_rate() value
  ASoC: mchp-spdifrx: remove struct mchp_spdifrx_dev::fmt member
  ASoC: mchp-spdifrx: add runtime pm support
  ASoC: mchp-spdifrx: document data structures

 sound/soc/atmel/mchp-spdifrx.c | 552 ++++++++++++++++++++++++---------
 1 file changed, 403 insertions(+), 149 deletions(-)

-- 
2.34.1

