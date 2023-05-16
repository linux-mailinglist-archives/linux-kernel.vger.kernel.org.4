Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6D7052CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjEPPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjEPPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEF903B;
        Tue, 16 May 2023 08:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE1B63BA0;
        Tue, 16 May 2023 15:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC25EC433A4;
        Tue, 16 May 2023 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252024;
        bh=ukkcZIi3rJQFXBZ+gAriRZey/Vj4dRVkg8uSR9+fmpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjYro4Jxqr2dc8uNfkbZR0YX17V/6dDi6Z2CqqKR6hDNo8Z/9tATqiR/kGvB/zI7L
         AC/NrRNyUUeR5MCHYu+8OKvpBW2ic6tGVm98MAOEgi+JJ2B3mHUHv8IwdgasHvPtet
         z0zGjoC/wdgfpqjgfgBV+X+UrHIrkvjwD4tL1KFgwGvVYp10z8VsW/C21iYUj3RdQI
         4+4iIMxm2jxDWTfPMmT7VuVQHoaeJTHHxn2vdg0tsuczx5LjPUZzJTQkKT74dOXRwP
         uhvWYhhj53dwW9OVJz1Vgp/0T6HFI9pWOpCC8CKtMIpd6FyVBv+lP56JnslHxHVBiX
         ZDLfw0lhn13bA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 13/16] ARM: vfp: add vfp_entry prototype
Date:   Tue, 16 May 2023 17:46:02 +0200
Message-Id: <20230516154605.517690-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

vfp_entry is only called from assembler code, so it does not
need a declaration. Since gcc complains when extra warnings
are enabled, add one anyway to avoid:

arch/arm/vfp/vfpmodule.c:657:17: warning: no previous prototype for function 'vfp_entry' [-Wmissing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/vfp/vfp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/vfp/vfp.h b/arch/arm/vfp/vfp.h
index 5cd6d5053271..10d9c0da0fd4 100644
--- a/arch/arm/vfp/vfp.h
+++ b/arch/arm/vfp/vfp.h
@@ -375,3 +375,6 @@ struct op {
 };
 
 asmlinkage void vfp_save_state(void *location, u32 fpexc);
+struct thread_info;
+asmlinkage void vfp_entry(u32 trigger, struct thread_info *ti, u32 resume_pc,
+			  u32 resume_return_address);
-- 
2.39.2

