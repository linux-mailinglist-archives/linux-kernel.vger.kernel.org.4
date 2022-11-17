Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B662E582
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbiKQTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbiKQTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:55:02 -0500
Received: from mailout-pe-b.jellyfish.systems (mailout-pe-b.jellyfish.systems [198.54.127.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5CD1836A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:54:56 -0800 (PST)
Received: from output-router-58994b6955-tvtjg (unknown [10.35.5.64])
        by mailout-pe-b.jellyfish.systems (Postfix) with ESMTPA id 4NCrGz3JPlzFqTJ;
        Thu, 17 Nov 2022 19:54:51 +0000 (UTC)
Received: from MTA-05.privateemail.com (unknown [10.50.14.15])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id 5BDF318000CF;
        Thu, 17 Nov 2022 14:54:51 -0500 (EST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 3ABDD18000A5;
        Thu, 17 Nov 2022 14:54:51 -0500 (EST)
Received: from bpappas-XPS-13-9310.wppl.org (unknown [131.226.25.151])
        by mta-05.privateemail.com (Postfix) with ESMTPA id 6967518000A6;
        Thu, 17 Nov 2022 14:54:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1668714891;
        bh=+5+iPAU4icdKGKy6PTarUF+CqZfqw/ulQHjgcef+9hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUjdSDkMQxAWPFzl2bOR53hb+MzCOsHtZDhMtXYq7wKutSvOBE86kBXSv1f+3Ecg6
         2V6+vSHXLJQ8ANJYP1nTaWWkQnzHLRuKNwQe5Y+bn7pcYoUSOJbYrT0UGovDUSXp+1
         VzyLydq4CXNm0BTUv2wHknkfd9qSxR9lH622V+gsJiuVrIIEmj4NT47Q3PzjUcVtkW
         OyInaSPYDVCFZ5RY6OZpxYDaYMTEWL1IQEcXaw5BxsH+/lGeCi9FHueuz+A9syNJBI
         Ej4FvJj+snuctYdaUVGvuPJpOvLnSZKkpd6hs2Gb9+0z92Ef4Hg7H0HddqcrTwfHEl
         A2q6ZplujiXrw==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     gregkh@linuxfoundation.org
Cc:     bpappas@pappasbrent.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/1 v2] staging: gdm724x: Replace macro GDM_TTY_READY with static inline function
Date:   Thu, 17 Nov 2022 14:54:43 -0500
Message-Id: <20221117195443.19616-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y3aCV4rSrfrptA0q@kroah.com>
References: <Y3aCV4rSrfrptA0q@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the macro GDM_TTY_READY with a static inline function
to follow the Linux kernel coding style.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
Changelog:
V1 -> V2: Change gdm_tty_ready return type from int to bool.

 drivers/staging/gdm724x/gdm_tty.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index cc6d80554c98..e1a84d6020f4 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -21,7 +21,10 @@
 
 #define MUX_TX_MAX_SIZE 2048
 
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
+static inline bool gdm_tty_ready(struct gdm *gdm)
+{
+	return gdm && gdm->tty_dev && gdm->port.count;
+}
 
 static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
@@ -113,7 +116,7 @@ static int gdm_tty_recv_complete(void *data,
 {
 	struct gdm *gdm = tty_dev->gdm[index];
 
-	if (!GDM_TTY_READY(gdm)) {
+	if (!gdm_tty_ready(gdm)) {
 		if (complete == RECV_PACKET_PROCESS_COMPLETE)
 			gdm->tty_dev->recv_func(gdm->tty_dev->priv_dev,
 						gdm_tty_recv_complete);
@@ -140,7 +143,7 @@ static void gdm_tty_send_complete(void *arg)
 {
 	struct gdm *gdm = arg;
 
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return;
 
 	tty_port_tty_wakeup(&gdm->port);
@@ -154,7 +157,7 @@ static int gdm_tty_write(struct tty_struct *tty, const unsigned char *buf,
 	int sent_len = 0;
 	int sending_len = 0;
 
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return -ENODEV;
 
 	if (!len)
@@ -181,7 +184,7 @@ static unsigned int gdm_tty_write_room(struct tty_struct *tty)
 {
 	struct gdm *gdm = tty->driver_data;
 
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return 0;
 
 	return WRITE_SIZE;
-- 
2.34.1

