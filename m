Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADA62C64C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiKPRY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKPRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:24:56 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138AE8F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:24:55 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l127so19275739oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ/NNMLHh6LK64uKKJShKHUFvTe0JgGULNEASlEIi3A=;
        b=jxds8hNaZdLNi1CltrK0CVSZu86Kacb9hqeSixayCShiRoOOumvgeQbDDNISBtkv5I
         hp1oAR5oHr6cRNcEnhrKz9Ap0TOazSD2wBheWlDQfEHkpHiJMS3Lzu1bBF7JqnVZRoUe
         a10464xuSn3wtOPNhBcIVBQLlmvG/nl2vEhtVH8Ah95eC9wZH8DIn98iQf/Gs1o57Csl
         RKH0BRULyhBOJGMtHcoFK6cbDoKiC/wtfdQXI3feFCaPfmMwL4UHYLeui2AFJGGsUqu6
         JzLrSmeWGVnw3v1P95iprsTMeFkfGr1fRLSENp94cUmh6IeJvtqYRvWeesYg2UV9GC+e
         eKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJ/NNMLHh6LK64uKKJShKHUFvTe0JgGULNEASlEIi3A=;
        b=Ipk462yfKrH+xlu5nfHpC+ls+B+NIJZkS/xdSVjy0qMa1OArAsioC1NykE8n/PP/5w
         HQpe5ux97jptruTjWvDUUq6PRGyInZUSv+vWdwKCvC0tbgtzxsH3A1dUhnhAQDv4g6Eh
         5Kojb8BVkCTYNu20NgWpvXna6qzv4kRNs00BYqFBq2ZwNCtiWtYdHrIP1M0EdqnZ1le/
         JTK7BKqFA9vmddaDU30ulpyD3+oqfYIxpX0sppcRzf3pAcemq65ketLSwZiZ/tVcOpnb
         ThNVolDzQEV3ohqoB2QFctYBKNlRD/t1nAMP35Mk6k1egbDtb5o5TQz1/9OnspM93j0A
         qxBw==
X-Gm-Message-State: ANoB5pma2e5sFn79i+zTa9H7CkZ3f+B9+m4wuWwt9Io/7YpZTQ6/Oarm
        Kiz+m2oviVfE1jGnnDaJb5VOy5zp2eE=
X-Google-Smtp-Source: AA0mqf6x0P+spVNPz8rTIeeaJPCbospkvtqBgjlnb0a52j4hxSxzb/aublcphAVXio0gTL50jScGRg==
X-Received: by 2002:a05:6808:688:b0:354:e358:ad2c with SMTP id k8-20020a056808068800b00354e358ad2cmr2137577oig.130.1668619494333;
        Wed, 16 Nov 2022 09:24:54 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id z35-20020a4a9866000000b0049f5ce88583sm4597848ooi.7.2022.11.16.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 09:24:53 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3] cpumask: limit visibility of FORCE_NR_CPUS
Date:   Wed, 16 Nov 2022 09:24:51 -0800
Message-Id: <20221116172451.274938-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current form, FORCE_NR_CPUS is visible to all users building their
kernels, even not experts. It is also set in allmodconfig or allyesconfig,
which is not a correct behavior.

This patch fixes it. It also changes the parameter short description:
removes implementation details and highlights the effect of the change. 

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
v3: instead of 'choice', use !COMPILE_TEST to disable FORCE_NR_CPUS
    in all{yes,mod}config, as suggested by Linus.
 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9bbf8a4b2108..404647cd3fac 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -529,8 +529,8 @@ config CPUMASK_OFFSTACK
 	  stack overflow.
 
 config FORCE_NR_CPUS
-       bool "NR_CPUS is set to an actual number of CPUs"
-       depends on SMP
+       bool "Set number of CPUs at compile time"
+       depends on SMP && EXPERT && !COMPILE_TEST
        help
          Say Yes if you have NR_CPUS set to an actual number of possible
          CPUs in your system, not to a default value. This forces the core
-- 
2.34.1

