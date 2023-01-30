Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F2681630
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjA3QR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjA3QRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:17:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16732137
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:17:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 836021EC066E;
        Mon, 30 Jan 2023 17:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675095437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d83KcD8OBTU0320YA3XbPbLjBYW6teajmhjAa074RMo=;
        b=iI0mWQpjGGsIaO6s913P6m725ex127gGkwG0rhWVn0i4NN94QLBfTLtxlfFIG3M4T+eYUa
        unForHvyJmRf/yUM9bwIUxp9avfPIO67eYSUnzvvcdbtFYAwdm6jaububuVmcfhcGRJr1b
        MrL2M8Bu6C3lfV13XdcOljUq+MO5e4g=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] x86/microcode/core: Return an error only when necessary
Date:   Mon, 30 Jan 2023 17:17:09 +0100
Message-Id: <20230130161709.11615-5-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230130161709.11615-1-bp@alien8.de>
References: <20230130161709.11615-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Return an error from the late loading function which is run on each CPU
only when an error has actually been encountered during the update.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 931d3c3262ec..d52042d5faae 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -409,10 +409,10 @@ static int __reload_late(void *info)
 		goto wait_for_siblings;
 
 	if (err >= UCODE_NFOUND) {
-		if (err == UCODE_ERROR)
+		if (err == UCODE_ERROR) {
 			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-
-		ret = -1;
+			ret = -1;
+		}
 	}
 
 wait_for_siblings:
-- 
2.35.1

