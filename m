Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF31E70C1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjEVO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjEVO7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:59:08 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75220FD;
        Mon, 22 May 2023 07:58:57 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 15EA921332;
        Mon, 22 May 2023 16:58:51 +0200 (CEST)
Date:   Mon, 22 May 2023 16:58:46 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrew Lunn <andrew@lunn.ch>, Praneeth Bajjuri <praneeth@ti.com>,
        Geet Modi <geet.modi@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: DP83867 ethernet PHY regression
Message-ID: <ZGuDJos8D7N0J6Z2@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
commit da9ef50f545f ("net: phy: dp83867: perform soft reset and retain
established link") introduces a regression on my TI AM62 based board.

I have a working DTS with Linux TI 5.10 downstream kernel branch, while
testing the DTS with v6.4-rc in preparation of sending it to the mailing
list I noticed that ethernet is working only on a cold poweron.

With da9ef50f545f reverted it always works.

Here the DTS snippet for reference:

&cpsw_port1 {
	phy-handle = <&cpsw3g_phy0>;
	phy-mode = "rgmii-rxid";
};

&cpsw3g_mdio {
	assigned-clocks = <&k3_clks 157 20>;
	assigned-clock-parents = <&k3_clks 157 22>;
	assigned-clock-rates = <25000000>;

	cpsw3g_phy0: ethernet-phy@0 {
		compatible = "ethernet-phy-id2000.a231";
		reg = <0>;
		interrupt-parent = <&main_gpio0>;
		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
		reset-gpios = <&main_gpio0 17 GPIO_ACTIVE_LOW>;
		reset-assert-us = <10>;
		reset-deassert-us = <1000>;
		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
	};
};

Any suggestion?
Francesco

