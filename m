Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9E717B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjEaJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjEaJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:09:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41EE58
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:09:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bad0f5d6a7dso10699684276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685524155; x=1688116155;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uDyUEUKWPkyh/YNSCkrScqS2AVFO7CTNEmU88s6Pdgk=;
        b=IDvx1FzI0zs8uomF/kYtxD5FQiXlgdcTWFeLWPSIgoNW+QgeAKm6njvIMJovu2Sz70
         g66SXYGQ3eUlS5rMixU7zaGHV9pdFknoG7XY4MvFFxwEVFZF1xznZm7tGSft5ICPRX+r
         OZEdaSr4LxdfMCZXXsXHlaY55zFdqeXmcb8ogZ05Z9QkGIkpatTc3d7ITMq3dZv1fbot
         Ob2vItvFSgI9vSODMQFQBgWEyN/zUlQXyXZAy5RN8xblQCv0h14kJXOzzEitjpmoOWmz
         uD13m7tTxjLkWL1CfCpNBr7eL1T0bhOS2ltLWbNaWdkRMhBJ9wHK+wYrKZT5SJ0mOOf4
         lfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524155; x=1688116155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDyUEUKWPkyh/YNSCkrScqS2AVFO7CTNEmU88s6Pdgk=;
        b=ZFws3rYWakFsLTSCnLffXbK+zhC39dpiQgaUnfmm5aIrGcBi+OWj+cJbhYRh58t/Te
         c3O8aq1FK0W1XdZ2eiO+sFNWn3batrdyosNkWMTZyekWKVrjkCgZgEgwgYb18Q2HEyBl
         f+g34qRZifoyZqeeJzD9VS15I33RG1N2NvEKtlE7jJUf4uxOUdkWt2nvB+C5i4kfovxK
         RfJogkYv7lvQRJDPNr//EYr89Eig32P+3GAysdKgRqYcBm1LeMcu0ZNg+ilB6CAorvfu
         q8tq9I21hrN0FRNvhF1qyCBo7btqlGtUOgC4FI13oiLO84JtADHV+IYsbGAguUR44oga
         qWvQ==
X-Gm-Message-State: AC+VfDwGYP7rgcqQb6pP2Rw/0pIPHmr3aYTF+qLniY0Q3amzC0+ywm3R
        1WlmhseXavd/6ceYzh08ZOIEqtNQu5HGIopX
X-Google-Smtp-Source: ACHHUZ7+Xbvza2uLLSegvbB8r3KcTVem9yNZ/3RS6DmqB+8K7xCD/VD6CUtf7VfnNc9h89fvFncI1VtVmA6e1bnG
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a25:818e:0:b0:ba8:736a:5bec with SMTP
 id p14-20020a25818e000000b00ba8736a5becmr3012561ybk.6.1685524155765; Wed, 31
 May 2023 02:09:15 -0700 (PDT)
Date:   Wed, 31 May 2023 09:09:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531090909.357047-1-ericchancf@google.com>
Subject: [PATCH v2] arm64: lockdep: enable checks for held locks when
 returning to userspace
From:   Eric Chan <ericchancf@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Chan <ericchancf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently arm64 doesn't use CONFIG_GENERIC_ENTRY and doesn't call
lockdep_sys_exit() when returning to userspace.
This means that lockdep won't check for held locks when
returning to userspace, which would be useful to detect kernel bugs.

Call lockdep_sys_exit() when returning to userspace,
enabling checking for held locks.

At the same time, rename arm64's prepare_exit_to_user_mode() to
exit_to_user_mode_prepare() to more clearly align with the naming
in the generic entry code.

Signed-off-by: Eric Chan <ericchancf@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/entry-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 3af3c01c93a6..9d6827201b6c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -126,7 +126,7 @@ static __always_inline void __exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long flags;
 
@@ -135,11 +135,13 @@ static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
 	flags = read_thread_flags();
 	if (unlikely(flags & _TIF_WORK_MASK))
 		do_notify_resume(regs, flags);
+
+	lockdep_sys_exit();
 }
 
 static __always_inline void exit_to_user_mode(struct pt_regs *regs)
 {
-	prepare_exit_to_user_mode(regs);
+	exit_to_user_mode_prepare(regs);
 	mte_check_tfsr_exit();
 	__exit_to_user_mode();
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog
V1 -> V2 : Revise the commit message to make it clearer and avoid any misleading information.

