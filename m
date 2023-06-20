Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFE737460
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFTSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjFTSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89610E2;
        Tue, 20 Jun 2023 11:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D53361376;
        Tue, 20 Jun 2023 18:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43D9C433C8;
        Tue, 20 Jun 2023 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687286090;
        bh=YOzPATmO8wGxwInPsNJVCNLX4H1Ef7rZzowHevjjD/s=;
        h=From:To:Cc:Subject:Date:From;
        b=1PLSkGkIsZPxpmUHXeKhKsPySfKl8A/ptcE9hebeInjOUIy3rHWsvPBJuqZFg1vUC
         gEYjlxlCn3fKyaBlDDyExTW37J8QGIYxqszhKuI5zuYGyBivS5DT8sFa3SJ50VHdun
         OXHHb+Et160zUAD4d2MXqwAE1RgLasXPi6NkPtzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] oradax: make 'cl' a static const structure
Date:   Tue, 20 Jun 2023 20:34:47 +0200
Message-ID: <20230620183446.684061-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=gregkh@linuxfoundation.org; h=from:subject; bh=iMcb7lPwqLnwJII9WdVDNBIv4TpcWL4faC5ec2Wi5h8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTP7o9D5+0ouLTn66PoYd+SuYv1j26WX7Z2qUuHlfMx Ccs+lPs2BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATcehiWHDgu/t3+3VzPVes 9baYEsd16EL0FTmGBUcsjwgfSZj+e92uJzJzmmcaXs6+2AcA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the 'cl' structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: sparclinux@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/sbus/char/oradax.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index aafce8d00000..a536dd6f4f7c 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -226,8 +226,10 @@ static int dax_ccb_info(u64 ca, struct ccb_info_result *info);
 static int dax_ccb_kill(u64 ca, u16 *kill_res);
 
 static struct cdev c_dev;
-static struct class *cl;
 static dev_t first;
+static const struct class cl = {
+	.name = DAX_NAME,
+};
 
 static int max_ccb_version;
 static int dax_debug;
@@ -323,14 +325,11 @@ static int __init dax_attach(void)
 		goto done;
 	}
 
-	cl = class_create(DAX_NAME);
-	if (IS_ERR(cl)) {
-		dax_err("class_create failed");
-		ret = PTR_ERR(cl);
+	ret = class_register(&cl);
+	if (ret)
 		goto class_error;
-	}
 
-	if (device_create(cl, NULL, first, NULL, dax_name) == NULL) {
+	if (device_create(&cl, NULL, first, NULL, dax_name) == NULL) {
 		dax_err("device_create failed");
 		ret = -ENXIO;
 		goto device_error;
@@ -347,9 +346,9 @@ static int __init dax_attach(void)
 	goto done;
 
 cdev_error:
-	device_destroy(cl, first);
+	device_destroy(&cl, first);
 device_error:
-	class_destroy(cl);
+	class_unregister(&cl);
 class_error:
 	unregister_chrdev_region(first, 1);
 done:
@@ -362,8 +361,8 @@ static void __exit dax_detach(void)
 {
 	pr_info("Cleaning up DAX module\n");
 	cdev_del(&c_dev);
-	device_destroy(cl, first);
-	class_destroy(cl);
+	device_destroy(&cl, first);
+	class_unregister(&cl);
 	unregister_chrdev_region(first, 1);
 }
 module_exit(dax_detach);
-- 
2.41.0

