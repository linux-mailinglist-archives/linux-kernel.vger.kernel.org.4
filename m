Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD269878E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBOVzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBOVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:55:53 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58020252B2;
        Wed, 15 Feb 2023 13:55:52 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id c15so17144699oic.8;
        Wed, 15 Feb 2023 13:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex8q2zDUDeHEdh9muzAk4Jw77fIktw5FRuus10AheOk=;
        b=Or9QCws6+84T67Itj41A+YueCjA2NCy/F0Zf/G0XCAt8ddqZQPpHkiqieNMXnxUy8n
         YipAFldY1Il6r2ZFtFpvEtDJgw+jMfYWvMxGvgQoaHQ4oL1yxFoqTtRZ/0hZ3scyRG/B
         4LSVrBhE2yCEdvkUkHBjeR3LMdzpxiR1dVOm6aXsYnTIMFVbxk4Nf+cBr9oRZ3HoNEsA
         DlCAvSQmuEzguyeZnDNItLClAD+o7oLPiCNL+NLWgREhhKbbjyebVXFF2toWAVGEj3N7
         J/qK8g9XIrRWwox32tz0iuvjiteMgESLwcinBq6B7AwcHDDHH3YQ78YihfLLcU5x2sfM
         CRfA==
X-Gm-Message-State: AO0yUKWwT0gm04KVI2ISJIePqGWl5bLkKRN/79WkNJdBxfbswcAuLPxA
        pxfovvPd3r91q2s6avmnpbS5GQjFVw==
X-Google-Smtp-Source: AK7set8QEGb5Omu11b1kK2zldOn2Cwel+sPXJ54m7NTANSoNlGVwmnR845tkxxROFaoxx4TJ7xVENQ==
X-Received: by 2002:a05:6808:6c8:b0:378:c02:bd51 with SMTP id m8-20020a05680806c800b003780c02bd51mr1645069oih.33.1676498151530;
        Wed, 15 Feb 2023 13:55:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m128-20020acabc86000000b0037880fdb1f6sm7747510oif.24.2023.02.15.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:55:51 -0800 (PST)
Received: (nullmailer pid 691658 invoked by uid 1000);
        Wed, 15 Feb 2023 21:55:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] of: Use of_property_present() helper
Date:   Wed, 15 Feb 2023 15:55:47 -0600
Message-Id: <20230215215547.691573-2-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215215547.691573-1-robh@kernel.org>
References: <20230215215547.691573-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_property_present() instead of of_get_property/of_find_property()
in places where we just need to test presence of a property.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/platform.c | 2 +-
 drivers/of/property.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b3878a98d27f..284379e67649 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -529,7 +529,7 @@ static int __init of_platform_default_populate_init(void)
 		int ret;
 
 		/* Check if we have a MacOS display without a node spec */
-		if (of_get_property(of_chosen, "linux,bootx-noscreen", NULL)) {
+		if (of_property_present(of_chosen, "linux,bootx-noscreen")) {
 			/*
 			 * The old code tried to work out which node was the MacOS
 			 * display based on the address. I'm dropping that since the
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 134cfc980b70..ff71d2ac26cb 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1086,7 +1086,7 @@ static struct device_node *of_get_compat_node(struct device_node *np)
 			np = NULL;
 		}
 
-		if (of_find_property(np, "compatible", NULL))
+		if (of_property_present(np, "compatible"))
 			break;
 
 		np = of_get_next_parent(np);
-- 
2.39.1

