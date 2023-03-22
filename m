Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD26C481C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCVKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCVKrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:47:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2D61529
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:47:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw3so18875507plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679482019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+5+KeEGvj5Q2Ho8473pkowWeg3TWrycUDtZWzvt1Sk=;
        b=UGpIC/Esbs9QLxaTfp3b+iA9ZmIWKea/P1K5lNMblbFya52zYzHjcYV9Z1dh4jHxNT
         5aHsz059WF//B+UsDC8QyXJ5zQHDy4bbjSVoqWq64B6RkpGTSGA24V1Tz7DMUrOe12jI
         xFPBgkoHzetP5XlAMPY3aZX7q415j8RX4XHXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+5+KeEGvj5Q2Ho8473pkowWeg3TWrycUDtZWzvt1Sk=;
        b=i1Z4WPtVpPMuyBy4pAjAYzx76ohLprAsNiXxVBp3gKIWOD0tH/efMUpN1DkzlcYcbK
         voqelzlfVL1+GbrQwZgUQHWlCL0WNsWilvGiYDGrGtWj0qdXfpUc0QTyUXZQsu5KpfTf
         VoGS7A0ecX/IUgB/7Xhpwf+8wEJrDldzWvdFTppseF4xmXlIVBkBgoh6U/x4jChunbeB
         28rn67Wqz1ujQtrm4sOAbHdadxiZ0lEZmGGgdXZ7WO9Rpsh+aaGHWghx8QEfoIYVk9yl
         nkgkbh1G5FamxUxOL2Nb/a4qCVP9ps2pZ/Xe61nA4xqGv10F92uz5HD3CGHz2l3CDQXG
         KuKA==
X-Gm-Message-State: AO0yUKWgB8BpguDWvxfGDEgUo7oO8+XDmvtSPJj2anlNtD4jGWP58AsA
        BPg5LcQE3KOSrbNFAM6GtXayIQ==
X-Google-Smtp-Source: AK7set90wpsycDChw65ny437J2h3RkWbTdHA+NGhsdfPnCYIlZE0iipJ0qCRLlLh4eP/BKLB8wMrnA==
X-Received: by 2002:a17:90a:50:b0:23f:ebf2:d3e9 with SMTP id 16-20020a17090a005000b0023febf2d3e9mr3333274pjb.6.1679482019432;
        Wed, 22 Mar 2023 03:46:59 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:343d:79bf:55f9:1da5])
        by smtp.gmail.com with ESMTPSA id hg4-20020a17090b300400b002340d317f3esm9508742pjb.52.2023.03.22.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:46:59 -0700 (PDT)
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
Cc:     Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v14 02/10] platform/chrome: cros_ec_typec: Purge blocking switch devlinks
Date:   Wed, 22 Mar 2023 18:46:31 +0800
Message-Id: <20230322104639.221402-3-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322104639.221402-1-treapking@chromium.org>
References: <20230322104639.221402-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

---

(no changes since v11)

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
2.40.0.rc1.284.g88254d51c5-goog

