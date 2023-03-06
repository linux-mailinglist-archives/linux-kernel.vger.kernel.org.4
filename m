Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262F96ACC72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCFSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:24:16 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B73DD7DB2;
        Mon,  6 Mar 2023 10:23:58 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 9B8B27A05BD;
        Mon,  6 Mar 2023 18:28:28 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/18] pata_parport: Introduce module_pata_parport_driver macro
Date:   Mon,  6 Mar 2023 18:27:39 +0100
Message-Id: <20230306172752.7727-6-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306172752.7727-1-linux@zary.sk>
References: <20230306172752.7727-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce module_pata_parport_driver macro and use it in protocol
drivers to reduce boilerplate code. Remove paride_(un)register
compatibility defines.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  | 13 +------------
 drivers/ata/pata_parport/bpck.c  | 13 +------------
 drivers/ata/pata_parport/bpck6.c | 13 +------------
 drivers/ata/pata_parport/comm.c  | 13 +------------
 drivers/ata/pata_parport/dstr.c  | 13 +------------
 drivers/ata/pata_parport/epat.c  |  4 ++--
 drivers/ata/pata_parport/epia.c  | 13 +------------
 drivers/ata/pata_parport/fit2.c  | 13 +------------
 drivers/ata/pata_parport/fit3.c  | 13 +------------
 drivers/ata/pata_parport/friq.c  | 13 +------------
 drivers/ata/pata_parport/frpw.c  | 13 +------------
 drivers/ata/pata_parport/kbic.c  | 10 +++++-----
 drivers/ata/pata_parport/ktti.c  | 13 +------------
 drivers/ata/pata_parport/on20.c  | 13 +------------
 drivers/ata/pata_parport/on26.c  | 13 +------------
 include/linux/pata_parport.h     | 14 +++++++++++---
 16 files changed, 31 insertions(+), 166 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index b66508bedbd0..9e6098f90162 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -147,16 +147,5 @@ static struct pi_protocol aten = {
 	.log_adapter	= aten_log_adapter,
 };
 
-static int __init aten_init(void)
-{
-	return paride_register(&aten);
-}
-
-static void __exit aten_exit(void)
-{
-	paride_unregister( &aten );
-}
-
 MODULE_LICENSE("GPL");
-module_init(aten_init)
-module_exit(aten_exit)
+module_pata_parport_driver(aten);
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 5fb3cf9ba11d..b9174cf8863c 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -462,16 +462,5 @@ static struct pi_protocol bpck = {
 	.log_adapter	= bpck_log_adapter,
 };
 
-static int __init bpck_init(void)
-{
-	return paride_register(&bpck);
-}
-
-static void __exit bpck_exit(void)
-{
-	paride_unregister(&bpck);
-}
-
 MODULE_LICENSE("GPL");
-module_init(bpck_init)
-module_exit(bpck_exit)
+module_pata_parport_driver(bpck);
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 3b3a40e48b21..3c358e66db25 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -245,19 +245,8 @@ static struct pi_protocol bpck6 = {
 	.release_proto	= bpck6_release_proto,
 };
 
-static int __init bpck6_init(void)
-{
-	return paride_register(&bpck6);
-}
-
-static void __exit bpck6_exit(void)
-{
-	paride_unregister(&bpck6);
-}
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Micro Solutions Inc.");
 MODULE_DESCRIPTION("BACKPACK Protocol module, compatible with PARIDE");
 module_param(verbose, bool, 0644);
-module_init(bpck6_init)
-module_exit(bpck6_exit)
+module_pata_parport_driver(bpck6);
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 11ed9fb57744..47f0fbccc3aa 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -206,16 +206,5 @@ static struct pi_protocol comm = {
 	.log_adapter	= comm_log_adapter,
 };
 
-static int __init comm_init(void)
-{
-	return paride_register(&comm);
-}
-
-static void __exit comm_exit(void)
-{
-	paride_unregister(&comm);
-}
-
 MODULE_LICENSE("GPL");
-module_init(comm_init)
-module_exit(comm_exit)
+module_pata_parport_driver(comm);
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index edf414d186a6..e733a2512e17 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -218,16 +218,5 @@ static struct pi_protocol dstr = {
 	.log_adapter	= dstr_log_adapter,
 };
 
-static int __init dstr_init(void)
-{
-	return paride_register(&dstr);
-}
-
-static void __exit dstr_exit(void)
-{
-	paride_unregister(&dstr);
-}
-
 MODULE_LICENSE("GPL");
-module_init(dstr_init)
-module_exit(dstr_exit)
+module_pata_parport_driver(dstr);
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 93ee91d9338b..7583d07083a8 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -327,12 +327,12 @@ static int __init epat_init(void)
 #ifdef CONFIG_PATA_PARPORT_EPATC8
 	epatc8 = 1;
 #endif
