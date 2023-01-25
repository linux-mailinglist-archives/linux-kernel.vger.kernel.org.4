Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA01667BD15
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjAYUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjAYUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:46 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513125E521
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:17 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i17so4275ila.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYPktuDkhsdEuRTk1MSfg8ZGrHbLgcCVScoM+jk3tZY=;
        b=eppfcnpqmJh6rDvGyb5bXWEyiJssB/4JtHxIYQzimFJC+9A5AXJynKMCbSZKltuDWt
         qh2w3LNWKNxLDqQwWucoDBqIupHe2tKgxFxRj0bRhaxxTDgMlKvj7oQ8a+eYO4RRxv0L
         6C+PPL3EsY7pOGp5BGarclSkuWzlej9nuSXDeP9b5H+Ni8bQmJrLGbUbC/Vbt8XuoXdj
         ilhsFUgPt3M4I6VGyNR/NTjxMHkIdzx7zHimkTgPw6Ngjn+ZgdpQVpjvoIq7UhwMu+Wn
         kmYKBaoUmNQgYvIE2uwIFVSGGLwe04puyw8dU3w3E9ndpDXFoe0SuJmB3hZtBNuAmeoI
         QXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYPktuDkhsdEuRTk1MSfg8ZGrHbLgcCVScoM+jk3tZY=;
        b=dsBBkwdC/wE9DyzKHWtPAA8biiqPsvHNrcvx87NZcrBCXn9x2NBXbSBhkXJYY1nA3f
         viNihouMng5TueA4TTuHxF41AAnYhUfBLYALcI+NWcxHQqnu5bkFDZNeuJ7QHWHSOz6X
         c2z9XBccVWuPIZ9jt/7OR7koJQfi61n7JoVPNLFDkQPhEiYDMO/9NPi4oigDaUeC8xxb
         GWZ3aCjJRAcmj1j3iTj03i3dyEC2NmdFxCTCAjud2DMpKUGVy/eNDBDr8bT5+V7MJbDp
         qyLfxxQnV/Qwz/57VkScSOMAc/arVIZD3X7jNGr8tv6DoRkQrU0PDm99cUJTHoykYWLO
         13LA==
X-Gm-Message-State: AFqh2krQT6Xv4LBbALMtnoYLbEdCbgljKMY0PuDVFmkUgMJlzbm/kYH1
        4q4KwK/qhIqvDraL+j3bSqJiqrsiHgM=
X-Google-Smtp-Source: AMrXdXsgxnTIXy6LMbJfQCXTR0XOCGlfz+t4W1ai6suugpJVCn73+qZoPKJfGaBxxUsfEQnWcPc5ww==
X-Received: by 2002:a05:6e02:12e8:b0:30e:f006:365 with SMTP id l8-20020a056e0212e800b0030ef0060365mr27732935iln.24.1674679096394;
        Wed, 25 Jan 2023 12:38:16 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:15 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 18/19] test-dyndbg: tune sub-module behavior
Date:   Wed, 25 Jan 2023 13:37:42 -0700
Message-Id: <20230125203743.564009-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125203743.564009-1-jim.cromie@gmail.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
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

lib/test_dynamic_debug.c is used to build 2 modules:
test_dynamic_debug.ko and test_dynamic_debug_submod.ko

Define DEBUG only in the main module, not in the submod.  Its purpose
is to insure that prdbgs are enabled by default, so that a modprobe
without params actually logs something, showing that compile-time
enablement works.  This doesn't need to be repeated in the submodule.

Rather, the submodule's purpose is to prove that classmaps defined and
exported from a parent module are propagated to submodules, setting
their class'd debugs accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 6b7bd35c3e15..70a1e8955ad0 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -10,10 +10,9 @@
   #define pr_fmt(fmt) "test_dd_submod: " fmt
 #else
   #define pr_fmt(fmt) "test_dd: " fmt
+  #define DEBUG	/* enable all prdbgs (plain & class'd), to log by default */
 #endif
 
-#define DEBUG /* enable all prdbgs (plain & class'd) at compiletime */
-
 #include <linux/module.h>
 
 /* run tests by reading or writing sysfs node: do_prints */
-- 
2.39.1

