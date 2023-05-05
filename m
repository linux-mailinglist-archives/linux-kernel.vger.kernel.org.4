Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B66F7BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjEEDwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEEDwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:52:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371A11562
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 20:51:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QCGvr1fKVz4x3g;
        Fri,  5 May 2023 13:51:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683258712;
        bh=mVhP5af+O4pwjB4DNxiBtegJzD+t5vqxTNie3cd58II=;
        h=From:To:Cc:Subject:Date:From;
        b=YGAKJi/haN+xysLJd5BAil8L/L/+hwaBEmRB9E8upgP9LF0JoWDnkPvsu8h2VRrPE
         XnBegrFs6ewtA32QyJVeomyJvhhp9Ob8K3vFyil5OLtRNydWprDwoglTClkI/soP/w
         Bmppa8JvSFoqn05S04yL487C7wqFfFXN/NgLd1OKZQErGhk8IeUIoKHit5ZzcB0EB3
         NrRMnLlI23zd77LEisLdrRgnePMZd9j9q72bteCPqXESFDlkNk0ertVWfis6wgTk1r
         S0Hk8dHXLfc8LPhSyJOaJ2uHhr92Y/rSETFn+dr36EgrSPn2Dgi3nlS0utee6kHm74
         Nrxjn2rmFcaUg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     glider@google.com, elver@google.com, <akpm@linux-foundation.org>,
        zhangpeng.00@bytedance.com
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mm: kfence: Fix false positives on big endian
Date:   Fri,  5 May 2023 13:51:27 +1000
Message-Id: <20230505035127.195387-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1ba3cbf3ec3b ("mm: kfence: improve the performance of
__kfence_alloc() and __kfence_free()"), kfence reports failures in
random places at boot on big endian machines.

The problem is that the new KFENCE_CANARY_PATTERN_U64 encodes the
address of each byte in its value, so it needs to be byte swapped on big
endian machines.

The compiler is smart enough to do the le64_to_cpu() at compile time, so
there is no runtime overhead.

Fixes: 1ba3cbf3ec3b ("mm: kfence: improve the performance of __kfence_alloc() and __kfence_free()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 mm/kfence/kfence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 2aafc46a4aaf..392fb273e7bd 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -29,7 +29,7 @@
  * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
  * at a time instead of byte by byte to improve performance.
  */
-#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
+#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(le64_to_cpu(0x0706050403020100)))
 
 /* Maximum stack depth for reports. */
 #define KFENCE_STACK_DEPTH 64
-- 
2.40.1

