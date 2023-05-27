Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1B7131B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbjE0BnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243813AbjE0Bmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC01E46
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64fbfe0d037so53750b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151748; x=1687743748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAUIzM0ipEZnJ+DKEACmhXTzJMTqgJKwduhWCKwpQIQ=;
        b=Q025PITc8JDv9dJTfN7tctFHTJNnpaJy29WWhsH2ZPNUoOboOZYviwhQysV0Gmhli6
         56fngg0HA+HuSP7ILjSstqS+Mhqo+R8NkGbp1+jpakojtJHDkgDTve7zASH3nWRB6R5B
         bOOBqThle1HJJLIUfe8O4ba5IMukCJE/7Qfis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151748; x=1687743748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAUIzM0ipEZnJ+DKEACmhXTzJMTqgJKwduhWCKwpQIQ=;
        b=eES/AkQDv52Gxi3Q36JSuNbevA7yc0RnSFBpI+9aQfA0oGIohxF396PaBos94Z+Lnt
         jAcUv8FKfMDhze6FrvlRoxxqV19ZGnj1XDUPWt1f7OeuYqhuGZQ/inC24silxpD0NdZR
         ebd6XL77QMmuzUCuzFrzGi+e/VpcXEGELHj52xhD57iuTF7+v2PJ5EKciqKs+rIKfeY/
         XzW+QLwtiRN5pWe8d5M4tyzCW7zY8zavLu0NnBxeP7J0qNeJS4aJzhPXVBwhcTsoV5Un
         VBogwcKMiTn8JtxEFa9Cja6TEVWmaYXjZtuAWrCG+xjqHcuOth+4caUMF2c2ns/bq5lA
         mjDA==
X-Gm-Message-State: AC+VfDw14Zu9JUhf0olJclianzjgBpB0bB3YtFQRg5OrzRA6blRwRf23
        oqdwjmNmwsiaMp3W3ElM0/QApw==
X-Google-Smtp-Source: ACHHUZ7CuB7PPQInlPEZH0k1cEJvxZtnt0cbbm9xAfq9bZv1LojzgB0/25WLra3jsMmghAsHAYATEg==
X-Received: by 2002:a05:6a20:7351:b0:105:3e47:7504 with SMTP id v17-20020a056a20735100b001053e477504mr902971pzc.11.1685151748589;
        Fri, 26 May 2023 18:42:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 07/10] watchdog/buddy: Don't copy the cpumask in watchdog_next_cpu()
Date:   Fri, 26 May 2023 18:41:37 -0700
Message-ID: <20230526184139.7.If466f9a2b50884cbf6a1d8ad05525a2c17069407@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to make a copy of the "watchdog_cpus" locally in
watchdog_next_cpu(). Making a copy wouldn't make things any more race
free and we're just reading the value so there's no need for a copy.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog_buddy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index 3ffc5f2ede5a..2ef88722c5e7 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -10,12 +10,11 @@ static cpumask_t __read_mostly watchdog_cpus;
 
 static unsigned int watchdog_next_cpu(unsigned int cpu)
 {
-	cpumask_t cpus = watchdog_cpus;
 	unsigned int next_cpu;
 
-	next_cpu = cpumask_next(cpu, &cpus);
+	next_cpu = cpumask_next(cpu, &watchdog_cpus);
 	if (next_cpu >= nr_cpu_ids)
-		next_cpu = cpumask_first(&cpus);
+		next_cpu = cpumask_first(&watchdog_cpus);
 
 	if (next_cpu == cpu)
 		return nr_cpu_ids;
-- 
2.41.0.rc0.172.g3f132b7071-goog

