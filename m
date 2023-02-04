Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3968AA0C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBDNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:31:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F336FC3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 05:30:57 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s13so3778094pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 05:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9iPc9yhVkUofB90tWrcvmiWB1xZN7L6aBmsKjdgh6c=;
        b=MmH3x/xM62zRTISXSedEvzRlaMSI+F8Qma5UmquaxSwlvv6YsPZ+8h1xP3F7M3D1Df
         QCXfWhoJOdvLdzh0hNXPqpam40tk12C8NpO5zRmImK/NmNXbcxJ9dSbO/w8oKgfe20ZG
         QRCqSAG2eCerNb0ZmsoC546f3eCSx0931M3tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9iPc9yhVkUofB90tWrcvmiWB1xZN7L6aBmsKjdgh6c=;
        b=XOiRTIX9BzlAUUufhtOlBS0QG4qVMxS8YoBQFDmAaJ+nJRYHtoY6sob5NHXTYfBJ2q
         PdBUlwY6+/9/bIew1nZtigg9VFOYnnQ4cSNhGXL4HZPZ5y1KrUvzWlCoYBYG8DIXJZod
         1Q4oUPfXv+CJLF0gtaS5aN0cjUrNRXG0DEbnI0DVZcJnXUlc00N9YtlUN5y8JHKT4cMl
         1Y+IYwXqEcizv63JAfIk9iktb5F0zGz1VXPHBtPH389tkGGAzSI2tDLhfWZi+h1FvaU4
         Dly2Oy5P29bGDMOFb1DHydO4lSddxaQHsQECBl9tCuzFpTl7LoxqKxA8dxsVf5PMqgTf
         fdsg==
X-Gm-Message-State: AO0yUKVIFeWsLcUZvWqoPWtHr0x7xP+NpiGcl6OiVM/OLqKo0IllBBdY
        c28c4Jn1b76nj9F1AlVQCPSomQ==
X-Google-Smtp-Source: AK7set+L0bc/md7jnlp6ucsfNCGE/z+ghrSK5N+MS4DGPqmGcMvtPY/U7zbRRON1T5JI3CoL3plPaA==
X-Received: by 2002:a05:6a00:882:b0:593:96a2:d60a with SMTP id q2-20020a056a00088200b0059396a2d60amr18474657pfj.30.1675517456766;
        Sat, 04 Feb 2023 05:30:56 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:c1ad:2bdc:7b5a:72e3])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm3655639pfv.184.2023.02.04.05.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:30:56 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v11 1/9] device property: Add remote endpoint to devcon matcher
Date:   Sat,  4 Feb 2023 21:30:32 +0800
Message-Id: <20230204133040.1236799-2-treapking@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230204133040.1236799-1-treapking@chromium.org>
References: <20230204133040.1236799-1-treapking@chromium.org>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v11:
- Added missing fwnode_handle_put in drivers/base/property.c

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v6:
- New in v6

 drivers/base/property.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2a5a37fcd998..e6f915b72eb7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1223,6 +1223,22 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
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
+		fwnode_handle_put(node);
+
 		node = fwnode_graph_get_remote_port_parent(ep);
 		if (!fwnode_device_is_available(node)) {
 			fwnode_handle_put(node);
-- 
2.39.1.519.gcb327c4b5f-goog

