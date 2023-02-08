Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B652768F465
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjBHRYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjBHRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634424F84E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rcZCmoIUcgLAbnZrH9bmcKFtR9+VWwtjQJpHM8y0dwU=; b=ZwzycoRhBe720t52V6JFKc/80J
        TLYRBAd2Q1EQRx2k7IQPbUI/JnFkzI6XV7zjMBdByLB6VTtVH1c7PODLaP1ce3IX/YqJiNPzAb90N
        HP5WsGY45Q5ADfBGiFbanS/iqb+F7jr0/suucQu2rl4Wcrpi2dlUn39Uw7CJ+dDaCrVpM3Hxeh5zv
        fVFcc3PqO0Bc4QquCSX2jFBrnb87rVzkLoYomWyJoKG8nt9J20aBl3PPbL+QsUswItCzcpQPJR4XE
        ymKSNI0RgVkyFlOxWVWLPBwwHNIQxO7xW8AK23aFuWTa0P+I1WfWl0YKj8GpQgVzq+vvik5hySYu5
        qOLrn9ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA5-007Vvl-14;
        Wed, 08 Feb 2023 17:23:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49753300BE3;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1ABAD23D8CFB3; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.711471461@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 07/10] objtool: Fix overlapping alternatives
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things like ALTERNATIVE_{2,3}() generate multiple alternatives on the
same place, objtool would override the first orig_alt_group with the
second (or third), failing to check the CFI among all the different
variants.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   69 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 26 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1732,36 +1732,49 @@ static int handle_group_alt(struct objto
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	struct instruction *last_orig_insn, *last_new_insn = NULL, *insn, *nop = NULL;
+	struct instruction *last_new_insn = NULL, *insn, *nop = NULL;
 	struct alt_group *orig_alt_group, *new_alt_group;
 	unsigned long dest_off;
 
-
-	orig_alt_group = malloc(sizeof(*orig_alt_group));
+	orig_alt_group = orig_insn->alt_group;
 	if (!orig_alt_group) {
-		WARN("malloc failed");
-		return -1;
-	}
-	orig_alt_group->cfi = calloc(special_alt->orig_len,
-				     sizeof(struct cfi_state *));
-	if (!orig_alt_group->cfi) {
-		WARN("calloc failed");
-		return -1;
-	}
+		struct instruction *last_orig_insn = NULL;
 
-	last_orig_insn = NULL;
-	insn = orig_insn;
-	sec_for_each_insn_from(file, insn) {
-		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
-			break;
+		orig_alt_group = malloc(sizeof(*orig_alt_group));
+		if (!orig_alt_group) {
+			WARN("malloc failed");
+			return -1;
+		}
+		orig_alt_group->cfi = calloc(special_alt->orig_len,
+					     sizeof(struct cfi_state *));
+		if (!orig_alt_group->cfi) {
+			WARN("calloc failed");
+			return -1;
+		}
 
-		insn->alt_group = orig_alt_group;
-		last_orig_insn = insn;
-	}
-	orig_alt_group->orig_group = NULL;
-	orig_alt_group->first_insn = orig_insn;
-	orig_alt_group->last_insn = last_orig_insn;
+		insn = orig_insn;
+		sec_for_each_insn_from(file, insn) {
+			if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
+				break;
 
+			insn->alt_group = orig_alt_group;
+			last_orig_insn = insn;
+		}
+		orig_alt_group->orig_group = NULL;
+		orig_alt_group->first_insn = orig_insn;
+		orig_alt_group->last_insn = last_orig_insn;
+	} else {
+		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
+		    orig_alt_group->first_insn->offset != special_alt->orig_len) {
+			WARN_FUNC("weirdly overlapping alternative! %ld != %d",
+				  orig_insn->sec, orig_insn->offset,
+				  orig_alt_group->last_insn->offset +
+				  orig_alt_group->last_insn->len -
+				  orig_alt_group->first_insn->offset,
+				  special_alt->orig_len);
+			return -1;
+		}
+	}
 
 	new_alt_group = malloc(sizeof(*new_alt_group));
 	if (!new_alt_group) {
@@ -1836,7 +1849,7 @@ static int handle_group_alt(struct objto
 
 		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len) {
-			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
+			insn->jump_dest = next_insn_same_sec(file, orig_alt_group->last_insn);
 			if (!insn->jump_dest) {
 				WARN_FUNC("can't find alternative jump destination",
 					  insn->sec, insn->offset);
@@ -3214,8 +3227,12 @@ static int propagate_alt_cfi(struct objt
 		alt_cfi[group_off] = insn->cfi;
 	} else {
 		if (cficmp(alt_cfi[group_off], insn->cfi)) {
-			WARN_FUNC("stack layout conflict in alternatives",
-				  insn->sec, insn->offset);
+			struct alt_group *orig_group = insn->alt_group->orig_group ?: insn->alt_group;
+			struct instruction *orig = orig_group->first_insn;
+			char *where = offstr(insn->sec, insn->offset);
+			WARN_FUNC("stack layout conflict in alternatives: %s",
+				  orig->sec, orig->offset, where);
+			free(where);
 			return -1;
 		}
 	}


