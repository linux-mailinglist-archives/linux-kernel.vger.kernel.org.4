Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173773874A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjFUOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjFUOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:40:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1291738
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b470330145so59577301fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358424; x=1689950424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIB5wlsg1EGijWyF8j75rKQgBWBiWi5YkvKjCqAmdlA=;
        b=hZPbxCk9XomiOQ86nLsKa9dg5VwY4wVkkRVEU+cDxbFEM+K8+b0BMrhwJnpdzq/0pz
         rCuE1hbYh8VV0GTWXM14TwPmqPvBWkle4n8WBK542wPk8521nEWj7NkXJcMaDrjttFam
         V4yR5DFCFFIcXklM/60ZbdaFtySrXICV+vjlfsokVGWjDPFVHyUQ3Y1qlqIXnRl97aV/
         PLJkgb4n/lyGB9ibzT/VKBGZjLzaKarEAa6mAzHVeLR84tiestjLMnguFe8NI5QSWaBH
         leJnf2t9e+JPvcDCnoLkpHreNi/SOk8+ICal1qavMc32+jOF/InGmEPhs9dJ3JlgGBnI
         41tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358424; x=1689950424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIB5wlsg1EGijWyF8j75rKQgBWBiWi5YkvKjCqAmdlA=;
        b=kSOw1hOn1yHgTA5cu5XrgsXW94H05cpl7FJWh+MqsLNcuoIxOKT1Ma4UI8DWvi4eas
         CXm6JTQJn36XaLCQSKsS2a8OhmN4Ey2EFYaYZ4/CNy98gfmenjP29mSVS73XVapOFGs5
         JfMIumTR0Olq6rJgFToY+3dSVGYQG/5IOWK93ty8GcBrzb6RSXpjFO+fQrgrzkchXUME
         pZPSLczZeYqbUmoYMd+Ke9RttnfgEP+UhE51DIP3yPidBLyYPX9NG9N+DiDY2m199sla
         f2AGDrPgTko7mHdnsb5ZCq016fMNs94ZkQIDxfAhcNSdJ6CQn/h8JtoKCcem4OhbDjns
         IBVA==
X-Gm-Message-State: AC+VfDwhWSVAbHE8nl38gnc3iXTGmZQxIDR/kieqUoVrOn0d3g3v0XEM
        9quBZ/ubuwjEBjMSmD1GzannuQ==
X-Google-Smtp-Source: ACHHUZ7k63ENiQkXV05akRIrSQQx+fyIyMmPCMnSBT7DefX3zvKIr+pXgiEvpsGoEML2BHGHFjQs5w==
X-Received: by 2002:a2e:b16d:0:b0:2b4:7875:dd98 with SMTP id a13-20020a2eb16d000000b002b47875dd98mr6627839ljm.23.1687358424498;
        Wed, 21 Jun 2023 07:40:24 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.17])
        by smtp.gmail.com with ESMTPSA id l13-20020a056402344d00b0051879c4f598sm2689505edc.66.2023.06.21.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:40:23 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [RFC PATCH v5 1/4] driver core: Add dev_set_drv_sync_state()
Date:   Wed, 21 Jun 2023 17:40:16 +0300
Message-Id: <20230621144019.3219858-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621144019.3219858-1-abel.vesa@linaro.org>
References: <20230621144019.3219858-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

This can be used by frameworks to set the sync_state() helper functions
for drivers that don't already have them set.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 66c13965153d..bae11928ef7e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -995,6 +995,18 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_drv_sync_state(struct device *dev,
+					 void (*fn)(struct device *dev))
+{
+	if (!dev || !dev->driver)
+		return 0;
+	if (dev->driver->sync_state && dev->driver->sync_state != fn)
+		return -EBUSY;
+	if (!dev->driver->sync_state)
+		dev->driver->sync_state = fn;
+	return 0;
+}
+
 static inline void dev_set_removable(struct device *dev,
 				     enum device_removable removable)
 {
-- 
2.34.1

