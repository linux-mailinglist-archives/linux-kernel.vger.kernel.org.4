Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1933E660DC8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjAGKXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjAGKWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:22:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254019C24
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:22:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z4-20020a17090a170400b00226d331390cso4334101pjd.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbxRbyImpevpLcgNpmQRY5xjXofgzVP7nhTUY2hiItA=;
        b=YBlSIcXwtTcNC6c/sLb0A+fA09dZ0F2u1NJHDrT/q2R/iaQ1cjbLt1qyxJ+NZKr+OG
         sW/aOZ9fN3xTZhfGKzIRuoDqca+1vXKtEQJA08aQuQeMQ1tC3YT2TD5gWitCdQvFDLU6
         1EdmUmEOxSdsdM3pqfJQ+lllt2BhcD8Tvj980=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbxRbyImpevpLcgNpmQRY5xjXofgzVP7nhTUY2hiItA=;
        b=BfC5mKJkgSPhvansRrMeScD9rI5DQNafB6ycZ29DFfoFGBxV8Qh1vKwz/v7S2XzsPv
         yNYJ59+1jbzeaPb5LNyeXyGQbyDUvdOLiRchjWLVG7ArOS8XZMacK6Mxhyw0QupwZxFS
         N96XGHtm4b14VnkI5l51/+4RzMAVlJRenzVmwOgcGZl0ch1Ra4AYNKRehb44UH379NdA
         Pc7V2UoZbfhiDDawIEWJef4Kg+f04/g83MtlY/Bb4e05ihikCAYSO7SZSpYlw3LLYadE
         TZp9Ijqsl/T9SphNe926xWEtJzRMUTsqOdVQT9ejdmBCTCpXyRCyBCZs6om2HqVr8SWI
         8l8A==
X-Gm-Message-State: AFqh2koYjeErrDeXBQ+DFanhJH4NsvJU/5+z2VinoTNwzS0qPb77mmq7
        WH1YscUDLAjd09DkHdOtnrohHg==
X-Google-Smtp-Source: AMrXdXvGarJZRipkxnWGG7cZHfw/m0d92b3irvWonmWk9YRAc88nnTJSpaQYTRjr83kRgvV6N2mG9A==
X-Received: by 2002:a17:902:b493:b0:189:cb73:75f0 with SMTP id y19-20020a170902b49300b00189cb7375f0mr53864845plr.8.1673086967014;
        Sat, 07 Jan 2023 02:22:47 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:180d:95e8:f4:84fb])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001892af9472esm2366362plh.261.2023.01.07.02.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 02:22:46 -0800 (PST)
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
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Xin Ji <xji@analogixsemi.com>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v8 1/9] device property: Add remote endpoint to devcon matcher
Date:   Sat,  7 Jan 2023 18:22:23 +0800
Message-Id: <20230107102231.23682-2-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230107102231.23682-1-treapking@chromium.org>
References: <20230107102231.23682-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

