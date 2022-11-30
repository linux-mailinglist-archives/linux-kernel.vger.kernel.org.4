Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1863DA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiK3QUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3QUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:20:21 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196A2B61A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:20:19 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso3681515wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e7aXnerOs81qEvUrhkJcE1R45f2KSaCBn6wkFjPKb+E=;
        b=m0vwX16TqEB4CoFMpCUL9QVzQnd31EsRH55uiPE7Vvc9IDMC0WfSj/YVs1Q5jjc9SU
         9J6vMT22Ba0EJbzjviX8PhqKa5B24+Tvg2DTtSW6B+qFw8tXHN7nabGV69R6yDg7xnps
         FK3lqBa129KX/S7XLocBeMdOMHg6bHdoQNRNwhj3I3sNWXrzS/SyrS0QD+RfLvgqiLkh
         RvrjWHxrmJcl5SQcsYB2djR1W3qNqltXspeAD1zG3/BRxhLed+NPkAGamLIMX6bw/7ql
         zK8qIeaQPVQkO74QlJgfANNpKLiZn0UrDvJeKbKe0ccKtyZk3sj3BUhpgI6B2JqRTvmQ
         8XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7aXnerOs81qEvUrhkJcE1R45f2KSaCBn6wkFjPKb+E=;
        b=BImvvqlT8qK7Orx9ZDniVFbUcG4mWCvdztTgE0BOIiRECzJX6jpyDnkxrqdgLRPtKi
         4jF04m8tSY9JuPVis/woy4wNE82ZgAtGjG5osgH/BouUu2CaDuiQdNe4kIbXFVattvf9
         nLHMDj/xtUfsv1ewzMswHNrdWpaSdW3BulWbNv8kgvvsFEXdeuN9uP6Lh6pDFRSpme7+
         K446M7DXXWgpAtA2xGZFxodbqRzlB+vkdOEsh4XLkrzzfpMmUKpZFkUNcPWl63x5/kBW
         XtFfyUwm9UFld92UMGSm7rYqxVLWyXjHVfrukWIGqVphxohBtZofwenVjQV2eNyQrw2g
         MlTA==
X-Gm-Message-State: ANoB5pnKUy7FtXKg7N9+ADPMoN/uJWEAOPn/BpF45reTcTqT4LfNAMW7
        jo2EzsXkfrAk0iz9L33/PbAh8c8=
X-Google-Smtp-Source: AA0mqf41Iqo1Xr4q/u4l0UTpEcPOH4dcv2oiqQGFjNnNGHT8V7/hmhjBp1rBvUhdxCKIQBtV5bUOVnw=
X-Received: from corndog.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:20e0])
 (user=spm job=sendgmr) by 2002:a05:6000:1108:b0:235:8867:50bf with SMTP id
 z8-20020a056000110800b00235886750bfmr28519161wrw.193.1669825217787; Wed, 30
 Nov 2022 08:20:17 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:19:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130161946.3254953-1-spm@google.com>
Subject: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
From:   Space Meyer <spm@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, kpsingh@kernel.org,
        Space Meyer <spm@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously this code assumed nothing would mess with current->state
between the set_current_state() and schedule(). However the call to
kvm_vcpu_check_block() in between might end up requiring locks or other
actions, which would change current->state. A similar pattern was
described in the "The problem with nested sleeping primitives" LWN
article[0].

[0] https://lwn.net/Articles/628628

Signed-off-by: Space Meyer <spm@google.com>
---
 virt/kvm/kvm_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fab4d37905785..64e10d73f2a92 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -32,6 +32,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/stat.h>
+#include <linux/wait.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 #include <linux/anon_inodes.h>
@@ -3426,6 +3427,7 @@ static int kvm_vcpu_check_block(struct kvm_vcpu *vcpu)
  */
 bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
+	DEFINE_WAIT_FUNC(vcpu_block_wait, woken_wake_function);
 	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
 	bool waited = false;
 
@@ -3437,13 +3439,11 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	preempt_enable();
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (kvm_vcpu_check_block(vcpu) < 0)
 			break;
 
 		waited = true;
-		schedule();
+		wait_woken(&vcpu_block_wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 	}
 
 	preempt_disable();
-- 
2.38.1.584.g0f3c55d4c2-goog

