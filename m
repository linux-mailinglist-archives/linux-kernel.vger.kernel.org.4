Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136D6011AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiJQOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJQOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A168CFA;
        Mon, 17 Oct 2022 07:53:31 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xg0xHXej0kpXb8D+dFwquGdGQDndJ4sP04mdgb/MTKk=;
        b=hnDUyaja6MpvH6W+3iQ0Au0xFHD2W8lf49eJF79hPNd8tW3kjYLsRojUqsSohXN7PMAmHH
        JrlMPJSAnY312Yx8y4hI1GV+pHfpbxHH/VzP/lbmnEyj21miVGx9k7goCPgc5MYanwYMkK
        5/gRLE9GOm7+Nfv6wy0So3TQc5yrJcAeO4SHFlDds6d61JzdEkRv2vLm7b42ZTLG0D30wS
        OrGuV9XDBOSf6eOsIY7vN+/Z4WLkVx0ZvNpupTdoe4KIH1Iq8L03ZoJ7Q23sGdnlr19i4h
        8BCTfwEDOu4b4qAQAubFEggifrqY+jhDpM3k4+bkLJwsbb6VqCK7BSV0NEB82Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xg0xHXej0kpXb8D+dFwquGdGQDndJ4sP04mdgb/MTKk=;
        b=Vl0FhSBjCYeHckk5G/NUn/Zh4ua8nqiq16T/OeHnlYTRdNP2rGQ9mHR40Gidh0N6DQSeG7
        b6R0FmH9BndPUuBQ==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bugs: Add retbleed=force
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166601840772.401.17827404870424990971.tip-bot2@tip-bot2>
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

Commit-ID:     5c9a92dec3235b0c1d51e92860f8014753161593
Gitweb:        https://git.kernel.org/tip/5c9a92dec3235b0c1d51e92860f8014753161593
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 17 Oct 2022 16:41:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:20 +02:00

x86/bugs: Add retbleed=force

Debug aid, allows running retbleed=force,stuff on non-affected uarchs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e6c23ea..b307b83 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -838,6 +838,8 @@ static int __init retbleed_parse_cmdline(char *str)
 			retbleed_cmd = RETBLEED_CMD_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
+		} else if (!strcmp(str, "force")) {
+			setup_force_cpu_bug(X86_BUG_RETBLEED);
 		} else {
 			pr_err("Ignoring unknown retbleed option (%s).", str);
 		}
