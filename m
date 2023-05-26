Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C1271213B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbjEZHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbjEZHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:36:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706E710E9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:35:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae40dcdc18so3088895ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685086548; x=1687678548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKWBdp4Kjo2s7gwqdnwE3qAnKBZlQrDQ7Bhod2F0iec=;
        b=gq7rzjt3t/xc/7eKsys5HW5xi/ugBh+XpYqENlPCR35jv7yZFm4s7ACeAfsR8ZgZ75
         cREmmzeZlILrUfAxYs5br/wSOosq5qXbbv3FnLu+3Gl8HlgaO7BYPhDaYuiXQvxosJuq
         w2UHiHQlSkVqtn9VBIu8kKzw3hhA0oituZDRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685086548; x=1687678548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKWBdp4Kjo2s7gwqdnwE3qAnKBZlQrDQ7Bhod2F0iec=;
        b=aqKeN6gv1YjL6rNd3CupvK2LXiXQwvpTSwEad4rfJJysTfisEfca2fsuJ7oy6nQD4t
         xmUmQkaa6uSNeNuYFEnmwWXyvXaWwmwewY61YVnmaNgADUFXKxm3UsT0g/qc3awHEylY
         wz9w8hd2yl1cH+HhWYjfAI+X5noK1LmxNsSJAVc1JPyIYqNArE80okdP3KTVGvLpDL57
         s15cOFSmeburqRCf7F79RstUnkzWTECVQJIYUhfqP9C9fm0zWTrQYAllKCpR9SYp8PUO
         7SvqBsLPfGlfSCjFnfTzPdMPhGOcPE8GQhO9nsbri1dmceHA3i9MFADnDcLK182SHSIf
         397Q==
X-Gm-Message-State: AC+VfDzOaBbCDDL8r3s2RdlgYFwcUche8w3SszWyLdxlkL6qb2oViSA0
        Flj0waeaVcOxuHPdV3xXq57A7Q==
X-Google-Smtp-Source: ACHHUZ6XkkD79ZkO3r3SorwEcsePA+9D5knmrdE/cFs1f7idnHafQ1XWj/0tGGrGQ1suvVau5lting==
X-Received: by 2002:a17:903:228a:b0:1a2:3108:5cc9 with SMTP id b10-20020a170903228a00b001a231085cc9mr1674737plh.40.1685086548637;
        Fri, 26 May 2023 00:35:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:17b9:e0b5:a956:4510])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902eb0900b001ac78ac2cafsm2573408plb.239.2023.05.26.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:35:48 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] notifier: Initialize new struct srcu_usage field
Date:   Fri, 26 May 2023 15:35:37 +0800
Message-ID: <20230526073539.339203-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 95433f726301 ("srcu: Begin offloading srcu_struct fields to
srcu_update"), a new struct srcu_usage field was added, but was not
properly initialized. This led to a "spinlock bad magic" BUG when
the SRCU notifier was ever used. This was observed in the MediaTek
CCI devfreq driver on next-20230525. Trimmed stack trace as follows:

    BUG: spinlock bad magic on CPU#4, swapper/0/1
     lock: 0xffffff80ff529ac0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
    Call trace:
     spin_bug+0xa4/0xe8
     do_raw_spin_lock+0xec/0x120
     _raw_spin_lock_irqsave+0x78/0xb8
     synchronize_srcu+0x3c/0x168
     srcu_notifier_chain_unregister+0x5c/0xa0
     cpufreq_unregister_notifier+0x94/0xe0
     devfreq_passive_event_handler+0x7c/0x3e0
     devfreq_remove_device+0x48/0xe8

Add __SRCU_USAGE_INIT() to SRCU_NOTIFIER_INIT() so that srcu_usage gets
initialized properly.

Fixes: 95433f726301 ("srcu: Begin offloading srcu_struct fields to srcu_update")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

Also, the original patch subject said "srcu_update", however the data
structure ended up as "srcu_usage". Maybe that could be updated?

 include/linux/notifier.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 2aba75145144..86544707236a 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -106,12 +106,22 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 #define RAW_NOTIFIER_INIT(name)	{				\
 		.head = NULL }
 
+#ifdef CONFIG_TREE_SRCU
 #define SRCU_NOTIFIER_INIT(name, pcpu)				\
 	{							\
 		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
 		.head = NULL,					\
+		.srcuu = __SRCU_USAGE_INIT(name.srcuu),		\
 		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
 	}
+#else
+#define SRCU_NOTIFIER_INIT(name, pcpu)				\
+	{							\
+		.mutex = __MUTEX_INITIALIZER(name.mutex),	\
+		.head = NULL,					\
+		.srcu = __SRCU_STRUCT_INIT(name.srcu, name.srcuu, pcpu), \
+	}
+#endif
 
 #define ATOMIC_NOTIFIER_HEAD(name)				\
 	struct atomic_notifier_head name =			\
-- 
2.41.0.rc0.172.g3f132b7071-goog

