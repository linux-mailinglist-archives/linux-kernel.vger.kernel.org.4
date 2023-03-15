Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A936BB603
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjCOOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbjCOOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:30:00 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8B1E5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:29:57 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id YeVt2900b1C8whw06eVtLg; Wed, 15 Mar 2023 15:29:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcS3h-00CI8b-Fn;
        Wed, 15 Mar 2023 15:25:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcS4J-00D13s-Rp;
        Wed, 15 Mar 2023 15:25:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tobias Klausmann <klausman@schwarzvogel.de>
Subject: [PATCH] lib: dhry: Fix unstable smp_processor_id(_) usage
Date:   Wed, 15 Mar 2023 15:25:22 +0100
Message-Id: <b0d29932bb24ad82cea7f821e295c898e9657be0.1678890070.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the in-kernel Dhrystone benchmark with
CONFIG_DEBUG_PREEMPT=y:

    BUG: using smp_processor_id() in preemptible [00000000] code: bash/938

Fix this by not using smp_processor_id() directly, but instead wrapping
the whole benchmark inside a get_cpu()/put_cpu() pair.  This makes sure
the whole benchmark is run on the same CPU core, and the reported values
are consistent.

Fixes: d5528cc16893f1f6 ("lib: add Dhrystone benchmark test")
Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217179
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/dhry_run.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/dhry_run.c b/lib/dhry_run.c
index f9d33efa6d090604..f15ac666e9d38bd2 100644
--- a/lib/dhry_run.c
+++ b/lib/dhry_run.c
@@ -31,6 +31,7 @@ MODULE_PARM_DESC(iterations,
 
 static void dhry_benchmark(void)
 {
+	unsigned int cpu = get_cpu();
 	int i, n;
 
 	if (iterations > 0) {
@@ -45,9 +46,10 @@ static void dhry_benchmark(void)
 	}
 
 report:
+	put_cpu();
 	if (n >= 0)
-		pr_info("CPU%u: Dhrystones per Second: %d (%d DMIPS)\n",
-			smp_processor_id(), n, n / DHRY_VAX);
+		pr_info("CPU%u: Dhrystones per Second: %d (%d DMIPS)\n", cpu,
+			n, n / DHRY_VAX);
 	else if (n == -EAGAIN)
 		pr_err("Please increase the number of iterations\n");
 	else
-- 
2.34.1

