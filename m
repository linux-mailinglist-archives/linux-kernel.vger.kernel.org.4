Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479F9640879
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiLBOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiLBOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:32:27 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9C8BDB;
        Fri,  2 Dec 2022 06:32:26 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 9a89291df2bf92d8; Fri, 2 Dec 2022 15:32:23 +0100
Received: from kreacher.localnet (unknown [213.134.188.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 371D52602969;
        Fri,  2 Dec 2022 15:32:22 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 2/2] PM: runtime: Relocate rpm_callback() right after __rpm_callback()
Date:   Fri, 02 Dec 2022 15:32:09 +0100
Message-ID: <2264402.ElGaqSPkdT@kreacher>
In-Reply-To: <5627469.DvuYhMxLoT@kreacher>
References: <5627469.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.181
X-CLIENT-HOSTNAME: 213.134.188.181
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrtdekgdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekkedrudekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeekrddukedupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghtnhhimhhkrghrsehquhhitghinhgtrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphht
 thhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhuihgtpghnihhtihhrrgifrgesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehpvghtvghrrdifrghnghesmhgvughirghtvghkrdgtohhmpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because rpm_callback() is a wrapper around __rpm_callback(), and the
only caller of it after the change eliminating an invocation of it
from rpm_idle(), move the former next to the latter to make the code
a bit easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -422,6 +422,38 @@ fail:
 }
 
 /**
+ * rpm_callback - Run a given runtime PM callback for a given device.
+ * @cb: Runtime PM callback to run.
+ * @dev: Device to run the callback for.
+ */
+static int rpm_callback(int (*cb)(struct device *), struct device *dev)
+{
+	int retval;
+
+	if (dev->power.memalloc_noio) {
+		unsigned int noio_flag;
+
+		/*
+		 * Deadlock might be caused if memory allocation with
+		 * GFP_KERNEL happens inside runtime_suspend and
+		 * runtime_resume callbacks of one block device's
+		 * ancestor or the block device itself. Network
+		 * device might be thought as part of iSCSI block
+		 * device, so network device and its ancestor should
+		 * be marked as memalloc_noio too.
+		 */
+		noio_flag = memalloc_noio_save();
+		retval = __rpm_callback(cb, dev);
+		memalloc_noio_restore(noio_flag);
+	} else {
+		retval = __rpm_callback(cb, dev);
+	}
+
+	dev->power.runtime_error = retval;
+	return retval != -EACCES ? retval : -EIO;
+}
+
+/**
  * rpm_idle - Notify device bus type if the device can be suspended.
  * @dev: Device to notify the bus type about.
  * @rpmflags: Flag bits.
@@ -505,38 +537,6 @@ static int rpm_idle(struct device *dev,
 }
 
 /**
- * rpm_callback - Run a given runtime PM callback for a given device.
- * @cb: Runtime PM callback to run.
- * @dev: Device to run the callback for.
- */
-static int rpm_callback(int (*cb)(struct device *), struct device *dev)
-{
-	int retval;
-
-	if (dev->power.memalloc_noio) {
-		unsigned int noio_flag;
-
-		/*
-		 * Deadlock might be caused if memory allocation with
-		 * GFP_KERNEL happens inside runtime_suspend and
-		 * runtime_resume callbacks of one block device's
-		 * ancestor or the block device itself. Network
-		 * device might be thought as part of iSCSI block
-		 * device, so network device and its ancestor should
-		 * be marked as memalloc_noio too.
-		 */
-		noio_flag = memalloc_noio_save();
-		retval = __rpm_callback(cb, dev);
-		memalloc_noio_restore(noio_flag);
-	} else {
-		retval = __rpm_callback(cb, dev);
-	}
-
-	dev->power.runtime_error = retval;
-	return retval != -EACCES ? retval : -EIO;
-}
-
-/**
  * rpm_suspend - Carry out runtime suspend of given device.
  * @dev: Device to suspend.
  * @rpmflags: Flag bits.



