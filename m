Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8242F5BF88C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiIUIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIUIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:01:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF3B868BB;
        Wed, 21 Sep 2022 01:01:30 -0700 (PDT)
Date:   Wed, 21 Sep 2022 08:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663747288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=os0yK4GP2z/n8Z71HCh3AJyvHSnUpgK6AB5SIry3Q40=;
        b=UP2pdNFZagRUG7lM93JW6L9RqLj5vTTLp2XxM9BeAwnNJIJqjvgt0Cz9Vk7Eqkj6oT33Mt
        bYUeYyGmR/Fv5g3OgO38E9g06dMzqnasFRQhHtnXvO36IIqZVMxbnXWz/HM8tHAW66cqYu
        Fe3Bdmf89XB3zlAVX6vzWjQr/ox8BQYKyRRS5AHzmBlt9fPFoUu3VsVgJsQwHhgIKKYoca
        9fMzqOSjYiw0CNgq9eyVVKdv8xSHw7CzhLeTzmKvLvliQycBK/DHwbWmZG3rgxkKr1pM1l
        DM00T447YSiCUIsYBbhDUhV6ogc7PhxHqLOwY5S8m55/IUb0MYXNZTsFbkWNSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663747288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=os0yK4GP2z/n8Z71HCh3AJyvHSnUpgK6AB5SIry3Q40=;
        b=nseuQzJ0orOwMM1kun0gI1y4e3d28pSzCr+O4OaKNy8NnOvClkdcQ+MGM2heF79Iqmu3lY
        cX3V8eUMJyUsm4DA==
From:   "tip-bot2 for Tetsuo Handa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Print more debug information -
 report name and key when look_up_lock_class() got confused
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <bd99391e-f787-efe9-5ec6-3c6dc4c587b0@I-love.SAKURA.ne.jp>
References: <bd99391e-f787-efe9-5ec6-3c6dc4c587b0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Message-ID: <166374728690.401.4563412884155961056.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     76e64c73db9542ff4bae8a60f4f32e38f3799b95
Gitweb:        https://git.kernel.org/tip/76e64c73db9542ff4bae8a60f4f32e38f3799b95
Author:        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate:    Mon, 19 Sep 2022 09:52:13 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 21 Sep 2022 09:58:21 +02:00

locking/lockdep: Print more debug information - report name and key when look_up_lock_class() got confused

Printing this information will be helpful:

  ------------[ cut here ]------------
  Looking for class "l2tp_sock" with key l2tp_socket_class, but found a different class "slock-AF_INET6" with the same key
  WARNING: CPU: 1 PID: 14195 at kernel/locking/lockdep.c:940 look_up_lock_class+0xcc/0x140
  Modules linked in:
  CPU: 1 PID: 14195 Comm: a.out Not tainted 6.0.0-rc6-dirty #863
  Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  RIP: 0010:look_up_lock_class+0xcc/0x140

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/bd99391e-f787-efe9-5ec6-3c6dc4c587b0@I-love.SAKURA.ne.jp
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 64a13eb..e3375bc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -934,8 +934,10 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 			 * Huh! same key, different name? Did someone trample
 			 * on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name &&
-				     lock->key != &__lockdep_no_validate__);
+			WARN_ONCE(class->name != lock->name &&
+				  lock->key != &__lockdep_no_validate__,
+				  "Looking for class \"%s\" with key %ps, but found a different class \"%s\" with the same key\n",
+				  lock->name, lock->key, class->name);
 			return class;
 		}
 	}
