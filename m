Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E060C981
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJYKJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiJYKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:08:59 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FCAD0CD6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:02:27 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id m18so2776365vka.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjcOdBz7+1s+SY2r8uPJdaB5l1xd98vivegT7WmsGzE=;
        b=uSml8+DnXdwQjFDu/31djurwZibknnkEBl0HfloAE435L9yijx8dYxLlvQivqhXScV
         h8hsofYyvULgKM+IrK5ydVpNk2DVBZWOvfe0dOoj5bpPFzmbV3vepj7d5Qt8wwhS1Zzo
         1W0glP4SH09ohTe+ZpDakMXVCo6TxCdx2q0M2gRDgTsJ08FXfEBJ1wpZf9V+uvwO6x2W
         lToztvWSBjLfQRKeQr+2+UEJI6Kb6NDH8nxwTJw5mTjDd/iG6tavzkeL7Ufw28RgKYdI
         f+MJmcCnHhl64lktXOa2tRzpI8O7seGSWpp3P+RnB0+dPQzUzfmeoO3nn0hgPpScNt05
         9pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjcOdBz7+1s+SY2r8uPJdaB5l1xd98vivegT7WmsGzE=;
        b=7qzJ+CipRE2Etgy4vnedEh4b/elLgkPnQ+CzRdcyB2yD8k1aMiMkAJFM4EGYOkQgvY
         k11LK0rqiEGmF6ZS/IlVp4TL2wBulOySm3mlau19NSb5TgJJlaO5M5HPVZWa65vKNkpQ
         Tx7niR9WIH6dzK+isMAtsISqRLFBraRT9xQGC5mqMR3/neIay1SNXq2t3knV09mKmS4/
         AGrnzY6wLPpygyYaoOcAgfF9tbKXdbwYOMWC/4/v31y0TK0y/sT+0qEJyDgx1bglT0K1
         q1RHCIF0pu74XMRxXaiwQzk5PyESH3ZuQqALT3+kdpDfPYLZrytj/pCF32MGmHf06h7B
         mUqw==
X-Gm-Message-State: ACrzQf3nxH48Hk4ZIVcVl4bZZX0arCJI738/0cPWHn0ciSNfbnVEf9PN
        yXAI7vtLpf+VI8Ct7XeRAvNd/TEt4UqB7g==
X-Google-Smtp-Source: AMsMyM5lGX2enYqCifLrbJt/SBNBsI/Lsd2ohDjqOo4h1cts463R0iTdtrUa1OmGWVr2s3/wWMQApg==
X-Received: by 2002:a17:902:ec83:b0:17c:afb3:d1ec with SMTP id x3-20020a170902ec8300b0017cafb3d1ecmr37607960plg.172.1666692135945;
        Tue, 25 Oct 2022 03:02:15 -0700 (PDT)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0017a018221e2sm962387plf.70.2022.10.25.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 03:02:15 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH] kretprobe events missing on 2-core KVM guest
Date:   Tue, 25 Oct 2022 18:01:17 +0800
Message-Id: <20221025100117.18667-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default value of maxactive is set as num_possible_cpus() for nonpreemptable
systems. For a 2-core system, only 2 kretprobe instances would be allocated
in default, then these 2 instances for execve kretprobe are very likely to
be used up with a pipelined command.

This patch increases the minimum of maxactive to 10.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3220b0a2fb4a..b781dee3f552 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2211,7 +2211,7 @@ int register_kretprobe(struct kretprobe *rp)
 #ifdef CONFIG_PREEMPTION
 		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
 #else
-		rp->maxactive = num_possible_cpus();
+		rp->maxactive = max_t(unsigned int, 10, num_possible_cpus());
 #endif
 	}
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
-- 
2.34.1

