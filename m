Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE63E6DFE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDLTDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDLTDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B39E6F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A49C634D3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC60C4339B;
        Wed, 12 Apr 2023 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326225;
        bh=dAkEqTLkgIq2vIL65t1W7EqLc3ca55ao4IifwBU07ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIDRrUvhwOjhD0Wf0t/If1fqIzu3GuH1BxHN/oPfMgfHOhaeEUq7vZAcPQK1QyZqB
         OrA7U4S1khWVVCxKFyPXum7dSlqvnBhgUbUamtMej0cYdEnnSUTfdt4zceP+STw3oR
         CmAiZzEhtdCBi+QELrZ8SItETeZ71Q1EZu5vYjHt9XX8TpemPjQxcIDEcGo+0Ogzj6
         0lgL//aRZYDjH1zHS/femqKSKM2wUCA1ntPKMhJLmWtkykHOaRqgXGI0C7WUrLIGdh
         Iox4rongGMbsUdoN+3QKewQQVHPdI5fNdhIu3XqSVv3f6ofLGLO8zXSG8HiJOGoynm
         xwnYqwGgC20Zg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 1/9] scripts/objdump-func: Support multiple functions
Date:   Wed, 12 Apr 2023 12:03:16 -0700
Message-Id: <0bf5f4f5978660985037b24c6db49b114374eb4d.1681325924.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681325924.git.jpoimboe@kernel.org>
References: <cover.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow specifying multiple functions on the cmdline.  Note this removes
the secret EXTRA_ARGS feature.

While at it, spread out the awk to make it more readable.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/objdump-func | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/scripts/objdump-func b/scripts/objdump-func
index 4eb463dd9f52..7b15b873d0e2 100755
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
-- 
2.39.2

