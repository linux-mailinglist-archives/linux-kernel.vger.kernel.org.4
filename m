Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587046B48D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjCJPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjCJPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:06:35 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8599D4E;
        Fri, 10 Mar 2023 06:59:39 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536c02eea4dso102496147b3.4;
        Fri, 10 Mar 2023 06:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678460254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSlcrAdOk2ZHbJaFPGHkD2mhUxcO2+0jdOc1ehU4BF0=;
        b=Q4SZI/q1Q7vDg9eqmTg3II4xYhX1r4nHDn2Kfg8LMyHEDd0WBtT7MQt09BYWC4VPJJ
         MS2+PZIV04UWYBh88L+eSEpy8eamCgQWmsdx741usuRfbRWLsuubqjAmbCjUbkI1LB8W
         IaD5b13agylttOhXgGSb5LaAQicPo87I3DtAJjShED/dbJuKIT22znp8O8/hJxE9MonD
         guYkPHh98xWLydU7IAoyNlMqv0PQ4jh8zW7wDCUipKmiRmSfVUC+amVFYZWcZePhKE7a
         PvQJyMCclbWV5dVdapgV0Ir9DdkMabklw5W9MSHb84ELJDQWWLFrxv3SLk6dCVX0uxDK
         rhkA==
X-Gm-Message-State: AO0yUKXsCxu9cHBdTLmawPGZY17/RxzIoS5DwKYGSJB6McpDfF/FdWM4
        7+yKO8otFENOsoBqbDC7bMIZsmkGwA==
X-Google-Smtp-Source: AK7set81+R7SptvFiU1mElhgKcbUszs0JCXieCGbcvg5GrDnQizYVUU/z1OANIDVszl1Z9u1lrX8nw==
X-Received: by 2002:aca:2210:0:b0:384:ea9:237d with SMTP id b16-20020aca2210000000b003840ea9237dmr11076654oic.36.1678459724416;
        Fri, 10 Mar 2023 06:48:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y129-20020acae187000000b0038476262f65sm967368oig.33.2023.03.10.06.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:43 -0800 (PST)
Received: (nullmailer pid 1546844 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Leroy <colin@colino.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:35 -0600
Message-Id: <20230310144735.1546817-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/rack-meter.c    | 2 +-
 drivers/macintosh/therm_adt746x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index c28893e41a8b..40240bce77b0 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -387,7 +387,7 @@ static int rackmeter_probe(struct macio_dev* mdev,
 	       if (of_node_name_eq(np, "lightshow"))
 		       break;
 	       if (of_node_name_eq(np, "sound") &&
-		   of_get_property(np, "virtual", NULL) != NULL)
+		   of_property_present(np, "virtual"))
 		       break;
 	}
 	if (np == NULL) {
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 8f5db9093c9a..384b87d661e1 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -483,7 +483,7 @@ static int probe_thermostat(struct i2c_client *client)
 	if (vers != 1)
 		return -ENXIO;
 
-	if (of_get_property(np, "hwsensor-location", NULL)) {
+	if (of_property_present(np, "hwsensor-location")) {
 		for (i = 0; i < 3; i++) {
 			sensor_location[i] = of_get_property(np,
 					"hwsensor-location", NULL) + offset;
-- 
2.39.2

