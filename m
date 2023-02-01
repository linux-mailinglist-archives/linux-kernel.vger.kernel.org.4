Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC797686B96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBAQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:26:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85E7921F;
        Wed,  1 Feb 2023 08:26:36 -0800 (PST)
Date:   Wed, 01 Feb 2023 16:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675268794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0Ifn1PH0wmWMUpzh2RXtGoObIymq9QWY0W9OAfa5nA=;
        b=38+Jnfa8VdLBhdcRE30W92onKblbsCKk1Iwi6mDrX5qtHap9BjqN546g1CWhKlYZ2/CksW
        PRRTrH5kh7EStZ+AgqMNZwLB5UUFzlz2c7Wnjlmm9rR18Pmv7A4CJ++SkbkR9YJlK84gYO
        JuaBua8sBNH+gbPrHzN3KRJw5CjET/kzest6YdZ+RYBBmecWN+HbJEHrlYZPdWeq/966KQ
        F9Q6ZoGY6wI1hctmDblxaAHDLGBx2ZJPFuJqZ9aEBbTSwghwjssQzXnLOisYOvqfkXtZxC
        sle3B+tp4Lt1Q+ft5ccLrEXitP0IERPVNH0X7FbpM12luwTZBtWZoX922PfVuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675268794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0Ifn1PH0wmWMUpzh2RXtGoObIymq9QWY0W9OAfa5nA=;
        b=iyAgTCNQVBeoy86prrfrY1h1hy3rKHgaXpCHTB1xVV5ps2ZnG0wpYZlB99744HWFMcNQ6e
        WC25G7j6naFKsCCA==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make struct entries[] static and const
Cc:     linux@weissschuh.net, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-objtool-memory-v2-1-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-1-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167526879446.4906.10494468720128495738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4bf285955dcac1810c5677bf69f5ae7a2e9be1cf
Gitweb:        https://git.kernel.org/tip/4bf285955dcac1810c5677bf69f5ae7a2e9=
be1cf
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:00:57=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 30 Jan 2023 16:28:18 -08:00

objtool: Make struct entries[] static and const

This data is not modified and not used outside of special.c.

Also adapt its users to the constness.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20221216-objtool-memory-v2-1-17968f85a464@wei=
ssschuh.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/special.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 9c8d827..baa85c3 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -26,7 +26,7 @@ struct special_entry {
 	unsigned char key; /* jump_label key */
 };
=20
-struct special_entry entries[] =3D {
+static const struct special_entry entries[] =3D {
 	{
 		.sec =3D ".altinstructions",
 		.group =3D true,
@@ -65,7 +65,7 @@ static void reloc_to_sec_off(struct reloc *reloc, struct se=
ction **sec,
 	*off =3D reloc->sym->offset + reloc->addend;
 }
=20
-static int get_alt_entry(struct elf *elf, struct special_entry *entry,
+static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
 {
@@ -139,7 +139,7 @@ static int get_alt_entry(struct elf *elf, struct special_=
entry *entry,
  */
 int special_get_alts(struct elf *elf, struct list_head *alts)
 {
-	struct special_entry *entry;
+	const struct special_entry *entry;
 	struct section *sec;
 	unsigned int nr_entries;
 	struct special_alt *alt;
