Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7D6561BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLZJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:58:04 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F12603;
        Mon, 26 Dec 2022 01:58:02 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BQ9vk6R078242;
        Mon, 26 Dec 2022 03:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672048667;
        bh=iHhOUXpNSlhf+aIXB7cwH4ZQHQG6+xLFZJXmmofWBM8=;
        h=From:To:CC:Subject:Date;
        b=QLs8CJTcw7OO2+SIzSsESij60DuJnA6+1qwFCX6vT9twmSPXyp5HEN8R7pnfwVJzk
         czacw1K381uVNiUVG1QDKGZ65c8DNLVP+euEU9eGVUtzKi4psVndnyuz2ov1v6R257
         DnugGubXoX57ytDRuSDsmcJSSgjRA0wkxCVBgAzk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BQ9vk09112194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Dec 2022 03:57:46 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 26
 Dec 2022 03:57:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 26 Dec 2022 03:57:46 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BQ9vjCi003614;
        Mon, 26 Dec 2022 03:57:46 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Tomi Valkeinen <tomba@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 0/2] Re-introduce parent clock-rate set for fixed-factor clock
Date:   Mon, 26 Dec 2022 15:27:43 +0530
Message-ID: <20221226095745.19757-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The support for configuring CLK_SET_RATE_PARENT flag for a few specific
clocks was only used by the legacy Allwinner A10 sunxi clock, and the
reason its compatible was dropped was that the code supporting the
legacy sunxi platforms was removed (as the below-mentioned patch set
highlights) and no other fixed factor clock needed to do the same.

https://lore.kernel.org/lkml/20220531051742.43273-1-samuel@sholland.org/T/


The current patch series adds "ti,k3-am62-oldi-clk-div" (TI's display
subsystem (DSS) clock for the 1st videoport (vp0) on the AM625 SoC) as
a fixed factor clock and further, it also re-introduces the same support
to set the CLK_SET_RATE_PARENT flag.

Based on the clock-set request from DSS (equivalent to pixel frequency),
this clock asks its parent for a serial clock (with 7 times the pixel
frequrncy), which is required for the generation of serial LVDS signals.
This clock thus requires the CLK_SET_RATE_PARENT flag to be set, in
order to propagate the set clock-rate request to its parent clock.

Aradhya Bhatia (2):
  dt-bindings: clock: fixed-factor: Add TI AM62 SoC OLDI clock
  clk: fixed-factor: Re-introduce support for clocks to set parent
    clock-rate

 .../devicetree/bindings/clock/fixed-factor-clock.yaml |  1 +
 drivers/clk/clk-fixed-factor.c                        | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.39.0

