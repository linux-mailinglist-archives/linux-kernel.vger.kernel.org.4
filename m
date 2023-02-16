Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA8699A72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBPQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:47:04 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A794CC99;
        Thu, 16 Feb 2023 08:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676566004; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GrPLRpJVoAtGe1QSM3oCQ0Z1MFBjeDNtoCW1YI3XlifzYQPOMYr/9GjmDMdsTrwcbK
    tkY4cEYKTRrV7XQUt8lMRdT+C/MBTGVdKtNvtaGVfvDcvKc8vOW6wL9ZvFMotGBZAljB
    qRrOBCZCRvh6TWEOXgI/s+VLKj+G33aYhG8FNtYlCpuVgBayGM43eVC/oLvfFZaUIHy4
    3MXRR9motdBqy1/7oaTvNJUbphFJ1aflOoVpnlrxn7fGA/8Cn0KBALY7wIVT5/cOVixX
    /RFViT0DoBLlOMWScs09wdturZiJ+JAPNnOoIBZEjOtzVZKSMpNRhMEjRicZVaiD34fk
    79CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676566004;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Zi6Do96Wyv8JYhglKdzeHQTuT3KJmQXKv8y3uhJcpwY=;
    b=iu2I4EX/mVPxDGay7t5wMaZ1MKu5LOLFVlxDP6Nq1Vt3ADuG/h4wfaS4VzRAdZokno
    bvVtZaNFmV5ICWFFZ/aGGLxSnb63AIEJ04Xeiad+yHGW8HLa20aKakqe/bEa8SF9ULWO
    67oRiViILIgGk9XtgemJPqoLMpyJnajvRFhXjwk6WCz9uFJNqcyOJ1XFRtTLbHEkTLJ2
    JijZi19MbrkOz18hF4gEKjrBUB/hE19BpprTnQq7EAiu2etUR9597KMGgWmGbbU8YaKg
    3/IioAJ2Aq7L9b1chqEr3lRF7o1yMTKDijP1AgGTNUDPhc0fFg9QEh0SDztUnOy5LA/s
    fSBQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676566004;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Zi6Do96Wyv8JYhglKdzeHQTuT3KJmQXKv8y3uhJcpwY=;
    b=abIRn0yOpZ11kuW3rSNDWUmU9Uad2JztvC5XQkBtn0VUakeoRm/zZblfnljQ5tBih2
    WPjfVvVZcjXaj1FGtD6DXoXuG93Yb2R3zdq7k/5TWbwzglMRNBfEu7BCp/mpOanaMjl6
    2ahc0UfmxHrYAFcjqYCJYkAFgqEADCDqgB426Bvq8lTrRIrmgXkCV+iFJ7LINZNiYJWk
    ZwLUsZ7ZDbJg78vW0wvoAYvLihVoseYZUDN0LjGmsFotKZSrLaptxVlJBRDbJQNEh6Ap
    opKgJzC9zoP40bcss0yIdO572BQUTefhRD4rfDtLj9tomlLqWzlMhPhX1TLnuBtmu6D7
    MmNg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZq23J"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1GGkhhTj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 16 Feb 2023 17:46:43 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: omap3-gta04: fix compatible record for GTA04 board
Date:   Thu, 16 Feb 2023 17:46:43 +0100
Message-Id: <38b49aad0cf33bb5d6a511edb458139b58e367fd.1676566002.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vendor of the GTA04 boards is and always was
Golden Delicious Computers GmbH&Co. KG, Germany
and not Texas Instruments.

Maybe, TI was references here because the GTA04 was based on
the BeagleBoard design which is designated as "ti,omap3-beagle".

While we are looking at vendors of omap3 based devices, we also
add the record for OpenPandora. The DTS files for the pandora
device already make use of it.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
 arch/arm/boot/dts/omap3-gta04.dtsi                     | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 70ffb3780621b..1476aaaebf883 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -508,6 +508,8 @@ patternProperties:
     description: GlobalTop Technology, Inc.
   "^gmt,.*":
     description: Global Mixed-mode Technology, Inc.
+  "^goldelico,.*":
+    description: Golden Delicious Computers GmbH & Co. KG
   "^goodix,.*":
     description: Shenzhen Huiding Technology Co., Ltd.
   "^google,.*":
@@ -959,6 +961,8 @@ patternProperties:
     description: OpenCores.org
   "^openembed,.*":
     description: OpenEmbed
+  "^openpandora,.*":
+    description: OpenPandora GmbH
   "^openrisc,.*":
     description: OpenRISC.io
   "^option,.*":
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 87e0ab1bbe957..5932012d04966 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -11,8 +11,7 @@
 
 / {
 	model = "OMAP3 GTA04";
-	compatible = "ti,omap3-gta04", "ti,omap3630", "ti,omap36xx", "ti,omap3";
-
+	compatible = "goldelico,gta04", "ti,omap3630", "ti,omap36xx", "ti,omap3";
 	cpus {
 		cpu@0 {
 			cpu0-supply = <&vcc>;
-- 
2.38.1

