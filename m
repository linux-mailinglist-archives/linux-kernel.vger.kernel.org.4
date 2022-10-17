Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3891C6011FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiJQO50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiJQOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F8DEC1;
        Mon, 17 Oct 2022 07:54:25 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShSQ8gRZVNhdaezyQC7crdxffyTpT7K2yg2NZMJVO8E=;
        b=Kc8/tKYf7oeY3ArWUdq0pvbQEL4JxZuyrKSXLa2CVxOX0In1/vuj4ctjMElSwNMu/O8QWK
        D5hbzf2sAGJ01NFj99FtUb4eIjJ8GevGTO8eWzI3gBJyGvipk49ul8ZZWrCj/ONWzym5Zf
        LVz1xfnEsC3Y60ZNTfpU2Fr7frBtWtl7jgNkLP06WWF0jgSgTTzpg9rEe5lYbneeW2+oWM
        wnuUWYSsd23ymgoUpa11EAf6RjR+AG6T22+PAQ63C6FLoN8PfcL/I1slZI22Du9JmFlUY8
        SLXyCDoUBUCQqKy+xz8rpbiCdFkPZyqkF8lv46wMXgJeuE+L/QrzfZ27AeAddg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ShSQ8gRZVNhdaezyQC7crdxffyTpT7K2yg2NZMJVO8E=;
        b=VPTZhGaHusXNa9skAKS8C2bYhhuDKY+QBoam70tRVH+1jXu0QINVNMAvkQQ7hZTLCubh0Q
        VoDfXEaen5AqzEBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] crypto: x86/poly1305: Remove custom function alignment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111145.073285765@infradead.org>
References: <20220915111145.073285765@infradead.org>
MIME-Version: 1.0
Message-ID: <166601845082.401.10358219257520130352.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fdc9ee7e97aa2c1dfa7ebb092fffec40ffa59108
Gitweb:        https://git.kernel.org/tip/fdc9ee7e97aa2c1dfa7ebb092fffec40ffa59108
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:03 +02:00

crypto: x86/poly1305: Remove custom function alignment

SYM_FUNC_START*() and friends already imply alignment, remove custom
alignment hacks to make code consistent. This prepares for future
function call ABI changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111145.073285765@infradead.org
---
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
index 2077ce7..b9abcd7 100644
--- a/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
+++ b/arch/x86/crypto/poly1305-x86_64-cryptogams.pl
@@ -108,7 +108,6 @@ if (!$kernel) {
 sub declare_function() {
 	my ($name, $align, $nargs) = @_;
 	if($kernel) {
-		$code .= ".align $align\n";
 		$code .= "SYM_FUNC_START($name)\n";
 		$code .= ".L$name:\n";
 	} else {
