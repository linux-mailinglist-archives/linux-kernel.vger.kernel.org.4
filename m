Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D972F6C4815
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCVKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCVKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:47:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C85DEF1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:46:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z19so8457466plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679482014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taPmB4+Xp9EC511rcY4vhFNfgJl8IMtTdglowbBg2bA=;
        b=TRfNa5Bjym9D/QOWv3oireKkb637T2hgKBgTBhwgznroO/IjIvby1HKxj8T78xQsPf
         gA7BKv0GlqGZZTjg9B+pKlOcISJ5w8svZIcbRBIQKpRbmBW8arjwvK3SbvfPeK7gfrf+
         pf6LJFcpkKHiwR3AHOWxcu4hh6JK9N+jVw22I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taPmB4+Xp9EC511rcY4vhFNfgJl8IMtTdglowbBg2bA=;
        b=jHVJuYzJR/qLHh/ULvrntGbcOnNX/8w70ejQPfkc/XqM2sUVobgdFudgnXxforWuT5
         W72xEgQY8OOCv24y1C+YI8Nxk77yD7puvSbkWD1ND+e+sxN30R6yE7GWIqGDfM72fSEb
         AFMBttzHkPG3lTGYZE0omocVOrUhZPMFeTyR+SuaazDtnCiac+jAhn/GrthJY6kPxb7u
         Z5kVSM7/t6EJBVGmEJzfO/vBYbOSwfi+aUgtngTmedheVBOdmS7v1+si6XSi4zZIw7bR
         iJ91NLM5MwcV6GKTC/hOAELbnIZ7UX64+6GL1JZbNKLOoOnk0s5l59E2H/ySF2AVCvyi
         9J9Q==
X-Gm-Message-State: AO0yUKVJlf6kDR1Bhi7BiqJzIBze5k+auOQI1VYkYVwsN+5coL0E2dan
        HbT7BxXtWRx0Pn12xn79ZAhKAQ==
X-Google-Smtp-Source: AK7set8NY7gSVoQ4fC5GN+MPbT1csTFpfLKJNC4YeNu9C5XL+LD4947BMZpiMhYqHKm0ufkRA9/KIg==
X-Received: by 2002:a17:90b:1a81:b0:23e:f855:79f2 with SMTP id ng1-20020a17090b1a8100b0023ef85579f2mr3799890pjb.12.1679482014097;
        Wed, 22 Mar 2023 03:46:54 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:343d:79bf:55f9:1da5])
        by smtp.gmail.com with ESMTPSA id hg4-20020a17090b300400b002340d317f3esm9508742pjb.52.2023.03.22.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:46:53 -0700 (PDT)
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
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v14 01/10] device property: Add remote endpoint to devcon matcher
Date:   Wed, 22 Mar 2023 18:46:30 +0800
Message-Id: <20230322104639.221402-2-treapking@chromium.org>
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

When searching the device graph for device matches, check the
remote-endpoint itself for a match.

Some drivers register devices for individual endpoints. This allows
the matcher code to evaluate those for a match too, instead
of only looking at the remote parent devices. This is required when a
device supports two mode switches in its endpoints, so we can't simply
register the mode switch with the parent node.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

---

Changes in v14:
- Collect review tags

Changes in v13:
- Update the kernel doc of fwnode_connection_find_match

Changes in v12:
- Check the availability of the device node in fwnode_graph_devcon_matches
- Ensured valid access to "matches" in fwnode_graph_devcon_matches
- Updated the documentation in fwnode_connection_find_match(es)
- Dropped collected tags due to the new changes

Changes in v11:
- Added missing fwnode_handle_put in drivers/base/property.c

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v6:
- New in v6

 drivers/base/property.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 083a95791d3b..4426ac2b16ca 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1243,6 +1243,23 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
 			continue;
 		}
 
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
+		if (ret) {
+			if (matches)
+				matches[count] = ret;
+			count++;
+
+			if (matches && count >= matches_len)
+				break;
+		}
+
+		/*
+		 * Some drivers may register devices for endpoints. Check
+		 * the remote-endpoints for matches in addition to the remote
+		 * port parent.
+		 */
+		node = fwnode_graph_get_remote_endpoint(ep);
 		ret = match(node, con_id, data);
 		fwnode_handle_put(node);
 		if (ret) {
@@ -1293,8 +1310,11 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
  * @match: Function to check and convert the connection description
  *
  * Find a connection with unique identifier @con_id between @fwnode and another
- * device node. @match will be used to convert the connection description to
- * data the caller is expecting to be returned.
+ * device node. For fwnode graph connections, the graph endpoints are also
+ * checked. @match will be used to convert the connection description to data
+ * the caller is expecting to be returned.
+ *
+ * Return: The pointer to the matched node, or NULL on error.
  */
 void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
@@ -1325,9 +1345,10 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
  * @matches_len: Length of @matches
  *
  * Find up to @matches_len connections with unique identifier @con_id between
- * @fwnode and other device nodes. @match will be used to convert the
- * connection description to data the caller is expecting to be returned
- * through the @matches array.
+ * @fwnode and other device nodes. For fwnode graph connections, the graph
+ * endpoints are also checked. @match will be used to convert the connection
+ * description to data the caller is expecting to be returned through the
+ * @matches array.
  * If @matches is NULL @matches_len is ignored and the total number of resolved
  * matches is returned.
  *
-- 
2.40.0.rc1.284.g88254d51c5-goog

