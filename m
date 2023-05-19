Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF3708E56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjESD2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjESD1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF5910D8;
        Thu, 18 May 2023 20:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F457653CA;
        Fri, 19 May 2023 03:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83B9C433D2;
        Fri, 19 May 2023 03:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466863;
        bh=HdWlDRXipx3TpYgWVO+5t2tBpNikk3svror7f2vLIJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGLvwm9S2HUt+CyrnOTyMXhDZ/Kdo5rDHzNg4qkW5J5/oGt/tQrUYdoBYyOxtBTQc
         aBDFlWd+aur0KEkcIBs+4nXKSS9bM8EusrvgClZO+eSf1MCff/rAZaYgR8igZiSgyR
         pn9siByJIJb1lzgUOWkefklJkdkWPNoPZ/zOAyhLGfY0JP2mHYM2OKoci/Wgp296or
         FEoL1lk7+KOyo2T3qKAXZF7wqOBGRa0Mn9s13j10kf6GVwZnAvf1sYzu5nrFhDtUw7
         bhTFTL074RdcEgnewdfe2qTST91YUXtfbn7i/pVTIZ9EpBglvFuLdHXWX0Vez92rzK
         iH5oZnht9Fshg==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ythermal: core: report errors to governors
Date:   Thu, 18 May 2023 20:27:18 -0700
Message-Id: <20230519032719.2581689-7-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032719.2581689-1-evalenti@kernel.org>
References: <20230519032719.2581689-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

Currently the thermal governors are not allowed to
react on temperature error events as the thermal core
skips the handling and logs an error on kernel buffer.
This patch adds the opportunity to report the errors
when they happen to governors.

Now, if a governor wants to react on temperature read
errors, they can implement the .check_error() callback.

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/thermal/thermal_core.c | 9 +++++++++
 include/linux/thermal.h        | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3ba970c0744f..2ff7d9c7c973 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,6 +313,12 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 		       def_governor->throttle(tz, trip);
 }
 
+static void handle_error_temperature(struct thermal_zone_device *tz, int error)
+{
+	if (tz->governor && tz->governor->check_error)
+		tz->governor->check_error(tz, error);
+}
+
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
 	/*
@@ -380,6 +386,9 @@ static void update_temperature(struct thermal_zone_device *tz)
 			dev_warn(&tz->device,
 				 "failed to read out thermal zone (%d)\n",
 				 ret);
+		/* tell the governor its source is hosed */
+		handle_error_temperature(tz, ret);
+
 		return;
 	}
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9dc8292f0314..82c8e09a63e0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -199,6 +199,8 @@ struct thermal_zone_device {
  *			thermal zone.
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
+ * @check_error:	callback called whenever temperature updates fail.
+ *		Opportunity for the governor to react on errors.
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -206,6 +208,7 @@ struct thermal_governor {
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	void (*check_error)(struct thermal_zone_device *tz, int error);
 	struct list_head	governor_list;
 };
 
-- 
2.34.1

