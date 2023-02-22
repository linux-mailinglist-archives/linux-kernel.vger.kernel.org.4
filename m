Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96669EDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjBVDza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjBVDz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:55:27 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03B31E0F;
        Tue, 21 Feb 2023 19:55:26 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so1235011otm.3;
        Tue, 21 Feb 2023 19:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RisiUnTKxh0SthJdKQRZqo4o/ROREVq/nJM+wr/YiyI=;
        b=mJzj0Kh6Ny+WV2zRyd/i0FgKix70BpBi/bk64KxYVV1kMpmOSO0KbfIfqfyAJHVfjL
         91jQhvYUwAB2jy/yywyIG1CCdBcH1D2O7Z+rPsMIMB2rRw++E78s9ktgrmGysJo2kKmR
         hSMq/pW8ibFmpnJCFE8TAByaGUTDFycE+29NFuv4cC+kk/gVjDIu11jDn5vLGrOAyQNb
         Fq1jBuiJZIxtTqgY7wS5aQkfdUumkUJ803fv+RUIe7vurWdzpOYbLzFA24igUqoikXxG
         YL99EguEl0vf6QHe+QFcfkcP3JA0KA0V3hCR0g8XOEyb0MSJoLfAOBeWOdRkoNL1HkOB
         0xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RisiUnTKxh0SthJdKQRZqo4o/ROREVq/nJM+wr/YiyI=;
        b=BWYZ33/20AVqpWqr8XTSTeE5DtTPgoYKooEDnUS7Uty0xiXXHMFfcIw+1OM+AAzQ16
         DZn4aeiHipqElzjo7x3U4DOJnZF73hxqXXdUDnumm57f57fgFcWYbktEqPpr1ieaLN56
         P3+34kvXwrJtR21yctG2nhWbCJWYPADy/C2B0CChasGOciHXJesU0DuJH3XKeVv14brT
         lDUs+13ENpfYPq2Lnn3uYRS5gLj4ybVxnTItp/A7jfYPfT4fUhiiUfzQclFdzjNnCEZm
         iMRNTKD4Uul27EoR6L1Xux6CIGPqopPU7QKiEijbOkF1B0+Oq2jqEpzejOxUOBLnyAer
         giwg==
X-Gm-Message-State: AO0yUKXkbMA9lkKChJzY/+UeraJM6P7pP+oUy7huw65y/4xYvHW41kF1
        tDdmofm6PzLcuziZ9xcxjcY=
X-Google-Smtp-Source: AK7set/sJ34MLf2jf6mSSDOZ23KNk5Up3UeK3LZwuo+rpYWvgeYKkLSkcAhL0/VhL8e4TIN6juyZSw==
X-Received: by 2002:a05:6830:3115:b0:68b:cb07:49ec with SMTP id b21-20020a056830311500b0068bcb0749ecmr4527670ots.14.1677038125821;
        Tue, 21 Feb 2023 19:55:25 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:70ac:b1e4:53db:3994])
        by smtp.gmail.com with ESMTPSA id y6-20020a056830070600b00684cbd8dd49sm533404ots.79.2023.02.21.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 19:55:25 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/2] of: unittest: treat missing of_root as error instead of fixing up
Date:   Tue, 21 Feb 2023 21:54:52 -0600
Message-Id: <20230222035452.803375-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222035452.803375-1-frowand.list@gmail.com>
References: <20230222035452.803375-1-frowand.list@gmail.com>
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

