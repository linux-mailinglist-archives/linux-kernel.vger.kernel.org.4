Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95AA5FC04C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJLF5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJLF5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:57:24 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F696ABD62;
        Tue, 11 Oct 2022 22:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554222; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FvfNG07iMKNR5U2ejpxyH2zlSm27+YkjplBGBsgjMzGIhJQuB8BXIUkQHBfYognfakb7GmEKRLPOLvY8W7MhrP13/Uvf0QP0TQvVP7j3duz7m7WexdcHEFtuK4f/bS4ML5FuzWiZkcRYISyxEhutI0GtYxcp+9aw2F+buYPrbdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554222; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=IHTmXBmR+SFMmksKEImErp0u02umet9I7N/QedIBsg0=; 
        b=I4ocvCEW7R83bS1dwEosMQ7CfgKOmdYkV2HT11tlbQ1ZwyPaI6uV44ShwfGFUk5amnytCe43kYvS7Q1OwRkriJTTMT4RfbVs6VFs7y3wSFBFSkqH/IweIghbxEJncFaShO3ByC0A1ywIC2J8ZRazOeaSe+FVmHe81xA6dDP2HaM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554222;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=IHTmXBmR+SFMmksKEImErp0u02umet9I7N/QedIBsg0=;
        b=fboFKdqMktGTVCo7PalO8Q/YiUucZt5w62Dh390+w6vyOo9cevo3BPWuzc5eWR1t
        yINLo+qReqseC7WsRLjtwBfrm9jcnEyeRBjWY4GRLunAQ52wmgsP5uOd8iyqMF2YZq/
        JWpc0Hk3zsK7A2snd5VKsJdNp8BF9gZG82wWDi74=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 16655542214699.646510723270012; Tue, 11 Oct 2022 22:57:01 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 05/10] musb: sunxi: add support for the F1C100s MUSB controller
Date:   Wed, 12 Oct 2022 13:55:57 +0800
Message-Id: <20221012055602.1544944-6-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012055602.1544944-1-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv SoC has a MUSB controller like the one in A33, but with a SRAM
region to be claimed.

Add support for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes since v1.

 drivers/usb/musb/sunxi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 7f9a999cd5ff..4b368d16a73a 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -722,14 +722,17 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	INIT_WORK(&glue->work, sunxi_musb_work);
 	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags);
+	}
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 
 	if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb") ||
-	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb")) {
+	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 		set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
 	}
@@ -815,6 +818,7 @@ static const struct of_device_id sunxi_musb_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-musb", },
 	{ .compatible = "allwinner,sun8i-a33-musb", },
 	{ .compatible = "allwinner,sun8i-h3-musb", },
+	{ .compatible = "allwinner,suniv-f1c100s-musb", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_musb_match);
-- 
2.37.1

