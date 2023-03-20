Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA96C1B80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCTQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjCTQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA630B38;
        Mon, 20 Mar 2023 09:18:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i10-20020a05600c354a00b003ee0da1132eso1278558wmq.4;
        Mon, 20 Mar 2023 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/XyMbhBKX7Uw3dkwx0fKsxzPHEWI6L3uTBJAp+icNs=;
        b=JrXDNwD6zgeKP3j8t2RvVhr/qpCRNJig9CSoKWXjkHIGyAnkepI7cR3q5wPYUVNCu7
         19q0USvz156CjLKCkDNN4gSVVG7MbpdVn4v7o1Izd06dVIdb5Ka3VWwTtbacPOw9nwQR
         6/2des/VMC+gmwJbKjICLj/YfA5vMnSrWo+/MvNdXlLU3DdkxePhclaT5yBXeX/jBWfy
         XcFe4Decqg7Zt0RPxk2MKm6b5faAUNzg4rRqpbV57C8RcSmvnueZ9iNgR7978GPQ2w2l
         tYJfuHxA1jVDSeJVpbTwHgduS/Zw32KSfk3vLHkey2ELbzXeMkMXc+B877PN2qD837+4
         ZsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/XyMbhBKX7Uw3dkwx0fKsxzPHEWI6L3uTBJAp+icNs=;
        b=Yfwh2fprCy9Fhcl9knS7AuTd52Y1/VgWo6/IvQTz65YWkf57jAWbqkEJOcRDvEUMqT
         DDiiwIK6ZRX+QNlYT474zTGGUggvLmfXQGd07QwS8T/s1oy706HVp4muXv8Ipe73TdBM
         FgGXBzRcpaq6a3/okS3md5/Vm8LUb6BVGq21C1/VnsR81bS3x1JLIXqSphzmL9gLt3QO
         CM1e06R3IMm/kku0N4zgKU3XKpM598VtzIug9JW21tv3f/bhphcPk65A7+fMBKWEWeIA
         6PFxya92VZFcx5t0Al3bvekwFlXa8/PTIRltk7vj3Gioasx425eDZmyYpXZDt2+orj6Y
         GMxg==
X-Gm-Message-State: AO0yUKX5jprHnyui3U1GxuAjTgC2ai+qHUgYWoUbq+cmgKxtTDQ1Omnq
        S/yGPe9uPO3UXp/3oYAScfz5XWp+nfQ=
X-Google-Smtp-Source: AK7set+WyFdkXkjhmexTtFgmFRQO85LsHVXhvhlIxes07sVIoXtq0jUOJ6PJz6oCAJxfw5F2eNLI0w==
X-Received: by 2002:a1c:6a08:0:b0:3ea:ed4d:38eb with SMTP id f8-20020a1c6a08000000b003eaed4d38ebmr44203wmc.24.1679329121985;
        Mon, 20 Mar 2023 09:18:41 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:41 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 10/10] MAINTAINERS: add Mediatek MTMIPS Clock maintainer
Date:   Mon, 20 Mar 2023 17:18:23 +0100
Message-Id: <20230320161823.1424278-11-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
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

Adding myself as maintainer for Mediatek MTMIPS clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..f11e8d1da326 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13137,6 +13137,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c
 
+MEDIATEK MTMIPS CLOCK DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mtmips-clock.yaml
+F:	drivers/clk/ralink/clk-mtmips.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1

