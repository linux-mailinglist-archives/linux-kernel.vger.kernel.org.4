Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C473163E83B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLADNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLADNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:13:45 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918754468
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:13:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669864422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SaM+GTjZfJmbOUpTQs/U3f0sQfHp+chDykvHNK7BLiw=;
        b=IZwlSd/J8MJXz1xM7v29XlDvNRe0dBF9l8WauEjLuiAGymi8UgKxrL3OPI5NdwUHj8qpCJ
        RdlJBBGFyaPyBd2I8u3KU5Pp321goHksPnA236HHaubHGxnaPeIogO3OoWtHR6TcaGV6US
        Zh+9GnZbrcxbt5JPwV08xXhvZBp21dM=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rmk+kernel@armlinux.org.uk, keescook@chromium.org,
        gregkh@linuxfoundation.org, Jason@zx2c4.com, djwong@kernel.org,
        ebiederm@xmission.com, thunder.leizhen@huawei.com, ardb@kernel.org,
        wangkefeng.wang@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] ARM: Remove redundant arch_cpu_idle_prepare()
Date:   Thu,  1 Dec 2022 11:13:06 +0800
Message-Id: <20221201031306.2782204-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_cpu_idle_prepare() was only called by cpu_startup_entry() and it is
just a wrapper for local_fiq_enable().

The local_fiq_enable() was already called before cpu_startup_entry().

So remove redundant arch_cpu_idle_prepare().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 arch/arm/kernel/process.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f811733a8fc5..e3f490ab95f4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -81,11 +81,6 @@ void arch_cpu_idle(void)
 	raw_local_irq_enable();
 }
 
-void arch_cpu_idle_prepare(void)
-{
-	local_fiq_enable();
-}
-
 void arch_cpu_idle_enter(void)
 {
 	ledtrig_cpu(CPU_LED_IDLE_START);
-- 
2.25.1

