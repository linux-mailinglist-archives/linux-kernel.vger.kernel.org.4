Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F4869878D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBOVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBOVzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:55:51 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5317F252B2;
        Wed, 15 Feb 2023 13:55:51 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id y11-20020a05683009cb00b0068dbf908574so66882ott.8;
        Wed, 15 Feb 2023 13:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qxOnZbyyMD2X855f4MGJc4sepk9aV6FO9PjuZ5202w=;
        b=noJgcpDjdEwaUs2o39mjJl2m8bKArqmP7pbpfOBuqBlyCYNy1UbDnZcmT3w8m9oK/f
         Dtv3+q+aH+CGjZ1LerKXepyyDxW4ficEH+5E6xjX6CdWZtROBlcYfb/Wopj0LwghlEPq
         NlfmKmthfd5PtzoGngpRU3iFj8bjHsehZVx0y7yn0aJ9F0/2esljzHBEcDPjm7WZA6vM
         73rQrsSKL+E4J7epbiQsbtdgsjoaqr74w+6MDna+iZjMXRWKHT3YlfzPLgLRMYXAKehP
         2mu9zzdwjxXH/0mAj2lU/c4ofgBqtHGZ7InT+EB3h/Ko59buUSdkWUjCKXuhmlnw7DFn
         DGbA==
X-Gm-Message-State: AO0yUKUP0Pf6c1U/PzHjs2PbtM7i/GmEK1i+htL2J3yWUsPVD2DT6yP0
        vLwjPq0j2evP/1ZviZNax3SjmYBryA==
X-Google-Smtp-Source: AK7set9St7sz9CLuIGJpDcK362y0DUfwewQJgY+ksCsjouAS1e6sjFww30S46EbvzZtcTm87C6k/Wg==
X-Received: by 2002:a05:6830:1d45:b0:68b:ddb1:89a2 with SMTP id p5-20020a0568301d4500b0068bddb189a2mr1758446oth.32.1676498150585;
        Wed, 15 Feb 2023 13:55:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a05683004b200b0068d59d15a93sm8167500otd.40.2023.02.15.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:55:50 -0800 (PST)
Received: (nullmailer pid 691641 invoked by uid 1000);
        Wed, 15 Feb 2023 21:55:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] of: Add of_property_present() helper
Date:   Wed, 15 Feb 2023 15:55:46 -0600
Message-Id: <20230215215547.691573-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an of_property_present() function similar to
fwnode_property_present(). of_property_read_bool() could be used
directly, but it is cleaner to not use it on non-boolean properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
I plan to add this for v6.3 and send most of the conversion patches in
the next cycle.
---
 include/linux/of.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 8b9f94386dc3..b3e04021186f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1537,6 +1537,11 @@ static inline bool of_device_is_system_power_controller(const struct device_node
 	return of_property_read_bool(np, "system-power-controller");
 }
 
+static inline bool of_property_present(const struct device_node *np, const char *propname)
+{
+	return of_property_read_bool(np, propname);
+}
+
 /*
  * Overlay support
  */
-- 
2.39.1

