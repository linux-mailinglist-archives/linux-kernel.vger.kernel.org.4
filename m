Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7540E7131A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbjE0Bmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbjE0Bmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B2E70
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d341bdedcso1167549b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151743; x=1687743743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYlDoP4hBUi1FEPJVk5SoicXju51KfuvgdrLi507k6g=;
        b=gGebBDgShZ+uN8dr+HtKBh/CQRIJdRl3JqouzIec7Inm884gWhnWsPBrktTgLBZqXK
         0Vn2L9wyjn0IxKnQRYUzz2PDRwxJ3dxbO49ReX7U7tQFaXawnlPxAsmZ8tisnLvHt2wy
         vVnzj/jVyWUESXQN92jj0oJ3Exaj1AaFGtAnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151743; x=1687743743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYlDoP4hBUi1FEPJVk5SoicXju51KfuvgdrLi507k6g=;
        b=kUA97JzeJyf64X7ZauuLptHl9yw7GS83h4gEh8L2fXOVdManQSBaTegX1802pUOdNm
         y2zcJqoN1Jx2brWucNIRJv1gnwxAVa4b1pvRYDwNMIvDahmA+fb42TpBAVaJ37pW2gC4
         7SQ4QUhNr02iVFyI20HZyXZkTPBs/WCaHv/aPTzePwoJGPz57YxCkPUXMYXjMPeAaln0
         W/2CWHNkT23+ARV+cY2yRG4GYUtvhxILkuYa4f3CO4aJW5zHa/B7HioXw1ZoHVRJUR1L
         BCdfg4ER0Ylo8DehauhrmCfUFaNASEfalFh40zcHdnlwfS9KrU3czkiGU5hXHRJv1wcr
         sVkA==
X-Gm-Message-State: AC+VfDyxXMTEH9fYe3ZkFwxQHMyjIo+0i1/NfujLtaDQTX9lsBX3GTaw
        q0basZXxXGgI8ngZnZGehaxYsJmHkNmSbxITs2I=
X-Google-Smtp-Source: ACHHUZ6PdCEKx9zc9UIjD6M27djXcRY5u4ncxaUOpt/n6iXeRwmVg57h5L9TsPisjROyLLUKXE2Imw==
X-Received: by 2002:a05:6a21:9985:b0:101:2ad0:1347 with SMTP id ve5-20020a056a21998500b001012ad01347mr1527991pzb.23.1685151743331;
        Fri, 26 May 2023 18:42:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:22 -0700 (PDT)
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
Subject: [PATCH 04/10] watchdog/hardlockup: In watchdog_hardlockup_check() use cpumask_copy()
Date:   Fri, 26 May 2023 18:41:34 -0700
Message-ID: <20230526184139.4.Iccee2d1ea19114dafb6553a854ea4d8ab2a3f25b@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("watchdog/hardlockup: add a "cpu" param to
watchdog_hardlockup_check()") we started using a cpumask to keep track
of which CPUs to backtrace. When setting up this cpumask, it's better
to use cpumask_copy() than to just copy the structure directly. Fix this.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/watchdog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 32dac8028753..85f4839b6faf 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -154,7 +154,9 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	 */
 	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
-		struct cpumask backtrace_mask = *cpu_online_mask;
+		struct cpumask backtrace_mask;
+
+		cpumask_copy(&backtrace_mask, cpu_online_mask);
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
-- 
2.41.0.rc0.172.g3f132b7071-goog

