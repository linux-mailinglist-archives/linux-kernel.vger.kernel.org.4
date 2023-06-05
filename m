Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD80722A6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjFEPJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjFEPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13994EE;
        Mon,  5 Jun 2023 08:08:32 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IszN7i8LvGZZtTT7DK5LZSM3FMAKJ2IdsnqEYQqg2vM=;
        b=UFsgXEn8RVQEhFIeSiiPTLKQ9SC+RRvCLj+I0FIA19cl4A5VPbFU3bU3vulPbWxzgnLtaa
        MznT4avcOAOwxUxaRv6m2EUv9v1ClvFrscnKpiFhkArfx+EGYq+ShtuqcK4zNBu5IhxeYw
        1hGcFWjMWqKNBEV54+c+rqq2VYZ51ZtLLIzGZabmX0zCxk33bhd7L1V4XdT3iptQ7/0DQh
        +KHSnWGdkd7ikKo/jtrs/yDQcKWgpOddJKMI2pl49lsHKFFXk2GfaVAnkBlmBdQTRoKC/a
        Y8fAfjJekAFAYn5hvrTMWpjqQtLyzACqqanMangNchR0qAJHRFQ8wXlrivHUyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IszN7i8LvGZZtTT7DK5LZSM3FMAKJ2IdsnqEYQqg2vM=;
        b=8Tmc+eTf+wubwlp0PxjO+vNyXSlsXhU7lw3qu34tJDFm/P14YLHQ62SbTcubE5H42lbGto
        XVsPvwKxvacEuiCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Set k_itimer:: It_signal to NULL on exit()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.196462644@linutronix.de>
References: <20230425183313.196462644@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597771022.404.18097593323774926958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     515eeda177b797d9a7d0c496739f0bdc02c73093
Gitweb:        https://git.kernel.org/tip/515eeda177b797d9a7d0c496739f0bdc02c73093
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:37 +02:00

posix-timers: Set k_itimer:: It_signal to NULL on exit()

Technically it's not required to set k_itimer::it_signal to NULL on exit()
because there is no other thread anymore which could lookup the timer
concurrently.

Set it to NULL for consistency sake and add a comment to that effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.196462644@linutronix.de

---
 kernel/time/posix-timers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4333334..e8d877f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1101,6 +1101,14 @@ retry_delete:
 	}
 	list_del(&timer->list);
 
+	/*
+	 * Setting timer::it_signal to NULL is technically not required
+	 * here as nothing can access the timer anymore legitimately via
+	 * the hash table. Set it to NULL nevertheless so that all deletion
+	 * paths are consistent.
+	 */
+	WRITE_ONCE(timer->it_signal, NULL);
+
 	spin_unlock_irqrestore(&timer->it_lock, flags);
 	release_posix_timer(timer, IT_ID_SET);
 }
