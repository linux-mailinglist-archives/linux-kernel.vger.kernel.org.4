Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C813732E33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbjFPKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344634AbjFPK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABDD49D7;
        Fri, 16 Jun 2023 03:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0418E635C2;
        Fri, 16 Jun 2023 10:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64108C433C9;
        Fri, 16 Jun 2023 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911179;
        bh=/jy0jdXDEhOY3t3DIBzvRMyMooNFsh+AkjgnCmlVeMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTcNX5jfdQc9y9NWYht5nmJtzmBkgnwYQZ27VlZ17cXSQ0UHJ0say2s7zlirhqWzv
         r+TAJQrGQW/Fz5lolM3lzMn8yYmgZuHO1JDT7yqcJTlqNuAe5GVM3YL2/ZjPnm5BTj
         kwZPl2KnalKn/UcitheiY3UfxL01jCWjkz6Lk3xtFthQS8FTIInNOA6NTfCgsvOKFL
         8tLS84YGuOpCW3kabnw/YO5I6eWuyDS01scGb2mHazQRjj4X76zeDr/ZoRz3qRPcdw
         yrr+kWDpIIQDigIfIQtoVHNyU2YHoDuCDoCHtYyGTdLOXp8wn6xNPZjRVULTl38o/6
         zlupUoKO8Q2qA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, dave@stgolabs.net,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.3 28/30] tools/virtio: Fix arm64 ringtest compilation error
Date:   Fri, 16 Jun 2023 06:25:16 -0400
Message-Id: <20230616102521.673087-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102521.673087-1-sashal@kernel.org>
References: <20230616102521.673087-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

[ Upstream commit 57380fd1249b20ef772549af2c58ef57b21faba7 ]

Add cpu_relax() for arm64 instead of directly assert(), and add assert.h
header file. Also, add smp_wmb and smp_mb for arm64.

Compilation error as follows, avoid __always_inline undefined.

    $ make
    cc -Wall -pthread -O2 -ggdb -flto -fwhole-program -c -o ring.o ring.c
    In file included from ring.c:10:
    main.h: In function ‘busy_wait’:
    main.h:99:21: warning: implicit declaration of function ‘assert’
    [-Wimplicit-function-declaration]
    99 | #define cpu_relax() assert(0)
        |                     ^~~~~~
    main.h:107:17: note: in expansion of macro ‘cpu_relax’
    107 |                 cpu_relax();
        |                 ^~~~~~~~~
    main.h:12:1: note: ‘assert’ is defined in header ‘<assert.h>’; did you
    forget to ‘#include <assert.h>’?
    11 | #include <stdbool.h>
    +++ |+#include <assert.h>
    12 |
    main.h: At top level:
    main.h:143:23: error: expected ‘;’ before ‘void’
    143 | static __always_inline
        |                       ^
        |                       ;
    144 | void __read_once_size(const volatile void *p, void *res, int
    size)
        | ~~~~
    main.h:158:23: error: expected ‘;’ before ‘void’
    158 | static __always_inline void __write_once_size(volatile void *p,
    void *res, int size)
        |                       ^~~~~
        |                       ;
    make: *** [<builtin>: ring.o] Error 1

Signed-off-by: Rong Tao <rongtao@cestc.cn>
Message-Id: <tencent_F53E159DD7925174445D830DA19FACF44B07@qq.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/virtio/ringtest/main.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index b68920d527503..d18dd317e27f9 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -8,6 +8,7 @@
 #ifndef MAIN_H
 #define MAIN_H
 
+#include <assert.h>
 #include <stdbool.h>
 
 extern int param;
@@ -95,6 +96,8 @@ extern unsigned ring_size;
 #define cpu_relax() asm ("rep; nop" ::: "memory")
 #elif defined(__s390x__)
 #define cpu_relax() barrier()
+#elif defined(__aarch64__)
+#define cpu_relax() asm ("yield" ::: "memory")
 #else
 #define cpu_relax() assert(0)
 #endif
@@ -112,6 +115,8 @@ static inline void busy_wait(void)
 
 #if defined(__x86_64__) || defined(__i386__)
 #define smp_mb()     asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
+#elif defined(__aarch64__)
+#define smp_mb()     asm volatile("dmb ish" ::: "memory")
 #else
 /*
  * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
@@ -136,10 +141,16 @@ static inline void busy_wait(void)
 
 #if defined(__i386__) || defined(__x86_64__) || defined(__s390x__)
 #define smp_wmb() barrier()
+#elif defined(__aarch64__)
+#define smp_wmb() asm volatile("dmb ishst" ::: "memory")
 #else
 #define smp_wmb() smp_release()
 #endif
 
+#ifndef __always_inline
+#define __always_inline inline __attribute__((always_inline))
+#endif
+
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
-- 
2.39.2

