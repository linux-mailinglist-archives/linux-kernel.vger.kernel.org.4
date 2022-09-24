Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E75E8E07
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiIXPdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiIXPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:33:24 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960892F67;
        Sat, 24 Sep 2022 08:33:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8DD9D240008;
        Sat, 24 Sep 2022 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664033602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Suot/ZSovcyspC1eYC8ftIYsFXv3M4ZCr+We5/lOwnQ=;
        b=U6uRCn6cjFA9d4hZ5ZDQiugxfluwwUjIENwmuINmSE7hxt+Uv1snR8AVMmRx43hM/CrkVo
        B5PVCc1GBcpKFaldKFvvpbNp5d4AfJzgrLE4etnt3e08H4UgMjMmyB5tbySIuLvIOfzfyi
        dhaHtVYTEiQMRCzczX+LkA5QLxH4EwIdBDFOJ8eAq4Xb1wMEF/0hVjxxxvL/gDwO3naHGN
        ztAO3fpS3S9mtUcHAbH/LZNx173bOYd+c7hqpdG92qLhKYrI/usRIJ0VXkOxi7uDXmGcZ9
        P0OdLeGxqln2wUk9155z5ScjuE1WNDycESnRum3J/iI9IyIOoYhqbl5NJaUV3Q==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/6] dt-bindings: media: sun6i-a31-csi: Add internal output port to the ISP
Date:   Sat, 24 Sep 2022 17:33:00 +0200
Message-Id: <20220924153304.77598-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924153304.77598-1-paul.kocialkowski@bootlin.com>
References: <20220924153304.77598-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Allwinner devices come with an Image Signal Processor (ISP) that
allows processing camera data to produce good-looking images,
especially from raw bayer representations.

The ISP does not have a dedicated capture path: it is fed directly by
one of the CSI controllers, which can be selected at run-time.

Represent this possibility as a graph connection between the CSI
controller and the ISP in the device-tree bindings.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
index 8551c4a711dc..e423aaebefcd 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
@@ -73,6 +73,10 @@ properties:
         $ref: /schemas/graph.yaml#/properties/port
         description: MIPI CSI-2 bridge input port
 
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Internal output port to the ISP
+
     anyOf:
       - required:
           - port@0
-- 
2.37.3

