Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6816FE3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjEJSS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjEJSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99847ABB;
        Wed, 10 May 2023 11:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBD563F7E;
        Wed, 10 May 2023 18:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB2BC4339B;
        Wed, 10 May 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742644;
        bh=M24YCjX89zrGo9hYrVbnM541YXT/QdSaa04NmGeV1Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwNrKLQiM4yEdY6dWQJDqXWcesIHahzZBEqAGGtQ447tYWiSNEApxDQwXUOjpEp6R
         J+wReUPEoXom8oYdwM6CqS1S2LdicSusW+2/fo373mB/XtrVjEnPSdLSbEDbfgHsbj
         GJMYhpQEDHxblTH31IUYtifLIMO/tsxJmH4Xjz5I+NvuMKDpu4iY6C7rOJQyR+vzvF
         dQbx0460xkB/3k7AvmWYCbbkBmUX4GyXue1UKOgK2xQyEdaKbNtUi6s9x6D2kWk8mE
         EBsBIyMdV+b//2hbywVmq7VxMgxiQvkqiQTTa+VYdP/OtkpzHMmD2JVy1UNjQT7z6C
         Qru4NcBSFkTWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EFA9CCE1F4C; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 13/19] locking/atomic: Script to auto-generate acquire, fence, and release headers
Date:   Wed, 10 May 2023 11:17:11 -0700
Message-Id: <20230510181717.2200934-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scripts/atomic/fallbacks/{acquire,fence,release} scripts require almost
identical scripting to automatically generated the required kernel-doci
headers.  Therefore, provide a single acqrel.sh script that does this
work.  This new script is to be invoked from each of those scripts using
the "." command, and with the shell variable "acqrel" set to either
"acquire", "full", or "release".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 scripts/atomic/acqrel.sh | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 scripts/atomic/acqrel.sh

diff --git a/scripts/atomic/acqrel.sh b/scripts/atomic/acqrel.sh
new file mode 100644
index 000000000000..5009a54fdac5
--- /dev/null
+++ b/scripts/atomic/acqrel.sh
@@ -0,0 +1,67 @@
+echo ${args} | tr -d ' ' | tr ',' '\012' |
+	awk -v atomic=${atomic} \
+	    -v name_op=${name} \
+	    -v ret=${ret} \
+	    -v oldnew=${docbook_oldnew} \
+	    -v acqrel=${acqrel} \
+	    -v basefuncname=arch_${atomic}_${pfx}${name}${sfx} '
+	BEGIN {
+		print "/**";
+		sfxord = "_" acqrel;
+		if (acqrel == "full")
+			sfxord = "";
+		print " * " basefuncname sfxord " - Atomic " name_op " with " acqrel " ordering";
+		longname["add"] = "add";
+		longname["sub"] = "subtract";
+		longname["inc"] = "increment";
+		longname["dec"] = "decrement";
+		longname["and"] = "AND";
+		longname["andnot"] = "complement then AND";
+		longname["or"] = "OR";
+		longname["xor"] = "XOR";
+		longname["xchg"] = "exchange";
+		longname["add_negative"] = "add";
+		desc["i"] = "value to " longname[name_op];
+		desc["v"] = "pointer of type " atomic "_t";
+		desc["old"] = "desired old value to match";
+		desc["new"] = "new value to put in";
+		opmod = "with";
+		if (name_op == "add")
+			opmod = "to";
+		else if (name_op == "sub")
+			opmod = "from";
+	}
+
+	{
+		print " * @" $1 ": " desc[$1];
+		have[$1] = 1;
+	}
+
+	END {
+		print " *";
+		if (name_op ~ /cmpxchg/) {
+			print " * Atomically compares @new to *@v, and if equal,";
+			print " * stores @new to *@v, providing " acqrel " ordering.";
+		} else if (have["i"]) {
+			print " * Atomically " longname[name_op] " @i " opmod " @v using " acqrel " ordering.";
+		} else {
+			print " * Atomically " longname[name_op] " @v using " acqrel " ordering.";
+		}
+		if (name_op ~ /cmpxchg/ && ret == "bool") {
+			print " * Returns @true if the cmpxchg operation succeeded,";
+			print " * and false otherwise.  Either way, stores the old";
+			print " * value of *@v to *@old.";
+		} else if (name_op == "cmpxchg") {
+			print " * Returns the old value *@v regardless of the result of";
+			print " * the comparison.  Therefore, if the return value is not";
+			print " * equal to @old, the cmpxchg operation failed.";
+		} else if (name_op == "xchg") {
+			print " * Return old value.";
+		} else if (name_op == "add_negative") {
+			print " * Return @true if the result is negative, or @false when"
+			print " * the result is greater than or equal to zero.";
+		} else {
+			print " * Return " oldnew " value.";
+		}
+		print " */";
+	}'
-- 
2.40.1

