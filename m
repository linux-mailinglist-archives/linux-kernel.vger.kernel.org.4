Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43060CCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiJYNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiJYNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:01:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C8F40018
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:00:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g12so11267781lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1vsiNiiwIzZazksMN4ViTwO/hUhf//I8PrPGoa++Tk=;
        b=GwA9tKkg3KqV61c5lfKLPKdG1DX5e/JvV06NDdkBtaVJKrU2f3E4dty4qvjdeOWzLn
         heO/scJkO15GIwW/G3uCUq+eS96D57e2vSdj8IxMrLLHYfVGS41NbgLG7iZNZELYgG6G
         V5ue9W7UI8aW1NSSeHUMMqYS9tB+wKCLumfd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1vsiNiiwIzZazksMN4ViTwO/hUhf//I8PrPGoa++Tk=;
        b=LrO4VpN8I8HLQcgCJJIrUfLYMZ21xwQHAx07gU3wHccQ35N7j/Li7x8A5NT6kbMVN5
         GlGEkyecmLBSR7uisxnBQrhpDjON0xiVwr0EgAwzTfLkXRKvdYojMIMZ1vEPXajWK2yb
         mtLUygU5yLs3uREB0f6SKxPLWceq48lQsB9u3Wnlb+6m7Yc7Cl3TvEGtWuybTPugWWr4
         d/xFvy7lb5rK+vCoGDptzN5idzn1YA6+rIfe/FJyhU/ZfuUAnxhb7pJWubDSpv59bERz
         AK3jX5xHpSL7Z+kwZcrP3dhIDmp/gJU8D32tkkvnu9ZDNiHu/euMB4Nsela9pRoSx9KF
         qQXA==
X-Gm-Message-State: ACrzQf3ARF18x4pWcXfQzcvfpqgJDcycuVL7tkstnUUQFkOYUOXVQ0au
        QI/c8vmd/JUpYhOnxdh/MbKlwQ==
X-Google-Smtp-Source: AMsMyM7Q2fXlsUL7oaT2JfPvfQdxLOGBb13Zb2izx5WUCdkga5xn+aQuIdqj2tDC7PQ/Yk9OWkJhuA==
X-Received: by 2002:a05:6512:b0e:b0:4ae:9d2:544e with SMTP id w14-20020a0565120b0e00b004ae09d2544emr993095lfu.461.1666702806226;
        Tue, 25 Oct 2022 06:00:06 -0700 (PDT)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b00497aae401edsm406722lfo.109.2022.10.25.06.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:00:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/params.c: defer most of param_sysfs_init() to late_initcall time
Date:   Tue, 25 Oct 2022 15:00:02 +0200
Message-Id: <20221025130003.1116366-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

param_sysfs_init(), and in particular param_sysfs_builtin() is rather
time-consuming; for my board, it currently takes about 30ms.

That amounts to about 3% of the time budget I have from U-Boot hands
over control to linux and linux must assume responsibility for keeping
the external watchdog happy.

We must still continue to initialize module_kset at subsys_initcall
time, since otherwise any request_module() would fail in
mod_sysfs_init(). However, the bulk of the work in
param_sysfs_builtin(), namely populating /sys/module/*/version and/or
/sys/module/*/parameters/ for builtin modules, can be deferred to
late_initcall time - there's no userspace yet anyway to observe
contents of /sys or the lack thereof.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

This is on top of
https://lore.kernel.org/lkml/20220929121039.702873-1-linux@rasmusvillemoes.dk/
which I think has been applied somewhere, but I can't yet find it in
linux-next.

 kernel/params.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 8d4e9a3f0df2..db524cf51231 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -953,7 +953,7 @@ struct kobj_type module_ktype = {
 };
 
 /*
- * param_sysfs_init - wrapper for built-in params support
+ * param_sysfs_init - create "module" kset
  */
 static int __init param_sysfs_init(void)
 {
@@ -964,11 +964,24 @@ static int __init param_sysfs_init(void)
 		return -ENOMEM;
 	}
 
+	return 0;
+}
+subsys_initcall(param_sysfs_init);
+
+/*
+ * param_sysfs_builtin_init - add sysfs version and parameter
+ * attributes for built-in modules
+ */
+static int __init param_sysfs_builtin_init(void)
+{
+	if (!module_kset)
+		return -ENOMEM;
+
 	version_sysfs_builtin();
 	param_sysfs_builtin();
 
 	return 0;
 }
-subsys_initcall(param_sysfs_init);
+late_initcall(param_sysfs_builtin_init);
 
 #endif /* CONFIG_SYSFS */
-- 
2.37.2

