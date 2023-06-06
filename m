Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F0723B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbjFFI0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbjFFI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4D196;
        Tue,  6 Jun 2023 01:26:18 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylXdZdeJh1jMS44nXMCBDkzT6yWm/qULQ8KWTKZtFiE=;
        b=tlWgPT39qY33CvE7vkuaEbjvmT1X7cbS4/E357ifiKThMsM7lL3k9697hHq3PYyqdIdo0v
        mnkHGpmQhsPQtw+qu2dUFyWjGdqZlD+gwBAGZsq0SAvO7vD66Zrax6iESqYUSfnutI3Bmi
        VzcvgKhNc8JhWzilnxLJrZuXiWXz80CRvazGrWx/+avFaItr39HhyOapdl5kjsulcGe+aw
        zV2bfOlADPLDw7eIr1gZAY8/MY/78ZEhQAvHhjshBDFN2k8ms3vsa2XTm+eDvXaUUuQV8p
        6h06ZT1KRIZRMk/Z8n9cO/+KikS6trAVkPNV0cmgoGE61ZXVqwn5BpkVlsLMjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylXdZdeJh1jMS44nXMCBDkzT6yWm/qULQ8KWTKZtFiE=;
        b=F8QcZ7p7mGvFFFzhxmnuDJNr+661cXGkyoGHyz47cB8j0+AgO3ao9KVBuVqY9KNJwSFKhB
        +tAOiIsn3GC/KxAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] docs: scripts: kernel-doc: accept bitwise
 negation like ~@var
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-25-mark.rutland@arm.com>
References: <20230605070124.3741859-25-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603997691.404.11912454815331454382.tip-bot2@tip-bot2>
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

Commit-ID:     8aaf297a0dd66d4fac215af24ece8dea091079bc
Gitweb:        https://git.kernel.org/tip/8aaf297a0dd66d4fac215af24ece8dea091079bc
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:23 +02:00

docs: scripts: kernel-doc: accept bitwise negation like ~@var

In some cases we'd like to indicate the bitwise negation of a parameter,
e.g.

  ~@var

This will be helpful for describing the atomic andnot operations, where
we'd like to write comments of the form:

  Atomically updates @v to (@v & ~@i)

Which kernel-doc currently transforms to:

  Atomically updates **v** to (**v** & ~**i**)

Rather than the preferable form:

  Atomically updates **v** to (**v** & **~i**)

This is similar to what we did for '!@var' in commit:

  ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")

This patch follows the same pattern that commit used to permit a '!'
prefix on a param ref, allowing a '~' prefix on a param ref, cuasing
kernel-doc to generate the preferred form above.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-25-mark.rutland@arm.com
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2486689..eb70c1f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -64,7 +64,7 @@ my $type_constant = '\b``([^\`]+)``\b';
 my $type_constant2 = '\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
-my $type_param_ref = '([\!]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
+my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
 my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
 my $type_env = '(\$\w+)';
