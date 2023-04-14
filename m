Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B922C6E2624
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDNOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDNOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F364D2683;
        Fri, 14 Apr 2023 07:47:59 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG7mVoFKYJwmwqxRMylTOAMatqSty9eoz3docMXo/MU=;
        b=KhHOg4Np0RzmeZheBAzN25mby3+J0Tj+KPi7oPBIeUn0caSJISkWVVGl/RIog75l9uhmEv
        3MJ1uDg2PNMr35GqEznpk9ctqsLDfeFGuM6dayzyvtC/5DAd443AC5oD/5vMGHvg0aKcs0
        0mSZ/WIUqWU3I/H//F4x3jLM3ccBMExa5jvefbCgcMhSCfIg91CiN0I3xpcqcg3vgCsLRF
        yCE4WjYHU9OqX7Xo0iz3eeWzXu6xQqDiNcto8NOwH3ObolXjbw4paMn2UFuvq7YIz8Dut/
        +1i0kpPozq4nU3oOxYx6CoqBKSqAKRLobFUQAo4nysJounfbPx3+ZtkDscvfvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG7mVoFKYJwmwqxRMylTOAMatqSty9eoz3docMXo/MU=;
        b=9CQhggiHaAR+7kCI/kv9YcxO6XIuHqjZ1wfqyIiS/IoNPRFsPqRhx6XEZ/ck9aSZqQxbew
        Icj8CNZXV252UnCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/objdump-func: Support multiple functions
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0bf5f4f5978660985037b24c6db49b114374eb4d.1681325924.git.jpoimboe@kernel.org>
References: <0bf5f4f5978660985037b24c6db49b114374eb4d.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367595.404.1640232172140364396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     27d000d635ce48b579988e9b3240352a2a0306e0
Gitweb:        https://git.kernel.org/tip/27d000d635ce48b579988e9b3240352a2a0306e0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 12:03:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:28 +02:00

scripts/objdump-func: Support multiple functions

Allow specifying multiple functions on the cmdline.  Note this removes
the secret EXTRA_ARGS feature.

While at it, spread out the awk to make it more readable.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/0bf5f4f5978660985037b24c6db49b114374eb4d.1681325924.git.jpoimboe@kernel.org
---
 scripts/objdump-func | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/scripts/objdump-func b/scripts/objdump-func
index 4eb463d..7b15b87 100755
--- a/scripts/objdump-func
+++ b/scripts/objdump-func
@@ -3,7 +3,7 @@
 #
 # Disassemble a single function.
 #
-# usage: objdump-func <file> <func>
+# usage: objdump-func <file> <func> [<func> ...]
 
 set -o errexit
 set -o nounset
@@ -13,17 +13,33 @@ OBJDUMP="${CROSS_COMPILE:-}objdump"
 command -v gawk >/dev/null 2>&1 || die "gawk isn't installed"
 
 usage() {
-	echo "usage: objdump-func <file> <func>" >&2
+	echo "usage: objdump-func <file> <func> [<func> ...]" >&2
 	exit 1
 }
 
 [[ $# -lt 2 ]] && usage
 
 OBJ=$1; shift
-FUNC=$1; shift
-
-# Secret feature to allow adding extra objdump args at the end
-EXTRA_ARGS=$@
-
-# Note this also matches compiler-added suffixes like ".cold", etc
-${OBJDUMP} -wdr $EXTRA_ARGS $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f "(\\..*)?>:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'
+FUNCS=("$@")
+
+${OBJDUMP} -wdr $OBJ | gawk -M -v _funcs="${FUNCS[*]}" '
+	BEGIN { split(_funcs, funcs); }
+	/^$/ { func_match=0; }
+	/<.*>:/ {
+		f = gensub(/.*<(.*)>:/, "\\1", 1);
+		for (i in funcs) {
+			# match compiler-added suffixes like ".cold", etc
+			if (f ~ "^" funcs[i] "(\\..*)?") {
+				func_match = 1;
+				base = strtonum("0x" $1);
+				break;
+			}
+		}
+	}
+	{
+		if (func_match) {
+			addr = strtonum("0x" $1);
+			printf("%04x ", addr - base);
+			print;
+		}
+	}'
