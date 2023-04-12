Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB46DFDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjDLSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDLSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:12 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F45740F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:11 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1842e8a8825so14801824fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325110; x=1683917110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI1QKnyB9mb6UAnZmBnXQzU2ONFlsltTDGtKyyUD28o=;
        b=OYyMovplh1Vk8gmeTpVI2bCmkYXiwH5ziby48r9n0AvhtcqaTm8fO/ndGn4OpgUHDb
         6sTNMGcYtsDrpzbMk+juJap0e2YXhwAdgK30G8fhDrq+Ua+541vkhpWMvJHXn7Gq+oC+
         rGjlZIy1jH9isHXk2Fv/ojCUXjV5VDmUNwGHAUpupqPOCMfGdAiJaYGOpYmHFQzskV6d
         s91+npBXcNNXBiEscdIykjowHr4UHgXPLO0iXt1CbtMx65AsAluR+ebGxIQ41ntIvd7S
         RywhwBrf2n8a0QgD3NKT7NF4U/MzMB9oViG0bjhmJveAiY6lFhFLMl3bNKeLqi1BACJk
         shDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325110; x=1683917110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI1QKnyB9mb6UAnZmBnXQzU2ONFlsltTDGtKyyUD28o=;
        b=MT8dJvcmpthqEIzN0Godw9KEBhcAQWkgmavPz3PQcPXuzxabTysoMbx0/8gAs63xej
         yP/6qM+AMMSYt2ENQSmjZi9vLrigMHAUBxRBvX35gMM7Iw8o0ejlZtKniR3p4uiG9Dsi
         qRRhYApHZ1vRHPD/YG13yROJPj31ndn7aHF6plnl9W2e2k0GFdc+U5tsa4v/GYQre4v5
         FCVvGrLbbbG0YTJXnPyP/pbtIV52YTevy/n5fWZY3Fz9rhILshiunDsw7DeJK0SLYbRf
         QhAmQoJr00oFc5YdRPcjSj46fB6uQa93KBvT2AjruwbG9Xs4gSKk5DTCe+owWWHGOAfm
         2FLw==
X-Gm-Message-State: AAQBX9eRO/98huTdnN2f/zAtAQYd89DzdaGqo1eBLyRv2GfVMJMTtlgN
        uQPYCzQs556VysY8VlMHSIZaT0DrcA==
X-Google-Smtp-Source: AKy350YX8yN8Syqj1ygwYeBSrMgOAmJalJlrS06q44scCicfTaqUNcvX+RlfVNhHq8rFZRD0VYisPg==
X-Received: by 2002:a05:6870:40cc:b0:177:b9d3:c028 with SMTP id l12-20020a05687040cc00b00177b9d3c028mr7724458oal.12.1681325110388;
        Wed, 12 Apr 2023 11:45:10 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:10 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 1/6] x86/boot: Move sanitize_boot_params()
Date:   Wed, 12 Apr 2023 14:44:57 -0400
Message-Id: <20230412184502.145289-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412184502.145289-1-brgerst@gmail.com>
References: <20230412184502.145289-1-brgerst@gmail.com>
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

sanitize_boot_params() contains a static table that would need to be
addressed in a PIC manner if it were executed early in the boot process
while using the identity-mapped page tables.  Separate it from
copy_bootdata().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/head64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 387e4b12e823..4a3b195c9002 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -455,7 +455,6 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_map_bootdata(real_mode_data);
 
 	memcpy(&boot_params, real_mode_data, sizeof(boot_params));
-	sanitize_boot_params(&boot_params);
 	cmd_line_ptr = get_cmd_line_ptr();
 	if (cmd_line_ptr) {
 		command_line = __va(cmd_line_ptr);
@@ -543,6 +542,8 @@ void __init x86_64_start_reservations(char *real_mode_data)
 	if (!boot_params.hdr.version)
 		copy_bootdata(__va(real_mode_data));
 
+	sanitize_boot_params(&boot_params);
+
 	x86_early_init_platform_quirks();
 
 	switch (boot_params.hdr.hardware_subarch) {
-- 
2.39.2

