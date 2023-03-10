Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065656B47C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjCJOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjCJOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:53:28 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADFC12A177;
        Fri, 10 Mar 2023 06:49:29 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176b90e14a9so6042731fac.9;
        Fri, 10 Mar 2023 06:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeturFWI0c03F8rWh31njjpGhdYT8mTfReK2FhO4MIc=;
        b=qpN68uxFMkAhzOOE2wZuiL6ROS2+ZhJGCmwTi51uEHDOuQhG4Lg1cx2LJurdycqZgA
         sb8bC/inS+RWh4+GYk+BhWuBY7BXmGtuZCgI1YZavz8L62jvDlwUPHD/yiPl+To6lOuc
         iHT5iHLLAu+aQtZuVd6TwLrtTSAO+AmZloZCk8uddjP9EzBlSUVXDo8SAj/3AY+2fxOd
         8qbvVgRuI4xkl7aIX+y78gP0Bj/CilfD2TUsfSEPOcYk4CbH83IyMSP9vkZBWGcMPYWO
         NPYRcX3sEffuEZmw5/JqYw/mJ0wY9e+JwqKLOtl5GuWAR06dRgsSq692sfPgtbD/ymFN
         PDiA==
X-Gm-Message-State: AO0yUKUxCbXbBBOKDYvtngtS6Gv6sfTCgXdCUe/wVbt9P4GLE/ml7ZHy
        KdqF9RT4HHzxAbkiqmnn0w==
X-Google-Smtp-Source: AK7set98LW32b1srv6QLeEq6OEp6lxv/K4bgOt8w/1gZLcSEpbdFe61Bs25SuZu0MVlw4ylfQZIqhg==
X-Received: by 2002:a05:6870:c10e:b0:172:2d0b:6121 with SMTP id f14-20020a056870c10e00b001722d0b6121mr5430915oad.36.1678459709956;
        Fri, 10 Mar 2023 06:48:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ax16-20020a05687c021000b00176d49bb898sm79608oac.44.2023.03.10.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:29 -0800 (PST)
Received: (nullmailer pid 1544400 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:18 -0600
Message-Id: <20230310144719.1544374-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/opp/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e55c6095adf0..bed2b651deb0 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -224,7 +224,7 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 	of_property_read_u32(np, "voltage-tolerance",
 			     &opp_table->voltage_tolerance_v1);
 
-	if (of_find_property(np, "#power-domain-cells", NULL))
+	if (of_property_present(np, "#power-domain-cells"))
 		opp_table->is_genpd = true;
 
 	/* Get OPP table node */
@@ -536,7 +536,7 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 		 * an OPP then the OPP should not be enabled as there is
 		 * no way to see if the hardware supports it.
 		 */
-		if (of_find_property(np, "opp-supported-hw", NULL))
+		if (of_property_present(np, "opp-supported-hw"))
 			return false;
 		else
 			return true;
-- 
2.39.2

