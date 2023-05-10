Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEF6FE3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjEJSSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjEJSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406B7A9D;
        Wed, 10 May 2023 11:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0366663F81;
        Wed, 10 May 2023 18:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F60C4339B;
        Wed, 10 May 2023 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742639;
        bh=UwZIwbcSgLfsaScEbsCZq/hnSjYCEy/ueiOBHUYJX6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhQTAUXKMTyOnQFt7BEN9Y2D0WN99QxH3SqWLZWZzfHfGsk3XDp4e8r63Wmoaf4La
         x2aFHC2HX7iLHEFsERqXgtBPRRlezKgbsZQRQZQOrHB9FSA+9ol9nCiwyveyQFoz18
         v3bRFf0Nx6taPwGFpCi0ZMOp0ogDYD5wufl7qPFZdKJfKbJDy2QMieXjywzo18k9nb
         imVCnaSdzav9fssB0HmPsPtASXkH32U0roh6B/uq8Wkjv/wSBkjSE0YUfWk/SzqAsj
         4rBuhwAEyoKhit2rNb1+kb+Z6/n7kxT4TzKYqDHb2pfYutJFXdFH9hpZIVHoXlewH6
         M8ai/dtpBfUzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D603DCE134D; Wed, 10 May 2023 11:17:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH locking/atomic 03/19] locking/atomic: Add kernel-doc and docbook_oldnew variables for headers
Date:   Wed, 10 May 2023 11:17:01 -0700
Message-Id: <20230510181717.2200934-3-paulmck@kernel.org>
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

The andnot, dec, inc, and try_cmpxchg files in the scripts/atomic/fallbacks
directory do not supply kernel-doc headers.  One reason for this is that
there is currently no reasonably way to document either the ordering or
whether the old or the new value is returned.

Therefore, supply docbook_order and docbook_oldnew sh variables that contain
the needed information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 scripts/atomic/gen-atomic-fallback.sh     | 17 +++++++++++++++++
 scripts/atomic/gen-atomic-instrumented.sh | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 6e853f0dad8d..697da5f16f98 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -24,6 +24,23 @@ gen_template_fallback()
 	local params="$(gen_params "${int}" "${atomic}" "$@")"
 	local args="$(gen_args "$@")"
 
+	local docbook_order=full
+	if test "${order}" = "_relaxed"
+	then
+		local docbook_order=no
+	elif test -n "${order}"
+	then
+		docbook_order="`echo $order | sed -e 's/_//'`"
+	fi
+	local docbook_oldnew="new"
+	if test "${pfx}" = "fetch_"
+	then
+		docbook_oldnew="old"
+	elif test "${sfx}" != "_return"
+	then
+		docbook_oldnew="no"
+	fi
+
 	if [ ! -z "${template}" ]; then
 		printf "#ifndef ${atomicname}\n"
 		. ${template}
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index d9ffd74f73ca..99c72393d362 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -68,6 +68,23 @@ gen_proto_order_variant()
 	local args="$(gen_args "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
+	local docbook_order=full
+	if test "${order}" = "_relaxed"
+	then
+		local docbook_order=no
+	elif test -n "${order}"
+	then
+		docbook_order="`echo $order | sed -e 's/_//'`"
+	fi
+	local docbook_oldnew="new"
+	if test "${pfx}" = "fetch_"
+	then
+		docbook_oldnew="old"
+	elif test "${sfx}" != "_return"
+	then
+		docbook_oldnew="no"
+	fi
+
 cat <<EOF
 static __always_inline ${ret}
 ${atomicname}(${params})
-- 
2.40.1

