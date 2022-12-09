Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ACC647ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLIHz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:55:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A65132E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:55:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BD64CE28AF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4385C433D2;
        Fri,  9 Dec 2022 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670572521;
        bh=wYIbLAR/5iF3vTBTzDgRe8zJ2RAJzzNQdh44OoznN6Y=;
        h=From:To:Cc:Subject:Date:From;
        b=FbwshvGCO+S/j9CBYvKhFYPuXKfqi3QPillGaior1K7Rwb/mNHfuUYLNoNwW4Vl2F
         teSxRGPx3jUraZ0dLrbUbVozHIsV2axKcnPzZusF3aqOGzz9IWi+0gvz1DugQBjIdv
         l4VR78w0mSpijn73+MXUNA6ZfMX/zd1y5mqt9Ot00uf8wkS7AXEcgx8DUXXWDNN1IC
         4DimXaytnVUZQmraPYtE+g1/SqisshrNLGgLJlLe3a+AeC1eXaP9JXiVvXHM4lGufb
         20SouKpa7qNMisv2zLoTQKa8TkVq6y/GYsvNInJnhxMXgIPQk9f/676PQAFX02K2Qr
         RmaJThyMijfOA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, conor.Dooley@microchip.com, guoren@kernel.org,
        heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        crash-utility@redhat.com, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V6 0/2] riscv: kexec: Fxiup crash_save percpu and
Date:   Fri,  9 Dec 2022 02:55:11 -0500
Message-Id: <20221209075513.532249-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current riscv kexec can't crash_save percpu states and disable
interrupts properly. The series fix them, make crash correct.

v6:
 - Fixup checkpatch.pl problems
 - Remove Fixes tags and make the series as features

v5:
https://lore.kernel.org/linux-riscv/20221020141603.2856206-1-guoren@kernel.org/
 - Remove the patch which isn't relate to riscv
 - Add fixup crash_smp_send_stop test result

v4:
https://lore.kernel.org/linux-riscv/20220921033134.3133319-1-guoren@kernel.org/
 - Add cpu_ops[cpu]->cpu_stop() in ipi_cpu_crash_stop
 - Wording optimization in comments

V3:
https://lore.kernel.org/linux-riscv/20220819025444.2121315-1-guoren@kernel.org/
 - Fixup compile problem with !SMP, which reported by lkp@intel.com
 - Cleanup declarations in asm/smp.h
 - Add reviewed-by

V2:
https://lore.kernel.org/linux-riscv/20220817161258.748836-1-guoren@kernel.org/
 - Add Fixes tags
 - Remove extern from bool smp_crash_stop_failed(void)

V1:
https://lore.kernel.org/linux-riscv/20220816012701.561435-1-guoren@kernel.org/

Guo Ren (2):
  riscv: kexec: EOI active and mask all interrupts in kexec crash path
  riscv: kexec: Make crash save multi harts' context

 arch/riscv/include/asm/smp.h      |  3 +
 arch/riscv/kernel/machine_kexec.c | 46 +++++++++++----
 arch/riscv/kernel/smp.c           | 97 ++++++++++++++++++++++++++++++-
 3 files changed, 133 insertions(+), 13 deletions(-)

-- 
2.36.1

