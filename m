Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52C5FE205
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJMSvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiJMSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457541517
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665686821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VBqJ4dzJjbnYynK7jkYTYjysfbRi2UUuxGT40j6Ev4=;
        b=bO0AtJSt49RUg3fghf9eKgPSfRuuBrAHb47oPBMDd2qItIX0AuzVeMrp32wtykSJumDYg+
        V5PE36mbWRJm0RJ4kKaMxiagpZOlPKgvNVE+SAw2OZJdBG4CO13bXSu3FRLPHvljkXqLOP
        OD05vAjnHqnS4QCsFLtKCg1M30vxaM0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-f-Y6KQlEPpWj25aVtK0HAg-1; Thu, 13 Oct 2022 14:40:56 -0400
X-MC-Unique: f-Y6KQlEPpWj25aVtK0HAg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13631a68551so1493048fac.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VBqJ4dzJjbnYynK7jkYTYjysfbRi2UUuxGT40j6Ev4=;
        b=ittnvjktDOz43Z6jeQGx0d4GGNvdI+1Pb0E6/c7oCIfIh+shDn8Xwg4/dMo/vKgSjJ
         +oQUFWtmP5TcWpSBvvpyYC0WsL8BfMOYUzG6b3wwLv6F4RmUOYh5sAeOi/1ySOByMiHS
         gPyzRdXnJaCPEdTkzDNceTr7Akq+Hpgoh0IwbOUJvByv7tmFzy6Ln7Y+bgtOnN4PXt5o
         PpMvham3tORMljiR7IfGBPgwrTREE0dccKJWOYV3U5nWOejvK0jI2J81e0nosT6nZ+W2
         HabgzWXe966iJr90BqAGp2avA1GIG6tZlkRcuenKibZuKRvYaqw2d5tzx8yENovW9Rz4
         0AAg==
X-Gm-Message-State: ACrzQf33aI3/LSD1KK8z0rqanW+a4i7o1PZnsM3AgD3MDGAQ+leyD3gk
        cHayFzPg3ol7ly8IlqHAixXBYFaJcb9guSxYKRygH/HfvwPpG171n9BjuvJOQbSogP1wityF6j1
        aH/BhkmVa7XmdRk4nqH2+j1XN
X-Received: by 2002:a05:6830:3152:b0:661:ceb9:9272 with SMTP id c18-20020a056830315200b00661ceb99272mr667842ots.149.1665686455893;
        Thu, 13 Oct 2022 11:40:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4nJIAmq9Hq+46Kh8sn9us3gulZMoSvouw/Iy6ORtvgE9Z/MyjjjsC/KzgV7OOt2CYFqnSHDA==
X-Received: by 2002:a05:6830:3152:b0:661:ceb9:9272 with SMTP id c18-20020a056830315200b00661ceb99272mr667806ots.149.1665686455653;
        Thu, 13 Oct 2022 11:40:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:9473:d360:c737:7c9c:d52b])
        by smtp.gmail.com with ESMTPSA id v13-20020a05683024ad00b006618ad77a63sm244521ots.74.2022.10.13.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:40:55 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Antoine Tenart <atenart@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wang Yufen <wangyufen@huawei.com>, mtosatti@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/4] sched/isolation: Fix style issues reported by checkpatch
Date:   Thu, 13 Oct 2022 15:40:26 -0300
Message-Id: <20221013184028.129486-2-leobras@redhat.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013184028.129486-1-leobras@redhat.com>
References: <20221013184028.129486-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/checkpatch.pl warns about:
- extern prototypes should be avoided in .h files
- Missing or malformed SPDX-License-Identifier tag in line 1

Fix those issues to avoid extra noise.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/sched/isolation.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed9..762701f295d1c 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_SCHED_ISOLATION_H
 #define _LINUX_SCHED_ISOLATION_H
 
@@ -20,12 +21,12 @@ enum hk_type {
 
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
-extern int housekeeping_any_cpu(enum hk_type type);
-extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
-extern bool housekeeping_enabled(enum hk_type type);
-extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
-extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
-extern void __init housekeeping_init(void);
+int housekeeping_any_cpu(enum hk_type type);
+const struct cpumask *housekeeping_cpumask(enum hk_type type);
+bool housekeeping_enabled(enum hk_type type);
+void housekeeping_affine(struct task_struct *t, enum hk_type type);
+bool housekeeping_test_cpu(int cpu, enum hk_type type);
+void __init housekeeping_init(void);
 
 #else
 
-- 
2.38.0

