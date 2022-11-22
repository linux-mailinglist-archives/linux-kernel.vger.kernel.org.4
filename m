Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2E633EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiKVOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiKVOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:14:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B72CE39;
        Tue, 22 Nov 2022 06:14:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o30so10825752wms.2;
        Tue, 22 Nov 2022 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a14RPlR4WzocN7pcji6vCght7gucx4JNI1zx9s6eY8g=;
        b=mOunQdWTUfcQkGDwPyUiTOqAiUBclPnjfakRR18S9Rp/73LXJHhpbEob7dG3AT71I7
         /ZWCgT+ev7rTqlwaPmCPgzpv1Y2TXBSmc54H029ZdTYbxHq4CB/7gFDBxSi27qVKMRL9
         85Uh/y3y26Dz24ahDSFtIFlX8jMUSRx7vzZnJ0M209gJOPoo3mpqwb0F48PKE0rnNfTL
         efpRb7+nUbirk0pyQ5JEdky8GFv1fJBd2uUyse4ydzqfDmAWgSulrHM4I+O2rQBzkteO
         hMOduwfTdJPAO8rj3nNnZhsrhsxwxq2nvFbOppT5itzio2+jgmEBmTtliTbKKJlucdTY
         Podw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a14RPlR4WzocN7pcji6vCght7gucx4JNI1zx9s6eY8g=;
        b=OOrAOcB8jLMMoaQr1zz5QvPRM7Te/5vZh/5rtxspN3Zs+GhrPISHIpVFXYsTUVnj+X
         Fpv0l5BHLp6A58QIBN2sVpLLsOXwlkOSAnMK77Ip026wdQerblnzM+wnbGzRNIUXlXYq
         Lu8YBjtVKywH9kDLCS0RhEnFcYabEvr4qWzStcPNM71m3rwCYE56bwOXOWZqoVw4B3Qb
         +767qwAbjNoH4mZekPuYo4qSBEvdZ7g/6MaEvsFj44GpA41lbNuYTF/1wQQ0TwS+Cz6L
         VpGi+fwMHEeg1ENNVSKFL2HWl4YBaFJRq+jjMFfRWKQUM14QKdQpjFAZe/2ePmYrlDwd
         ssOw==
X-Gm-Message-State: ANoB5plc6KbmalDvwdHr23wcWXmEoVrG4g9y3Vt9IEkgm+dhdTrgNSL1
        baqEXQJe3fqPF7eFOKUruMs=
X-Google-Smtp-Source: AA0mqf4rMNLyM2P7cFlrTcJpiA7QoSOmaY2mo45mjl+FkwhzZZORV6c9t/h9t8QRooLxyBHo3ktrzg==
X-Received: by 2002:a1c:7208:0:b0:3cf:6198:dd2f with SMTP id n8-20020a1c7208000000b003cf6198dd2fmr7382274wmc.119.1669126489116;
        Tue, 22 Nov 2022 06:14:49 -0800 (PST)
Received: from felia.fritz.box (200116b8267b3700c41d4e99e424db57.dip.versatel-1u1.de. [2001:16b8:267b:3700:c41d:4e99:e424:db57])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm24774664wms.5.2022.11.22.06.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:14:48 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clocksource: ingenic-ost: define pm functions properly in platform_driver struct
Date:   Tue, 22 Nov 2022 15:14:34 +0100
Message-Id: <20221122141434.30498-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx OST")
adds the struct platform_driver ingenic_ost_driver, with the definition of
pm functions under the non-existing config PM_SUSPEND, which means the
intended pm functions were never actually included in any build.

Since commit 7a82e97a11b9 ("PM: core: introduce pm_ptr() macro"), the
default pattern for platform_driver definitions is to use pm_ptr().
Assuming CONFIG_PM_SUSPEND really intended to mean CONFIG_PM (and not
CONFIG_PM_SLEEP), use pm_ptr() just as most other drivers do.

Fixes: ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx OST")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/clocksource/ingenic-ost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 06d25754e606..6b64731df15c 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -181,9 +181,7 @@ static const struct of_device_id ingenic_ost_of_match[] = {
 static struct platform_driver ingenic_ost_driver = {
 	.driver = {
 		.name = "ingenic-ost",
-#ifdef CONFIG_PM_SUSPEND
-		.pm = &ingenic_ost_pm_ops,
-#endif
+		.pm = pm_ptr(&ingenic_ost_pm_ops),
 		.of_match_table = ingenic_ost_of_match,
 	},
 };
-- 
2.17.1

