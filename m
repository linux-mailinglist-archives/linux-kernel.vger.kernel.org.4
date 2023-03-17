Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1325F6BE0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCQFei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCQFeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:34:31 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A2F940;
        Thu, 16 Mar 2023 22:34:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id n2so4591660qtp.0;
        Thu, 16 Mar 2023 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679031269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/GcK3ST5seDShdKUAT+Ly3z8BvqJ6uC+lJYQIWJMMM=;
        b=lFyz6F9UsZO61Y6dJ947WIhMUEJnlu9oTELO/Xk2A6yS/VqTz4qMkEarvYPmk8l8Ct
         P8jdcv0BqrvNDq+/1Sq3kmUQwa24jskLcmx6bH9pyCxodORxu8pD1UgaoSgjVohEvDah
         ifTE5PU75RP5rW5SojIhSIs5PNSxc8jxhMVh1lEEzfplVqyE6CxOiTRnJe4NwWzemtPb
         DEB2etFF9HKDqXH+4EwZkFIctPBb2kC2kN9/fDrgvshMVbcV0wsUBRNpdvPoD2uNqXyH
         FFEe+wkOL+Ot2qX89SfH6f9n9qcxvcY964CLm97iIPdQm/uyWVGmRSo4loRo5FsXs8vr
         0IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679031269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/GcK3ST5seDShdKUAT+Ly3z8BvqJ6uC+lJYQIWJMMM=;
        b=T/S1a1scvd/lT0PFI01VrrfkljsX7Iil/1P83BejN5ALvs3Z7sDgIBab5MW0KrSvfT
         HPUSWSpfYo6rgYVyl+BnkDuVoaiCmD06J+Dfso8g22pmD9EgMj/vX+BLWcDgJJuE5k9Z
         0gq90PKmQxAUt8QHJ1CQ1EHvQwTFiOnCg24BorbWVFMCDaSCsmhZwk/nz6kKwIwsgi8Z
         JdMwptJOq5rpy5b4f84qxYCcOwfiWIiNs8SuQwbVJgqVdbeQQo4mXhNYeIiTK9jI+jwK
         VommwN1tmk6cQfYU/gR3YaMe/sfZ5Gw9I5034xyvty13mdBU6PF668Kpyz7kW1ReiRY1
         aMkw==
X-Gm-Message-State: AO0yUKWMrWEvgmaNNjeCRiZNqbc+XgHNh5d5e0gtOF3GpKwKprNr2f1L
        L8cSvfOmqbA2OClrK4QTmaYao/+uN+g=
X-Google-Smtp-Source: AK7set9bBUA+Hmo3UZGk+DY2y/igOweTOcOhMrhYCAq6wHrVnwo7Irht7XIFmaXw1+Fl9twph7mxSA==
X-Received: by 2002:ac8:5894:0:b0:3bf:c388:cbea with SMTP id t20-20020ac85894000000b003bfc388cbeamr11456463qta.43.1679031269060;
        Thu, 16 Mar 2023 22:34:29 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:557c:9772:415e:adc7])
        by smtp.gmail.com with ESMTPSA id i5-20020ac860c5000000b003b34650039bsm737649qtm.76.2023.03.16.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:34:28 -0700 (PDT)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 2/2] of: unittest: treat missing of_root as error instead of fixing up
Date:   Fri, 17 Mar 2023 00:34:15 -0500
Message-Id: <20230317053415.2254616-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317053415.2254616-1-frowand.list@gmail.com>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_of() now ensures that of_root node is populated with the
root of a default devicetree. Remove the unittest code that
created of_root if it was missing.  Verify that of_root is
valid before attempting to attach the testcase-data subtree.
Remove the unittest code that unflattens the unittest overlay
base if architecture is UML.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---

Changes since version 3:
  - refresh for 6.3-rc1
  - remove the CONFIG_UML case of populating the devicetree
  - unittest_data_add() - move an EXPECT_BEGIN() to after an error
    check that can result in an early return

Changes since version 2:
  - none

Changes since version 1:
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix formatting error (leading space) in patch comment

 drivers/of/unittest.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index b5a7a31d8bd2..8dc293ac08b7 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1476,20 +1476,16 @@ static int __init unittest_data_add(void)
 		return -EINVAL;
 	}
 
+	/* attach the sub-tree to live tree */
 	if (!of_root) {
-		of_root = unittest_data_node;
-		for_each_of_allnodes(np)
-			__of_attach_node_sysfs(np);
-		of_aliases = of_find_node_by_path("/aliases");
-		of_chosen = of_find_node_by_path("/chosen");
-		of_overlay_mutex_unlock();
-		return 0;
+		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
+		kfree(unittest_data);
+		return -ENODEV;
 	}
 
 	EXPECT_BEGIN(KERN_INFO,
 		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
-	/* attach the sub-tree to live tree */
 	np = unittest_data_node->child;
 	while (np) {
 		struct device_node *next = np->sibling;
@@ -3612,10 +3608,6 @@ static int __init of_unittest(void)
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
 
 	/* adding data for unittest */
-
-	if (IS_ENABLED(CONFIG_UML))
-		unittest_unflatten_overlay_base();
-
 	res = unittest_data_add();
 	if (res)
 		return res;
-- 
Frank Rowand <frowand.list@gmail.com>

