Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694F60D6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJYWOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiJYWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:14:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0136122517
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:14:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d26so16364453eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTaknaRW+YQUii5aGCvKGY1TnjYtNBii7AzO5EDitjA=;
        b=VxVcn7aZKcKdSlfx+ctPfT2y9nbRoZAZoRqEY4vGim3hvIPWunsC81KhQ+sjAVyzLW
         9U7V61S7/S7P/dWVvcEE6c0YrKaoNrcam5/phSI5BNv85Dh1dcReGZ453dL5spXdo2F3
         ODAkeWMUI98d7vQaRITgQx07WKL2FtzCKu37g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTaknaRW+YQUii5aGCvKGY1TnjYtNBii7AzO5EDitjA=;
        b=DKeKzJ7ILShL7ms2urj+gvI1dE0IothvGjEOq9xITTTAprat3xp2c+My6ls8nkDWYd
         NVyHjVbwrYDcaP8RT1ILBLHJVaHivEPuoLoCqXq2PcxsqSNVoUzPcxCYxZdGvkrQTqKy
         3tl/+G2AAA2IBO9FzH6ExquwXlpjK3wKXIjrmM3bCVAT7dOlEd57DsgmgLCZ/lzMwAOb
         k8PfTiiPWkcimUeqDfJ0h5LWgRrYA1bD8LMxJJWG6hdVYCCHvjnBSDBJ8Lf8as+9vbro
         7ObZXnT/thawBo/p/psf4N3664q7TSC5oP8FTfiM1kIw6n2mDNhGQaMBNvydZEWbMA06
         fCRQ==
X-Gm-Message-State: ACrzQf2WVNpvCGp9OpJVtNglNvzmjEBf9EZzCRSElG5nd8wXuh/E9TNw
        PGTfw78QtOlhoetfFE8DLZkvDg==
X-Google-Smtp-Source: AMsMyM6Fp+5vYSXgetq7/aHH5pkTaPOcKlPCfHySF8qUovCxgQqMVB+7zn0vtbR+DoGVJ8n6DStzHg==
X-Received: by 2002:a17:907:7ba8:b0:78e:1b38:6b1b with SMTP id ne40-20020a1709077ba800b0078e1b386b1bmr33585435ejc.626.1666736039476;
        Tue, 25 Oct 2022 15:13:59 -0700 (PDT)
Received: from localhost.localdomain ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906319100b00781b589a1afsm1990726ejy.159.2022.10.25.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:13:58 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kernel/params.c: defer most of param_sysfs_init() to late_initcall time
Date:   Wed, 26 Oct 2022 00:13:56 +0200
Message-Id: <20221025221356.1126728-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221025130003.1116366-1-linux@rasmusvillemoes.dk>
References: <20221025130003.1116366-1-linux@rasmusvillemoes.dk>
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
 kernel/params.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 8d4e9a3f0df2..a06f80c56f19 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -953,7 +953,11 @@ struct kobj_type module_ktype = {
 };
 
 /*
- * param_sysfs_init - wrapper for built-in params support
+ * param_sysfs_init - create "module" kset
+ *
+ * This must be done before the initramfs is unpacked and
+ * request_module() thus becomes possible, because otherwise the
+ * module load would fail in mod_sysfs_init.
  */
 static int __init param_sysfs_init(void)
 {
@@ -964,11 +968,24 @@ static int __init param_sysfs_init(void)
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

