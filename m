Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F36FC1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjEIIkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjEIIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:40:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59458A73;
        Tue,  9 May 2023 01:40:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965e93f915aso832178666b.2;
        Tue, 09 May 2023 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683621610; x=1686213610;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYoqIspga6VVNOgplfkhPgEKyUSoYEOyFaJeyHtCIVY=;
        b=A77DX7ZtfU7QIwGEFQSjIJesTCiBnNHx8wrqCC+fw4j0m3ZZeWDLZRS/OH/HZo/OoO
         ADIP+rovYCEJg4TLshImyx9xHZ6IYsVATXYdi4Wg9/EzlA8NETijV9V74XeSOPhPsqH7
         Bx0TNnvkfxwseeotB2JFyRZMyZ9WcM6A9O7iNuxhwi7gdIHmNiGVr4MEUj4CbN/bUh8Q
         dER1M2wjyiH7idl7dfPEC34GZgHgjHWMuvz3RHC3RIcsdnH76OZaz5IZwVeqhmmqQHcp
         zz5XmWhw22HqTSFJJkq+1qef6eKStN+8+zPu59/yDOi2LXNs8AcJ913dCnny9EG6CS/Q
         W39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683621610; x=1686213610;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYoqIspga6VVNOgplfkhPgEKyUSoYEOyFaJeyHtCIVY=;
        b=jN7oO3AsZnRVDO0kT5wkVNoFUoP3U1si4c+T/ZBihVFklT3U6sWmkrVbe6TBt5ALDq
         KprO515eLDmTvTruAuTtrU3u0fkZrKQd9DXgzN/oSZV+BhpB33O30blzs6Inmq0CVBuT
         E90Bou7p2ccjb9EhvI9W9Ek7yiZ7WxkIS0Tr4o7Q7DnQjOlSs8SHlBu7PdGUREnxcyuc
         ewCTD+DpUULOjX3D6wy61cG03wAXbQcK9Hu8nByHguYXqRtXBgLSgNAuXDC28qWNxR25
         Q1tItQfi/L1c91O+GELSuH1LrOJClbVfkMe3gVFq65w+ONNr2IGrp87leOaAZc/c9fcb
         h5ZQ==
X-Gm-Message-State: AC+VfDzytQEgICdA4yGOTCemlJN6347rWvoxRI8J/iezm+4iAJJ0uZaD
        2m4naSU3gTKZ034x4UoPqyQ=
X-Google-Smtp-Source: ACHHUZ6hd93FZWtWtg4ZJBvGGApThiqmx/hX5hZ9HWlOvaz6jcwkWlqtSy2ZX+qPpm4TQEMtHJRM0w==
X-Received: by 2002:a17:907:1c85:b0:94e:48ac:9a51 with SMTP id nb5-20020a1709071c8500b0094e48ac9a51mr12668621ejc.4.1683621609994;
        Tue, 09 May 2023 01:40:09 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:b892:8631:69c7:ec2c])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b0050d89daaa70sm501447edr.2.2023.05.09.01.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 01:40:09 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
Date:   Tue,  9 May 2023 10:40:07 +0200
Message-Id: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
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
the visibility of config options, they may re-introduce suitable new
config options simply as they see fit.

Make the config X86_FEATURE_NAMES visible when CONFIG_EXPERT is enabled.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ce460d6b4e25..595f6696281c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -442,7 +442,7 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config X86_FEATURE_NAMES
-	bool "Processor feature human-readable names" if EMBEDDED
+	bool "Processor feature human-readable names" if EXPERT
 	default y
 	help
 	  This option compiles in a table of x86 feature bits and corresponding
-- 
2.17.1

