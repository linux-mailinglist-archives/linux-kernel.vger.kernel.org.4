Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD96011C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJQOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiJQOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A9668CF0;
        Mon, 17 Oct 2022 07:53:59 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yg47wEtGmxkn7LmYA5aeq8v92KRiwHDl65auQo/fnA4=;
        b=h4RQC2PscyhAGH9fRVCpHwKRAfe5ifmNZK7lKYSMpQVDXvYf9C0QTkW8esY50FgwLNMBgx
        yiyitvQF0fEh9zs1jkvoPpqGD+J+YnZVs0SUIurdc2c593pxjPp00KHX9piovG7Us31f5j
        XZIpjLA4gtipFp7tKh27INQS4J9gRPByPiAvZxCqZkN38qWWCEkeVAy7bv6peDlRA0VAcJ
        grQT2Y9i6vRzSl1DnTeY9XB0glTIL7gOBadfHWJoiKq5eLajaWES/euV11s5zT3VgDDbUB
        4tHSF/TJc9qbm/PfzTiHkYJdx5sTdpTFDs88u06tIQVUJxs7Ft5MuB6sx08mCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yg47wEtGmxkn7LmYA5aeq8v92KRiwHDl65auQo/fnA4=;
        b=J1JoldzRUDJAuoQbH2tAo0Yc2ib82CWk7oTQZL6h0XeDg+EudnT0qwqJRsXfK9vYXvNkrb
        CO+ZmSEkFMmWDBBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/Kconfig: Add CONFIG_CALL_THUNKS
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.849523555@infradead.org>
References: <20220915111146.849523555@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843147.401.3646706448544046869.tip-bot2@tip-bot2>
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

Commit-ID:     8f7c0d8b23c3f5f740a48db31ebadef28af17a22
Gitweb:        https://git.kernel.org/tip/8f7c0d8b23c3f5f740a48db31ebadef28af17a22
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:10 +02:00

x86/Kconfig: Add CONFIG_CALL_THUNKS

In preparation for mitigating the Intel SKL RSB underflow issue in
software, add a new configuration symbol which allows to build the
required call thunk infrastructure conditionally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.849523555@infradead.org
---
 arch/x86/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f408fa8..e18963e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2446,6 +2446,14 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
+config HAVE_CALL_THUNKS
+	def_bool y
+	depends on RETHUNK && OBJTOOL
+
+config CALL_THUNKS
+	def_bool n
+	select FUNCTION_ALIGNMENT_16B
+
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
 	default y
