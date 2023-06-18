Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B97345AA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 11:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFRJMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 05:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 05:12:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA41713D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 02:12:02 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AoRzqEE3BtieiAoRzq4eJ0; Sun, 18 Jun 2023 11:12:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687079520;
        bh=IPe57G4mt7sHUeZs/pUABOMlmfqc6SVR+qf56bLRvks=;
        h=From:To:Cc:Subject:Date;
        b=Kpb5qhNZDIssWIDn68TTP4Tmt80DSlHclMOIWdpIZT0pC5FFVX6Pechv3YIV1uw0w
         Q1yDvEg+KRz8A+1nEt12JP/wpzuDUSRP3xi6QPlZ/rAb/mB73LtXl/an1jth/hp+bK
         BNeB+VRtpkh+ZINb4gBTqCJ8VloBctPbKr45LxEOzjJ4ZcQ/m846Z4AECFudUqhGTt
         X6gcGASdqUsEnuy1REdF1y0e9uy4egbd4uTK1ry64wI6zAqVa/5ZHVpcxpknQZemBL
         OOus/XviwJyt4tacQ3DHR8A3kTp2LDumWhyetTKaquNND/xW1DX4tb12j+peK7EFTr
         vaDLe62D6yUng==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Jun 2023 11:12:00 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: Reorder fields in 'struct hid_input'
Date:   Sun, 18 Jun 2023 11:11:58 +0200
Message-Id: <9accb4ebd1247e2f2acc77dd053f67e60bf8d283.1687079502.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct hid_input'
from 72 to 64 bytes.

It saves a few bytes of memory and is more cache-line friendly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct hid_input {
	struct list_head           list;                 /*     0    16 */
	struct hid_report *        report;               /*    16     8 */
	struct input_dev *         input;                /*    24     8 */
	const char  *              name;                 /*    32     8 */
	bool                       registered;           /*    40     1 */

	/* XXX 7 bytes hole, try to pack */

	struct list_head           reports;              /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               application;          /*    64     4 */

	/* size: 72, cachelines: 2, members: 7 */
	/* sum members: 61, holes: 1, sum holes: 7 */
	/* padding: 4 */
	/* last cacheline: 8 bytes */
};


After:
=====
struct hid_input {
	struct list_head           list;                 /*     0    16 */
	struct hid_report *        report;               /*    16     8 */
	struct input_dev *         input;                /*    24     8 */
	const char  *              name;                 /*    32     8 */
	struct list_head           reports;              /*    40    16 */
	unsigned int               application;          /*    56     4 */
	bool                       registered;           /*    60     1 */

	/* size: 64, cachelines: 1, members: 7 */
	/* padding: 3 */
};
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5be5e671c263..d29c5de96a40 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -555,9 +555,9 @@ struct hid_input {
 	struct hid_report *report;
 	struct input_dev *input;
 	const char *name;
-	bool registered;
 	struct list_head reports;	/* the list of reports */
 	unsigned int application;	/* application usage for this input */
+	bool registered;
 };
 
 enum hid_type {
-- 
2.34.1

