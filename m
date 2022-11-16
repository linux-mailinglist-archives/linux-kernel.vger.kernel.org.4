Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B962BFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiKPNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiKPNiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:38:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA734429AA;
        Wed, 16 Nov 2022 05:38:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ft34so44045390ejc.12;
        Wed, 16 Nov 2022 05:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wIDFtoQcxM4v9BSbkXANKUxT6C+d890LN3a0zTsJxA=;
        b=Vr3x0gTvOeZDCKekWYV9fzA8t5IzU6556bd+oUIKmGCAYwjc4GLIlYpkxHKU0vti4h
         2zxxSV3A09jjeFsBVAMlhjk4ftpNNJ4qnbQwCO+rK0vIgmXHz9D4KqhUxw85jhDC0mMR
         eO157reViF9/Hg/c6tgdHtiecbTJw3YA4/ySoBAbm96hSahWOQWH0Fpu+WofM3HkhVHo
         oG24UOx5pPpOrlrCmCngtboRMTcG4mCHSHIj/RpiVhUCgAToGHIgVcKW1bj7v5cZE5/9
         uLSk/ZrcwTExiPKqYtcOCmyAlCRg3Hr+QlpSRuyjztIZQqh9DCW0FF86ELPdqZSl+64f
         evDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wIDFtoQcxM4v9BSbkXANKUxT6C+d890LN3a0zTsJxA=;
        b=vKo4019M5/8N1jAXmasiJNcwnI3U6GqrU2xObxwBBeo62bUqMMOPwYirK8G6TEHekp
         gKw9TMVXwZV4EchxfpD2VMXUvvWA8cJO1U+7efst6YCEma/Qof3FyIilDaFypQxIzAFJ
         1OxmCABlLDu8AMOoomXlWbnXe9G+QkTDUFz995642l2jS/ayNCAlojzoGDjVM9dkrBIw
         0qjPbDH/lmd0P2XdEtosFa6FZ1QFVE1ZJsGxjykEArw1ZTKNxnqsBxA59VkJf0n7i/3c
         q62hf+Ip8bbbP+Uc19vHnueqAIEa70+o2F5wwJxSKJ6g8shXeCZibSaeLHJx5jGCZDze
         B80A==
X-Gm-Message-State: ANoB5pm8QJJd/eBx316/bygKVe1stywDykewDttn54kWTv8iLuGyyKlF
        b78u4lqn1ciUOcUbk/UhwOc=
X-Google-Smtp-Source: AA0mqf6pqA6SMZnHgw4Ph5CBksVUnO0C2CJ2/eWeAQKHc9RvBitMa9WSOVlLbeDTf8kSJrqH0Z0tVA==
X-Received: by 2002:a17:907:6f17:b0:791:9801:e48a with SMTP id sy23-20020a1709076f1700b007919801e48amr16926157ejc.738.1668605893180;
        Wed, 16 Nov 2022 05:38:13 -0800 (PST)
Received: from felia.fritz.box (200116b826c55000c59461cca0b9a159.dip.versatel-1u1.de. [2001:16b8:26c5:5000:c594:61cc:a0b9:a159])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0078b03d57fa7sm6869628ejf.34.2022.11.16.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:38:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] x86: make config X86_FEATURE_NAMES visible with EXPERT
Date:   Wed, 16 Nov 2022 14:37:53 +0100
Message-Id: <20221116133753.5615-1-lukas.bulwahn@gmail.com>
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
the visibility of config options, they may re-introduce suitable new
config options simply as they see fit.

Make the config X86_FEATURE_NAMES visible when CONFIG_EXPERT is enabled.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v1:
  https://lore.kernel.org/lkml/20220908104337.11940-3-lukas.bulwahn@gmail.com/
v1 -> v2:
  - fixed some omitted words in the commit message
  - added tags from Masahiro-san and Arnd

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cef0107e4260..4555ca4601e3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -439,7 +439,7 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config X86_FEATURE_NAMES
-	bool "Processor feature human-readable names" if EMBEDDED
+	bool "Processor feature human-readable names" if EXPERT
 	default y
 	help
 	  This option compiles in a table of x86 feature bits and corresponding
-- 
2.17.1

