Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3065C592
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjACSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbjACSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:00:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D711474;
        Tue,  3 Jan 2023 10:00:42 -0800 (PST)
Date:   Tue, 03 Jan 2023 18:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672768841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtB1U/VEk/htiQd0Z9W7KK2KMQVCfvqESdHqfgHUhSg=;
        b=l/VLWdoWYh5RYqm/xxabFGJjQKV3OZWzJIGueDgr/mqY0ZQZX5pICahVnEf4SKI5TUkTl9
        4WNU+vLGVHN1X+Z5fCLYZ9GRtC3UV9lvFxDRU9YdlqxEmQZl0hqTEAo4vDV01ClbRcjXk4
        hnQeQG0gdl68lmmx721JQYLWMYXi526Z1/ViUa93XXuAEzGb0R6T/0hGa12pwe/XLTu5WP
        X0bGHXFGx8gLtQ2gMULdBoe4Hj7BzGg4PtfBnLZCBGpUNSbx11YDMtg8RCrIsVgKCuKgV5
        8chP45b8hen+ONGBUfYG6yZCAq5pJj8oJ61sWuGb3+lUYPBOITB5zOjs8gMnGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672768841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtB1U/VEk/htiQd0Z9W7KK2KMQVCfvqESdHqfgHUhSg=;
        b=YkxLZxb0kHUCYDV2HcqUXcs1LNzFVFi3kcbb9l5u/05UtUwcJy3rlJlA6RpyBqiAb1qa2s
        kjVbgmWqlFlScwCQ==
From:   "tip-bot2 for Chris Wilson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Treat Tigerlake like Icelake
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221228113454.1199118-1-rodrigo.vivi@intel.com>
References: <20221228113454.1199118-1-rodrigo.vivi@intel.com>
MIME-Version: 1.0
Message-ID: <167276884075.4906.6298448659461708987.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c07311b5509f6035f1dd828db3e90ff4859cf3b9
Gitweb:        https://git.kernel.org/tip/c07311b5509f6035f1dd828db3e90ff4859cf3b9
Author:        Chris Wilson <chris@chris-wilson.co.uk>
AuthorDate:    Wed, 28 Dec 2022 06:34:54 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Jan 2023 18:55:35 +01:00

perf/x86/rapl: Treat Tigerlake like Icelake

Since Tigerlake seems to have inherited its cstates and other RAPL power
caps from Icelake, assume it also follows Icelake for its RAPL events.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20221228113454.1199118-1-rodrigo.vivi@intel.com
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a829492..ae5779e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -800,6 +800,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
