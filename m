Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169065ECF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjAENZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjAENZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:25:15 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D210E392F3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:25:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n12so26947214pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbxRbyImpevpLcgNpmQRY5xjXofgzVP7nhTUY2hiItA=;
        b=aff45gLxfSUOPSf+P16Wfqefq4B3AAiek2pWrvQRllMjMCQXDmLrCJ016EujGWaX3q
         EdlF/dam+lvnc2QOWICQbuXZrYWTm5byyAE0km3RStxK4OycVexOKmH7kuQXq9xCD7ZL
         73HASPzrpoidvfOf6UuW6Dexj/RgPR2Glgkm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbxRbyImpevpLcgNpmQRY5xjXofgzVP7nhTUY2hiItA=;
        b=tQP7XywJ4hscYzOmRvebt/mBElNJQQ6bNPkljxIhq9v0DbI4q9I78hpJYtjKAKwtUG
         XWWH/SoIrNPa236ULfhpeRtsKTdEbi5o9Xj/WG1JHc/o8nRMlQfVVdPPVEkKUz4MQKLZ
         kV7ZANvfcTw0hlZEU20+1Oo7idV8u9LdJXjfcLgLuYJiufjdNRpf0ONogjmlenjjxwiJ
         r3ASbTQu9dn46x2aVj3FjK1yHLIHIJANWT2RAFDwbGQoNLgMME1ftrLEXmE17LS2dY5M
         /8myQ5I3pqihs8AjwqTzP9dxf5HyeWYesWI3RdbFu0TNpgk+qIEKXhTmPIW/WQ6A/84/
         DSuQ==
X-Gm-Message-State: AFqh2korSUkHGT6prM2+laPejoq6PsRg1Yd7+pL75OpwWSbuxX5GxlYo
        0LAQGsRSvGBSxH0Ku1G172XVVw==
X-Google-Smtp-Source: AMrXdXtNIhm1zRqPAeWmXv09/1S9tpXOtiiTUYV1OphcKK5xQL/pBpTem6Md/SpDKiVfYtS+hZxHTQ==
X-Received: by 2002:a17:90a:f2d4:b0:21a:b64:3488 with SMTP id gt20-20020a17090af2d400b0021a0b643488mr54462147pjb.44.1672925114268;
        Thu, 05 Jan 2023 05:25:14 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7a61:eb85:2e3:2bd0])
        by smtp.gmail.com with ESMTPSA id gk22-20020a17090b119600b00225e670e4c7sm1372682pjb.35.2023.01.05.05.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:25:13 -0800 (PST)
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
Subject: [PATCH v7 1/9] device property: Add remote endpoint to devcon matcher
Date:   Thu,  5 Jan 2023 21:24:49 +0800
Message-Id: <20230105132457.4125372-2-treapking@chromium.org>
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

When searching the device graph for device matches, check the
remote-endpoint itself for a match.

Some drivers register devices for individual endpoints. This allows
the matcher code to evaluate those for a match too, instead
of only looking at the remote parent devices. This is required when a
device supports two mode switches in its endpoints, so we can't simply
register the mode switch with the parent node.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

(no changes since v6)

Changes in v6:
- New in v6

 drivers/base/property.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2a5a37fcd998..48877af4e444 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1223,6 +1223,21 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 			break;
 		}
 
+		/*
+		 * Some drivers may register devices for endpoints. Check
+		 * the remote-endpoints for matches in addition to the remote
+		 * port parent.
+		 */
+		node = fwnode_graph_get_remote_endpoint(ep);
+		if (fwnode_device_is_available(node)) {
+			ret = match(node, con_id, data);
+			if (ret) {
+				if (matches)
+					matches[count] = ret;
+				count++;
+			}
+		}
+
 		node = fwnode_graph_get_remote_port_parent(ep);
 		if (!fwnode_device_is_available(node)) {
 			fwnode_handle_put(node);
-- 
2.39.0.314.g84b9a713c41-goog

