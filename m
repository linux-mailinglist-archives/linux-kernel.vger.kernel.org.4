Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1666FC1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjEIIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjEIIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:36:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3D64217;
        Tue,  9 May 2023 01:36:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso10436923a12.0;
        Tue, 09 May 2023 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683621359; x=1686213359;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WY12/+GxrYuE6ZT7p+AVfSbRBwrZRvdjfIL9M7i5HM=;
        b=QT2z/op7Lqack6xreaSOyUZYU1BMlssDbGqPlRrhFCvvOPRJW56SCj/eKK89gc2ta0
         +2MUyVPqkys+omRFSclviFqTBASSEBO3yf4sHOqwlwiBwE8sI0mxpc02iZN7v/PNx7Tr
         3W7s6D6NVDFgurOaKt5xo01JD/pxX94XmxlsQf4DBVji0KCrlRbuZvcfK/snTbzaQgBr
         h7AnHkinJVQZDTRoD4ci1GoIUQZrpfdnlNvikrpWBwcPSP0OCvll3UDHAhA2O7dFElQy
         Oi2KZt5q07xDaX0rxYbcj1siVSuzAlCvLDO+6yKPbzR4rXPFFRad/FyAYD9GNPySYvEb
         Kk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683621359; x=1686213359;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WY12/+GxrYuE6ZT7p+AVfSbRBwrZRvdjfIL9M7i5HM=;
        b=Im4bpyYNbvytNJrPTS8lc6K9y0afRyPY/dY23jX3RWM7WoOYMobFQU6lZVDRPEhWOT
         3og/OD+1OUNre60ZAxNxaptpb1nFJfNzHYpeTZB5aradJsewfwtO3vK1BvbbW5RqUwLg
         WnXRhdrYi+CYBzBVAgL+39qVvQtITeyskh1lGhE7LmGwaK2Y/K2epL7v6gHsAwvD+mky
         zoc09VAZSFrKKbF+L+ao+24Iz8baucXiT8PBMhgygzXTS7BG57Bm/H9+Mwipfe/CVtpF
         3iEr3ZEbexnH6+zAfoXNpvBWrERpY4DNvh6JMkFnj4t7GRFW51wiI+7ydHrN0VxEFeCN
         bjYA==
X-Gm-Message-State: AC+VfDw4rjh00465R9ZsLAnJSUAYDfd6uJknTe6rGZGPp9gPjgqbr46d
        lw2hF7cpkyMv2aWjDVlZsU1UGQD6Xjw=
X-Google-Smtp-Source: ACHHUZ7C64+cxBG2eumDiQf6O7mnUOKrDkKwK2bveM4s4XIH7V8//1WBrSVg2RslWGvU5PJraH01Fg==
X-Received: by 2002:aa7:dc12:0:b0:506:9805:7b56 with SMTP id b18-20020aa7dc12000000b0050698057b56mr10734030edu.32.1683621359548;
        Tue, 09 May 2023 01:35:59 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:b892:8631:69c7:ec2c])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7db4a000000b005027d31615dsm482865edt.62.2023.05.09.01.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 01:35:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: make config ARM_PATCH_PHYS_VIRT visible with EXPERT
Date:   Tue,  9 May 2023 10:35:54 +0200
Message-Id: <20230509083554.21514-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
and just gives that intent a much better name. That has been clearly a good
and long overdue renaming, and it is clearly an improvement to the kernel
build configuration that has shown to help managing the kernel build
configuration in the last decade.

However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
open for future contributors to implement that intended semantics:

    A new CONFIG_EMBEDDED option is added that automatically selects
    CONFIG_EXPERT when enabled and can be used in the future to isolate
    options that should only be considered for embedded systems (RISC
    architectures, SLOB, etc).

Since then, this CONFIG_EMBEDDED implicitly had two purposes:

  - It can make even more options visible beyond what CONFIG_EXPERT makes
    visible. In other words, it may introduce another level of enabling the
    visibility of configuration options: always visible, visible with
    CONFIG_EXPERT and visible with CONFIG_EMBEDDED.

  - Set certain default values of some configurations differently,
    following the assumption that configuring a kernel build for an
    embedded system generally starts with a different set of default values
    compared to kernel builds for all other kind of systems.

Considering the first purpose, at the point in time where CONFIG_EMBEDDED
was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more options
become visible throughout all different menus for the kernel configuration.
Over the last decade, this has gradually increased, so that currently, with
CONFIG_EXPERT, roughly 170 more options become visible throughout all
different menus for the kernel configuration. In comparison, currently with
CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86,
one in arm, and five for the ChipIdea Highspeed Dual Role Controller.

As the numbers suggest, these two levels of enabling the visibility of even
more configuration options---beyond what CONFIG_EXPERT enables---never
evolved to a good solution in the last decade. In other words, this
additional level of visibility of configuration option with CONFIG_EMBEDDED
compared to CONFIG_EXPERT has since its introduction never become really
valuable. It requires quite some investigation to actually understand what
is additionally visible and it does not differ significantly in complexity
compared to just enabling CONFIG_EXPERT. This CONFIG_EMBEDDED---or any
other config to show more detailed options beyond CONFIG_EXPERT---is
unlikely to be valuable unless somebody puts significant effort in
identifying how such visibility options can be properly split and creating
clear criteria, when some config option is visible with CONFIG_EXPERT and
when some config option is visible only with some further option enabled
beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do. For now, it
is much more reasonable to simply make those additional seven options that
are visible with CONFIG_EMBEDDED visible with CONFIG_EXPERT, and then
remove CONFIG_EMBEDDED. If anyone spends significant effort in structuring
the visibility of config options, they may re-introduce suitable new config
options simply as they see fit.

Make the config ARM_PATCH_PHYS_VIRT visible when CONFIG_EXPERT is enabled.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..0456afcebabb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -247,7 +247,7 @@ config ARCH_MTD_XIP
 	bool
 
 config ARM_PATCH_PHYS_VIRT
-	bool "Patch physical to virtual translations at runtime" if EMBEDDED
+	bool "Patch physical to virtual translations at runtime" if EXPERT
 	default y
 	depends on MMU
 	help
-- 
2.17.1

