Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BD68C0C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBFO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBFO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:57:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009F21AE;
        Mon,  6 Feb 2023 06:57:46 -0800 (PST)
Date:   Mon, 06 Feb 2023 14:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675695465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yluV3lLkO9smXnLsr2KsLUa9LqscUFrEopzcZx76aEQ=;
        b=IWSzC1hVO/xB7xMg9+i/SY/BAx3Y3agOE2b6BlKi0wy81GSlyq4ICwcleOaXiWadkuFQ+O
        7cpxf1vzT5n/L30qk0rCh+9Qhqju9Wnxl3bf6LynKeFS2s/H6AnR8o6EDBo7E3p1MC9l29
        Dml31ZKic/kRRKQQYWKFvQkALfUwEwGPAzVD9OuqI95oiadeMWZbPPqlQTcdGMZYONyFS3
        ZvD26xG5g2VfEQG1oWIDcmL8IEY5YvqCljGJxigT0VGiG1FN7ejJDa3R+DvjS2o8zA1GRZ
        KdWAaiawwwqUsGW6+Vrtq3bJSp8wvExMMK0J5xzqvSXuk8EUyOfZ0hq4C2INIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675695465;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yluV3lLkO9smXnLsr2KsLUa9LqscUFrEopzcZx76aEQ=;
        b=qSp0js0UZQXCawCJwINFd5+Ok9jBlh6xYnLO/uXiDWH9e/2DGCXesn7Yebgnk3jNMD8sTE
        +bizSMexRp2vbLBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] selftests: Emit a warning if getcpu() is missing on 32bit
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221125094216.3663444-4-bigeasy@linutronix.de>
References: <20221125094216.3663444-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <167569546513.4906.15099899150796556318.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     5646bbd6684acf5c9b9dedb863b7d2f6f5a330fb
Gitweb:        https://git.kernel.org/tip/5646bbd6684acf5c9b9dedb863b7d2f6f5a330fb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 10:42:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Feb 2023 15:48:54 +01:00

selftests: Emit a warning if getcpu() is missing on 32bit

The VDSO implementation for getcpu() has been wired up on 32bit so warn if
missing.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20221125094216.3663444-4-bigeasy@linutronix.de

---
 tools/testing/selftests/x86/test_vsyscall.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 5b45e69..47cab97 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -92,11 +92,8 @@ static void init_vdso(void)
 		printf("[WARN]\tfailed to find time in vDSO\n");
 
 	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
-	if (!vdso_getcpu) {
-		/* getcpu() was never wired up in the 32-bit vDSO. */
-		printf("[%s]\tfailed to find getcpu in vDSO\n",
-		       sizeof(long) == 8 ? "WARN" : "NOTE");
-	}
+	if (!vdso_getcpu)
+		printf("[WARN]\tfailed to find getcpu in vDSO\n");
 }
 
 static int init_vsys(void)
