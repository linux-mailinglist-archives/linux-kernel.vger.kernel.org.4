Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61060F644
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiJ0LdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiJ0LdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:33:01 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8B61211D9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:32:59 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7E33E1B40;
        Thu, 27 Oct 2022 13:32:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666870376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=86Syqd89b1/HCshZzD+et9Bo2opsZhhVIvgaLhrsOcI=;
        b=mvJXS1/G8NnG3D8HvhI7aMBDN2AXxviQSZavm7F0DzocELCt0oHdv4/KtBG5eJQ7oGQuHa
        gmQ4L6B6yEJJ2fneIa9NrNWrDt4jgLaN3G0cIMq56FyxznBTnb78gxVtlUeHys9Pu8q3FD
        uty1ze5E+RFo9Wcx1tZrZWGBVkLQhp/nPJdxWgSddvpdP3TgpUHll5nFJlAWiBXIdZikHj
        dmotv999hjgrG09N0X8YkS72kyk1hm2Cw8+06a5oocyBcFw8qyHa/m8WJ+fRWS/rZTsNN/
        PoMnKhHxwRZ7l6SX4CAWBpRxS6xlhfYycrSjpwtw6/yDINY7LmShYi3ud4N+dQ==
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q tagging by default"
Date:   Thu, 27 Oct 2022 13:32:48 +0200
Message-Id: <20221027113248.420216-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit be0b178c50c37a666d54f435da71cf9f008362a0.

This commit will break networking on the sl28 boards if the tagger is
not compiled into the kernel. If a non-default tagger is used, the
kernel doesn't do a request_module(). Fixing that is also not that
trivial because the tagger modules are loaded by ids, not by name.
Thus for now, just revert to the default tagger until that is fixed.

Fixes: be0b178c50c3 ("arm64: dts: ls1028a: sl28: use ocelot-8021q tagging by default")
Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
Vladimir, I'm not sure how to fix that one. Adding aliases to the tagger
modules? Something like "MODULE_ALIAS("dsa_tag-ocelot-8021q");" and then do
a request_module() in dsa_find_tagger_by_name(), too?

 .../arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 72429b37a8b4..771c50c7f50a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -324,14 +324,6 @@ &lpuart1 {
 	status = "okay";
 };
 
-&mscc_felix_port4 {
-	dsa-tag-protocol = "ocelot-8021q";
-};
-
-&mscc_felix_port5 {
-	dsa-tag-protocol = "ocelot-8021q";
-};
-
 &usb0 {
 	status = "okay";
 };
-- 
2.30.2

