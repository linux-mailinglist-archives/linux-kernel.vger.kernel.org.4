Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC569FE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBVWLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjBVWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:11:44 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF49392BE;
        Wed, 22 Feb 2023 14:11:26 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id op8so10266175qvb.11;
        Wed, 22 Feb 2023 14:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RisiUnTKxh0SthJdKQRZqo4o/ROREVq/nJM+wr/YiyI=;
        b=gkgOt5jnP0EGkBSRBVDtWTyRrxk4P+ulLM6orh8qwdEObuAEmgxpTS8mrl7Sy1vbOp
         3lTRsAYmS+l4Q10AW7HHk+WtspQ9vHaHUr+gl2zcEeScU/SoCRen6vpA84C5BpVyC2/n
         VDoYG1tfdy+Nc6+ROysdMV37oYFJBwSX7203pO0MJng4Voe089c+UoHPUSAypvAmvUkk
         8ow3mJqzCcH8esL/MGfR1IdTF7QabUFveqh0HMI4vVkhBavvnqn93RtsrJtFW+3fhD8c
         lSg8Dxjiq6z1Qh6Fl8YWJ4cjWK5VlRj1UQMIIIc8db/xW1Q0SgsuHh0to4y52sv5j/fp
         fMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RisiUnTKxh0SthJdKQRZqo4o/ROREVq/nJM+wr/YiyI=;
        b=CFKff1F5vR50ePVd8TdUJLfjRqt4e7SEwsFHv6RONqYSpLc/A1zuBVQOzZqMZeT60s
         CTcHUcR9nv5I6MbLwWlJczMlyEA81Lpz34rY3xT/h9bphtgbfmMz887FMXrDs6t5yClP
         aJ2ofsQ0ey2QVBwW0ETG6oaxM9HE+a82UmsO6BqilLtWADdaO4Mb4zHHGZGiFW0KJTb4
         rtFQAIA3oteysqomm7baRKo1fXXIKrssm6+mTCfa0d2tbi1TSN2mx6NA5JqHGVfV5STC
         Q1uaOx3vhzsIorY6wRA1aM0sdZc6MgVXQUTY31g+Mog/dOfjncbsxtComxbIQgqSGg+R
         03Fg==
X-Gm-Message-State: AO0yUKUlGmiHl9llTu5LKonnfM+zbFZOLlCYjCsJv3GuvulgDg4XycOk
        ZIPhFFgsZfbyiW6eVOB5Uss=
X-Google-Smtp-Source: AK7set8dsFE9wYnrnZaQVj3UcXkC7O2c4gQSgT2qmjPqM1k0HqXuboFp1KI+P1SJ6xUaVjKf/eBQ7Q==
X-Received: by 2002:a05:6214:c22:b0:56c:858:6c00 with SMTP id a2-20020a0562140c2200b0056c08586c00mr15649929qvd.32.1677103885021;
        Wed, 22 Feb 2023 14:11:25 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:70ac:b1e4:53db:3994])
        by smtp.gmail.com with ESMTPSA id a83-20020ae9e856000000b0073f7f1618e8sm6334294qkg.51.2023.02.22.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:11:24 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/2] of: unittest: treat missing of_root as error instead of fixing up
Date:   Wed, 22 Feb 2023 16:10:51 -0600
Message-Id: <20230222221051.809091-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222221051.809091-1-frowand.list@gmail.com>
References: <20230222221051.809091-1-frowand.list@gmail.com>
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

