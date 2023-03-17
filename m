Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A26BE5C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjCQJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCQJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:39:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C10026CFD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:39:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p4so3827189wre.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devialet.com; s=google; t=1679045954;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f65fKEpaJqyUwxXm+2vVNOROxBQI4YZ3iwac9jAGXik=;
        b=NBjutXHRYhGs4yncXA2Mz3GN3rTOnP4ccUT+UC8p9A2/M9W9SltGnY2TCP0wgJH/85
         ynZWkq/jqHjfpRBcnNvua+0J6UoN7qHBlPNqNVu42Sz1Lh1YYcr4n8wZimlO41w62hbG
         xnVokWGXzflt44ziHDb60+iGA3Is5W43KwdFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045954;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f65fKEpaJqyUwxXm+2vVNOROxBQI4YZ3iwac9jAGXik=;
        b=oiiYFMMc+Pp+kBVt1H26aDmIiCUkVflNjNrMmvtEocaBT1AlgkN9GeV+YsbUtTSZ/6
         OTyRMUQJyBRN9l2XG+sdNfJcCpOBq9/pzz1L3G59DZL7g3RUnjfm8ap0RSaKsuxHtqPJ
         pgw7KuskGcoav9dK/U0m3ApZQeAT1C0ONlqeR+yDycv+nE1eLC6MIHiiuzPsWnEZbk1X
         nKX3mQ9ax1sNcBpDiPIbxl7HPkStWKOetcWEWt5w/ASNYo/9/rj18sWv9IgcMr7eVKVf
         V/LB26fJukElB+VaeQJa9cxD7LFhkjF22xt/8f3z0OCrSAmGs7uC7rO1FCtjR+Ct/VBn
         qzRw==
X-Gm-Message-State: AO0yUKWYjD/tpwNLRjK7fvT1Paao1CcHXhvF6M0LtJyH9MCnBp1Hjbzc
        bmBrJI5EFoByqFD/FyYMbSW3nR+PpnuPdQVjRZ4D6t3A+jdTEnF9oeDamu2ch4w4s7R9s8Uxf6F
        TESWcKpwDwHXE0pX3Iw==
X-Google-Smtp-Source: AK7set/iRb/u//fySyWaWubjeyTeZKJQjHl+WIsUn08tQDSEP8zBTlOAHNVosAPfcreOyj4pvWwCjw==
X-Received: by 2002:a5d:55cb:0:b0:2d1:21a1:742d with SMTP id i11-20020a5d55cb000000b002d121a1742dmr3890276wrw.6.1679045953916;
        Fri, 17 Mar 2023 02:39:13 -0700 (PDT)
Received: from nicolas-laptop.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b002c592535839sm1530823wrr.17.2023.03.17.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:39:13 -0700 (PDT)
From:   Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Subject: [PATCH 2/2] bindings: regulator: pca9450: Add LOADSW regulator
Date:   Fri, 17 Mar 2023 10:39:11 +0100
Message-Id: <20230317093911.1254530-3-nicolas.heemeryck@devialet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317093911.1254530-1-nicolas.heemeryck@devialet.com>
References: <20230317093911.1254530-1-nicolas.heemeryck@devialet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation for the load switch regulator.

Signed-off-by: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 835b53302db8..064d57256aff 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -20,6 +20,7 @@ description: |
 #The valid names for PCA9450 regulator nodes are:
 #BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
 #LDO1, LDO2, LDO3, LDO4, LDO5
+#LOADSW
 #Note: Buck3 removed on PCA9450B and connect with Buck1 on PCA9450C.
 
 properties:
@@ -74,6 +75,14 @@ properties:
 
         unevaluatedProperties: false
 
+        "LOADSW":
+          type: object
+          $ref: regulator.yaml#
+          description:
+            Properties for LOAD SWITCH regulator.
+
+        unevaluatedProperties: false
+
     additionalProperties: false
 
   sd-vsel-gpios:
@@ -190,6 +199,11 @@ examples:
                     regulator-boot-on;
                     regulator-always-on;
                 };
+                loadsw: LOADSW {
+                    regulator-name = "LOADSW";
+                    regulator-boot-on;
+                    regulator-always-on;
+                };
             };
         };
     };
-- 
2.34.1


-- 
- Confidential -
