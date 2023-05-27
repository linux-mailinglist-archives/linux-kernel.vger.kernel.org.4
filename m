Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE81713721
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjE0XIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 19:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0XIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 19:08:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70182D9;
        Sat, 27 May 2023 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=frPYJ36rxH9nF5LNMS4zMzq20zxU7jkqk42ub4ec8no=; b=Aarn348wPe7l4g7Byg3+imvVI8
        nIU+i4S3LQxr6UTldZSgUEd+v6iyAS8ETsOrXA4cjiC7JUPIK7gFN9WPln/jb1evthfKb8gtrwAqb
        zRrNSNg6ffDMtryEKZaLakB+QO3EMIQ1gefpdXHFzRT+abCAfqFVobb2VTtzJ3QkiflHEiAKbOw/m
        F36bB8h2eUN3EPMAIVUme2hXLWov6qNqQc7BUUSjl+5BA0IIrEGZlxZNnBEbrmr829jmRVh/TcAWO
        Nhl5HHcMQl8oPtZYuCuraV99Oc/fgb/LXcNZiIL//oLVrdUd4GurSWEUrHdgusU6BRHZ0evpu9kV9
        QcRKK6Nw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3316-006UZa-0v;
        Sat, 27 May 2023 23:08:08 +0000
Message-ID: <89df78d0-fb52-9045-2074-1d6f0afae4d9@infradead.org>
Date:   Sat, 27 May 2023 16:08:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: scsi/stex time_after() build warnings
To:     linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I build stex.o for i386, I see these build warnings:

In file included from ../include/linux/bitops.h:7,
                 from ../include/linux/kernel.h:22,
                 from ../drivers/scsi/stex.c:13:
../drivers/scsi/stex.c: In function ‘stex_common_handshake’:
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1035:29: note: in expansion of macro ‘time_after’
 1035 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                             ^~~~~~~~~~
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1085:21: note: in expansion of macro ‘time_after’
 1085 |                 if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                     ^~~~~~~~~~
../drivers/scsi/stex.c: In function ‘stex_ss_handshake’:
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1121:29: note: in expansion of macro ‘time_after’
 1121 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                             ^~~~~~~~~~
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1133:29: note: in expansion of macro ‘time_after’
 1133 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                             ^~~~~~~~~~
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1186:29: note: in expansion of macro ‘time_after’
 1186 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                             ^~~~~~~~~~
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1199:29: note: in expansion of macro ‘time_after’
 1199 |                         if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
      |                             ^~~~~~~~~~
