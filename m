Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5D6CFA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC3ElY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjC3ElG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:41:06 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9F55BF;
        Wed, 29 Mar 2023 21:41:00 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17786581fe1so18528617fac.10;
        Wed, 29 Mar 2023 21:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680151259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkdOS4IPS6lAQ/+/R/HSZz8UmvvCCFlzt5mrQlViXVE=;
        b=Ad+K/21HHHCmG+2LPPxPPbenT+S7mRF6t2x5naSZR5mN4ZY1Dfbmty4mIKdSUorQ6B
         4Lypn5IuRidd1Yt/9Znw1lk52fLWKw24w6uFA57h5pqqOltAD4/DCJBzH9QBMiln7ZNg
         Si/xtk0Z/DxYhzavwXU6THjgtbrqrdlOArErbhS03WXthgfqVQRbiv2dqDKGfgUiFyon
         CH3nY9Bqhx5h5KJEjQ9Nnc6PnCxd9CojFBGTgv5TV4bGhkR1FQtnwZ+9XX7jfl1f3EPb
         dNqb67hhHjfgY5Dpa1D3CMTlYg8RYDWo8zNe8prw7KuAidz5xsX67zz2cmHFqmXceCa0
         34hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkdOS4IPS6lAQ/+/R/HSZz8UmvvCCFlzt5mrQlViXVE=;
        b=Hr5dIAw5TJavasCdlg/ZPqXzqBAq/rxmXtp3Hz79R0DxTYy2NYoGnPmiVNtJorZ2g8
         17vhwPQjvNftJIk9JHEslvHafVyteJ5VAOjFJABH6fyOgvfa8IVnA6chfyMzGkw6YPfW
         /5AycIaH7c5UnIRqTNGuczeYLw6wGlvpehnNH6009bbJcHyCbOIW2KLVyb04U7PO9jhq
         LntUCOYTInTYUr9m4a0lwxbzHN+KPcBhgDcEq6uyt2/X0+Jopf5LQBHEOHUQmqpSmvWh
         NZT6pR6pgmIV36rEs/JrTkM8xtL4KHA2lNXAkVmpWq3UrXe+szJxlnegGwP/n0B6Qfts
         jREg==
X-Gm-Message-State: AO0yUKXngqOoOvH2WpdtdXI29mOBCVDqGcgvxX326cDUnPLwz4JEzz2m
        ePd9cAstGg/68qUQQ/cE8orct3uURqWnSw==
X-Google-Smtp-Source: AK7set8gqY6fdnkUDtRiVC2OATWOm2NkxDDBJyt0JQrb5SWF6837eHRcfsKPe3pNwPlaYSMkf+r3TA==
X-Received: by 2002:a05:6870:b006:b0:17a:d2e0:1a14 with SMTP id y6-20020a056870b00600b0017ad2e01a14mr13809272oae.27.1680151259564;
        Wed, 29 Mar 2023 21:40:59 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id ea43-20020a056870072b00b0017e0c13b29asm7518599oab.36.2023.03.29.21.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:40:59 -0700 (PDT)
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
Subject: [PATCH 04/13] locking/spinlock: introduce spin_lock_init_with_key
Date:   Thu, 30 Mar 2023 01:39:45 -0300
Message-Id: <20230330043954.562237-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330043954.562237-1-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
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

