Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC26DD1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDKFqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDKFqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:46:13 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D130C5;
        Mon, 10 Apr 2023 22:46:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id f14so23130228oiw.10;
        Mon, 10 Apr 2023 22:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681191968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMoguo+iBIICiLerFXdpd+JcayaULGRY+QPKRH6ebeo=;
        b=Vy0MDXVmlIUIX1TZ3HA4etUNBbauhNAB+kdihsmMwBX8Y17PAEDNf8npYjdk4om5df
         vreUWoEEYtyF0ulvNg7L0Tr+PAIMKpcHHGDMP0Z5wlcDl/hCzSEIKarx2WWmhV0TaArm
         EkhyoU40N7EAK5HNYmkkGOclOjq2WtzEXFjiVA/KQ5Y384dQm1eH4w742NnX+NUbNM8R
         TMIEtEcCO7NEY7rRQLIp8PdiV74u16QcfWMD0UnbqGWziY2/T0X/30GPmoDgEsc0zCQG
         3UAW1w8bpUvtTXNb9PKX0VQpJbqgOAzL44k3Fi5Ygl2i3DKllsjRXGcp834zGHT8xAqZ
         45FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMoguo+iBIICiLerFXdpd+JcayaULGRY+QPKRH6ebeo=;
        b=eYvrAaWuLD63uAF58Hmq1Fy/ku8R2408zl6pWslhcw0c6YOh0zxLDTiUvjjQwC0Z0W
         AJoKR7Ff8ZgdGAXj6LjyFO3bb+3BOeQAoKYCgCaNM3X4CvI1eqi8KWhlLGZhliznR/os
         OKOpoGRQos21j+QBxvG/dMnbh0fgX+bG8Gscn9xavqtTaCXCtMGAxRlCyZ8jOotacgct
         jqahvqHP/tgwFbzerDEq+69gTDQw3mV2+bRYg4b71ZV84KpllpqGXoqhkxtTs9fcxoKW
         OMU4OGYxTiHrm/pn942YKevfivbVsp+h6b4IzokmySBIUn/raw93YJ24IaWg7wL0I2QV
         1FjA==
X-Gm-Message-State: AAQBX9eowFFk55G75ht1Od5SqFaWbIESBSY0Nj5/JjUT9hrv6IKxYSUh
        NJhFzgAAMOQsdjbdG8VzcU0nq+PmjRw=
X-Google-Smtp-Source: AKy350acU+JT2prlVq/j3YJBkWwCyNGii41ooc2asBUAc36m8Gtlxh6Q95mnm8MKe67hZFl5ikej5g==
X-Received: by 2002:a05:6808:2117:b0:386:e510:db0 with SMTP id r23-20020a056808211700b00386e5100db0mr6242965oiw.44.1681191968444;
        Mon, 10 Apr 2023 22:46:08 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id z186-20020a4a49c3000000b005252d376caesm5440706ooa.22.2023.04.10.22.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:46:08 -0700 (PDT)
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
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v4 04/13] locking/spinlock: introduce spin_lock_init_with_key
Date:   Tue, 11 Apr 2023 02:45:34 -0300
Message-Id: <20230411054543.21278-4-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411054543.21278-1-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
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
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
v1 -> v2: No changes
v2 -> v3: No changes
v3 -> v4: No changes

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

