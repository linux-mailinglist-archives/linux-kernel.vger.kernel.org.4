Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF826DB964
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDHHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDHHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:54:06 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0326EFBD;
        Sat,  8 Apr 2023 00:54:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id f14so18830902oiw.10;
        Sat, 08 Apr 2023 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht+Snw7oqKAYwWbuQnCqRHObcbb/KZ3skYYXvWfrZk8=;
        b=D5nB5m8Hn67ITtdKlaB0dHuMUxSNyMOaAEpOmuO86juhbgRRRD+MV0Ot+fB9CFEamj
         v3NglJw1JZGFQ4oW6cHzBe9GPotPulpRlMBnEub+FEYvpjKUctc14IDvwJ6I471KOQF2
         Iyer6YfRpXXesByamiBfqbv1TGrtJBKyYnM+8SUXHsjhNenIUymUrwiCwFIaZ98Wwfnv
         0byZ9JHBc2oTqFuGyGBJC59LFmfVAuoHln1Br/i2HSKf2TIZxfQcTtqlxwnve7OXNA3m
         KTkf6b3u4OXLKMjmCTvLuCyfekFRNCL46A4y0sxWksGjVliXtbtQasRiEm/3K3f65ivI
         vfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht+Snw7oqKAYwWbuQnCqRHObcbb/KZ3skYYXvWfrZk8=;
        b=A39VdogPMfF1JK8ybqyynktEuQ5bV5kInFPPvN96wBZH0hRMmpOqa7XfMEcSSZ851D
         XSo9FkPsr7W557nWyoVqV1OrvEwOl6eV9E0xl0o4+12QmEMME/5Vr2WomgQ6IckdHpob
         1v+dlMbkYnxDWml93jfjJX6ZgInYiZjBp2zaVpO9gaPlpNwZL0h1pqa/bldOTO8HJ0Rg
         C0MWuO/obGcYDt9E6KB0ZWDC1ifo0xm+mFUDyS7hRcl0IXpNE9TmIHUjtfIse3jKCEtH
         U5+ViR/jm6p362TmFOGjYBFI9KBp614+NfIxU1cut6Dft3GUESc3hyzbXyqFZRhqI/BS
         HMnA==
X-Gm-Message-State: AAQBX9dDgkE4KTWlPLDg7e5K266iIo8TyF/jtmpQLyUy/8YahnmmO4BL
        EDR2FmJ6J2JugVJDqbZAykEsNtQ8azkjHg==
X-Google-Smtp-Source: AKy350bJSJD8sgzjt0jhNpYQPKNwsgl/1ntfYTBRuRMzpEGRQqwMkM7A3SsWaM+vrK0C18PJrF73/g==
X-Received: by 2002:aca:2304:0:b0:384:1221:9a24 with SMTP id e4-20020aca2304000000b0038412219a24mr1826021oie.27.1680940444328;
        Sat, 08 Apr 2023 00:54:04 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id o6-20020a4a9586000000b0051ffe0fe11bsm2435175ooi.6.2023.04.08.00.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 00:54:04 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 04/13] locking/spinlock: introduce spin_lock_init_with_key
Date:   Sat,  8 Apr 2023 04:53:31 -0300
Message-Id: <20230408075340.25237-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230408075340.25237-1-wedsonaf@gmail.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

Rust cannot call C macros, so it has its own macro to create a new lock
class when a spin lock is initialised. This new function allows Rust
code to pass the lock class it generates to the C implementation.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes

 include/linux/spinlock.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index be48f1cb1878..cdc92d095133 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -327,12 +327,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 
+static inline void spin_lock_init_with_key(spinlock_t *lock, const char *name,
+					   struct lock_class_key *key)
+{
+	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
+}
+
 # define spin_lock_init(lock)					\
 do {								\
 	static struct lock_class_key __key;			\
 								\
-	__raw_spin_lock_init(spinlock_check(lock),		\
-			     #lock, &__key, LD_WAIT_CONFIG);	\
+	spin_lock_init_with_key(lock, #lock, &__key);		\
 } while (0)
 
 #else
-- 
2.34.1

