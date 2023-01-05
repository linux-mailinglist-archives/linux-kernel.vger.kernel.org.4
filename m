Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D365ED02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjAEN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAENZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:25:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3274392E0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:25:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so2024420pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hqQOkKrItwHNX5v+5p8BbzfdB8bkg8Yca4jGeyjDgg=;
        b=ShnfgUSOXuCGjRuna6wTL6cMaiNo15jKbthJwNrqZDEoFWjV+y52Bky++fVGKWPNxm
         TSdKdMVhcW3JgNP8dNM2EKQqaSXZgCti2M+wYScNBPeL3ExWbgqWeNvI7nKzg+eh/rJv
         IZAWA8zf44oLxLGeGCLsIrMHdbHb/gXBWUTYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hqQOkKrItwHNX5v+5p8BbzfdB8bkg8Yca4jGeyjDgg=;
        b=Z9sU+l7vIT8aTMxyPKnY2QgXCKzerGB/FnPGUAvAKRZeuCTAKHcOHnEPUc9MGtgUrH
         DQxIeG8oj59+XIXTyn3p2QpcVVW2fE253bjZcPxBzU4LU0CVRAZwSmxrKcyQfji0d58i
         DtJga3Rs7IWRlZuI0p2cGUBlD5p6JIkZ9MgHa5tj2jG6CoJuxABep6iDLSl/Uv/1x9tJ
         bh/tF4AgdZsep7nlDXHDeqSDYcWRlp2aW7uJjoyqKyqzvJbvktgAi66KUMGaWnQeTNH7
         w15CSKI7eIv655VQxoGDkOdxtS7W6hjdedL6V8Q9NyHWXEWpTKYJgMgdgtFNZPoQ7IZY
         jcOg==
X-Gm-Message-State: AFqh2konIKpzxH+d/VMpOiWxgtLEu8oDkiPxm33KlQ5GUF+4HDwcqlvj
        zJ+BSRAswZ6RY/amo3MOfmU0vA==
X-Google-Smtp-Source: AMrXdXs2rSmGWZCqtd8p+t21jfexuxiaORDcdvHuQTqxS2qgF6MSOKcW+gdNFTSY78GsG4nyx34fPg==
X-Received: by 2002:a17:90b:35d0:b0:225:f793:ab2d with SMTP id nb16-20020a17090b35d000b00225f793ab2dmr36398951pjb.46.1672925120095;
        Thu, 05 Jan 2023 05:25:20 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7a61:eb85:2e3:2bd0])
        by smtp.gmail.com with ESMTPSA id gk22-20020a17090b119600b00225e670e4c7sm1372682pjb.35.2023.01.05.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:25:19 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, chrome-platform@lists.linux.dev,
        Pin-yen Lin <treapking@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v7 2/9] platform/chrome: cros_ec_typec: Purge blocking switch devlinks
Date:   Thu,  5 Jan 2023 21:24:50 +0800
Message-Id: <20230105132457.4125372-3-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105132457.4125372-1-treapking@chromium.org>
References: <20230105132457.4125372-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prashant Malani <pmalani@chromium.org>

When using OF graph, the fw_devlink code will create links between the
individual port driver (cros-ec-typec here) and the parent device for
a Type-C switch (like mode-switch). Since the mode-switch will in turn
have the usb-c-connector (i.e the child of the port driver) as a
supplier, fw_devlink will not be able to resolve the cyclic dependency
correctly.

As a result, the mode-switch driver probe() never runs, so mode-switches
are never registered. Because of that, the port driver probe constantly
fails with -EPROBE_DEFER, because the Type-C connector class requires all
switch devices to be registered prior to port registration.

To break this deadlock and allow the mode-switch registration to occur,
purge all the usb-c-connector nodes' absent suppliers. This eliminates
the connector as a supplier for a switch and allows it to be probed.

Signed-off-by: Prashant Malani <pmalani@chromium.org>

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v7:
- Fix the long comment lines

Changes in v6:
- New in v6

 drivers/platform/chrome/cros_ec_typec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2a7ff14dc37e..30cf03c2e95d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -382,6 +382,16 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		return -EINVAL;
 	}
 
+	/*
+	 * OF graph may have set up some device links with switches, since
+	 * connectors have their own compatible. Purge these to avoid a deadlock
+	 * in switch probe (the switch mistakenly assumes the connector is a
+	 * supplier).
+	 */
+	if (dev->of_node)
+		device_for_each_child_node(dev, fwnode)
+			fw_devlink_purge_absent_suppliers(fwnode);
+
 	/* DT uses "reg" to specify port number. */
 	port_prop = dev->of_node ? "reg" : "port-number";
 	device_for_each_child_node(dev, fwnode) {
-- 
2.39.0.314.g84b9a713c41-goog

