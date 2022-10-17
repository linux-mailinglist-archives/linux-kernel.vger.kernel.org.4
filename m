Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE836011EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiJQO5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiJQOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:55:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340F6888A;
        Mon, 17 Oct 2022 07:53:57 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDfYSiVQDjxsoQYaFKeEMiHBqsdJctTtIyt8Fcc40j8=;
        b=FF++7pgKcBL+5RLGXunOcE/WEeAUn8oZoGz5jAp7FfE5YlAJSmjOODu5DcPuJQHh8hg2Yy
        uqjCihnd2vaRUvwCaoe77IJNfIQHQ8/Kzz5SUjmVr5naE8syZ7RCvc8qkqMzD2BdYvzirM
        kaOPRB36tXCOsQk8pdYon7e7Yu5oT9oja8wLhEjq+S31NlzKjFqEJcgEmghkmvZ6PIlC+O
        VPnNSz1DHmGdIqwlt7br+z3cdKOXevIYJIOmWHhNCD4JhssOE98ZhQyJAjBCIKqVPB6RY0
        aYI5mMwWCqyiclW3t7lXjrbncArsN6e6ZXj5iA4C+FTmJclpB59IF4DdSLBWZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDfYSiVQDjxsoQYaFKeEMiHBqsdJctTtIyt8Fcc40j8=;
        b=/FohbC3uLP/8JeUEjyCCPjmoZ2vOZoA5gYWAXdcuYr5Xh5LjQtA8EGG8vgWoPk1/u1pIPl
        Wx++POereQCTrHAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry: Make some entry symbols global
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.265598113@infradead.org>
References: <20220915111147.265598113@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842695.401.12296281013490963610.tip-bot2@tip-bot2>
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

Commit-ID:     c22cf380c79c4bb0e502b0343f57271b17626424
Gitweb:        https://git.kernel.org/tip/c22cf380c79c4bb0e502b0343f57271b17626424
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:12 +02:00

x86/entry: Make some entry symbols global

paranoid_entry(), error_entry() and xen_error_entry() have to be
exempted from call accounting by thunk patching because they are
before UNTRAIN_RET.

Expose them so they are available in the alternative code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.265598113@infradead.org
---
 arch/x86/entry/entry_64.S |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b24b84b..4cc0125 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -327,7 +327,8 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
-SYM_CODE_START_LOCAL(xen_error_entry)
+SYM_CODE_START(xen_error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -906,7 +907,8 @@ SYM_CODE_END(xen_failsafe_callback)
  * R14 - old CR3
  * R15 - old SPEC_CTRL
  */
-SYM_CODE_START_LOCAL(paranoid_entry)
+SYM_CODE_START(paranoid_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
@@ -1041,7 +1043,8 @@ SYM_CODE_END(paranoid_exit)
 /*
  * Switch GS and CR3 if needed.
  */
-SYM_CODE_START_LOCAL(error_entry)
+SYM_CODE_START(error_entry)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 
 	PUSH_AND_CLEAR_REGS save_ret=1
