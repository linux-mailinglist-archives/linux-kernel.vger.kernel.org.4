Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1743662ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbjAIQI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjAIQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:08:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353983B90C;
        Mon,  9 Jan 2023 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IWQp+dbz3tPD0BbW9vxQ/2vTC08Sy+DyjJEG4zi6onc=; b=bWZV7XQCDnsvNcJYDEt+yN0Gpr
        qAsThBNTT2qcDVAocJUuYke/IzZp9PsXtxRfNEO5cYm3ViZ3wfbe4Kjo0pXcWoeVCtjpd0r4RR3G5
        7iMANrOV6Ah2wfvpD88fvkwv9mgkguihyWZW/MkY37P1N1rbm2kcBLhz2cUZTPqOuB/CKN9DFsWHj
        zSCok+TUcDATD4ITzDShlsIju/ouElkn8HRhzdJaOH27OGtHC6KxPxEJ8SwnKye/zT+04L3o89tpB
        HUL529/FVigqt+4e6L7FjA9Jx0ZkrUnLxQ2owRWz6h9E3ghQnACcw5xKvraP3Y2YlUUs6WUIYBFjU
        /an4UiYg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEuh0-002UBK-NY; Mon, 09 Jan 2023 16:08:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] x86/retbleed: add "stuff" mode admin documentation
Date:   Mon,  9 Jan 2023 08:08:08 -0800
Message-Id: <20230109160808.30740-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add admin documentation for "retbleed=stuff", based on commit
description and source code.

Fixes: d82a0345cf21 ("x86/retbleed: Add call depth tracking mitigation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Acked-by: Ingo Molnar <mingo@kernel.org>
---
v2: fix typo "if effect" -> "in effect" (thanks Ingo)

 Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5364,6 +5364,14 @@
 				       when STIBP is not available. This is
 				       the alternative for systems which do not
 				       have STIBP.
+			stuff        - Enables "stuffing" mode mitigation,
+				       which uses return thunking and call depth
+				       tracking.  Only in effect if
+				       CONFIG_CALL_DEPTH_TRACKING is set and
+				       Spectre V2 mitigation mode is
+				       "retpoline".
+				       IBRS is fully secure mitigation but is
+				       more costly (slower) than stuffing.
 			unret        - Force enable untrained return thunks,
 				       only effective on AMD f15h-f17h based
 				       systems.
