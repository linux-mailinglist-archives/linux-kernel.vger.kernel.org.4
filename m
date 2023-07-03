Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC47745FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGCPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:24:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1382AE44;
        Mon,  3 Jul 2023 08:24:03 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363FGerx002353;
        Mon, 3 Jul 2023 15:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XX/0OO54wPH+sHb1bhYwakicAKLe2TXrnBfi5bUvmak=;
 b=mhdsPt7iuJDYXd6XsyWGPoGOLoDeWkoFMpokL6wU3MH1FgsnWju0QiQL6hP9kqlSSLj+
 kpP01EsW0t6nnEZ/93UPNgzrS+W7uoTpQ5Q19J8PJG/7wzhGEEfV6NfiGllGLV3GGy1Y
 QDpRq4WlPnoKzoIMWjXan3BW6qdSv1ZV+rTmHYDFkDyeX8nCj40Zh3XnhmKxhnbp6YNb
 P3g8hF9VeUAoIjONJOuXSKwVdIETK1D8rpuLqb4bs7hyNShFc76thz4cQva5NaP667cp
 Iloyx7HD8/IrsymN8IQERoDSE5fh2vlsWN8LseOHf2TVCJdQZWJMmwT2W78SoHTze80j 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm0u5r6km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:24:00 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363FGgDq002475;
        Mon, 3 Jul 2023 15:24:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm0u5r6jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:24:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3633njWv024429;
        Mon, 3 Jul 2023 15:23:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde1cvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:23:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363FNtWn39911762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 15:23:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDA6A2004B;
        Mon,  3 Jul 2023 15:23:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 933BB2004D;
        Mon,  3 Jul 2023 15:23:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jul 2023 15:23:55 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/1] Input: gameport: add ISA and HAS_IOPORT dependencies
Date:   Mon,  3 Jul 2023 17:23:55 +0200
Message-Id: <20230703152355.3897456-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703152355.3897456-1-schnelle@linux.ibm.com>
References: <20230703152355.3897456-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9180IHRVap59P-G37HhCgF8lfqFQzfUW
X-Proofpoint-GUID: FrGz4yymQ95VT8J5STO2I8rWG6GxrDL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=974 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
not being declared. As ISA already implies HAS_IOPORT we can simply add
this dependency and guard sections of code using inb()/outb() as
alternative access methods.

Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/input/gameport/Kconfig    |  4 +++-
 drivers/input/gameport/gameport.c | 28 +++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/input/gameport/Kconfig b/drivers/input/gameport/Kconfig
index 5a2c2fb3217d..fe73b26e647a 100644
--- a/drivers/input/gameport/Kconfig
+++ b/drivers/input/gameport/Kconfig
@@ -25,6 +25,7 @@ if GAMEPORT
 
 config GAMEPORT_NS558
 	tristate "Classic ISA and PnP gameport support"
+	depends on ISA
 	help
 	  Say Y here if you have an ISA or PnP gameport.
 
@@ -35,6 +36,7 @@ config GAMEPORT_NS558
 
 config GAMEPORT_L4
 	tristate "PDPI Lightning 4 gamecard support"
+	depends on ISA
 	help
 	  Say Y here if you have a PDPI Lightning 4 gamecard.
 
@@ -53,7 +55,7 @@ config GAMEPORT_EMU10K1
 
 config GAMEPORT_FM801
 	tristate "ForteMedia FM801 gameport support"
-	depends on PCI
+	depends on PCI && HAS_IOPORT
 	help
 	  Say Y here if you have ForteMedia FM801 PCI audio controller
 	  (Abit AU10, Genius Sound Maker, HP Workstation zx2000,
diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index a1443320b419..bee935211554 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -519,12 +519,34 @@ EXPORT_SYMBOL(gameport_set_phys);
 
 static void gameport_default_trigger(struct gameport *gameport)
 {
+#ifdef CONFIG_HAS_IOPORT
 	outb(0xff, gameport->io);
+#endif
 }
 
 static unsigned char gameport_default_read(struct gameport *gameport)
 {
+#ifdef CONFIG_HAS_IOPORT
 	return inb(gameport->io);
+#else
+	return 0xff;
+#endif
+}
+
+static void gameport_setup_default_handlers(struct gameport *gameport)
+{
+	if (gameport->trigger && gameport->read)
+		return;
+
+	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
+		dev_err(&gameport->dev,
+			"I/O port access is required for %s (%s) but is not available\n",
+			gameport->phys, gameport->name);
+
+	if (!gameport->trigger)
+		gameport->trigger = gameport_default_trigger;
+	if (!gameport->read)
+		gameport->read = gameport_default_read;
 }
 
 /*
@@ -545,11 +567,7 @@ static void gameport_init_port(struct gameport *gameport)
 	if (gameport->parent)
 		gameport->dev.parent = &gameport->parent->dev;
 
-	if (!gameport->trigger)
-		gameport->trigger = gameport_default_trigger;
-	if (!gameport->read)
-		gameport->read = gameport_default_read;
-
+	gameport_setup_default_handlers(gameport);
 	INIT_LIST_HEAD(&gameport->node);
 	spin_lock_init(&gameport->timer_lock);
 	timer_setup(&gameport->poll_timer, gameport_run_poll_handler, 0);
-- 
2.39.2

