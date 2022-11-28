Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6141863A555
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiK1Jp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1Jpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:45:47 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8319296
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:45:47 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id z3-20020a056402274300b0046b14f99390so1925066edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rXoOet1Rb1vO+RV0XEBtCtgaydxMI/engJANIwuECRQ=;
        b=s6w1xbIf2vlYUmSknr7oRraUB85nf4lYbLpqHtE7R/uCCqK/YnX+XJ9uS2gmJ6EfSy
         WC3rIcgYxlJav7Y0J/sxRNoZa4e7zOpW5Pab30yV6YSdxovSZhHEQa+NVRLP8hkETK4O
         6xWCrhsjeg4dEgQ2Uyr/UbXf2G5Ql3Tvr+GtnFm8cARQJPnSKqhRpB68cZ0zzU6hYpMI
         TDcudtbdB+cg27Z0lGhN4n88RSV9kqLIMMgDW5leYNMZG4GEDv1J/ZlQuk/hm3AAZjfE
         UYGRAKSaGz2kKfqLvXtVQaNO+vPQS76GptQqpktijCNM6SDr2GTU81PuaYL3NZ69Igxe
         O1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXoOet1Rb1vO+RV0XEBtCtgaydxMI/engJANIwuECRQ=;
        b=am05efrPv3mArzrHxVyGnRUIcvwhWDLMqGpAQiGcX+yYJBpCtWp0fdHGD80sgZy53F
         65BLxQ3WiVM0BWjiSpg+MQCvaQzACBwzFuU+che/ewqDfBQoaBCNE0D1ZILlIQUcRrpO
         HjLpFAQPabnZ7J2RJU/TARYPNyVXoqUZn3xQAKIiTelmXThWuM1+pvx93VHit4WxjU3E
         ikeq68INdUrpU4PkaA6ZUdkfzboQ6DMrkiCVXPeUGIGrNowYhuM7VgHkbcMbK8Bq/q8c
         U5jcw7YoV/57spVXoUP8vOs4C6mjgoJzYtnhYBhRbVA5fd06uvIuXaoZ4H8lHCPj4ya0
         D3KQ==
X-Gm-Message-State: ANoB5pmywXftS73WMC6d+ef1Zx8cqTlFXxjk5dgTcmlmxdEo1/XHIdom
        +9JnGXTia2s3x4RiWKt4dhEgtF6itiQ=
X-Google-Smtp-Source: AA0mqf5JjgMUAXNrjyuEcpH5yC8Dqz2bfrGhmUj8weFzLuPbv1iNyji1PfDPUp5njvuDbzAg0khDIxsb0Ro=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:dc07:26e3:1eb7:b279])
 (user=glider job=sendgmr) by 2002:aa7:de08:0:b0:46a:e4e0:8407 with SMTP id
 h8-20020aa7de08000000b0046ae4e08407mr10060697edv.36.1669628745543; Mon, 28
 Nov 2022 01:45:45 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:45:40 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128094541.2645890-1-glider@google.com>
Subject: [PATCH 1/2] lockdep: allow instrumenting lockdep.c with KMSAN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        elver@google.com, dvyukov@google.com, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep and KMSAN used to play badly together, causing deadlocks when
KMSAN instrumentation of lockdep.c called lockdep functions recursively.

Looks like this is no more the case, and a kernel can run (yet slower)
with both KMSAN and lockdep enabled.
This patch should fix false positives on wq_head->lock->dep_map, which
KMSAN used to consider uninitialized because of lockdep.c not being
instrumented.

Link: https://lore.kernel.org/lkml/Y3b9AAEKp2Vr3e6O@sol.localdomain/
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 kernel/locking/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index ea925731fa40f..0db4093d17b8a 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -7,7 +7,6 @@ obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
 # Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
 KCSAN_SANITIZE_lockdep.o := n
-KMSAN_SANITIZE_lockdep.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
-- 
2.38.1.584.g0f3c55d4c2-goog

