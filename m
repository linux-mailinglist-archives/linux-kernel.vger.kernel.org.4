Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F85F7E47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJGTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJGTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:47:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6112103D98;
        Fri,  7 Oct 2022 12:47:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l8so3486004wmi.2;
        Fri, 07 Oct 2022 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQIAtfxw9qFz9Hl/XRNhdWvv/WP4PsamsNA94vPOScw=;
        b=CWEz1G2S7PpTw3YqmzToiMwiNbuD1Drf7WmIgIG8V7JJvKYsk/ZIOpnPDfjkqNtj4u
         x30Wo/rBxvwnjxsrYw4VshH3VQRaJNJBS9dwf2gCSam8zVwT0x57jLY0PkzPhtjRvgru
         yS4DFP4pSMkpeCuO9D5YZWKbdxEPxQ7p8LzZEf5/CVfFcZeDkP+bz6t9Ne7SGq+his84
         FbyRlu5tBAMBVqeBr2ppFUJmG+9yQMlSq0OJ8QiwrN6HLr5Q55oU0RnQFjnA7qLh7PMq
         udmzxQlqNKIaMlrC1eUYEpZsqX8u/rhlv+eTU/IyYY9xZmwr1rYWaF7ZqOk8eSiOY4lC
         qaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQIAtfxw9qFz9Hl/XRNhdWvv/WP4PsamsNA94vPOScw=;
        b=ydom+B/eZcyzTaVw8hKrdN8r0oiMG78R0uKMJFdEUg7Ua4lP2VV7aWZIYHbfTPNgDD
         7HtecK0H2/9VEqP9aX0VX7mwGru79QJ/C/xQ5VXI55wH6DmW6+cgfuHQnJZ9g+FQAWop
         Bhlf9w+DwKi3+zxkDpNhNtQYkfIqUxaSg6Y86uDAaBmH2H13xNvAusSPLp8X8MvzG8dG
         2woRXdFEx4/buOzXj4He4vw0ku1K+ONtt2rzb/RfFNKYtYlUsyupNryFWCBf5hhhlnEo
         w9+Mr5nAc1lcrqvLnbLMP4J2ZEs73Q3t50S0MhPx1CE60lpIwmox4/Miozh+4b6ewVDs
         Vemg==
X-Gm-Message-State: ACrzQf2Ar8lhB2rc0dO0BSJKY4aKkqyK063KastB3kr2KEujW5CHQj1Z
        jxfYW1L4z5S+QlCLjYxEACw=
X-Google-Smtp-Source: AMsMyM7/YTveBhPU+ZlmzDgp++oNS+vvRqhX5gWak6BuDVO4QseTU9T6OaWBOMN9HuEbtuNn71dvDw==
X-Received: by 2002:a05:600c:4ed3:b0:3b4:ade9:ecf0 with SMTP id g19-20020a05600c4ed300b003b4ade9ecf0mr11769784wmq.46.1665172066974;
        Fri, 07 Oct 2022 12:47:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e17-20020adfdbd1000000b0022ae59d472esm2705304wrj.112.2022.10.07.12.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:47:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gem: remove redundant assignments to variable ret
Date:   Fri,  7 Oct 2022 20:47:45 +0100
Message-Id: <20221007194745.2749277-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable ret is being assigned with a value that is never read
both before and after a while-loop. The variable is being re-assigned
inside the while-loop and afterwards on the call to the function
i915_gem_object_lock_interruptible. Remove the redundants assignments.

Cleans up clang scan-build warnings:

warning: Although the value stored to 'ret' is used in the
enclosing expression, the value is never actually read
from 'ret' [deadcode.DeadStores]

warning: Value stored to 'ret' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index d4398948f016..b7e24476a0fd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -292,7 +292,7 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
 	if (!i915_gem_object_is_readonly(obj))
 		gup_flags |= FOLL_WRITE;
 
-	pinned = ret = 0;
+	pinned = 0;
 	while (pinned < num_pages) {
 		ret = pin_user_pages_fast(obj->userptr.ptr + pinned * PAGE_SIZE,
 					  num_pages - pinned, gup_flags,
@@ -302,7 +302,6 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
 
 		pinned += ret;
 	}
-	ret = 0;
 
 	ret = i915_gem_object_lock_interruptible(obj, NULL);
 	if (ret)
-- 
2.37.3

