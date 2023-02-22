Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9A69ED0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjBVCur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBVCun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:50:43 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059B3402F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:50:33 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id be35so6411069oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3FFCt8YZaicmHfmZj/AGkoStrLtSljRIrqwUwWfE5Q=;
        b=LzbueKS5dUxi8UhgObjgBGQVM9xmvQd2mEA7vYiMJSFq18paUoO6/etb3yX0X1SCn5
         2i3I77KPWazwbo/9u9ZSzdms8MNt845ZGDSq8/zWIzeUOafT1u2/Fsgca//TqVlluev4
         kRWM8PBoncAtPQu/M2bSAE0MujWHlqcOJBVv92jZSR8unTOXGXhdOHxKmTNHCFW2G0Xr
         VhkfsxReW4dgFDGZrr7epgr/3Swku8xqUv1rtCcgwlSnwFCuSa1CgeBKdLT+KKXlZYBR
         ZjpEU5r0iKDvrKp7pU6N7oqfqcKMs+3tS0i7W1pKf4IdYczGqC2sfpfmb/fNYBsgq2ws
         20Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3FFCt8YZaicmHfmZj/AGkoStrLtSljRIrqwUwWfE5Q=;
        b=HUbPCw1BgVbcFboC6Rpbqr6Ve0j+G5LBNLm0GO3bVXMSZkT0wzByBCXNX2M2JJpGQK
         hmMsxlZJzXYOANb9+Voj9SFmstxRb01QSdDrMrmkZrYCnArrsBcwGHTtorsToh6HIvpI
         VgO8oBt38OYodm4dvNs7ZHF2WBuLVMHhcSWoJuzETsgGHZf3T5ICN0LdhFPXaydX6Xbi
         p9QSXdh7ESFlv6L0cwGrGjC7uU9LYShc6gMAYMQ4fxL454hLRc2Mnatr7dQjUWq3cZSZ
         6K+BbOiPqArFDxjCQFz0Vk5QuXvvAvd4vLKm0TsKhRoaYKzJoFXhZNratjxj7diGc0ZY
         +D+Q==
X-Gm-Message-State: AO0yUKX0j4vE3VV3pSUfkDPxx3e1MXDQBki9edCNcQU3jk54dB2CooNK
        eyKXdIvC9p59YB9KNGRcJ5I=
X-Google-Smtp-Source: AK7set/kFB+K3t5utsTeZa2jYSy11RX9Oh54PT1UbsJcbnblK7NKt5QvARs1M9lbIdjBY/pCkMEU9A==
X-Received: by 2002:a05:6808:e8a:b0:37e:9955:3e16 with SMTP id k10-20020a0568080e8a00b0037e99553e16mr5897465oil.25.1677034232783;
        Tue, 21 Feb 2023 18:50:32 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id m132-20020acabc8a000000b0037880fdb1f6sm1009627oif.24.2023.02.21.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 18:50:32 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jeremy Kerr <jk@ozlabs.org>, Jakub Kicinski <kuba@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH 1/2] sched/topology: introduce node_has_cpus() macro
Date:   Tue, 21 Feb 2023 18:50:28 -0800
Message-Id: <20230222025029.453834-1-yury.norov@gmail.com>
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

Currently, to check if NUMA node has CPUs, one has to use the
nr_cpus_node() macro, which ends up with cpumask_weight. We can do it
better with cpumask_empty(), because the latter can potentially return
earlier - as soon as 1st set bit found.

This patch adds a node_has_cpus() macro to implement that.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/topology.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index fea32377f7c7..7e0d8f8f5a39 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -39,9 +39,11 @@
 #define nr_cpus_node(node) cpumask_weight(cpumask_of_node(node))
 #endif
 
+#define node_has_cpus(node) (!cpumask_empty(cpumask_of_node(node)))
+
 #define for_each_node_with_cpus(node)			\
 	for_each_online_node(node)			\
-		if (nr_cpus_node(node))
+		if (node_has_cpus(node))
 
 int arch_update_cpu_topology(void);
 
-- 
2.34.1

