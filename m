Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC768A971
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjBDKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjBDKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB26EAF8;
        Sat,  4 Feb 2023 02:17:14 -0800 (PST)
Date:   Sat, 04 Feb 2023 10:17:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wJn3bVGYanUgnPRXGSIEsEijONrQy3w2WvDeWz6/vo=;
        b=eywHCIxFBOsPeJ9e1OsE8+x+TF3r4zi/IILrht+yYoA7DIyDwTuOPhrKryu5T2NS0VrprE
        80AjXHM0vaFdk+fEN2v1i0wV5CsyFmix8uNUkAyci26sRosOyXE9ooTVDo6fGOlZm5apxD
        b2OEIFAwOao+v1X/rJiNJcuiO2NPg8MPb0xKO8MOWaofGzvQiJsVB81fUpwmKzBXOXab+7
        bMEL2nFwGWP0oe3C9y0w4sYXs1GqRCWmhlG0333XZvYQnzAinEPxxDAC7FniiY/rt56Nwb
        PvelKdsA966EKtRt/WtkBC8MWXAs7svmgtE8afkupnM9OXNPJJMiz4CszW14og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wJn3bVGYanUgnPRXGSIEsEijONrQy3w2WvDeWz6/vo=;
        b=nKw1FQTTqbEYQhUBLBQkrRIJ8lHQCfiylxrIf3kxkw3tD+Qv4LcOUJlG5mzSw+DqdRUIo3
        tpS4b7xmPwRo+4Ag==
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
Message-ID: <167550583213.4906.16896019408675810020.tip-bot2@tip-bot2>
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

Commit-ID:     d93ee0553cf2e83c1696a18423bcf05b94b85e1d
Gitweb:        https://git.kernel.org/tip/d93ee0553cf2e83c1696a18423bcf05b94b=
85e1d
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:00:57=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 01 Feb 2023 09:15:22 -08:00

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
