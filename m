Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF0657185
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiL1BAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:00:02 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B737E013
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:00:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 6so7067091pfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl9lz1LdkOsI7rrZ+m78RYNdWxgzzlfo1gzTHpgM0to=;
        b=LEO2YJhja0QYiJBr0E4k0KdFonbevTkEqWkdTH1/UlaDcZ4FMjgHlEs4sYaltUvvup
         AflcM7I7fNmcBvbsXaJeuog+gvdLuVQPH/RgNR7FcmXGWF0sugC4nqSAY72+ztwvisM1
         9CN5EhlD8jf6mZfTgEiKHhHINhVwFJJJTAIfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl9lz1LdkOsI7rrZ+m78RYNdWxgzzlfo1gzTHpgM0to=;
        b=b5K/TZRU4Wn3CIOIeEkZJOsP3rh6XznvBj6oKvH5Y2d2+Rud+xlTBKxGSRk51svC5V
         8r4Ale4v1NkiIB3/3otefsLkFCtmbbnZB+kQhGslbnBRWyrjXou03DL4bdd0dF9RTN6T
         9mYtINrAx1sGfhMvJKafAAgqjcL6RfjJdy2rJbhQSD/YApH/zAKJuLB9tSFhtBP8ksww
         239mtzRRT45JtqEDexCVYyYaSDp76vcu5egq7A6qY1XOSg5nSU3l8rD/rSQl1wUY4LI+
         NBIYGRIdrDVyBdbQRR7Ef5GTDRiSlurDZojqSlm5td1ENTXgeuhI5MEVcmmCB4HVkpSC
         8RqA==
X-Gm-Message-State: AFqh2kpjfFJo2uIFuXYOgHRFZ0+3DGC7fIAhPvGh+nZgPG5Htt5QJEqJ
        L1+yvL2SMldr3GK3MPaOV2Iy3Zk20N+QM7Ft
X-Google-Smtp-Source: AMrXdXtAppN52JChY/7t8akMZ+vaDIVh1t73ZtrT//8uxQ3LN5WN4hTEtGMrmbsqO/sRMnFMX5IfsA==
X-Received: by 2002:a62:6143:0:b0:577:3546:d7be with SMTP id v64-20020a626143000000b005773546d7bemr24695903pfb.30.1672189201437;
        Tue, 27 Dec 2022 17:00:01 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.17.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:00:01 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 03/10] platform/chrome: cros_ec_typec: Stash port driver info
Date:   Wed, 28 Dec 2022 00:45:06 +0000
Message-Id: <20221228004648.793339-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221228004648.793339-1-pmalani@chromium.org>
References: <20221228004648.793339-1-pmalani@chromium.org>
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

Stash port number and a pointer to the driver-specific struct in the
local typec port struct.

These can be useful to the port driver to figure out how to communicate
with the Chrome EC when an altmode-driver related callback is invoked
from the Type-C class code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 001b0de95a46..bc8dc8bd90b3 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -45,6 +45,7 @@ struct cros_typec_altmode_node {
 /* Per port data. */
 struct cros_typec_port {
 	struct typec_port *port;
+	int port_num;
 	/* Initial capabilities for the port. */
 	struct typec_capability caps;
 	struct typec_partner *partner;
@@ -78,6 +79,8 @@ struct cros_typec_port {
 	struct usb_power_delivery *partner_pd;
 	struct usb_power_delivery_capabilities *partner_src_caps;
 	struct usb_power_delivery_capabilities *partner_sink_caps;
+
+	struct cros_typec_data *typec_data;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -408,6 +411,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			goto unregister_ports;
 		}
 
+		cros_port->port_num = port_num;
+		cros_port->typec_data = typec;
 		typec->ports[port_num] = cros_port;
 		cap = &cros_port->caps;
 
-- 
2.39.0.314.g84b9a713c41-goog

