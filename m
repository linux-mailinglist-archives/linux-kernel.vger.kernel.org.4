Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1C6D8541
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjDERwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjDERwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:52:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2516591;
        Wed,  5 Apr 2023 10:51:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b19so27233463oib.7;
        Wed, 05 Apr 2023 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680717119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWfXCnCRLHGCdfIApvX9+B1Kyu8tR4YNh4ctx6G09S4=;
        b=Ka/svnAHZR+5faSaZQK9uR5ULlK+zzKrSaBtJLoNuMfsdOw62K8ztnFxbZ5NRtbVQF
         ul/Ju8isfNSoJoiVnkLcQGZ9VuOo6vWfcuFnwJkvlGOpsKn4pi/zHS7Djb4dxn5ywYBR
         UYwaItHimsDc4HSyx+7DYUyHP2kcC9sRClOjJPTknmW4mFoCeuK8mpb6B4yjljM/9N/F
         1Q9vZvaMxsj/7a/W7kzBnvKsAt1n4EaETqIQkzJ0JD8ncpRvcHE6aLBsPp1rj1z4z7Bx
         FJ+CRsDRm60NgahLiPMhD4Qk3xam8KHE162pHCjU3jieBlwiizeY7mF0Miw0VZepD2aM
         mAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWfXCnCRLHGCdfIApvX9+B1Kyu8tR4YNh4ctx6G09S4=;
        b=G1a61ZhOFZEWJ0vdnSR3K2/U5GoNDRY5aFF/LSIQThqJm5ldDzIinOBfVnN3ZVNAoo
         0ZCFKcPlasLQEpMXQWffmnDlMmaG68Q8kssnXGaka5kB3eFYqyzCxl9Pq6EUNHLtgMFr
         kQkARr6LXkxSbHm8QI5V8mwATbDxHTMf/DeH85mfjl2tZk7XUgdC3O3WQMuf2mfWY296
         qttj6gFZ0v7VFEzPe3IAiDiq/BLq/PgKTO9dhJYkg6CkqoqIg+yvWxxTMvAL6wgnF2IW
         O/eHGoi8sMGvcQdmlKyj9KdP7UFUVNMIOql309tb6hv5huCFAw2SzzNd15VjqkhjmLH0
         BLWw==
X-Gm-Message-State: AAQBX9df6QFP5/Rw+y1D3hG+hpwGBn6Mw368qCjmXENWu5JQAI56dVeI
        n4+XfEKCa6mYZ73Mz18OAL7HNsZw4W5nEg==
X-Google-Smtp-Source: AKy350YzX6Icrtup1yYz2iLwPUYBovhx2DqyQWPOSP0ACWT23HKiD5UanbvBSkCcU8tR+e08zCMitw==
X-Received: by 2002:a05:6808:2b02:b0:384:118f:f9c5 with SMTP id fe2-20020a0568082b0200b00384118ff9c5mr3120794oib.25.1680717118868;
        Wed, 05 Apr 2023 10:51:58 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id w185-20020aca62c2000000b003896e31867esm6604045oib.49.2023.04.05.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:51:58 -0700 (PDT)
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
Subject: [PATCH v2 04/13] locking/spinlock: introduce spin_lock_init_with_key
Date:   Wed,  5 Apr 2023 14:51:02 -0300
Message-Id: <20230405175111.5974-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405175111.5974-1-wedsonaf@gmail.com>
References: <20230405175111.5974-1-wedsonaf@gmail.com>
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

