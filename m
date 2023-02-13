Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767356943E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBMLKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBMLKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB5EC5B;
        Mon, 13 Feb 2023 03:10:31 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:10:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676286628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOC0a4gy2ApTzddPrjSS4SZiss1DvZODmo8oPZZk5lY=;
        b=j5xXLzEW9kyStfVvpjdy8+7zUVVolEbfCBUmsuhRPzY3MkMX9HGAbf7Ve1zqE2VUqvuEiB
        dGxocwJieRjGGTeCKPJyQ3+QtmdKnxxg54YfA8pZu81cYERkcQJsqtgCAXs518uMHm+U4F
        mmegKnlfBgfMZx5hd3ol2X78M7CN+vtZDdbZtA1B8NCRuLDmcmwOQqNY60iRNYbV7LSeGF
        Qu6Mtn0RrVuWLmTSlFwGp3K8oACt3wublerEb5F28HBStk9wzkkXXrUDcr8TTE0Ns1mfHS
        fGFd+3k4O7G43V/MC1uMvcT44EIx1aeJvYtQJoHvvxWThUqR15Skna3XElQDcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676286628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOC0a4gy2ApTzddPrjSS4SZiss1DvZODmo8oPZZk5lY=;
        b=qa49NxNKB4eF2K16abgm3uedoYNQ484YY7PR9jPClfrHz/1rsUulNmq2lV1yEgA74MjCvY
        n4cUz00nw5kD8EBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix overlapping alternatives
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.711471461@infradead.org>
References: <20230208172245.711471461@infradead.org>
MIME-Version: 1.0
Message-ID: <167628662854.4906.18315456608077226990.tip-bot2@tip-bot2>
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

Commit-ID:     339b90b37d80ff2f4064bf072584031f3b1b5838
Gitweb:        https://git.kernel.org/tip/339b90b37d80ff2f4064bf072584031f3b1=
b5838
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:18:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Feb 2023 11:26:08 +01:00

objtool: Fix overlapping alternatives

Things like ALTERNATIVE_{2,3}() generate multiple alternatives on the
same place, objtool would override the first orig_alt_group with the
second (or third), failing to check the CFI among all the different
variants.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.711471461@infradead.org
---
 tools/objtool/check.c | 69 ++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6f0adb2..7e9d3d3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1744,36 +1744,49 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	struct instruction *last_orig_insn, *last_new_insn =3D NULL, *insn, *nop =
=3D NULL;
+	struct instruction *last_new_insn =3D NULL, *insn, *nop =3D NULL;
 	struct alt_group *orig_alt_group, *new_alt_group;
 	unsigned long dest_off;
=20
-
-	orig_alt_group =3D malloc(sizeof(*orig_alt_group));
+	orig_alt_group =3D orig_insn->alt_group;
 	if (!orig_alt_group) {
-		WARN("malloc failed");
-		return -1;
-	}
-	orig_alt_group->cfi =3D calloc(special_alt->orig_len,
-				     sizeof(struct cfi_state *));
-	if (!orig_alt_group->cfi) {
-		WARN("calloc failed");
-		return -1;
-	}
+		struct instruction *last_orig_insn =3D NULL;
=20
-	last_orig_insn =3D NULL;
-	insn =3D orig_insn;
-	sec_for_each_insn_from(file, insn) {
-		if (insn->offset >=3D special_alt->orig_off + special_alt->orig_len)
-			break;
+		orig_alt_group =3D malloc(sizeof(*orig_alt_group));
+		if (!orig_alt_group) {
+			WARN("malloc failed");
+			return -1;
+		}
+		orig_alt_group->cfi =3D calloc(special_alt->orig_len,
+					     sizeof(struct cfi_state *));
+		if (!orig_alt_group->cfi) {
+			WARN("calloc failed");
+			return -1;
+		}
=20
-		insn->alt_group =3D orig_alt_group;
-		last_orig_insn =3D insn;
-	}
-	orig_alt_group->orig_group =3D NULL;
-	orig_alt_group->first_insn =3D orig_insn;
-	orig_alt_group->last_insn =3D last_orig_insn;
+		insn =3D orig_insn;
+		sec_for_each_insn_from(file, insn) {
+			if (insn->offset >=3D special_alt->orig_off + special_alt->orig_len)
+				break;
=20
+			insn->alt_group =3D orig_alt_group;
+			last_orig_insn =3D insn;
+		}
+		orig_alt_group->orig_group =3D NULL;
+		orig_alt_group->first_insn =3D orig_insn;
+		orig_alt_group->last_insn =3D last_orig_insn;
+	} else {
+		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
+		    orig_alt_group->first_insn->offset !=3D special_alt->orig_len) {
+			WARN_FUNC("weirdly overlapping alternative! %ld !=3D %d",
+				  orig_insn->sec, orig_insn->offset,
+				  orig_alt_group->last_insn->offset +
+				  orig_alt_group->last_insn->len -
+				  orig_alt_group->first_insn->offset,
+				  special_alt->orig_len);
+			return -1;
+		}
+	}
=20
 	new_alt_group =3D malloc(sizeof(*new_alt_group));
 	if (!new_alt_group) {
@@ -1848,7 +1861,7 @@ static int handle_group_alt(struct objtool_file *file,
=20
 		dest_off =3D arch_jump_destination(insn);
 		if (dest_off =3D=3D special_alt->new_off + special_alt->new_len) {
-			insn->jump_dest =3D next_insn_same_sec(file, last_orig_insn);
+			insn->jump_dest =3D next_insn_same_sec(file, orig_alt_group->last_insn);
 			if (!insn->jump_dest) {
 				WARN_FUNC("can't find alternative jump destination",
 					  insn->sec, insn->offset);
@@ -3226,8 +3239,12 @@ static int propagate_alt_cfi(struct objtool_file *file=
, struct instruction *insn
 		alt_cfi[group_off] =3D insn->cfi;
 	} else {
 		if (cficmp(alt_cfi[group_off], insn->cfi)) {
-			WARN_FUNC("stack layout conflict in alternatives",
-				  insn->sec, insn->offset);
+			struct alt_group *orig_group =3D insn->alt_group->orig_group ?: insn->alt=
_group;
+			struct instruction *orig =3D orig_group->first_insn;
+			char *where =3D offstr(insn->sec, insn->offset);
+			WARN_FUNC("stack layout conflict in alternatives: %s",
+				  orig->sec, orig->offset, where);
+			free(where);
 			return -1;
 		}
 	}
