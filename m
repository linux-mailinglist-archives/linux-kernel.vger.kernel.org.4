Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567606B4747
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjCJOtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjCJOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:17 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF98122399;
        Fri, 10 Mar 2023 06:47:29 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-176261d7f45so6034839fac.11;
        Fri, 10 Mar 2023 06:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2CxQVHwtr3wlNxH6MjBO8bDMbJbWt3MoMaK9ZWX5lU=;
        b=14M+FGldcMZanV11C51qabmOMPfHs6nNaCHFItnzOaxMBisgUYfmKPNrsmvaF54cMa
         8t9dLMXCt7bKlNczbj2YS9VrImY33tyEZOr3B1ruRAwP3fkpphqqX2ghYAbp7daoAlhi
         KzIBwSA/wD1DZRla0SjhO9TaJVYIPVSr4i+pDV2ibXpPuOBei5Emg02SO/yCaGGRIZ3d
         xJYqtT101yT1OxMt/KRGbnL/7tHGXQm5PuILjmP9hkMyqAgdxF6JLAimP3Vf8thJpiTZ
         R19xh/4i3uFjwSZ3iutWz9DEXab0fWT+4yA4MlQd0VVvPIds7hdBSBR0pNl8fyr1V02g
         8w/g==
X-Gm-Message-State: AO0yUKXI79MW1W8wC5rPAlbPXaikYVC+xkTkGrABNw/O5cmnf7LrBqKZ
        lj4Ib2yiv0vltCDZF/1dXRgZkCbL8w==
X-Google-Smtp-Source: AK7set/0G0Lvyo7EMS2TNN30LYTyjTzCgvaBM8CcI9Z89Q0l2+Lf0Q1PcNJYwXUX/oTxFCnx4Oct2g==
X-Received: by 2002:a05:6870:3907:b0:172:3d66:c428 with SMTP id b7-20020a056870390700b001723d66c428mr16322716oap.25.1678459649240;
        Fri, 10 Mar 2023 06:47:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y13-20020a4ade0d000000b005251903c669sm666oot.13.2023.03.10.06.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:28 -0800 (PST)
Received: (nullmailer pid 1542391 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hte: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:06 -0600
Message-Id: <20230310144706.1542365-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
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
 drivers/hte/hte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 7c3b4476f890..9f3221462e75 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -518,7 +518,7 @@ static struct hte_device *hte_of_get_dev(struct device *dev,
 
 	np = dev->of_node;
 
-	if (!of_find_property(np, "timestamp-names", NULL)) {
+	if (!of_property_present(np, "timestamp-names")) {
 		/* Let hte core construct it during request time */
 		desc->attr.name = NULL;
 	} else {
-- 
2.39.2

