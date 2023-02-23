Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21086A121E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBWVer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBWVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:34:44 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE058493;
        Thu, 23 Feb 2023 13:34:42 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-172094e10e3so17183252fac.10;
        Thu, 23 Feb 2023 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG7BfhWICi210IReUr1JwkGM/hX8ZWUtKNaWTP0Cayw=;
        b=Jaw6YqX3I/wdi0fmfNqg1NUJ/gocDWwOkWX+csGeI//TF8ks9gPp2y6kV09BDut0Y4
         JCzhcZKHEkbX69uFLZ0dtwBscVSDBLAS45n219s9fKt9uO9IXVEk/0CJRf4fWCdcm9hT
         tvEcXRqy+Y5GUTkXaAWDMqOUzJidVuHeN81NHeQMyuwro46jXwkyZhSfvYUGQbEht3an
         m0zYh5f9b36ru8QVHjlnksS+u9njTuOi79HGnRX6YbwM5+/9YHa3s6yiTiLCePsaAg3Q
         Ucta2qASJpNDf2m1geK6m3s1qQ/65KzjJxHkCfr+aMkaLKeEaCxSt+Cg2Z/bj5U3qPBE
         D/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG7BfhWICi210IReUr1JwkGM/hX8ZWUtKNaWTP0Cayw=;
        b=K9qHQl8sLOIwh903/Y15ZanrCueQlo4aANvydu6egWaOUckM18AjHPZn1uKQott8N1
         dFp9mDNtVts2RfhWaQXzLKdmwDvn3TSG/YHMUEqgqLJAu/kRNDpFdN1bHI5wjvNU+b1n
         3HUtmSC6NLyFouglr9n9xJ5oY+u6ImE1TzQ9uAEK7f0leyzopjOxo7cLiXJ9H4TOJXEd
         AvJitp0xFRvUUQv34oLUldDaYCR353q5/r6ribnZNJ5/s9WdQuwvUAG51MqvicrqoH6T
         PhQAfqnhwBRyxUoyUIzFORrxUsX77Y9GCLy0FS6mK91DmjgLHvQSV76QkTJjoVJVPclr
         jUbg==
X-Gm-Message-State: AO0yUKW681Ww5lf3KYmY4oB/yIkx1bj73irM/Ej6aFlnfuz77sV+PzAu
        jIiTWUVd2DaT/JC4AUtXNT0=
X-Google-Smtp-Source: AK7set8Jz334GZrHm4qZzNSXqExXNUlHd+MEPdEfUgrROm7qqiTs9SJxeyl0gbyoDXzRovJFLS+9tg==
X-Received: by 2002:a05:6870:3929:b0:16e:8edf:42bb with SMTP id b41-20020a056870392900b0016e8edf42bbmr14552787oap.14.1677188082166;
        Thu, 23 Feb 2023 13:34:42 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:e42b:73d3:ba1a:1b32])
        by smtp.gmail.com with ESMTPSA id r1-20020a4ae501000000b00524fe20aee5sm2903976oot.34.2023.02.23.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:34:41 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 2/2] of: unittest: treat missing of_root as error instead of fixing up
Date:   Thu, 23 Feb 2023 15:34:18 -0600
Message-Id: <20230223213418.891942-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223213418.891942-1-frowand.list@gmail.com>
References: <20230223213418.891942-1-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
Changes since version 2:
  - none

Changes since version 1:
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix formatting error (leading space) in patch comment

 drivers/of/unittest.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index bc0f1e50a4be..006713511c53 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1469,20 +1469,16 @@ static int __init unittest_data_add(void)
 		return -EINVAL;
 	}
 
-	if (!of_root) {
-		of_root = unittest_data_node;
-		for_each_of_allnodes(np)
-			__of_attach_node_sysfs(np);
-		of_aliases = of_find_node_by_path("/aliases");
-		of_chosen = of_find_node_by_path("/chosen");
-		of_overlay_mutex_unlock();
-		return 0;
-	}
-
 	EXPECT_BEGIN(KERN_INFO,
 		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
 	/* attach the sub-tree to live tree */
+	if (!of_root) {
+		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
+		kfree(unittest_data);
+		return -ENODEV;
+	}
+
 	np = unittest_data_node->child;
 	while (np) {
 		struct device_node *next = np->sibling;
-- 
Frank Rowand <frowand.list@gmail.com>

