Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757BA723B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbjFFI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbjFFI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84911B;
        Tue,  6 Jun 2023 01:26:24 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PyOlr5Do4Dx8uHOUcpfYxKS6KFM6Nby3w1ggOE4npI=;
        b=H4oFB0ubdAxLJRHxT+jU5UgRZYb3T+tAoH2Uhra3ifv/dNulcoyot8ELuNbOTv9e6yA5U/
        DD3GAd2iel0U2gnz8sm7LmVUpFe7/z+Yjj8BkMeA0qBCKImQijEBCp9jzGeZNxqx/SL1L4
        h8GxVN5VuK8mUJ+TT2MaakrSGoSdlnk1Ht5bgc8xAXNv+gdoMlK/V93Ml4dpNKu99OFAcL
        ylZ7xIe0BAPqo13Iv9ijksItUOwG3ZzPnNmPXyKuv5Prq6UBCn108dSitN6zy6fOkiUFXn
        m9z+OxV7LcpcXq5rfqbnYHFQOKau+8GbDLeY8anOu8Sk1R1pLSYTZA9grAQEkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PyOlr5Do4Dx8uHOUcpfYxKS6KFM6Nby3w1ggOE4npI=;
        b=TGpJf6tQrFUPHSzNyZ5M4ctTUOzjXDYJ60Bpnl/PGfDHkCXUXX2ROYauu20tvMn1scQU6p
        HpHVivJA3M7yZvDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: factor out order
 template generation
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-17-mark.rutland@arm.com>
References: <20230605070124.3741859-17-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603997998.404.2438990856808509661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7ed7a1564090fdd265f49d1ad94ee92845b14c76
Gitweb:        https://git.kernel.org/tip/7ed7a1564090fdd265f49d1ad94ee92845b14c76
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:19 +02:00

locking/atomic: scripts: factor out order template generation

Currently gen_proto_order_variants() hard codes the path for the templates used
for order fallbacks. Factor this out into a helper so that it can be reused
elsewhere.

This results in no change to the generated headers, so there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-17-mark.rutland@arm.com
---
 scripts/atomic/gen-atomic-fallback.sh | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 7a6bcea..3373308 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -32,6 +32,20 @@ gen_template_fallback()
 	fi
 }
 
+#gen_order_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
+gen_order_fallback()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+
+	local tmpl_order=${order#_}
+	local tmpl="${ATOMICDIR}/fallbacks/${tmpl_order:-fence}"
+	gen_template_fallback "${tmpl}" "${meta}" "${pfx}" "${name}" "${sfx}" "${order}" "$@"
+}
+
 #gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
 gen_proto_fallback()
 {
@@ -56,20 +70,6 @@ cat << EOF
 EOF
 }
 
-gen_proto_order_variant()
-{
-	local meta="$1"; shift
-	local pfx="$1"; shift
-	local name="$1"; shift
-	local sfx="$1"; shift
-	local order="$1"; shift
-	local atomic="$1"
-
-	local basename="arch_${atomic}_${pfx}${name}${sfx}"
-
-	printf "#define ${basename}${order} ${basename}${order}\n"
-}
-
 #gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
 gen_proto_order_variants()
 {
@@ -117,9 +117,9 @@ gen_proto_order_variants()
 
 	printf "#else /* ${basename}_relaxed */\n\n"
 
-	gen_template_fallback "${ATOMICDIR}/fallbacks/acquire"  "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
-	gen_template_fallback "${ATOMICDIR}/fallbacks/release"  "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-	gen_template_fallback "${ATOMICDIR}/fallbacks/fence"  "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
+	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
+	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
+	gen_order_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 
 	printf "#endif /* ${basename}_relaxed */\n\n"
 }
