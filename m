Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD97622169
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiKIBrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:47:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D3627C4;
        Tue,  8 Nov 2022 17:47:33 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so510097pjk.2;
        Tue, 08 Nov 2022 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFiQ8yrjAlu5znJjGKWnW7N78yY9mCgalJ70ibzG+ng=;
        b=oCh9xJ9oUKKILoRe5QDlFP54kKTfklbomAYRLGMq9JZosnmEb3/63FkNJ1FQoEMtsh
         Wrp/BB0+uHZjVR59x+5BrwuSAWI8GsxvloqqNQtBqTnWcCi1Z2lJFT3TkKjYtHZc2rd8
         TVJopvWQi5VSzvOiQLFti098ESk4tvS+m6Msy8L+M8xFkvp24omusHsF0aMHYVMuX6tr
         Lsg/PgSWPisnKTIDajNwVgMPJB7PGOxoMovrHzyI9hhsu0rCVl3UKx6veQlmnyOhQawD
         /u8A8i85p7d8/QqBYtHUyG+dZqpokD4xLreaIjwqFslkh0MPzcozYjXIh5dMtgkFV23n
         8Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFiQ8yrjAlu5znJjGKWnW7N78yY9mCgalJ70ibzG+ng=;
        b=K4EulCPLATVngqNO817uqFS9vvDo+KbR+XDbM4mY3QSbpzzo/Rou1C4HQcVjsTLSeL
         AXmKXI5su0Gnygowxtxt/J1IeEk3td/TXZ8nHXhlViXuiCAp+eawJxLOos+MUZ6DRgDM
         q1B1iViq/rfnkNapUI9cHo5M4nj3w+eYtHvlkJB4uMmkQ3aX+pXvwikXyJMDcxELyzp7
         tszLMnJ5GHr6lOAYPcy9S/UX1os6GPxKgUnW1Vues3QoLzbKFcVEY1k51YITmYrkjTEe
         eUQMivMLh8auRb+DIYKajgAgqaJko84GF4IUCos67tOP1XpAdcD7CUivYcGQCFye+zam
         1gkw==
X-Gm-Message-State: ACrzQf1z9vzA8+ZZs75P4eJNum9NlHGIx78tVrnPxE+FiGqphjA6lGQV
        3gwDbQZ3euGErLMaxSh4InQ=
X-Google-Smtp-Source: AMsMyM6UqZa83zJujrnKHC7JbTzJ9UswKPa4PYCmrh7ZZB9x/ofQrmMFZjXxbjS+NZx7WWsvqdGGAQ==
X-Received: by 2002:a17:903:2c2:b0:182:df88:e6d3 with SMTP id s2-20020a17090302c200b00182df88e6d3mr58216653plk.81.1667958453283;
        Tue, 08 Nov 2022 17:47:33 -0800 (PST)
Received: from localhost.localdomain ([114.242.248.205])
        by smtp.gmail.com with ESMTPSA id y123-20020a623281000000b0056bb4dc8164sm6992779pfy.193.2022.11.08.17.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 17:47:32 -0800 (PST)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next][RFC]powerpc: move pseries interrupt cleanup code to under __cpu_disable
Date:   Wed,  9 Nov 2022 09:47:06 +0800
Message-Id: <20221109014706.10484-1-zhouzhouyi@gmail.com>
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

According to
Link: https://lore.kernel.org/lkml/20220914021528.15946-1-zhouzhouyi@gmail.com/T/
Link: https://lore.kernel.org/lkml/CN6WCMKCWHOG.LT2QV3910UJ2@bobo/

During the cpu offlining, the sub functions of xive_teardown_cpu will
call __lock_acquire when CONFIG_LOCKDEP=y. The latter function will
travel RCU protected list, so "WARNING: suspicious RCU usage" will be
triggered.

According to Documentation/core-api/cpu_hotplug.rst:
__cpu_disable should shut down the interrupt handler.

This patch move pseries interrupt cleanup code to under __cpu_disable.

RCU torture tested in ppc VM of Open Source Lab of Oregon State University,
by comparing the test results, our fix don't introduce new bugs and fixed
previous "WARNING: suspicious RCU usage" bugs.

Suggested-by: Nicholas Piggin <npiggin@gmail.com> 
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear PPC and RCU developers

I tries do move pseries interrupt cleanup code to under __cpu_disable.
During this process, I learn the XIVE interrupt controller architecture
by debugging the qemu virtual machine, and reading the following documents:
Link: https://www.qemu.org/docs/master/specs/ppc-spapr-xive.html
Link: https://www.qemu.org/docs/master/specs/ppc-xive.html
It is a fruitful journey, thank you for you guidance ;-)

I also tested the patch in ppc VM of Open Source Lab of Oregon
State University by invoking
tools/testing/selftests/rcutorture/bin/torture.sh

Thanks again
Zhouyi
--
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index e0a7ac5db15d..c7c86ea0a74d 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -62,12 +62,7 @@ static void pseries_cpu_offline_self(void)
 {
 	unsigned int hwcpu = hard_smp_processor_id();
 
-	local_irq_disable();
 	idle_task_exit();
-	if (xive_enabled())
-		xive_teardown_cpu();
-	else
-		xics_teardown_cpu();
 
 	unregister_slb_shadow(hwcpu);
 	rtas_stop_self();
@@ -96,3 +91,10 @@ static int pseries_cpu_disable(void)
 
 	cleanup_cpu_mmu_context();

+	local_irq_disable();
+
+	if (xive_enabled())
+		xive_teardown_cpu();
+	else
+		xics_teardown_cpu();
+
	return 0;
 }
 
-- 
2.25.1

