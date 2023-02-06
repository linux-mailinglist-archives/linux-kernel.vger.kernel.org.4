Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324768C033
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjBFOeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBFOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:34:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D224118;
        Mon,  6 Feb 2023 06:34:32 -0800 (PST)
Date:   Mon, 06 Feb 2023 14:34:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675694070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PB5txZZ6YpAhlL1fSCALO3Puny2bU5PftBtTWYCZ5+s=;
        b=U4xV5drYpfGhrgJhPXIuI3+SaEz2ebAK4x6d/tW9IHNMht2kNJy6TFEtY08KkqKGZotNyU
        j5YCE8kEOCu4z9ijUCOS1Qb8/GinIQGN2NCmT9ZWARlewijP0XzNThEZt74tUxgw50HcMJ
        yFw5KBkjlDqUa4+ldyuaIv9yj8Rw3X9hIcVUl6uYc9ZFZMo0fOvBBt4/6nC1cDUwpHRs0/
        fvRmXSkCKqKJdfss1nLTa/yjWjMUccZ7NwCRvzLg5tE+fbXSnzgXmVPUXl+mHwIWWVPYb9
        08LTKrJn93PliX0yBldfX+0C7+lcDdTwtO6zDTxOPBX3KWACgDG7ZwNEKWGGtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675694070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PB5txZZ6YpAhlL1fSCALO3Puny2bU5PftBtTWYCZ5+s=;
        b=GIY8aXb+texE0veODYYD41n/aBq2gySMt8KUnRyuhjlFzJgdjsfjULBTlB8pxQ+gNxLesa
        1hPq5mshyNPfSfBQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Remove lockdep_init_map_crosslock.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220311164457.46461-1-bigeasy@linutronix.de>
References: <20220311164457.46461-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <167569407048.4906.7677170692451089615.tip-bot2@tip-bot2>
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

Commit-ID:     2edcedcd1dcb542cb09acabda1732de47dd82e68
Gitweb:        https://git.kernel.org/tip/2edcedcd1dcb542cb09acabda1732de47dd82e68
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 09 Jun 2022 17:36:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Feb 2023 15:31:05 +01:00

locking/lockdep: Remove lockdep_init_map_crosslock.

The cross-release bits have been removed, lockdep_init_map_crosslock() is
a leftover.

Remove lockdep_init_map_crosslock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20220311164457.46461-1-bigeasy@linutronix.de
Link: https://lore.kernel.org/r/YqITgY+2aPITu96z@linutronix.de

---
 include/linux/lockdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1f1099d..1023f34 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -435,7 +435,6 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
-#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
