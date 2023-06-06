Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB4723BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjFFI1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbjFFI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41690E64;
        Tue,  6 Jun 2023 01:26:26 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039981;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MBILDPZ33vrV9dcDvWtslZdP7yLwLmQ7fH/hx8xM1Q=;
        b=Kd3MXCmWc+5JRsn6IxKuUFguu0dqvfD0aRzVmQmhngKNcwV9BP8A1mbHnyEQPEavgyFazG
        xu6GEGqkxyrt/Q/1105uqNkOKTePYzKEV0EEgbz2IodBPxOndB6/3Z49Haan3MFWRDQt2R
        dytWFIc7k++JfLM9oA67cCS2xJuQSCagMGBOyEr+K2if5B25Lr2v0fdSLbMJgFzhwSKs5e
        m7ZpdQyQsf76AMe5d+4ndKQvU3riEnMQX8V5Vn0Tyj/xsDR42IwcWHqIhCBBYxuPA+S7f1
        3Z2y2FvASrmL1sI8U2F58bb5ly0gHgexdWdHTeG4JGglbUkM6o6AWJaQ8CZSRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039981;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MBILDPZ33vrV9dcDvWtslZdP7yLwLmQ7fH/hx8xM1Q=;
        b=el7RP9RyGGH3tggJdccn88ZMZQDciSNmm68p3KTPTKl2MGiMPIRZ4PRYTIWbxMpzzUUNIP
        9RVFOcmUAfP4hWBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: remove bogus order parameter
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-15-mark.rutland@arm.com>
References: <20230605070124.3741859-15-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998082.404.6497984744465631560.tip-bot2@tip-bot2>
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

Commit-ID:     a083ecc9333c62237551ad93f42e86a42a3c7cc2
Gitweb:        https://git.kernel.org/tip/a083ecc9333c62237551ad93f42e86a42a3c7cc2
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:18 +02:00

locking/atomic: scripts: remove bogus order parameter

At the start of gen_proto_order_variants(), the ${order} variable is not
yet defined, and will be substituted with an empty string.

Replace the current bogus use of ${order} with an empty string instead.

This results in no change to the generated headers.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-15-mark.rutland@arm.com
---
 scripts/atomic/gen-atomic-fallback.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index a70acd5..7a6bcea 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -81,7 +81,7 @@ gen_proto_order_variants()
 
 	local basename="arch_${atomic}_${pfx}${name}${sfx}"
 
-	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
+	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "")"
 
 	# If we don't have relaxed atomics, then we don't bother with ordering fallbacks
 	# read_acquire and set_release need to be templated, though
