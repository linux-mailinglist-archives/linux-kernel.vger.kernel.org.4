Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92FE715A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjE3Jjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE3Jjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:39:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299BBFC;
        Tue, 30 May 2023 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685439577; x=1716975577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EilXIOvUaLl6Wbm/Y1NuawMKvR7ssqkmCU3WRLSqQPs=;
  b=2FMHPj05fwHXm5WAAun6rvJUVbsgFB+m6GteUEJ1R9YycQJJpc0QzyBu
   m6K2QWC4UEhmn1iaDEbwJ/jNJVFpbo16eUsol62ErHBn2W3GCPmKanR1n
   8e6thTzVkpSoVw3nwEnSEMEdgEj4SK06ZxLZokowgkVnECerM7Qw78taR
   qdFoM7PBypOiocFvrc7HZNpR1tqdVGvf3CmwWd5AyGXT2nunPUiPt7hPr
   W/PTkI72iL96OaSy7DgvhmxOEj0NzOmjU067QdYCt5miEmRKjpbzbOcuA
   YVD/Ij9cblbJNiOnnJhZm2iEHoZHTHzFIPnhhA4OHDFdaAirmQdeEbPru
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="217918973"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:39:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:39:35 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:39:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <luca.ceresoli@bootlin.com>, <nm@ti.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <michal.simek@xilinx.com>
CC:     <aford173@gmail.com>, <mike.looijmans@topic.nl>,
        <robert.hancock@calian.com>, <shawn.guo@linaro.org>,
        <fabio.estevam@freescale.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/8] clk: check memory returned by {devm_}kasprintf()
Date:   Tue, 30 May 2023 12:39:05 +0300
Message-ID: <20230530093913.1656095-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While browsing some code I noticed that there are places where pointer
returned by devm_kasprintf() or kasprintf() is not checked. Thus I've
tooked the chance and fixed this (by updating kmerr.cocci script,
changes published at [1]). Along with it some other places where
resources may need to be freed on failure paths were updated.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/

Claudiu Beznea (8):
  clk: vc5: check memory returned by kasprintf()
  clk: cdce925: check return value of kasprintf()
  clk: si5341: return error if one synth clock registration fails
  clk: si5341: check return value of {devm_}kasprintf()
  clk: si5341: free unused memory on probe failure
  clk: keystone: sci-clk: check return value of kasprintf()
  clk: ti: clkctrl: check return value of kasprintf()
  clk: clocking-wizard: check return value of devm_kasprintf()

 drivers/clk/clk-cdce925.c                  | 12 +++++++
 drivers/clk/clk-si5341.c                   | 38 +++++++++++++---------
 drivers/clk/clk-versaclock5.c              | 29 +++++++++++++++++
 drivers/clk/keystone/sci-clk.c             |  2 ++
 drivers/clk/ti/clkctrl.c                   |  7 ++++
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c |  5 +++
 6 files changed, 78 insertions(+), 15 deletions(-)

-- 
2.34.1

