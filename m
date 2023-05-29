Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94A714598
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjE2Hi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjE2Hi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D279AC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3946615F7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C88EC433EF;
        Mon, 29 May 2023 07:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685345936;
        bh=2L03bJl1JvE9E9WzzUYTOxEyFHRi8LoxGv46OCU6JGg=;
        h=From:To:Cc:Subject:Date:From;
        b=SKYzK0tcInU/JLYLpz78c3bJNrLK2QLdpzE+WFK9GHt1celhAZScPSLWIFJVgwd1l
         G9+lOlTghfGaZT9Id0/EC+rUy0XsObm+b/treJk76pes14RNSoQ1QHNYGLIObb8tOd
         tzQi73cnRHq7djsnYoFzd8ZhhJzW2vBhRbPSfsOQ/GUi3qUQkIoowRTQ8KRTnb5SJF
         2aRxLsq6sMdOXqE73RvLxDw5RK6IOPaQpwooCc0DkKNMxmVFTR+eAgCjQXU4JnndzG
         Enve7ntYb4wC6V9aTc0mEtx/9ach7AynwYFY9p/K3i/yMFTt9jm6Izlhc6Xvqk2IK1
         7PsX/IvKAvMXQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, greentime.hu@sifive.com,
        vincent.chen@sifive.com, andy.chiu@sifive.com,
        paul.walmsley@sifive.com, palmer@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: vector: Fixup modules compile error
Date:   Mon, 29 May 2023 03:38:45 -0400
Message-Id: <20230529073845.2859178-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Some .ko also need the riscv_v_user_allowed symbol.

ERROR: modpost: "riscv_v_user_allowed" [arch/riscv/kvm/kvm.ko]
undefined!
make[3]: ***
[/home/guoren/source/kernel/linux/scripts/Makefile.modpost:136:
Module.symvers] Error 1

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/vector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 1c4ac821e008..3ae08816d608 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -129,6 +129,7 @@ bool riscv_v_user_allowed(void)
 {
 	return riscv_v_get_cur_ctrl(current) == PR_RISCV_V_VSTATE_CTRL_ON;
 }
+EXPORT_SYMBOL(riscv_v_user_allowed);
 
 bool riscv_v_first_use_handler(struct pt_regs *regs)
 {
-- 
2.36.1