../drivers/scsi/stex.c: In function ‘stex_yos_reset’:
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1355:21: note: in expansion of macro ‘time_after’
 1355 |                 if (time_after(jiffies, before + ST_INTERNAL_TIMEOUT * HZ)) {
      |                     ^~~~~~~~~~
../drivers/scsi/stex.c: In function ‘stex_hba_stop’:
../include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
   12 |         (void)(&__dummy == &__dummy2); \
      |                         ^~
../include/linux/jiffies.h:106:10: note: in expansion of macro ‘typecheck’
  106 |          typecheck(unsigned long, b) && \
      |          ^~~~~~~~~
../drivers/scsi/stex.c:1902:21: note: in expansion of macro ‘time_after’
 1902 |                 if (time_after(jiffies, before + ST_INTERNAL_TIMEOUT * HZ)) {
      |                     ^~~~~~~~~~



but I don't see this type of warning for any other SCSI drivers
and I don't see this problem for stex.o on x86_64.

Does anyone have a clue about why this happens?


If I modify each timer_after() check to use a calculated unsigned long
variable, the warnings do not happen (as in the patch below).

Thanks.
-- 
~Randy
---
 drivers/scsi/stex.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff -- a/drivers/scsi/stex.c b/drivers/scsi/stex.c
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1025,14 +1025,15 @@ static int stex_common_handshake(struct
 	struct handshake_frame *h;
 	dma_addr_t status_phys;
 	u32 data;
-	unsigned long before;
+	unsigned long before, timeout;
 
 	if (readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE) {
 		writel(MU_INBOUND_DOORBELL_HANDSHAKE, base + IDBL);
 		readl(base + IDBL);
 		before = jiffies;
 		while (readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE) {
-			if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
+			timeout = before + MU_MAX_DELAY * HZ;
+			if (time_after(jiffies, timeout)) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): no handshake signature\n",
 					pci_name(hba->pdev));
@@ -1082,7 +1083,8 @@ static int stex_common_handshake(struct
 	udelay(10);
 	before = jiffies;
 	while (readl(base + OMR0) != MU_HANDSHAKE_SIGNATURE) {
-		if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
+		timeout = before + MU_MAX_DELAY * HZ;
+		if (time_after(jiffies, timeout)) {
 			printk(KERN_ERR DRV_NAME
 				"(%s): no signature after handshake frame\n",
 				pci_name(hba->pdev));
@@ -1110,7 +1112,7 @@ static int stex_ss_handshake(struct st_h
 	struct handshake_frame *h;
 	__le32 *scratch;
 	u32 data, scratch_size, mailboxdata, operationaldata;
-	unsigned long before;
+	unsigned long before, timeout;
 	int ret = 0;
 
 	before = jiffies;
@@ -1118,7 +1120,8 @@ static int stex_ss_handshake(struct st_h
 	if (hba->cardtype == st_yel) {
 		operationaldata = readl(base + YIOA_STATUS);
 		while (operationaldata != SS_MU_OPERATIONAL) {
-			if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
+			timeout = before + MU_MAX_DELAY * HZ;
+			if (time_after(jiffies, timeout)) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): firmware not operational\n",
 					pci_name(hba->pdev));
@@ -1130,7 +1133,8 @@ static int stex_ss_handshake(struct st_h
 	} else {
 		operationaldata = readl(base + PSCRATCH3);
 		while (operationaldata != SS_MU_OPERATIONAL) {
-			if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
+			timeout = before + MU_MAX_DELAY * HZ;
+			if (time_after(jiffies, timeout)) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): firmware not operational\n",
 					pci_name(hba->pdev));
@@ -1183,7 +1187,8 @@ static int stex_ss_handshake(struct st_h
 	scratch = hba->scratch;
 	if (hba->cardtype == st_yel) {
 		while (!(le32_to_cpu(*scratch) & SS_STS_HANDSHAKE)) {
-			if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
+			timeout = before + MU_MAX_DELAY * HZ;
+			if (time_after(jiffies, timeout)) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): no signature after handshake frame\n",
 					pci_name(hba->pdev));
@@ -1196,7 +1201,8 @@ static int stex_ss_handshake(struct st_h
 	} else {
 		mailboxdata = readl(base + MAILBOX_BASE + MAILBOX_HNDSHK_STS);
 		while (mailboxdata != SS_STS_HANDSHAKE) {
-			if (time_after(jiffies, before + MU_MAX_DELAY * HZ)) {
+			timeout = before + MU_MAX_DELAY * HZ;
+			if (time_after(jiffies, timeout)) {
 				printk(KERN_ERR DRV_NAME
 					"(%s): no signature after handshake frame\n",
 					pci_name(hba->pdev));
@@ -1344,7 +1350,7 @@ static void stex_hard_reset(struct st_hb
 static int stex_yos_reset(struct st_hba *hba)
 {
 	void __iomem *base;
-	unsigned long flags, before;
+	unsigned long flags, before, timeout;
 	int ret = 0;
 
 	base = hba->mmio_base;
@@ -1352,7 +1358,8 @@ static int stex_yos_reset(struct st_hba
 	readl(base + IDBL); /* flush */
 	before = jiffies;
 	while (hba->out_req_cnt > 0) {
-		if (time_after(jiffies, before + ST_INTERNAL_TIMEOUT * HZ)) {
+		timeout = before + ST_INTERNAL_TIMEOUT * HZ;
+		if (time_after(jiffies, timeout)) {
 			printk(KERN_WARNING DRV_NAME
 				"(%s): reset timeout\n", pci_name(hba->pdev));
 			ret = -1;
@@ -1852,7 +1859,7 @@ static void stex_hba_stop(struct st_hba
 	struct req_msg *req;
 	struct st_msg_header *msg_h;
 	unsigned long flags;
-	unsigned long before;
+	unsigned long before, timeout;
 	u16 tag = 0;
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -1899,7 +1906,8 @@ static void stex_hba_stop(struct st_hba
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	before = jiffies;
 	while (hba->ccb[tag].req_type & PASSTHRU_REQ_TYPE) {
-		if (time_after(jiffies, before + ST_INTERNAL_TIMEOUT * HZ)) {
+		timeout = before + ST_INTERNAL_TIMEOUT * HZ;
+		if (time_after(jiffies, timeout)) {
 			hba->ccb[tag].req_type = 0;
 			hba->mu_status = MU_STATE_STOP;
 			return;

