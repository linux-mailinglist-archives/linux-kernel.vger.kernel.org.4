Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34386E5CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjDRJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDRJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302846580;
        Tue, 18 Apr 2023 02:03:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay3-20020a05600c1e0300b003f17289710aso3080599wmb.5;
        Tue, 18 Apr 2023 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808606; x=1684400606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=hyEeYlnfKNsu+wzQODFiRayLJJCKTLCADKbn1i3jqynVZ018mc3hUSpdhvmmgx/eNs
         r1YuePjwGg8/CTpKqWGtd+Hv7B7fX/6V41//R5EZ5stjzTsmY6HzngplXif07bjqCCgc
         plFlxNLfNBuq2Vau1l0x+9fCzcZEwE9e/yzw1DjIecgQTT1nvydFD1Bma7+jFfw2PIO+
         d+2SoU1Knwzj3oqYXdY5EdManDUV2g0kOR7t5EJ0lpY9SUwJ3mvJVhP+c6YKWsybu3Xb
         fMVlBkqbmI7mjbqyZj7LgYAbkkuY67Tus5smCNEYOdXqhZr9KjGOcRD44PkZEg89sanw
         Y27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808606; x=1684400606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=BC8c2iUC7bjT5AIt6FZQhQzBZcB8Ds5LpiGTqG01tcZzyiTrFHEYG7jZgPUDRJtiQr
         /gFt5wkdEFHsac2+yPvk+0k6XpsVqYrMnaZZR3GWVGXeRMhOLJfO5u78ZkQh4JnfzU3Z
         BrF6a4MgiuMycUBJ6+V4aEeVw7nHenbwTW7U68bcmhS/XZcfEkwEzfxDHwoY0Y23qiRo
         1pyAk5ANqEEbNlfcgacyMQ2MwH70r460Aj8PRpPyzRjopaU/GW/l+K8sT+zdilrGxmuy
         8VDAHwxn/2gjwaX1w6I99A6yBwYgBaFg4T5T1sQBlp9Bx5SROFRK5apRATVYHn5QmBzS
         DBMw==
X-Gm-Message-State: AAQBX9fIS26PfrmHYphGnuIdxOmtChQs08SOp0XY7DVk48+cYOk5ai55
        OVvt5hxyZcSNO4cu7/n/+z1JMYHGskM=
X-Google-Smtp-Source: AKy350ZbzAvqWY90P0Z3eLgU84LWQm4rGea1JWCNTJm6KLIaNScNr5BdKbE8V3dU5m0SczFMAP2Rmw==
X-Received: by 2002:a05:600c:1c20:b0:3f1:6fb4:5645 with SMTP id j32-20020a05600c1c2000b003f16fb45645mr7486090wms.1.1681808606231;
        Tue, 18 Apr 2023 02:03:26 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm14341109wmj.15.2023.04.18.02.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:03:25 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v3 9/9] MAINTAINERS: add Mediatek MTMIPS Clock maintainer
Date:   Tue, 18 Apr 2023 11:03:12 +0200
Message-Id: <20230418090312.2818879-10-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintainer for Mediatek MTMIPS clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..581234dfa735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13137,6 +13137,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c
 
+MEDIATEK MTMIPS CLOCK DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
+F:	drivers/clk/ralink/clk-mtmips.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1

