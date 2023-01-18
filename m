Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003CF671881
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjARKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjARKFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:05:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4949AA84
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:11:25 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b4so29205510edf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxj8H9i6KU881UdYVe5EuzkuebPPKMfYy3OoIlcIPlo=;
        b=dWmh0YMYxSrOVOXK+zjy7pLmQl1T/LfLg5POOqaGuzfQ9lNmxmNFzK7dvggcMob2WD
         ZQGvVhW4wqgeIlL8BJ/q4mJld5gCFfUqTqy0Jb4l4OXk5ZdZd6mh7N0+bzuGid5Gncmp
         E4PfD7GFseFfokdUZhqdz8cdK6VLmdgAO/Z4IsHPzadoOlYMWOe8ooubA8b4dRq4BW+X
         qfQ8nBX8+EPCXXyaMnp4QeF6Cv9m5s/xjgMBDdhlI0xesJ7ELh7cArhdSaMMniftACVu
         ssroT+ItgGR8g+xh6rFdcbcaZZb1WRAkS7hrjGZQ57d07w35ijHgiL1E4pxZnhHRiKGi
         EfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxj8H9i6KU881UdYVe5EuzkuebPPKMfYy3OoIlcIPlo=;
        b=E91Ms9aOGrB2GSXHe++7ZDDB/M1aFgkiiVpdOVDZn4wWNpjlciThV/RYfIoC4vB4B7
         XXiOjiWPe2Lgv4g2c9GKoo/Xn7jo9pPFAChIlT1kpIeDgvEkH/TT9NOZY50eegrX8HUd
         jJmkPObc4/Q9gCiBjs+wD5FXmNv6McLDQQnNCX5pa79ab9xWNJBk/2VkSS8eDYe+Pb+H
         mFAWhXfVxkMjn+H5+uA+PeRJbAlQmXQuUMaw2B7f2XKgvOGTssTiaH+24l8hUNpZMyz4
         iSusYhHC6MepmKtNMif8nF6qG66/Wbym94gqL+pNjhNytmnwWQTL3byxCgKyf6HHzOUj
         Q3Yg==
X-Gm-Message-State: AFqh2kpPAJcUaJbzqJ5MbhI9xzL2brBN9+a1GeL0tKF6eDxkhtNI8M1w
        vUffjOHhemySi79FL4afmDJHIw==
X-Google-Smtp-Source: AMrXdXtvoL53wkIUnF8UzSZrQYnm9HUXrGhkxlLLOQu28WT+LxxHrhTjPDP6hpjmiR9pH0jodeCpkw==
X-Received: by 2002:a05:6402:1c84:b0:49c:d353:8237 with SMTP id cy4-20020a0564021c8400b0049cd3538237mr5684389edb.42.1674033084089;
        Wed, 18 Jan 2023 01:11:24 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b007c16f120aacsm14213624ejn.121.2023.01.18.01.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 01:11:23 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RESEND PATCH] of: property: do not create clocks device link for clock controllers
Date:   Wed, 18 Jan 2023 11:11:22 +0200
Message-Id: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not create device link for clock controllers. Some of the clocks
provided to the device via OF can be the clocks that are just parents to
the clocks provided by this clock controller. Clock subsystem already
has support for handling missing clock parents correctly (clock
orphans). Later when the parent clock is registered, clocks get
populated properly.

An example of the system where this matters is the SDM8450 MTP board
(see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
dispcc itself provides clocks to both PHYs, to the PHY parent device,
etc. With just dsi0_phy in place devlink is able to break the
dependency, but with two PHYs, dispcc doesn't get probed at all, thus
breaking display support.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

This patch has been posted a year ago in January 2022 ([1]). Since that time
Saravana failed to produce patches to assist in debugging the issue
([2]) or to fix the issue ([3]). The issue we observe has been described
by Abel at ([4]). As we work on adding support for Dual DSI
configurations, the issue becomes more and more important, since binding
the whole display subsystem fails.

Currently the qcom/sdm845-mtp board is already broken and I've just
posted a patch adding Dual DSI variant for the qcom/sdm845-db845c board
([5]).

[1] https://lore.kernel.org/lkml/20211125183622.597177-1-dmitry.baryshkov@linaro.org/
[2] https://lore.kernel.org/lkml/CAA8EJpqELXvRMPWJdTLCURjwkcMxyPDPj1tVZPkdOT_JVQb4-w@mail.gmail.com/
[3] https://lore.kernel.org/all/CAGETcx8F0wP+RA0KpjOJeZfc=DVG-MbM_=SkRHD4UhD2ReL7Kw@mail.gmail.com/
[4] https://lore.kernel.org/all/YrsdLQrOtg1qdaoE@linaro.org/
[5] https://lore.kernel.org/all/20230118082048.2198715-1-dmitry.baryshkov@linaro.org/

---
 drivers/of/property.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70..d323bf26a613 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1297,7 +1297,6 @@ struct supplier_bindings {
 	bool node_not_dev;
 };
 
-DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
@@ -1327,6 +1326,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
+static struct device_node *parse_clocks(struct device_node *np,
+					const char *prop_name, int index)
+{
+	/*
+	 * Do not create clock-related device links for clocks controllers,
+	 * clock orphans will handle missing clock parents automatically.
+	 */
+	if (!strcmp(prop_name, "clocks") &&
+	    of_find_property(np, "#clock-cells", NULL))
+		return NULL;
+
+	return parse_prop_cells(np, prop_name, index, "clocks",
+				       "#clock-cells");
+}
+
 static struct device_node *parse_gpios(struct device_node *np,
 				       const char *prop_name, int index)
 {
-- 
2.39.0

