Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25B666572
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjAKVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjAKVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:17:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB951929B;
        Wed, 11 Jan 2023 13:17:39 -0800 (PST)
Date:   Wed, 11 Jan 2023 21:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673471857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJcFPsuRnlT69IfwpVb+Lnza97LPnA6DR8gMevnpBGw=;
        b=YuyZtPHT9VUWbAqE6ZkkWB2ToPyyYRnxiUGvqCKAYevTyyEMhJEVbToy4s1tlJgR2So1uH
        zy25ZeLgrrQIQoss19ezxr2HPpowEMCva0W1IslLi6ihTywEqWW5Rddiak8QtlPXVPP67T
        e7+TyOh5FTOIq8/yYEumvTZj+MX8BPaOGqxEzzA+0z/EiNX7zO0G6zkfQGFxZJmCWUhljE
        FVrshCa8ynFSjcVicR5gIt3q0fCIAIaQf05WMscmVJ2a1fp6ZbgDwjRVAdSxI91wl3VDww
        TNDSkjdBEuKRk41LjUbA7Eh3qUsYBc+Mwu5pE01vgMcMcAwRd8NXXX+5h1fdWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673471857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJcFPsuRnlT69IfwpVb+Lnza97LPnA6DR8gMevnpBGw=;
        b=DTVafsYt6XoZL5MU5+n/ygFwWjVq1xj5baaC2FsrXbyxXwpbmy0BzkyBBa9dOJ1ZlCynzV
        OE5TUkCOu/7TYLBg==
From:   "tip-bot2 for Alexander Sverdlin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] docs: locking: Discourage from calling disable_irq()
 in atomic
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-doc@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221212163715.830315-1-alexander.sverdlin@siemens.com>
References: <20221212163715.830315-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Message-ID: <167347185712.4906.2425854562140867761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     379af13b31fa8a36ad4abd59a5c511f25c5d4d42
Gitweb:        https://git.kernel.org/tip/379af13b31fa8a36ad4abd59a5c511f25c5=
d4d42
Author:        Alexander Sverdlin <alexander.sverdlin@siemens.com>
AuthorDate:    Mon, 12 Dec 2022 17:37:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Jan 2023 19:45:26 +01:00

docs: locking: Discourage from calling disable_irq() in atomic

Correct the example in the documentation so that disable_irq() is not being
called in atomic context.

disable_irq() calls sleeping synchronize_irq(), it's not allowed to call
them in atomic context.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-doc@vger.kernel.org
Link: https://lore.kernel.org/lkml/87k02wbs2n.ffs@tglx/
Link: https://lore.kernel.org/r/20221212163715.830315-1-alexander.sverdlin@si=
emens.com

---
 Documentation/kernel-hacking/locking.rst                    | 4 ++--
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index c756786..dff0646 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1277,11 +1277,11 @@ Manfred Spraul points out that you can still do this,=
 even if the data
 is very occasionally accessed in user context or softirqs/tasklets. The
 irq handler doesn't use a lock, and all other accesses are done as so::
=20
-        spin_lock(&lock);
+        mutex_lock(&lock);
         disable_irq(irq);
         ...
         enable_irq(irq);
-        spin_unlock(&lock);
+        mutex_unlock(&lock);
=20
 The disable_irq() prevents the irq handler from running
 (and waits for it to finish if it's currently running on other CPUs).
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Do=
cumentation/translations/it_IT/kernel-hacking/locking.rst
index b8ecf41..05d362b 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1307,11 +1307,11 @@ se i dati vengono occasionalmente utilizzati da un co=
ntesto utente o
 da un'interruzione software. Il gestore d'interruzione non utilizza alcun
 *lock*, e tutti gli altri accessi verranno fatti cos=C3=AC::
=20
-        spin_lock(&lock);
+        mutex_lock(&lock);
         disable_irq(irq);
         ...
         enable_irq(irq);
-        spin_unlock(&lock);
+        mutex_unlock(&lock);
=20
 La funzione disable_irq() impedisce al gestore d'interruzioni
 d'essere eseguito (e aspetta che finisca nel caso fosse in esecuzione su
