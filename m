Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0696E6083
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjDRL6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjDRLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6769977D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D8A625F0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A8C433A1;
        Tue, 18 Apr 2023 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681818849;
        bh=IwyqCw0ZeRA4BYG/sIG8QCK/6HafSnbXWPI++Rremlc=;
        h=From:Date:Subject:To:Cc:From;
        b=HnV7Gg44KLdEPtO6NSa/XqBBiESq55Dum3jMjkpXMI9O7nRk9We5Rgo/MoFCdPyvI
         JWnWnbZQGpnI53fmf/120wytyjRBVXIxocsDWTcHxQ449S1rNE7j6fLdQiDT0DvfBN
         sKRjEFhrO0xM1AM7iVstceNC5N13OVkk4tlGhDZuNMHKGALxloBwPMHFCekA0Xju+m
         HKpIBtlo11JRgA8CQQCsoPL9Z1Zt0xb2TaqBDdfu9HrdLRXUmLuD44ChLz2iXa9cDV
         wcUn2DNc16EeY8sE/nqGAcg2HS/k+jchwXFz37jm20J/xST6+hewX8ln2sNecIatl4
         TnVCsi9DqdgWQ==
From:   Simon Horman <horms@kernel.org>
Date:   Tue, 18 Apr 2023 13:54:00 +0200
Subject: [PATCH] arm64: kexec: include reboot.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-arm64-kexec-include-reboot-v1-1-8453fd4fb3fb@kernel.org>
X-B4-Tracking: v=1; b=H4sIANeEPmQC/x2NzQrCMBAGX6Xs2cW0KW3xVcRDfr7aoCayqRIof
 XdTj8PAzEYZEpDp0mwk+IYcUqzQnhpyi4l3cPCVqVOdVn07sZHX0PMDBY5DdM+PBwtsSiu3A0b
 ltVbjpKkGrMlgKya65UjMSTiirGeXBId/C+ZQ/vPrbd9/exbtaYwAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include reboot.h in machine_kexec.c for declaration of
machine_crash_shutdown.

gcc-12 with W=1 reports:

 arch/arm64/kernel/machine_kexec.c:257:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
   257 | void machine_crash_shutdown(struct pt_regs *regs)

No functional changes intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 54f8e2d081c4..078910db77a4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/page-flags.h>
+#include <linux/reboot.h>
 #include <linux/set_memory.h>
 #include <linux/smp.h>
 

