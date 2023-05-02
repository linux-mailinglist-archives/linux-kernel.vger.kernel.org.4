Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65C6F3B29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjEBAB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBABy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:01:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662343AA5;
        Mon,  1 May 2023 17:01:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso2240719b3a.0;
        Mon, 01 May 2023 17:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682985711; x=1685577711;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgRjL0UqIuB56pKOxHZ86ANrDObQS3AcyO9BsAqX6Gs=;
        b=ggzlmwVcHmxIyTRt8GPfp+r6Tp3lOGjn84JT6AWWsKm4Fmw3oHfXD0NzZKUlHbR6y+
         ZpTs/+E/neG0qLrjatysk7acCVHfZ027FehRwiYxgggmWeGOy53YZdiF9GlSKEdPhS3r
         6NJSQLF42uO6wn8oUUmPmdq5wFTjnj2onXbLuqzGnTwggUX/JMiSQnslo7Nbfr/WM7m5
         Ltt666L1IKK88OKlBsLemv6w734uJXKR5QoK0tRNsCcmm/Otzq6YxY3bFWsv7zrRmA3a
         8MLOWzEDX+bw590R7Wjbhj3YChXOmOzwFoGHyHTcgZj88OzVfYqXXdrsiAsp1EcsdYPQ
         1M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682985711; x=1685577711;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgRjL0UqIuB56pKOxHZ86ANrDObQS3AcyO9BsAqX6Gs=;
        b=HDy/H2MMzGx4mvAJce7HW8v4bHrQx80pHmCDDKtvPEOgs6MXxmZwtkBD2rk7QB+tNc
         WnWydY9DTz3Rew8qmb2vVOMu+1SYbZIYNP8zaV1gxwqtqx2fdeKLOpDbYkFOlByt/nlE
         etW5lbKNqgLtkiPxshRKsENBvn6hj2464oTwjVn9OU01ORGO4kVWV6khdoQR+TjfZAm7
         I1wcfZQeKdjlMwlG0fkxN7UoHQj/VjtqxTgwZ8J+Vie4SHeIFrI5W45UP9mXXBYLkTUl
         wXjbaSyBQJVTRsY4ArAR8a5GDUgy0DW+fRcfT1QuVhexEiPyBxHxCEsDeqpnbz4Wibbb
         bLbg==
X-Gm-Message-State: AC+VfDwbU0fzWfzznOyID2HZAKxEfyKLkwMSAcpu6aCbn8QYZwDew44L
        HfQqdZtVxmpJ/EbaxRF2+jw=
X-Google-Smtp-Source: ACHHUZ5I1cYQLgHCUYdaa02DXr79EgoIqXvmW94Aiud/N7kkZSWxVHq6BPemQdL2bB/+mlkg6fMeBA==
X-Received: by 2002:a05:6a00:10c4:b0:63d:2680:94dd with SMTP id d4-20020a056a0010c400b0063d268094ddmr20072920pfu.6.1682985711444;
        Mon, 01 May 2023 17:01:51 -0700 (PDT)
Received: from localhost.localdomain ([154.220.3.115])
        by smtp.gmail.com with ESMTPSA id t7-20020a656087000000b0050fa6546a45sm17511847pgu.6.2023.05.01.17.01.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 17:01:50 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
Date:   Tue,  2 May 2023 08:01:41 +0800
Message-Id: <1682985701-19914-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
if kfree_loops is too big. Replace wait_event with wait_event_idle
to avoid false positive.

Tested in the PPC VM of Open Source Lab of Oregon State University.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>    
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                    
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..d99c586939d1 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
+	wait_event_idle(shutdown_wq,
 		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
-- 
2.34.1

