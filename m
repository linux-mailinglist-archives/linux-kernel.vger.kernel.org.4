Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25286C3FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCVBhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCVBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:37:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341EA574D5;
        Tue, 21 Mar 2023 18:36:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id o14so7832781ioa.3;
        Tue, 21 Mar 2023 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679448996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnvFcWzQC9kp0s3Ad9+shbkiRajCq0VM9LtHb2VW5NE=;
        b=iI/r7oZWPjB8fVKJxHIwCq0lhJMf7Au1DLZTtsnTwKYYgnnl26/qY+0JMi+AuQbLlS
         qcNb1K+gXIf8FH/7nwdKnRRmsPAPankblFbcVUAo14uPI4ZI/CHZQTyIdsw2tdN0+qlG
         XqRVcGYkDodvwGOw3dzt2sjHy4IiAgBySyktkFKh6wTMUdKssTdgK1O3H9UP49jnlKTe
         cLqYrohnCTBpZgnr5QVp5eu0HpNvkbTz2ubxgL7j3nG6O6+mHkH1LDxhxFyylJnc1PEB
         LvrnXmkuZhSS3LYjX7lXv2zHs51kbyqtBnyr4qpkIS0yxDRBRl1ihzMatJE8ufMQs8uD
         d0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679448996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnvFcWzQC9kp0s3Ad9+shbkiRajCq0VM9LtHb2VW5NE=;
        b=Eh1UqV4AcqYp65AGflP/uA0rk0fYtq7JTK9AQjGePaqk3veTP9lgzm0HkT0w8tJjjY
         Wmq0I4FnAqOIo5TUjfYxfdpSCVsYb1sgZDZPrGeYNvDE0GRebslRsu4tX+H4jZMyzswf
         a5yP0r0dreA8nrtM6nSEkP6irUNMkB6lT7bnSONebpJ/G3u66VGUlHlUn4yorcPbzkPc
         9aSHHPZnPRqH3OWAVUMZ9eMMeHy1oXNnIg5+Y7ZxKGw9272ghCQBRxWGwJB4PKR4ld68
         ysESAxtAcDgaqIFsD9i+9XGmlsDGfe2FP+wMe42F3Kiv1pRWqCqXdFpP7jE48T8fSiMY
         kx9Q==
X-Gm-Message-State: AO0yUKX46Porf3xf17OGXedi6P1iA+FRDgJXs1ctrJ+pYOUEkvpZe36z
        WdBKf6nX5Sc1khyWCL90liM=
X-Google-Smtp-Source: AK7set8MHRaO4K0z3XF3OnZulVfjEK7FTNO1+bzXEkiNh2U7IlPfqyUOD8mhtVwEFdFvmJmMX4Xp4w==
X-Received: by 2002:a5e:cb03:0:b0:74e:3d8e:8e1e with SMTP id p3-20020a5ecb03000000b0074e3d8e8e1emr3414250iom.15.1679448995992;
        Tue, 21 Mar 2023 18:36:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm3925058ioc.18.2023.03.21.18.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:36:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/4] module: already_uses() - reduce pr_debug output volume
Date:   Tue, 21 Mar 2023 19:36:23 -0600
Message-Id: <20230322013623.251401-5-jim.cromie@gmail.com>
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

already_uses() is unnecessarily chatty.

`modprobe i915` yields 491 messages like:

  [   64.108744] i915 uses drm!

This is a normal situation, and isn't worth all the log entries.

NOTE: I've preserved the "does not use %s" messages, which happens
less often, but does happen.  Its not clear to me what it tells a
reader, or what info might improve the pr_debug's utility.

[ 6847.584999] main:already_uses:569: amdgpu does not use ttm!
[ 6847.585001] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585014] main:already_uses:569: amdgpu does not use drm!
[ 6847.585016] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585024] main:already_uses:569: amdgpu does not use drm_display_helper!
[ 6847.585025] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585084] main:already_uses:569: amdgpu does not use drm_kms_helper!
[ 6847.585086] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585175] main:already_uses:569: amdgpu does not use drm_buddy!
[ 6847.585176] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585202] main:already_uses:569: amdgpu does not use i2c_algo_bit!
[ 6847.585204] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585249] main:already_uses:569: amdgpu does not use gpu_sched!
[ 6847.585250] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585314] main:already_uses:569: amdgpu does not use video!
[ 6847.585315] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585409] main:already_uses:569: amdgpu does not use iommu_v2!
[ 6847.585410] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6847.585816] main:already_uses:569: amdgpu does not use drm_ttm_helper!
[ 6847.585818] main:add_module_usage:584: Allocating new usage for amdgpu.
[ 6848.762268] dyndbg: add-module: amdgpu.2533 sites

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2a8ed8564ae..0a5583686994 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -563,10 +563,8 @@ static int already_uses(struct module *a, struct module *b)
 	struct module_use *use;
 
 	list_for_each_entry(use, &b->source_list, source_list) {
-		if (use->source == a) {
-			pr_debug("%s uses %s!\n", a->name, b->name);
+		if (use->source == a)
 			return 1;
-		}
 	}
 	pr_debug("%s does not use %s!\n", a->name, b->name);
 	return 0;
-- 
2.39.2

