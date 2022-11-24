Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C163A25A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiK1H4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiK1H4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:56:41 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 23:56:38 PST
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9049AA44E;
        Sun, 27 Nov 2022 23:56:38 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 8D80B135A; Mon, 28 Nov 2022 08:49:01 +0100 (CET)
From:   Nikolaus Voss <nikolaus.voss@haag-streit.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 24 Nov 2022 17:50:34 +0100
Subject: [PATCH 1/2] nvmem: imx-ocotp: reverse MAC on imx6qdl
Message-Id: <20221128074901.8D80B135A@mail.steuer-voss.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet MAC on iMX6Q/DL is stored in OTP in little-endian byte order. I
suspect that this is true for all iMX flavors. If so, we could get rid
of the .reverse_mac_address attribute entirely.

Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
---
 drivers/nvmem/imx-ocotp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 14284e866f26e..a39a0defb070a 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -496,6 +496,7 @@ static const struct ocotp_params imx6q_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
+	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx6sl_params = {
-- 
2.34.1

