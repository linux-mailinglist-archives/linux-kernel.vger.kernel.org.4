Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D5610A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJ1Gmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJ1GmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B53D585;
        Thu, 27 Oct 2022 23:41:59 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUSrvwYgL0dIcLR2lJy0T+1rcLcG46h66uXQXaF8FEg=;
        b=xlOkPiXtwsK0gjG2S/jzmvrqwEtxLqQYjqRV0qnANbyEJdXQ6QjCNpiw77nj+vXJTQX91b
        wD1jEeSINiqkMAiLoLb17Ho+MwIQxT+6hLgAzY0SH74G2VDIJw6AuyBy1SOseLbEGtc7i2
        GPsbuV4JRRMzDMuq8lA4W5Ib8w8af0/M+ddDvf/bRkunF2iDKqA/T8chmDR3XrMCZLHKvj
        7dDUJh4aLlxnHLDjvjsslr57losaCDU8x9ntApO1hjOGSio1Nl2pXnUAEDZ9VpNamknC5I
        GWFR1xqeTupZYYCLCWIGhN2YydvJmkYADlgIC89jVVWRsCc2E5togRqux1wwiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUSrvwYgL0dIcLR2lJy0T+1rcLcG46h66uXQXaF8FEg=;
        b=1WsGJY96mB1ZzO8z07PfEFaXLPOiQ+er1L4NmF8eu9VHMf9KGFubUyVo5K3ctMsmSlJoVi
        u3AfIfqbvfiywdCQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Add support for Intel AlderLake-N
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wang Wendy <wendy.wang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221023125120.2727-1-rui.zhang@intel.com>
References: <20221023125120.2727-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <166693931648.29415.14499497491956419477.tip-bot2@tip-bot2>
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

Commit-ID:     1ab28f17eeeecf7d832e686fdd903d74569854ed
Gitweb:        https://git.kernel.org/tip/1ab28f17eeeecf7d832e686fdd903d74569854ed
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Sun, 23 Oct 2022 20:51:19 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 10:27:31 +02:00

perf/x86/rapl: Add support for Intel AlderLake-N

AlderLake-N RAPL support is the same as previous Sky Lake.
Add AlderLake-N model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Link: https://lkml.kernel.org/r/20221023125120.2727-1-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47..165c506 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -806,6 +806,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	{},
 };