-	return paride_register(&epat);
+	return pata_parport_register_driver(&epat);
 }
 
 static void __exit epat_exit(void)
 {
-	paride_unregister(&epat);
+	pata_parport_unregister_driver(&epat);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 417d5a3c7f72..2bcb18a6845a 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -301,16 +301,5 @@ static struct pi_protocol epia = {
 	.log_adapter	= epia_log_adapter,
 };
 
-static int __init epia_init(void)
-{
-	return paride_register(&epia);
-}
-
-static void __exit epia_exit(void)
-{
-	paride_unregister(&epia);
-}
-
 MODULE_LICENSE("GPL");
-module_init(epia_init)
-module_exit(epia_exit)
+module_pata_parport_driver(epia);
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 3c7a1069b026..c63f0cd2ea52 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -136,16 +136,5 @@ static struct pi_protocol fit2 = {
 	.log_adapter	= fit2_log_adapter,
 };
 
-static int __init fit2_init(void)
-{
-	return paride_register(&fit2);
-}
-
-static void __exit fit2_exit(void)
-{
-	paride_unregister(&fit2);
-}
-
 MODULE_LICENSE("GPL");
-module_init(fit2_init)
-module_exit(fit2_exit)
+module_pata_parport_driver(fit2);
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index cd95f4f0edc2..adbef142c88f 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -196,16 +196,5 @@ static struct pi_protocol fit3 = {
 	.log_adapter	= fit3_log_adapter,
 };
 
-static int __init fit3_init(void)
-{
-	return paride_register(&fit3);
-}
-
-static void __exit fit3_exit(void)
-{
-	paride_unregister(&fit3);
-}
-
 MODULE_LICENSE("GPL");
-module_init(fit3_init)
-module_exit(fit3_exit)
+module_pata_parport_driver(fit3);
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index da1d0cb016d6..e740fe933e20 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -261,16 +261,5 @@ static struct pi_protocol friq = {
 	.release_proto	= friq_release_proto,
 };
 
-static int __init friq_init(void)
-{
-	return paride_register(&friq);
-}
-
-static void __exit friq_exit(void)
-{
-	paride_unregister(&friq);
-}
-
 MODULE_LICENSE("GPL");
-module_init(friq_init)
-module_exit(friq_exit)
+module_pata_parport_driver(friq);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 7bc8fa16d5d8..8c8681812bed 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -298,16 +298,5 @@ static struct pi_protocol frpw = {
 	.log_adapter	= frpw_log_adapter,
 };
 
-static int __init frpw_init(void)
-{
-	return paride_register(&frpw);
-}
-
-static void __exit frpw_exit(void)
-{
-	paride_unregister(&frpw);
-}
-
 MODULE_LICENSE("GPL");
-module_init(frpw_init)
-module_exit(frpw_exit)
+module_pata_parport_driver(frpw);
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 93430ca32a52..b120597043cc 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -288,19 +288,19 @@ static int __init kbic_init(void)
 {
 	int rv;
 
-	rv = paride_register(&k951);
+	rv = pata_parport_register_driver(&k951);
 	if (rv < 0)
 		return rv;
-	rv = paride_register(&k971);
+	rv = pata_parport_register_driver(&k971);
 	if (rv < 0)
-		paride_unregister(&k951);
+		pata_parport_unregister_driver(&k951);
 	return rv;
 }
 
 static void __exit kbic_exit(void)
 {
-	paride_unregister(&k951);
-	paride_unregister(&k971);
+	pata_parport_unregister_driver(&k951);
+	pata_parport_unregister_driver(&k971);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index fc4f707fed1f..15463cd18968 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -113,16 +113,5 @@ static struct pi_protocol ktti = {
 	.log_adapter	= ktti_log_adapter,
 };
 
-static int __init ktti_init(void)
-{
-	return paride_register(&ktti);
-}
-
-static void __exit ktti_exit(void)
-{
-	paride_unregister(&ktti);
-}
-
 MODULE_LICENSE("GPL");
-module_init(ktti_init)
-module_exit(ktti_exit)
+module_pata_parport_driver(ktti);
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 995fc41e3122..f2a601e77842 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -138,16 +138,5 @@ static struct pi_protocol on20 = {
 	.log_adapter	= on20_log_adapter,
 };
 
-static int __init on20_init(void)
-{
-	return paride_register(&on20);
-}
-
-static void __exit on20_exit(void)
-{
-	paride_unregister(&on20);
-}
-
 MODULE_LICENSE("GPL");
-module_init(on20_init)
-module_exit(on20_exit)
+module_pata_parport_driver(on20);
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 35f1c481a782..66f04015f19a 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -304,16 +304,5 @@ static struct pi_protocol on26 = {
 	.log_adapter	= on26_log_adapter,
 };
 
-static int __init on26_init(void)
-{
-	return paride_register(&on26);
-}
-
-static void __exit on26_exit(void)
-{
-	paride_unregister(&on26);
-}
-
 MODULE_LICENSE("GPL");
-module_init(on26_init)
-module_exit(on26_exit)
+module_pata_parport_driver(on26);
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index 458544fe5e6c..9614ce53470a 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -87,8 +87,16 @@ struct pi_protocol {
 
 int pata_parport_register_driver(struct pi_protocol *pr);
 void pata_parport_unregister_driver(struct pi_protocol *pr);
-/* defines for old paride protocol modules */
-#define paride_register pata_parport_register_driver
-#define paride_unregister pata_parport_unregister_driver
+
+/**
+ * module_pata_parport_driver() - Helper macro for registering a pata_parport driver
+ * @__pi_protocol: pi_protocol struct
+ *
+ * Helper macro for pata_parport drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_pata_parport_driver(__pi_protocol) \
+	module_driver(__pi_protocol, pata_parport_register_driver, pata_parport_unregister_driver)
 
 #endif /* LINUX_PATA_PARPORT_H */
-- 
Ondrej Zary

