Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6F660E1F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjAGKxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjAGKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:53:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E725A1AA35;
        Sat,  7 Jan 2023 02:53:13 -0800 (PST)
Date:   Sat, 07 Jan 2023 10:53:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673088792;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IG2g6yfdzj3v6AzxV31vJmclu07XKAtOZiLHWzNUv8=;
        b=uYKFVjejgctGX8iRO6cdRK3X3cDeq1VvUhjHH+1FcARi/B+hZRgeOby4W/OkDsQP4Q2dpf
        XIWcKxgZRT7JqLUMJyyovetjYCQS36k1TtaHOz+NhumulSBe4AVmMBP1vuO8w0DuRoT2CM
        Uo1lecLjxjDvNDvQmZ3fYsupfFdbTPgQkRnilIDRD/Pv3r2yyUaeHuC6IkwgHci+oOsJ3R
        iQB36L+IcscXz0ZOhONZWTvULedSVZ/0SLs0CGDdP8OfkysVB9RivAJQIftgfrUgK97OK3
        S+/eyip5GTPQCdslk8oErHRwWMbbDcQ1zeCZxqNoqc4WCtg5cUv4cAWSqJaiuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673088792;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IG2g6yfdzj3v6AzxV31vJmclu07XKAtOZiLHWzNUv8=;
        b=gh9PitinoVHwIX58N3Wlk/tFUxlI7cvCJ4z193dSgONJ8UbORYQQHp/q4fe8Oi7sH3O6aD
        qz5NUNEM1WWLYmCQ==
From:   "tip-bot2 for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix memory leak in create_static_call_sections()
Cc:     Miaoqian Lin <linmq006@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221205080642.558583-1-linmq006@gmail.com>
References: <20221205080642.558583-1-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <167308879222.4906.1093835434113126695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3da73f102309fe29150e5c35acd20dd82063ff67
Gitweb:        https://git.kernel.org/tip/3da73f102309fe29150e5c35acd20dd82063ff67
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Mon, 05 Dec 2022 12:06:42 +04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 11:45:24 +01:00

objtool: Fix memory leak in create_static_call_sections()

strdup() allocates memory for key_name. We need to release the memory in
the following error paths. Add free() to avoid memory leak.

Fixes: 1e7e47883830 ("x86/static_call: Add inline static call implementation for x86-64")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221205080642.558583-1-linmq006@gmail.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4350be7..cab1a16 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -679,6 +679,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
 			    STATIC_CALL_TRAMP_PREFIX_LEN)) {
 			WARN("static_call: trampoline name malformed: %s", key_name);
+			free(key_name);
 			return -1;
 		}
 		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
@@ -688,6 +689,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (!key_sym) {
 			if (!opts.module) {
 				WARN("static_call: can't find static_call_key symbol: %s", tmp);
+				free(key_name);
 				return -1;
 			}
 
