Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B260EE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiJ0CyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiJ0CyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:54:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA9D127433
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:54:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so4909779pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 19:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alwOCN2lVugGQDo7bNzsNkCClF+obiVDxZ+DoG3doNQ=;
        b=49Yiz+j1vU0PQcTjF7/YjHEUuHZ26mEKUQQic96K13BQMOM+XGdvPXWYjJqb+z7n1b
         l8LAnPEf2VoH4z13zxXfMKHtPUIfzYBAP4AIVBVgDbpbrVy1qJy7fx/tqgWjsDh7c0Jb
         vVMhze9eZIVfJaedO9Bfcq2XiUQoNuV+j/EAmv4D96NX02vtW3B1aGRZ6L+9Zr2ltn3E
         3IdoDYMC3Lu7/l9mIqUYPX04EUi9pJv5+Nsb9lkpq2eqltTIC8fchbPDnoPCJWjeWXRu
         L5w+PSsb0gXIODEr4XqR/n9WvUv4myDyJtrkEbFTKwoATXien451oQFG3N2J5thvBpvs
         SCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alwOCN2lVugGQDo7bNzsNkCClF+obiVDxZ+DoG3doNQ=;
        b=L5t1YrhCgFrTGZlVxYTf2l+931juYoQqzF18gKAYmK6YaPC74lZe6L7xoZ1Jhggwin
         hEHj9k3A51QfZRTV0vKJe2sPGjw/MGc1By3dNFF/SEsTbp39N+KfY4bDGJu9eU0ndhYK
         1o6qbLbssyQ1JMNauV9L1QgP8WXCKHlBoBpv14EpuBcdmqoz2tN4t2svBWSzGlb8DyeD
         ywnYKOyUgOv2wVBtCLFkCDvCyKtkZ5UZJdqqR893Scsqu/cltyE0xQqc6mJ9QvfyDHxn
         y8k6eRb19NiktisPfdE9R8Rmotskf4/QqkTmjnnoSxbqEbgCNAERZBd8EErszcSnFgWN
         bS4A==
X-Gm-Message-State: ACrzQf3rR+agh0Htera23i0iDZe6+/pPyTmE5W1BKmA2Zi2nOPg7BMsf
        gULobaPUgI5dXdEzdcaDlYozkQ==
X-Google-Smtp-Source: AMsMyM46I1QvdBEYTxlVsfywzN2A+sbyVGRZkR1Yaa5nLihSh6wf45pCsKToOcIq6rHQKfHNnAeFOg==
X-Received: by 2002:a17:903:26ce:b0:186:9029:fa22 with SMTP id jg14-20020a17090326ce00b001869029fa22mr24082523plb.140.1666839243909;
        Wed, 26 Oct 2022 19:54:03 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id o1-20020aa79781000000b0056b6a22d6c9sm79783pfp.212.2022.10.26.19.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 19:54:03 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] sched/numa: use static_branch_inc/dec for sched_numa_balancing
Date:   Thu, 27 Oct 2022 10:53:01 +0800
Message-Id: <20221027025302.45766-2-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
References: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

per-process numa balancing use static_branch_inc/dec() to count
how many enables in sched_numa_balancing. So here must be converted
to inc/dec too.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 kernel/sched/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..43716d107d72 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4372,21 +4372,15 @@ DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
 
 int sysctl_numa_balancing_mode;
 
-static void __set_numabalancing_state(bool enabled)
-{
-	if (enabled)
-		static_branch_enable(&sched_numa_balancing);
-	else
-		static_branch_disable(&sched_numa_balancing);
-}
-
 void set_numabalancing_state(bool enabled)
 {
-	if (enabled)
+	if (enabled) {
 		sysctl_numa_balancing_mode = NUMA_BALANCING_NORMAL;
-	else
+		static_branch_enable(&sched_numa_balancing);
+	} else {
 		sysctl_numa_balancing_mode = NUMA_BALANCING_DISABLED;
-	__set_numabalancing_state(enabled);
+		static_branch_disable(&sched_numa_balancing);
+	}
 }
 
 #ifdef CONFIG_PROC_SYSCTL
@@ -4420,8 +4414,14 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
 		    (state & NUMA_BALANCING_MEMORY_TIERING))
 			reset_memory_tiering();
-		sysctl_numa_balancing_mode = state;
-		__set_numabalancing_state(state);
+		if (sysctl_numa_balancing_mode != state) {
+			if (state == NUMA_BALANCING_DISABLED)
+				static_branch_dec(&sched_numa_balancing);
+			else if (sysctl_numa_balancing_mode == NUMA_BALANCING_DISABLED)
+				static_branch_inc(&sched_numa_balancing);
+
+			sysctl_numa_balancing_mode = state;
+		}
 	}
 	return err;
 }
-- 
2.20.1

