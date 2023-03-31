Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4436D1B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjCaJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjCaJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:12:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8961D913
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:12:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id kq3so20644645plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680253927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuyGEC/BCL1exOJo9w5cckpDi+j1ToSvkBZ5wHJd1EI=;
        b=asCmRmQnDO169ph3UWKR1Z453FBunIfmYwRDQIA8D06CqqHt26CWm64PBNzQPfLq7i
         9VhRVbihJvA417MwBMmcik33jSerfc/m9zokq3LI30/lC1AN3uxYjN74qdAsdwHwFfEo
         LD6TuuAm1zjPYtesKo5nMx7iPf9AOv/0ZprM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuyGEC/BCL1exOJo9w5cckpDi+j1ToSvkBZ5wHJd1EI=;
        b=hqE+J6ZfxV5GhsvouvDnUQQ8fML8iJvzVvh4/bfjYxzZpD3X+HrL5lWw13R+T0O1w2
         5JIgpWgb17IFmPFt8NSIGhFuKKsgv/CFstPR+ROv7GQcyhbdvtPz71uFO0OWG5uLw6+3
         qQA6pRStxzt78xrbndRwOPtlWn+VLMNF85RCHLmiJj80PwnGHl1VYRgpmkP16ltSNUGG
         nFZxMu2Q++CCr9oldHc0XS3mZI2WsxWtagTgkJXqXjH9qibMinIA3BQTNfF7j6qfefOc
         tEYuGR0EclsGbhUuU8g7svvsNdkMFvihwPKZ2Iyd3mWs4qwUxZ0BSrKRh9o22rptjL+k
         25hA==
X-Gm-Message-State: AO0yUKX0T94cAliox8UHXtHkJwmqVl0jBcouGAL8Ge/y9KSeXt9QkFRn
        Gea4N8VgOdSl75IXQ0Kb4mcByg==
X-Google-Smtp-Source: AK7set+ubiZHdR0EYwAEQ+6mxM9jDOMo4i5HJvDrMdaVpzntUKo5Gz+rySNDQSajJbJNpYlHL+hJnA==
X-Received: by 2002:a05:6a20:4f1f:b0:be:da1c:df65 with SMTP id gi31-20020a056a204f1f00b000beda1cdf65mr21256623pzb.28.1680253927134;
        Fri, 31 Mar 2023 02:12:07 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:ae9d:db7a:8a71:d458])
        by smtp.gmail.com with ESMTPSA id n6-20020a62e506000000b006227c3d5e29sm1360905pff.16.2023.03.31.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:12:06 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
Cc:     Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v15 02/10] platform/chrome: cros_ec_typec: Purge blocking switch devlinks
Date:   Fri, 31 Mar 2023 17:11:37 +0800
Message-Id: <20230331091145.737305-3-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331091145.737305-1-treapking@chromium.org>
References: <20230331091145.737305-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

---

Changes in v15:
- Collected Reviewed-by tags

Changes in v11:
- Collected Acked-by tag

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v7:
- Fix the long comment lines

Changes in v6:
- New in v6

 drivers/platform/chrome/cros_ec_typec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index a673c3342470..5911cd9640cb 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -325,6 +325,16 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		return -EINVAL;
 	}
 
+	/*
+	 * OF graph may have set up some device links with switches,
+	 * since connectors have their own compatible. Purge these
+	 * to avoid a deadlock in switch probe (the switch mistakenly
+	 * assumes the connector is a supplier).
+	 */
+	if (dev_of_node(dev))
+		device_for_each_child_node(dev, fwnode)
+			fw_devlink_purge_absent_suppliers(fwnode);
+
 	/* DT uses "reg" to specify port number. */
 	port_prop = dev->of_node ? "reg" : "port-number";
 	device_for_each_child_node(dev, fwnode) {
-- 
2.40.0.348.gf938b09366-goog

