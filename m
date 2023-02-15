Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3B6988CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBOXgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBOXgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:36:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9543469;
        Wed, 15 Feb 2023 15:36:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so282434wmb.5;
        Wed, 15 Feb 2023 15:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLWxglH8TvO+YjEnp0OsBiwCevBxF+hBx7Ea32u4U1s=;
        b=XqP2qTHN3FxCW03V1fZuaqLV9dSsKSa5UCeHysLTZ6Z2ilvx3KPGTDbe0f1HqCMTrh
         0QzhOvWMipm4pTrDTiEIKI6ATFUUAFDJkApr6U/0/xIgVwIpaCMYXlqx8/323YIG9sab
         YoDWAJTWSVW+YexHbB9kS92EdUQxsO3p8HoQwlbG1xpHS8qWfizGZ76FpnYzjI58we6u
         XI67WcJHrLfkxdJWpmDo7iC8gMO6oWc/lzkiDh1+VsiCWKg0FJpdgGjbB3KpLhmvo3Di
         hDnJlFreRzTOXeRyc8LPVw2J7Eem2LfC9l3xss+UfCBIni4PmOyzBeLbTauIfKpGI9YU
         yrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLWxglH8TvO+YjEnp0OsBiwCevBxF+hBx7Ea32u4U1s=;
        b=FNBg2GofetG2wrbkKYjdr3CEvl/u/v2pN3aRBuUoBo6hMsECD+9Jk2/mmo+3nQuYg2
         makUCCca/BnbrVSLw5RYHmYmbQ1wcBmY1sFv0gvuYGCOQ2CczUJBCF1TPNWbFSt8kB5b
         n2dFfqpqnVUtqv0UPYA9NE+oaOXbxFZu9HQDf7uw2NK6Qp1NYSUyOjkDWtpMj93gWzN1
         m0eMSZA6LPYX3+k1C29YPL6800R5gN1Tcvw1zco6wKAtCrwor6QP1phKwgVC+pxwKyhd
         AI7husgMjZoV0LChgW45WsYKvvZA2QVVIoMtX8PWj/7URsf84k4uj4dRyWpQdRlq6Fb/
         iPuQ==
X-Gm-Message-State: AO0yUKWcj14FyU5zaE0cCmjOF2LitulhVkZAkFf1MKfFojT8+LiGP/Xn
        QFnfBTmrgKFJh1javsiVyn4=
X-Google-Smtp-Source: AK7set/0N26bH2pJeOZrfQ3amLrk+OGysrgVUNLdiap4mWIP9pBIBXj5sL9Q/8s3teDjjYS9FR3cVQ==
X-Received: by 2002:a05:600c:44c4:b0:3da:fc30:bfc5 with SMTP id f4-20020a05600c44c400b003dafc30bfc5mr3259702wmo.13.1676504207100;
        Wed, 15 Feb 2023 15:36:47 -0800 (PST)
Received: from localhost.localdomain (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.googlemail.com with ESMTPSA id m17-20020a05600c3b1100b003dd1bd0b915sm3702281wms.22.2023.02.15.15.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:36:46 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] clk: Fix wrong clock returned in parent_data with .name and no .index
Date:   Thu, 16 Feb 2023 00:27:12 +0100
Message-Id: <20230215232712.17072-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
introduced a regression due to a "fragile" implementation present in some very
corner case.

Such commit introduced the support for parents to be specified using
clkspec index. The index is an int and should be -1 if the feature
should not be used. This is the case with parent_hws or legacy
parent_names used and the index value is set to -1 by default.
With parent_data the situation is different, since it's a struct that
can have multiple value (.index, .name, .fw_name), it's init to all 0 by
default. This cause the index value to be set to 0 everytime even if not
intended to be defined and used.

This simple "fragile" implementation cause side-effect and unintended
behaviour.

Assuming the following scenario (to repro the corner case and doesn't
reflect real code):

In dt we have a node like this:
		acc1: clock-controller@2098000 {
			compatible = "qcom,kpss-acc-v1";
			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
			clock-output-names = "acpu1_aux";
			clocks = <&pxo_board>;
			clock-names = "pxo";
			#clock-cells = <0>;
		};

And on the relevant driver we have the parent data defined as such:
		static const struct clk_parent_data aux_parents[] = {
			{ .name = "pll8_vote" },
			{ .fw_name = "pxo", .name = "pxo_board" },
		};

Someone would expect the first parent to be globally searched and set to
point to the clock named "pll8_vote".
But this is not the case and instead under the hood, the parent point to
the pxo clock. This happen without any warning and was discovered on
another platform while the gcc driver was converted to parent_data and
only .name was defined.

The reason is hard to discover but very simple.

Due to the introduction of index support, clk_core_get() won't return
-ENOENT but insted will correctly return a clock.
This is because of_parse_clkspec() will use the index (that is set to 0
due to how things are allocated) and correctly find in the DT node a
clock at index 0. That in the provided example is exactly the phandle to
pxo_board.

Clock is found so the parent is now wrongly linked to the pxo_board
clock.

This only happens in this specific scenario but it's still worth to be
handled and currently there are some driver that hardcode the
parent_data and may suffer from this.

To fix this and handle it correctly we can use the following logic:
1. With a .fw_name not defined (index searching is skipped if a named
   clock is provided)
2. Check if .name is provided
3. Compare the provided .name with what clockspec found
4. Return -ENOENT if the name doesn't match, return the clock if it does.

Returning -ENOENT permit clk core code flow to fallback to global
searching and correctly search the right clock.

Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 998676d78029..42e297fcfe45 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -395,6 +395,7 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
  */
 static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 {
+	const char *global_name = core->parents[p_index].name;
 	const char *name = core->parents[p_index].fw_name;
 	int index = core->parents[p_index].index;
 	struct clk_hw *hw = ERR_PTR(-ENOENT);
@@ -407,6 +408,23 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	    !of_parse_clkspec(np, index, name, &clkspec)) {
 		hw = of_clk_get_hw_from_clkspec(&clkspec);
 		of_node_put(clkspec.np);
+
+		/*
+		 * The returned hw may be incorrect and extra check are required in
+		 * some corner case.
+		 *
+		 * In case a .fw_name is not set of_parse_clkspec will use the index
+		 * to search the related clock.
+		 * But index may be never set and actually never intended to be used
+		 * in the defined parent_data since a 0 value is also accepted and that
+		 * is what by default each struct is initialized.
+		 *
+		 * In the following case check if we have .name and check if the returned
+		 * clock name match the globally name defined for the parent in the
+		 * parent_data .name value.
+		 */
+		if (!name && global_name && strcmp(global_name, hw->core->name))
+			return ERR_PTR(-ENOENT);
 	} else if (name) {
 		/*
 		 * If the DT search above couldn't find the provider fallback to
-- 
2.38.1

