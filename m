Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5776FC9CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjEIPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjEIPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:03:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E630126AF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:03:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so11650076a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683644584; x=1686236584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46sFLqQARW3IRka2wIs9+b0QgXDTHZ4c0a8iYuva5as=;
        b=Wh+N/EPo5Q2lusjsLbbBW5M8V1bRio5DAOMldUnmGXDdfE7Va8Kg1eQLtM0moeTEAU
         Cg/RYaT6oriq8V4i5jKHvZ+Ew2LA1k7dXkxY6GbXL/k36CTmg8n/yPhSeZ1mLGycxe2D
         1CIpeF6I+Vs8mPtjJOggrMDzVAPSGieM8lqf0YK4JnPmtwU9S8+XzKJsLLfy94RNlQt5
         lBs2RbX8gl7QcyajscKQMcIQPzzqMYdPw4SV3ej5B8tkzuR9pWFu4H6uPswP+kDvrbAx
         ahGtNqYo3emb5yQi+iJjJEw3UphmQpOn0SRiV3OhFDy6EUXf6oS+KGEnQliwwCM9v6qt
         n9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644584; x=1686236584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46sFLqQARW3IRka2wIs9+b0QgXDTHZ4c0a8iYuva5as=;
        b=Zv3e3iNXWh/CA0d5t6VC9JFPNsu1eAtcX5h0oGFEVGM/+Uhl5I42ieuZcNaVxJT4HL
         56599cSXWQ4A+85mDtbXQ89Z3S7yKu1r7M9FSEjEaHDkWBMoklNTKES0HPxhBzmRzTqf
         B2eZhkV+IJ7LKBuG4Qdq086l4SdufTkcqRjKACelS+WeOq8mFeI4aNcV92RmFfmtartg
         dlAE6e+QdVMF2PxWouUW8bMCvjZzgfD2/8Ml75lo06Fo2s37i4mMBPfILznKOphCCvNc
         CU/rtEZ78exRhMF9cD3iO0xdiDU8xlIVP/t4liw1EjUuGbIFVvCAdMQysqFfXNBUzlmD
         w2mg==
X-Gm-Message-State: AC+VfDxlG6Vl6QrI8SYHf3Csp8QF911AdTASG/gebA/mK+JqFxCAB/ds
        ued9lZY3y8efaCS9SLYx0ErD7tUknCkxTQ==
X-Google-Smtp-Source: ACHHUZ5tFwLwic0BFEWx7AT/H4VbUWvqtTSRFQGMlfYvKW14MRN4WHNB/twhk3aw2C0luPKqgM9hTQ==
X-Received: by 2002:a17:906:db08:b0:965:fa80:bf1 with SMTP id xj8-20020a170906db0800b00965fa800bf1mr11672958ejb.32.1683644583918;
        Tue, 09 May 2023 08:03:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0094f5179540fsm1401749ejc.83.2023.05.09.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:03:03 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] atomics: Use atomic_try_cmpxchg_release in rcuref_put_slowpath()
Date:   Tue,  9 May 2023 17:02:55 +0200
Message-Id: <20230509150255.3691-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in rcuref_put_slowpath(). 86 CMPXCHG instruction returns success in
ZF flag, so this change saves a compare after cmpxchg.  Additionaly,
the compiler reorders some code blocks to follow likely/unlikely
annotations in the atomic_try_cmpxchg macro, improving the code from

  9a:	f0 0f b1 0b          	lock cmpxchg %ecx,(%rbx)
  9e:	83 f8 ff             	cmp    $0xffffffff,%eax
  a1:	74 04                	je     a7 <rcuref_put_slowpath+0x27>
  a3:	31 c0                	xor    %eax,%eax

to

  9a:	f0 0f b1 0b          	lock cmpxchg %ecx,(%rbx)
  9e:	75 4c                	jne    ec <rcuref_put_slowpath+0x6c>
  a0:	b0 01                	mov    $0x1,%al

No functional change intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 lib/rcuref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rcuref.c b/lib/rcuref.c
index 5ec00a4a64d1..97f300eca927 100644
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -248,7 +248,7 @@ bool rcuref_put_slowpath(rcuref_t *ref)
 		 * require a retry. If this fails the caller is not
 		 * allowed to deconstruct the object.
 		 */
-		if (atomic_cmpxchg_release(&ref->refcnt, RCUREF_NOREF, RCUREF_DEAD) != RCUREF_NOREF)
+		if (!atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD))
 			return false;
 
 		/*
-- 
2.40.1

