Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201AB6B4751
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjCJOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjCJOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:21 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E5122082;
        Fri, 10 Mar 2023 06:47:35 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-17671fb717cso6050146fac.8;
        Fri, 10 Mar 2023 06:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94mYS0ixkpFzIVMT2vXhMO8X8yYIBJws9koTggQn1Ok=;
        b=2DSLN3Jb39/OsxiXqVPa+MPUBR5O19VsiKMvLl2XzL87hILFO+eFgmZJLwQO0KyxLS
         aUCrljiRn77Dd1iBcyNtUv+VWBU+SQOuG1maBqcAd1gBBSpSolYlvuAYn5NAqPKeX75P
         fWHU2y07ZUntGwBZwXmgtSp9B+cg0Kvb38ku51rC/e0va3et/EJpLB1GR8wHG3aENJ2w
         pFSk+XDWGDsw3PGSRPMkuYf2p4RSED88ERP/HZUb+yk9Pr5qAAY2BZr67bLSnyyzlnxd
         LkDVtw6EZOyl+7rI+0hQ8tx+sbUwtsiVpHm2a/7XRbX/BOLDaiKMvTvLvuFWX198bfyv
         yp5g==
X-Gm-Message-State: AO0yUKUSqAHM7qJTs97h0KmLnIdH9bMJbH4oFCCme7rrGgPT7fOkHy0T
        wJ0aiYhPO/DzuXF+GZ4D0QxJSADDfw==
X-Google-Smtp-Source: AK7set/LANuF+J+3nZ4A+lYhQ5iTPmVTe5pc5374uDILVQ5+zkFLS2zckMiJxyxDFsTnMTBWm0jIcw==
X-Received: by 2002:a05:6870:4724:b0:176:1e66:989a with SMTP id b36-20020a056870472400b001761e66989amr15540733oaq.37.1678459655355;
        Fri, 10 Mar 2023 06:47:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a056870a2c400b00172ac40356csm74698oak.50.2023.03.10.06.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:34 -0800 (PST)
Received: (nullmailer pid 1542552 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: ltc4245: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:07 -0600
Message-Id: <20230310144707.1542525-1-robh@kernel.org>
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
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/ltc4245.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 5088d28b3a7c..57cbaf3b39fa 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -434,7 +434,7 @@ static bool ltc4245_use_extra_gpios(struct i2c_client *client)
 		return pdata->use_extra_gpios;
 
 	/* fallback on OF */
-	if (of_find_property(np, "ltc4245,use-extra-gpios", NULL))
+	if (of_property_read_bool(np, "ltc4245,use-extra-gpios"))
 		return true;
 
 	return false;
-- 
2.39.2

