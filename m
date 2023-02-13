Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67D694FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBMStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBMSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B641CAFA;
        Mon, 13 Feb 2023 10:48:36 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k/nAO6D5+40cddh0WbZTxoJpzCW4ZAewqvnajsY1fag=;
        b=UfM8+hfar5sYI1mEMKuZtf9gZk6kB8SQ4byg3EpZzkTzyeC1cxNZKNI3IdJmqCaAzmofUs
        xueYOq6sqzbEQpuKlJxPO2h9gQD2dw0svB1wPSIDwECaDRetrYmrZNP3512Gr8Ozo+Bn4E
        YoRuhGZo53YGx7+UbniDqWylLNvdVe90pcyp4k+8Wm05lINrwWh0lynF94rScSqs4Uviba
        VBguS63PYTfFlopUYFVPdg+ITyt/BBXIvKseJbh69zN8kO2qih/JGVBPCnLuoMgJ5Gzd40
        mVcYw2WGXXsqyoOyprzXVjOIBwY0OvrbHOnC8EPSMkyhno61B2qbEkKPHfab1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k/nAO6D5+40cddh0WbZTxoJpzCW4ZAewqvnajsY1fag=;
        b=aiC7gRq8/iMVEkbCA2f93/jOg/8+V5itdZEoNXurSHvVz4jMsncOhrCly3OZM5H1jQk4Zl
        agcjvLFCA8JezYBg==
From:   "tip-bot2 for Yunying Sun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Print clocksource name when
 clocksource is tested unstable
Cc:     Yunying Sun <yunying.sun@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167631411430.4906.12795499771072205782.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     beaa1ffe551c330d8ea23de158432ecaad6c0410
Gitweb:        https://git.kernel.org/tip/beaa1ffe551c330d8ea23de158432ecaad6c0410
Author:        Yunying Sun <yunying.sun@intel.com>
AuthorDate:    Wed, 16 Nov 2022 16:22:21 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 03 Jan 2023 20:43:45 -08:00

clocksource: Print clocksource name when clocksource is tested unstable

Some "TSC fall back to HPET" messages appear on systems having more than
2 NUMA nodes:

clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 4296200ns, attempt 4, marking unstable

The "hpet" here is misleading the clocksource watchdog is really
doing repeated reads of "hpet" in order to check for unrelated delays.
Therefore, print the name of the clocksource under test, prefixed by
"wd-" and suffixed by "-wd", for example, "wd-tsc-wd".

Signed-off-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9cf32cc..4a2c3bb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 			goto skip_test;
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
+		smp_processor_id(), cs->name, wd_delay, nretries);
 	return WD_READ_UNSTABLE;
 
 skip_test:
