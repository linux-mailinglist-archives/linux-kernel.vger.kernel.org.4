Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9150D650477
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLRTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 14:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiLRTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:13:21 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3585BB866
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:13:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id fu10so6852148qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMETP/jVGqYAt1Am1sKohN2GIK72fbH2eJG8GB8IcRM=;
        b=YLzX79p8Zz+klCpFEHuJD+fh6t+1Tol2NaoKjWGxZ7Yq3F9NHrlMXh/zlTV14xaoRj
         y+Pc6HvAoZFfaHJtzIpbZAh561Uvj5MeZ2pZu6tBtBbOP7MEbwrkqKhQJDK/FrCrWWZG
         ZUAxaLoo8oBMzcxsJ1E0iUOuhScEbJwSSMsec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMETP/jVGqYAt1Am1sKohN2GIK72fbH2eJG8GB8IcRM=;
        b=rZLeaO2DCCZy2EyXEO3IFrrC1GrUQTCbGx5YL7d/JvHVzoZ8EG0HDaR7n1MFl6bEGn
         fW4B5cgIXEBahaGFbQYQKKpo86I77X6U8N82/UKZ7eNoR9DRSXB1rif9BWPBYsCMwSqe
         9TEE0IDE2PbevCulfOPnEDAz5L6flFaJl/cw/oRXOCrno3l2up2j59cd8zfCZFzZYTls
         qZv8ESExc87Rdrzrvwbmxya/2d4kmD6vhDFFSfQtodryd3BYWswsID2qPCT2Zbfzidgx
         m8QdntGql8E4Be7WznA/q69mh/OtuDBosKFb7iRNharpcRJftbNG17sQzY8HGrqF4+a7
         aQMw==
X-Gm-Message-State: ANoB5plbK04UMRoeG5Vv4KunRA1eOpctzktvb6IeMdrMpZgF/jj6dUzE
        JsPMwizNB4R49P1SqzSiDapUN2FhcvloTs/T9oM=
X-Google-Smtp-Source: AA0mqf5vbZr+d96WNNC0ud+2q6Ds+10bWi55Eh0WTvC+9QSlCfnuSJrllRhoGw8lTWnveVLPRptsFA==
X-Received: by 2002:ac8:481a:0:b0:3a8:2ca5:8f9b with SMTP id g26-20020ac8481a000000b003a82ca58f9bmr25529899qtq.16.1671390798263;
        Sun, 18 Dec 2022 11:13:18 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id cq8-20020a05622a424800b003a591194221sm4952864qtb.7.2022.12.18.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 11:13:17 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC 1/2] srcu: Remove comment about prior read lock counts
Date:   Sun, 18 Dec 2022 19:13:08 +0000
Message-Id: <20221218191310.130904-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221218191310.130904-1-joel@joelfernandes.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment says that if an updater saw lock count updates, then
ensure the reader does not see the new srcu_idx.

However, there is no memory barrier between a READER reading srcu_idx
with respect to incrementing the lock count for that srcu_idx.

So what is really happening is, both "B" and "C" will order the current
reader's unlock count update, and the _next_ readers lock count update, with
respect to the write to the currently active index.

Consider first the case of the unlock count update being seen by the UPDATER:

(for brevity, the pseudocode shortens "srcu_idx" to "idx")

READER                            UPDATER

rcu_read_lock() {
    idx = READ(idx);
    lock_count[idx]++;

    smp_mb();    // B
}
                                srcu_flip() {
                                    smp_mb(); //E
                                    idx++;
                                    smp_mb();
                                }
rcu_read_unlock() {
    smp_mb();    // C
    unlock_count[idx]++;
}

Consider that the updater saw the unlock count update, and due to this, we
expect "E" to make sure that the reader only used the old srcu_idx.

However, say the reader used the new srcu_idx because we dropped "E".  That is
totally OK because both unlock and lock counts of this reader will negate each
other during the next scan of the srcu_idx. So we don't have to guarantee at
all that the reader used the old srcu_idx, that does not buy us anything
because if it used the new one, we would just ignore it during the next scan
anyway (the reader is "done").

Now lets look at the following case:

READER                            UPDATER

rcu_read_lock() {
    idx = READ(idx);
    lock_count[idx]++;

    smp_mb();    // B
}

rcu_read_unlock() {
    smp_mb();    // C
    unlock_count[idx]++;
}
                                srcu_flip() {
                                    smp_mb(); //E
                                    idx++;
rcu_read_lock() {
    idx = READ(idx);
    lock_count[idx]++;

    smp_mb();    // B
                                    smp_mb();
                                }
}

Consider that the updater saw the lock count update of the second
rcu_read_lock(). It does not matter that we guarantee that the reader sees only
the old srcu_idx. This is because, a reader could totally just sample
srcu_idx, and stay preempted for long periods of time. So, during any scan, we
already have the issue of a preempted-reader randomly springing up with a copy
of the index which we consider the "new index". So guaranteeing that the reader
saw the old srcu_idx instead of the new one if we saw its lock count updates,
also does not buy us anything.

Due to these reasons, drop the argument that the reader has to see a certain
srcu_idx since we have no control over that anyway, and guaranteeing that does not
buy us anything.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..d6a4c2439ca6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -983,12 +983,10 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Ensure that if a given reader sees the new value of ->srcu_idx, this
+	 * updater's earlier scans cannot have seen that reader's increments
+	 * (which is OK, because this grace period need not wait on that
+	 * reader).
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
-- 
2.39.0.314.g84b9a713c41-goog

