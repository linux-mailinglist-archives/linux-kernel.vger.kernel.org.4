Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4096201AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiKGWBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:01:09 -0500
X-Greylist: delayed 2400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Nov 2022 14:01:02 PST
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E38A6385;
        Mon,  7 Nov 2022 14:01:02 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 524D6E0EAC;
        Mon,  7 Nov 2022 23:44:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=ypuVjFp
        3Hgx1sBJP8N0IPOtO9JwOrzeOMW551uvk+vU=; b=rPQy6bRV0eY+8tpO4QyqQ6z
        3rNjK8APbaUO//K2uczk+BippVnNT1miaG+oWL3YWq0GKaAJUA5nEgp1PaiZ03Xe
        zE+5zLTyMw9a2DL+xb/MlwbgDe42lv2UBloUnqQMBeupAcn8dfH/deqPADlKYQNL
        lC/t7uq8fXcaMIZaqld0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 37F3FE0E1D;
        Mon,  7 Nov 2022 23:44:49 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:44:48 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: opp-v2: Fix clock-latency-ns prop in example
Date:   Mon, 7 Nov 2022 23:43:54 +0300
Message-ID: <20221107204355.31971-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accidentally discovered a hidden typo in the DT-nodes defined in the
opp-v2 bindings example. Instead of specifying the "clock-latency-ns"
property the DT-node has been created with the "lock-latency-ns" property
in it, which doesn't exist neither in opp-v2 nor in the base schemas.
Let's fix the name to having the "clock-" prefix as it was originally
implied and as the rest of the similar nodes has.

Fixes: 94274f20f6bf ("dt-bindings: opp: Convert to DT schema")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Note unevaluatedProperties flag hasn't revealed the problem here most
likely due to the property having the "-ns" suffix which implies the
property being single-number. It is implicitly evaluated by the dt-schema
core thus preventing the unevaluatedProperties schema to detect the
inconsistency.
---
 Documentation/devicetree/bindings/opp/opp-v2.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2.yaml b/Documentation/devicetree/bindings/opp/opp-v2.yaml
index eaf8fba2c691..2f05920fce79 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2.yaml
@@ -155,7 +155,7 @@ examples:
             opp-hz = /bits/ 64 <1200000000>;
             opp-microvolt = <1025000>;
             opp-microamp = <90000>;
-            lock-latency-ns = <290000>;
+            clock-latency-ns = <290000>;
             turbo-mode;
         };
     };
-- 
2.38.0


