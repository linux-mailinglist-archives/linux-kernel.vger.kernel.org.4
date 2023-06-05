Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1C721ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjFEHDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjFEHCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:02:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C41910E5;
        Mon,  5 Jun 2023 00:02:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E94E81596;
        Mon,  5 Jun 2023 00:02:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A40EA3F793;
        Mon,  5 Jun 2023 00:02:06 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: [PATCH v2 14/27] locking/atomic: scripts: remove bogus order parameter
Date:   Mon,  5 Jun 2023 08:01:11 +0100
Message-Id: <20230605070124.3741859-15-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605070124.3741859-1-mark.rutland@arm.com>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the start of gen_proto_order_variants(), the ${order} variable is not
yet defined, and will be substituted with an empty string.

Replace the current bogus use of ${order} with an empty string instead.

This results in no change to the generated headers.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 scripts/atomic/gen-atomic-fallback.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index a70acd548fcd8..7a6bcea8f565b 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -81,7 +81,7 @@ gen_proto_order_variants()
 
 	local basename="arch_${atomic}_${pfx}${name}${sfx}"
 
-	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
+	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "")"
 
 	# If we don't have relaxed atomics, then we don't bother with ordering fallbacks
 	# read_acquire and set_release need to be templated, though
-- 
2.30.2

