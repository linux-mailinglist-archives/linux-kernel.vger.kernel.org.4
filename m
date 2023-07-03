Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB497745F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGCPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:07:15 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD3BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:07:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:bc71:f024:6708:ff])
        by baptiste.telenet-ops.be with bizsmtp
        id Gf782A00S0kCKfg01f784p; Mon, 03 Jul 2023 17:07:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qGL8t-000Rks-39;
        Mon, 03 Jul 2023 17:07:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qGL8u-0031nG-Nq;
        Mon, 03 Jul 2023 17:07:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode names
Date:   Mon,  3 Jul 2023 17:07:06 +0200
Message-Id: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eMMC and SDHI pin control configuration nodes in DT have subnodes
with the same names ("data" and "ctrl").  As the RZ/V2M pin control
driver considers only the names of the subnodes, this leads to
conflicts:

    pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by 85000000.mmc; cannot claim for 85020000.mmc
    pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
    renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reverse things back

Fix this by constructing unique names from the node names of both the
pin control configuration node and its child node, where appropriate.

Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio controller driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested on real hardware.
The RZ/G2L pin control drivers needs a similar fix.

Before:

    $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pingroups
    registered pin groups:
    group: data
    pin 130 (P8_2)
    pin 131 (P8_3)
    pin 132 (P8_4)
    pin 133 (P8_5)

    group: ctrl
    pin 128 (P8_0)
    pin 129 (P8_1)

    group: cd
    pin 135 (P8_7)

    $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pinmux-functions
    function 0: data, groups = [ data ]
    function 1: ctrl, groups = [ ctrl ]
    function 2: cd, groups = [ cd ]

After:

    $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pingroups
    registered pin groups:
    group: sd0.data
    pin 130 (P8_2)
    pin 131 (P8_3)
    pin 132 (P8_4)
    pin 133 (P8_5)

    group: emmc.data
    pin 0 (P0_0)
    pin 1 (P0_1)
    pin 2 (P0_2)
    pin 3 (P0_3)
    pin 4 (P0_4)
    pin 5 (P0_5)
    pin 6 (P0_6)
    pin 7 (P0_7)

    group: sd0.ctrl
    pin 128 (P8_0)
    pin 129 (P8_1)

    group: emmc.ctrl
    pin 10 (P0_10)
    pin 11 (P0_11)

    group: sd0.cd
    pin 135 (P8_7)

    group: sd0-uhs.data
    pin 130 (P8_2)
    pin 131 (P8_3)
    pin 132 (P8_4)
    pin 133 (P8_5)

    group: sd0-uhs.ctrl
    pin 128 (P8_0)
    pin 129 (P8_1)

    group: sd0-uhs.cd
    pin 135 (P8_7)

    $ cat /sys/kernel/debug/pinctrl/b6250000.pinctrl/pinmux-functions
    function 0: sd0.data, groups = [ sd0.data ]
    function 1: emmc.data, groups = [ emmc.data ]
    function 2: sd0.ctrl, groups = [ sd0.ctrl ]
    function 3: sd0.cd, groups = [ sd0.cd ]
    function 4: emmc.ctrl, groups = [ emmc.ctrl ]
    function 5: sd0-uhs.data, groups = [ sd0-uhs.data ]
    function 6: sd0-uhs.ctrl, groups = [ sd0-uhs.ctrl ]
    function 7: sd0-uhs.cd, groups = [ sd0-uhs.cd ]
---
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 28 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index e5472293bc7fb247..35b23c1a5684d3e4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -209,6 +209,7 @@ static int rzv2m_map_add_config(struct pinctrl_map *map,
 
 static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				   struct device_node *np,
+				   struct device_node *parent,
 				   struct pinctrl_map **map,
 				   unsigned int *num_maps,
 				   unsigned int *index)
@@ -226,6 +227,7 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	struct property *prop;
 	int ret, gsel, fsel;
 	const char **pin_fn;
+	const char *name;
 	const char *pin;
 
 	pinmux = of_find_property(np, "pinmux", NULL);
@@ -309,8 +311,19 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	if (parent) {
+		name = devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOFn.%pOFn",
+				      parent, np);
+		if (!name) {
+			ret = -ENOMEM;
+			goto done;
+		}
+	} else {
+		name = np->name;
+	}
+
 	/* Register a single pin group listing all the pins we read from DT */
-	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, num_pinmux, NULL);
+	gsel = pinctrl_generic_add_group(pctldev, name, pins, num_pinmux, NULL);
 	if (gsel < 0) {
 		ret = gsel;
 		goto done;
@@ -320,17 +333,16 @@ static int rzv2m_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	 * Register a single group function where the 'data' is an array PSEL
 	 * register values read from DT.
 	 */
-	pin_fn[0] = np->name;
-	fsel = pinmux_generic_add_function(pctldev, np->name, pin_fn, 1,
-					   psel_val);
+	pin_fn[0] = name;
+	fsel = pinmux_generic_add_function(pctldev, name, pin_fn, 1, psel_val);
 	if (fsel < 0) {
 		ret = fsel;
 		goto remove_group;
 	}
 
 	maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
-	maps[idx].data.mux.group = np->name;
-	maps[idx].data.mux.function = np->name;
+	maps[idx].data.mux.group = name;
+	maps[idx].data.mux.function = name;
 	idx++;
 
 	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
@@ -377,7 +389,7 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 	index = 0;
 
 	for_each_child_of_node(np, child) {
-		ret = rzv2m_dt_subnode_to_map(pctldev, child, map,
+		ret = rzv2m_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
 		if (ret < 0) {
 			of_node_put(child);
@@ -386,7 +398,7 @@ static int rzv2m_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	if (*num_maps == 0) {
-		ret = rzv2m_dt_subnode_to_map(pctldev, np, map,
+		ret = rzv2m_dt_subnode_to_map(pctldev, np, NULL, map,
 					      num_maps, &index);
 		if (ret < 0)
 			goto done;
-- 
2.34.1

