Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA517200F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjFBLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjFBLyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:54:37 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E41BB;
        Fri,  2 Jun 2023 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685706843; x=1717242843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LABoMO8CCV2HXsLiDgIjvxsb0uweZP5XENgJqsudm+M=;
  b=CwLTX5Bof1On4jMTpMzQCh0KwHFrTHV0KI3gJXCwKSCjKyLMoD6XZRJH
   ocWJqbeWSWAR2E5QJg7HWK4jNqzghCAPevqUd1j78tPLI2FiGY8JWvfa+
   ALaS4uT2+2ROK/Ji7u1RIkfzZzSxAwRBQFrdqA9SacTeQi39NP4bl+ZW7
   Sul80Oj5TnG+gXSkcI+Dpb90V2inwQlgTmu2jd8nmha6Y5ew9H2IcqsLN
   01+ejvfz2+mC9yTJ52efJjGgiqKA63hdkLrKo4WPG+rS+EMTUB1eCrfVp
   prd8u1PGVAhnN7ER6A3IbvnVzYfCTb351lGgYvLA0u9RP0crf/Hl5uQHJ
   A==;
X-IronPort-AV: E=Sophos;i="6.00,212,1681164000"; 
   d="scan'208";a="31246992"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Jun 2023 13:52:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 02 Jun 2023 13:52:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 02 Jun 2023 13:52:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685706760; x=1717242760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LABoMO8CCV2HXsLiDgIjvxsb0uweZP5XENgJqsudm+M=;
  b=aTqFSHMRk3De/cHHxAvUPin7+/VybecWvYZ4dpNbElfpKMxbfpFWLyT6
   130G6ZGi+hgqKgacfp8pka2AL8UsqyJJiJgEJSfjh+5kNdgirut8/rohF
   v9iS43h1/Lo3XZNgw1hOFTZiy1+JJKYWVKkRn74f+mJABPm+ujG84sxHE
   yoDVAy2M1GrSPP1uKydl1O39GqVKb0k4Xtpf/aaAIIjS7w7XfxgcdzMLx
   qoHipIotnKeCYqNL1qjxp1420RrQpKXJKGu+p5S/eG3W7zNBvE62P0ko1
   mDcLBzMum9nwBgKUmXzqtUW0eLIJEK9zHFrLelmwa/fnaYY3Bcg2W+Y1X
   A==;
X-IronPort-AV: E=Sophos;i="6.00,212,1681164000"; 
   d="scan'208";a="31246991"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Jun 2023 13:52:40 +0200
Received: from localhost.localdomain (unknown [192.168.66.223])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id DA2F4280087;
        Fri,  2 Jun 2023 13:52:39 +0200 (CEST)
X-CheckPoint: {6479D7FA-2C-AA2CB662-E129E996}
X-MAIL-CPID: AA5DA1E75EDCD4A6141B319D63173EDC_3
X-Control-Analysis: str=0001.0A782F1E.6479D808.0020,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Date:   Fri,  2 Jun 2023 13:52:00 +0200
Message-Id: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen a number of downstream patches that allow enabling the
realtime feature of the SPI subsystem to reduce latency. These were
usually implemented for a specific SPI driver, even though the actual
handling of the rt flag is happening in the generic SPI controller code.

Introduce a generic linux,use-rt-queue flag that can be used with any
controller driver. The now redundant driver-specific pl022,rt flag is
marked as deprecated.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++++
 Documentation/devicetree/bindings/spi/spi-pl022.yaml      | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 524f6fe8c27b4..a24b4ea87443b 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -79,6 +79,12 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
+  linux,use-rt-queue:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that the controller should run the message pump with realtime
+      priority to minimise the transfer latency on the bus.
+
   slave:
     type: object
 
diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 91e540a92fafe..3c43fcc007e1f 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -49,8 +49,10 @@ properties:
 
   pl022,rt:
     description: indicates the controller should run the message pump with realtime
-      priority to minimise the transfer latency on the bus (boolean)
+      priority to minimise the transfer latency on the bus (deprecated, use the
+      generic linux,use-rt-queue property)
     type: boolean
+    deprecated: true
 
   dmas:
     description:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

