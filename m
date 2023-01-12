Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D376686DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjALWXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjALWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:22:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F541CB0A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:16:25 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 200so8677783pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjiuF0nk2Kld9KpyTDhRe2O6SrSLJ1BXqR8sAU0pb9U=;
        b=oZlwH+7eiNMzSIWcVe5eQOtedrPcUmvYsQ9xgKiam4GhJtqz9USbZasRnjKseYbjGy
         5hNUOJCi1IrDGf9VQHhDgRf5oWzCSJi6nRjDnqXi7kLkWOD316vLo1N1u64Nftmlu4fj
         G8cBo7eSLqFgU5dWh+Ei1rPvnGc3Q2aNkITKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjiuF0nk2Kld9KpyTDhRe2O6SrSLJ1BXqR8sAU0pb9U=;
        b=DG8QpJypcTq6D3Zk8tUhdm4O2QV1uV9S/t/UYg7sAs3eA9Rn+GhBH+YH77VjYSYrtK
         0AtG/+LH8VFkBpVCG/qY8imxNCY8WRmeDyUcI5Hd37+VyzQdwyR75gdVmx9N16lvIyJ1
         MQdtXLhIHeYajMaOiqgNW4B8A0iJbnxyhL3kTXdEXlRMigcn6zh1F9Ji2P4QE9Fw7Zrh
         bGo1MQDsMV/Xz+KYB5TuDAG33U0e+FcFk8Zh8konyV44IN7XrdfFbOMs6UTSp2oqqn8H
         dh2MMUCva8QSvCrYcWtl7cmOWdjmFGkdQLwTBll4g9um91wwFvKdon6fA4UwyMX7GG9s
         5JHQ==
X-Gm-Message-State: AFqh2kob7R2b2a4epcXCTW5NXgMMaR4RXrvHKw3P50JgIspXTroWBpiT
        /8ZvQ8fnUiz23SUg4xVEqDm16yrFMSbjCT/l
X-Google-Smtp-Source: AMrXdXurxr+VIziGlnQiBgwKaswKl4TWFukGIKJbTAbZII2HoYU9eQx7fzUE0kwb+hx3J0V9Tcasaw==
X-Received: by 2002:a62:5801:0:b0:574:a541:574a with SMTP id m1-20020a625801000000b00574a541574amr72123429pfb.0.1673561785239;
        Thu, 12 Jan 2023 14:16:25 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d191-20020a621dc8000000b0058193135f6bsm12330658pfd.84.2023.01.12.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:16:24 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] usb: typec: Add retimer handle to port altmode
Date:   Thu, 12 Jan 2023 22:16:06 +0000
Message-Id: <20230112221609.540754-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112221609.540754-1-pmalani@chromium.org>
References: <20230112221609.540754-1-pmalani@chromium.org>
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

Just like it does with muxes, the Type-C bus code can update the state
of connected retimers (especially when altmode-related transitions
occur). Add a retimer handle to the port altmode struct to enable this.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/typec/bus.h   |  2 ++
 drivers/usb/typec/class.c | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
index 56dec268d4dd..c89168857417 100644
--- a/drivers/usb/typec/bus.h
+++ b/drivers/usb/typec/bus.h
@@ -7,11 +7,13 @@
 
 struct bus_type;
 struct typec_mux;
+struct typec_retimer;
 
 struct altmode {
 	unsigned int			id;
 	struct typec_altmode		adev;
 	struct typec_mux		*mux;
+	struct typec_retimer		*retimer;
 
 	enum typec_port_data		roles;
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 5897905cb4f0..ed3d070b1ca4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -583,6 +583,7 @@ void typec_unregister_altmode(struct typec_altmode *adev)
 {
 	if (IS_ERR_OR_NULL(adev))
 		return;
+	typec_retimer_put(to_altmode(adev)->retimer);
 	typec_mux_put(to_altmode(adev)->mux);
 	device_unregister(&adev->dev);
 }
@@ -2108,16 +2109,26 @@ typec_port_register_altmode(struct typec_port *port,
 {
 	struct typec_altmode *adev;
 	struct typec_mux *mux;
+	struct typec_retimer *retimer;
 
 	mux = typec_mux_get(&port->dev, desc);
 	if (IS_ERR(mux))
 		return ERR_CAST(mux);
 
+	retimer = typec_retimer_get(&port->dev);
+	if (IS_ERR(retimer)) {
+		typec_mux_put(mux);
+		return ERR_CAST(retimer);
+	}
+
 	adev = typec_register_altmode(&port->dev, desc);
-	if (IS_ERR(adev))
+	if (IS_ERR(adev)) {
+		typec_retimer_put(retimer);
 		typec_mux_put(mux);
-	else
+	} else {
 		to_altmode(adev)->mux = mux;
+		to_altmode(adev)->retimer = retimer;
+	}
 
 	return adev;
 }
-- 
2.39.0.314.g84b9a713c41-goog

