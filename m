Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E730965FF23
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjAFKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjAFKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:48:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458D66CFDF;
        Fri,  6 Jan 2023 02:48:05 -0800 (PST)
Date:   Fri, 06 Jan 2023 10:48:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673002083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hxCtPufFtZ5al9rbAfK0+sKz8sTOiY727C5yei9u9k=;
        b=t1MiUaHuRMCwIAF88dKGsbhsvmMLn/iopIFfDEWrJfWvT2+4gfJXlx7Fa3DQUUvdRwM1EW
        l/nh5ReZ3ZFJJj5ByIzcUxJ0n2UfJeH3MPb3ID1gbN6V8LtuV/F5fP5h1i4MmdNSS/br9W
        XGodTzOTdYA/ZcOUtz/TUAX2x0STSkCZEj3lvJPIHv+swBxLKPSilNmgxuAgi6qF/51rJi
        RQr6qgdes0IHuJgx0xMgaVmVxobf/K+mAcAxK1k0jGusqFLNZNbPacnwHF1ZA9C1KWTPaC
        s5kf108Ja1KBjufC02i0ytSRpCNP/vPxF0nl78cEnkeCPCWfF8ykYQ/y+c6Dsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673002083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hxCtPufFtZ5al9rbAfK0+sKz8sTOiY727C5yei9u9k=;
        b=REJk9c4Jvqc7Zar4ycE2QFX2GuxLQF7FH8SBRwNK/arsg7SwLc7m/5y1FAAkS6gnRp+KJg
        urGE9lT/BckJ5WBA==
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/rtc: Simplify PNP ids check
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <167300208315.4906.17267307487336474723.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     bd4edba2653aeef0119b7a945f07e58711343bf9
Gitweb:        https://git.kernel.org/tip/bd4edba2653aeef0119b7a945f07e58711343bf9
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Wed, 14 Dec 2022 22:24:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Jan 2023 04:22:34 +01:00

x86/rtc: Simplify PNP ids check

compare_pnp_id() already iterates over the single linked pnp_ids list
starting with the id past to it.

So there is no need for add_rtc_cmos() to call compare_pnp_id()
for each id on the list.

No change in functionality intended.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/rtc.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 3490464..1309b9b 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -138,15 +138,12 @@ static __init int add_rtc_cmos(void)
 	static const char * const ids[] __initconst =
 	    { "PNP0b00", "PNP0b01", "PNP0b02", };
 	struct pnp_dev *dev;
-	struct pnp_id *id;
 	int i;
 
 	pnp_for_each_dev(dev) {
-		for (id = dev->id; id; id = id->next) {
-			for (i = 0; i < ARRAY_SIZE(ids); i++) {
-				if (compare_pnp_id(id, ids[i]) != 0)
-					return 0;
-			}
+		for (i = 0; i < ARRAY_SIZE(ids); i++) {
+			if (compare_pnp_id(dev->id, ids[i]) != 0)
+				return 0;
 		}
 	}
 #endif
