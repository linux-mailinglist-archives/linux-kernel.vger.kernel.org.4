Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558B6340C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiKVQCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKVQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:02:11 -0500
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 08:02:07 PST
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A9725C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:02:07 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NGpjd72bdzMq8y8;
        Tue, 22 Nov 2022 16:54:45 +0100 (CET)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NGpjd3pT8zMpqZJ;
        Tue, 22 Nov 2022 16:54:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1669132485;
        bh=OibOyPbYDvOO36AmVFDgYcMxPI1BJwV2MyOCOtx4pbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndmRKFwp01B18jzR8dtJjQmXt6zxUgMJKIDHZeT8DKGjl1g+KRT0kKE801XFIjFhs
         OC5Ztd9R8p4A5AzRgipP23zDyqZGddVbka0ek/vuBQHsQ+uPyrE9Gdhl7Z0jdQFqk1
         cAYTydENUj/VtWBerQKaNNW3HHgCURxsV48+rQbs=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: dts: colibri-imx6: Disable usb over-current
Date:   Tue, 22 Nov 2022 16:54:35 +0100
Message-Id: <20221122155439.456142-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122155439.456142-1-dev@pschenker.ch>
References: <20221122155439.456142-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Disable usb over-current of the chipidea driver on all Carrier-Boards
used by Toradex. Do this as we don't want to use this functionality on
our Carrier Boards and to leave it open to someone who includes our
module-level device-trees.

Remove the now obsolete disable-over-current flag from module-level
device-tree imx6qdl-colibri.dtsi and leave it as already mentioned to
the people actually implementing the carrier-board to implement this.

This will prevent the warning "No over current polarity defined" from
being printed on boot.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm/boot/dts/imx6dl-colibri-aster.dts   | 2 ++
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 2 ++
 arch/arm/boot/dts/imx6dl-colibri-iris.dts    | 2 ++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 1 -
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-aster.dts b/arch/arm/boot/dts/imx6dl-colibri-aster.dts
index a28e083f29d5..82a0d1a28d12 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-aster.dts
@@ -99,10 +99,12 @@ &uart3 {
 };
 
 &usbh1 {
+	disable-over-current;
 	status = "okay";
 };
 
 &usbotg {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index a02981d4a3fc..f50a26dd34c0 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -111,10 +111,12 @@ &uart3 {
 };
 
 &usbh1 {
+	disable-over-current;
 	status = "okay";
 };
 
 &usbotg {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-colibri-iris.dts b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
index c5797ff35b71..4303c88bb2a9 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-iris.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-iris.dts
@@ -138,10 +138,12 @@ &uart3 {
 };
 
 &usbh1 {
+	disable-over-current;
 	status = "okay";
 };
 
 &usbotg {
+	disable-over-current;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d8f985f297e4..f894d6907604 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -684,7 +684,6 @@ &usbh1 {
 
 /* Colibri USBC */
 &usbotg {
-	disable-over-current;
 	dr_mode = "otg";
 	extcon = <0>, <&extcon_usbc_det>;
 	status = "disabled";
-- 
2.38.1

