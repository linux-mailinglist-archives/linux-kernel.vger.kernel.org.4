Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B096C3FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCVBhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjCVBg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:36:59 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3745A92E;
        Tue, 21 Mar 2023 18:36:40 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h2so4609429iow.0;
        Tue, 21 Mar 2023 18:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679448993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAvSDTaQNCs+gy/ESSErpV55nInpY/nvxkb3Bc1Sf+Q=;
        b=YtkuE4e6GTaL+l4VQm0Go5MDVaO0GXT4CxCeRqw1liR/AdZVkzunI8FJAZEeFn4+t+
         AOQwLIsaD1NVe3WUoyWnNaqdEPu5hj7Bvji8FtIar4uEdZJ+ypHNwQ9uBmcr8LRuQSqA
         b//GoOac8z8vWIoqxV7jAyVN5y3OHtjdMaLSyCBiGguQhGCNCQT8O2xG6Q8gk2TGcmWd
         M9i7REryIqfVB42yQR+OV1lGanWak9kHGk1e/cT6cHvTQp8kiEfF3WXBQAWv++GunfQO
         GFNhMluh2zYkNtUXkhp0pfdt9jqApl/C940xoSBtJOGr+m/Vhvbdj59WztmiD5os8mn9
         o2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAvSDTaQNCs+gy/ESSErpV55nInpY/nvxkb3Bc1Sf+Q=;
        b=DO4gz2pLA9DndVgbAex5E88Rv1SG8q7Upy+bX426xZDxzOGlmRZSODbU8iPGGRIse7
         ubjKCTwzgJ/KDgvwr1m1gL8E9xx6V3GlYFddu4mLJglpktSyATxeWM7rL4kOjZnzmaCQ
         EI+ZH8Tu8/LY2yp+jdvqhmqDSxuuzhyloXJcIZh6XBM/IBTHBUH2Z6Cxxg4hO5SYI1LM
         v2UNaCCVWyVK7WSQxYJuOgDbWWOSXoMjVt7vY3NfIup1XOcNYycY1uWIKT9pSoV73Y/M
         TSQMAYGTUtA8UJY6iXeoWjdYnwMfaJ5dX8Z8DvD4DFSPZIdRxPksYg8aJQK54pNqXXI7
         +ZZg==
X-Gm-Message-State: AO0yUKVNrKjAUS396DzuY9HmlnAEBESnqRnPX4XUSVEienjrUbAIro29
        vD7BwCEewgNWcDBxybiSDrM=
X-Google-Smtp-Source: AK7set82++47bpRl1j35mFQOSt2xSoX7hdvw3hNOfmaXbJPdPb9L4B8EtdK9B4Wdn3EvyX+IZuis6A==
X-Received: by 2002:a6b:e704:0:b0:74c:b686:6227 with SMTP id b4-20020a6be704000000b0074cb6866227mr3355463ioh.14.1679448993133;
        Tue, 21 Mar 2023 18:36:33 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm3925058ioc.18.2023.03.21.18.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:36:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/4] module: in layout_sections, move_module: add the modname
Date:   Tue, 21 Mar 2023 19:36:20 -0600
Message-Id: <20230322013623.251401-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322013623.251401-1-jim.cromie@gmail.com>
References: <20230322013623.251401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

layout_sections() and move_module() each issue ~50 messages for each
module loaded.  Add mod-name into their 2 header lines, to help the
reader find his module.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index b4759f1695b7..39f267c40286 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1523,10 +1523,10 @@ static void layout_sections(struct module *mod, struct load_info *info)
 	for (i = 0; i < info->hdr->e_shnum; i++)
 		info->sechdrs[i].sh_entsize = ~0UL;
 
-	pr_debug("Core section allocation order:\n");
+	pr_debug("Core section allocation order for %s:\n", mod->name);
 	__layout_sections(mod, info, false);
 
-	pr_debug("Init section allocation order:\n");
+	pr_debug("Init section allocation order for %s:\n", mod->name);
 	__layout_sections(mod, info, true);
 }
 
@@ -2162,7 +2162,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	}
 
 	/* Transfer each section which specifies SHF_ALLOC */
-	pr_debug("final section addresses:\n");
+	pr_debug("Final section addresses for %s:\n", mod->name);
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
-- 
2.39.2

