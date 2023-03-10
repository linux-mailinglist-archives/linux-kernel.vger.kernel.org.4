Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703F16B475E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjCJOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjCJOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:17 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6863B10D31D;
        Fri, 10 Mar 2023 06:47:31 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3036378otp.6;
        Fri, 10 Mar 2023 06:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w7H2E20MK/c+6XlILkgZ7nt0rr3HyTMC7JKg2n78vQ=;
        b=oUvXedPYZshpGVFL5nV049LnzAn5IvvWj+T64FerSQIKwHy7PgIQBwSbNeSyIPqRoL
         6HiPl6ivywdsKoAKKzR5Pi4l+A2TAf6N3kinEKOE/gA/uMPAEb6Ip9si5nVE5U9kbdOk
         Bm/ix+J4KJDS//NafVty0VN4i3R31Qm/gFD1Rh/67Fjmq2l6AmGRs3dcSaxAvJq3vLtl
         yuhz7A5O2RY+XLOVax/9gymDJHZehWV66TEmVUQaxbfMAxJtxFQar3VdYmFny+I1bl2/
         PiaMEP9J4xC7TKPgTpRFsbrPviSb1NlRAUW19i0hvAZ2Q3Dg0Kf9/1Ty0KVMibq5cU2f
         e7RQ==
X-Gm-Message-State: AO0yUKU4EXq5URo6aeMQ4e57ahwAwGnGqDT8RpMo3m/o1rfbBCF/PrJz
        5hTTwm1pJPoQMIVmpj1atkgDDDIKrA==
X-Google-Smtp-Source: AK7set/IsF3Ai3xSNIz2lx0Yu/Fngjzx+lXBu0znW7EWt3FuwC3pB5REDfw1WSy/UMILjiyWDRhxdg==
X-Received: by 2002:a05:6830:3687:b0:690:ddbc:d777 with SMTP id bk7-20020a056830368700b00690ddbcd777mr13641632otb.10.1678459650530;
        Fri, 10 Mar 2023 06:47:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p7-20020a0568301d4700b0068bcadcad5bsm104051oth.57.2023.03.10.06.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:29 -0800 (PST)
Received: (nullmailer pid 1542867 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:08 -0600
Message-Id: <20230310144709.1542841-1-robh@kernel.org>
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
 drivers/interconnect/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 0f392f59b135..cc963c754da6 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -451,7 +451,7 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 	 * When the consumer DT node do not have "interconnects" property
 	 * return a NULL path to skip setting constraints.
 	 */
-	if (!of_find_property(np, "interconnects", NULL))
+	if (!of_property_present(np, "interconnects"))
 		return NULL;
 
 	/*
@@ -544,7 +544,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 	 * When the consumer DT node do not have "interconnects" property
 	 * return a NULL path to skip setting constraints.
 	 */
-	if (!of_find_property(np, "interconnects", NULL))
+	if (!of_property_present(np, "interconnects"))
 		return NULL;
 
 	/*
-- 
2.39.2

