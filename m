Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD586B8BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCNHQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCNHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:16:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C518B0D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:16:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so4111307pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678778189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=capDrvSzHPBJ+/hngQENgrZQLfx+ZLJQalj1uKIfdVo=;
        b=Wb45VOZJa3P+dZc0rW8US1JkHxWIkiLDUvy/r9PgDAdIxF+ClpQOqtLMxq6lmgg3kx
         s381vBCOeLj40iL+k+yMhJb6snXFUqi4LLaOQ97H1UW4kSJH/x1Y08LYkPdmjLscvlXK
         1Mf5O9UHFpbxx6gSHYWODYx6mw7PClWrGKopw9vH78SgduvUs5Z2dYbPzQmXE+08btqr
         uCPnHxp1RrOAc48CKm+dhD149VMgxDQbiv1kZMiWpcmZz6UispdmpLd0XsHRMEPQ5TyJ
         qUtRDy49h+wfK8+sQCST//25+3t5BeqaZoN8Raf3Q+uM31Sc91+1/RuZdNnvpzCywcrV
         pymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678778189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=capDrvSzHPBJ+/hngQENgrZQLfx+ZLJQalj1uKIfdVo=;
        b=QE2Aj4hNbWzWlWkMvNXGpjW6sWWelwPNdmASytOVeUv4FDPJbS2BoktjqTfotI4Rn6
         CWehh7xqpUp4CPbyyldHB5CuS3XbijYFTdmTPhWrKoTwM3B9AOefqoFW7/pJZYa15Jgp
         ZUV8iU72UzC6Yd32b+unupt4SX1HjLaCdgmk8GKD4XWP/QDN//5HISh4kICZJxpE5Wnw
         V9zbdpkoaSIaKbiOBGuw9FUySL793l8+sDCoF56PU1mkHDpIimLvmRv+3iCpx1vr5RRc
         IPCfTu9W/IIi0f84r8b5N3lN38JLGvrLKevjMbrrznez+6X8YJv2gZSBGt+QNzGDx2og
         0bMw==
X-Gm-Message-State: AO0yUKU7I4C6cV4TFtV6C2hJ09KU+re0AangLYNyDsI0ktgEdlopwo+e
        MezbdBZFlNXmGsLozWSsx4k=
X-Google-Smtp-Source: AK7set+okZTkiAohrB4HnjBziacKGuP3DRWb41MO9EE/LH49nrOjlSQ8FtFy6khyq63Z8pbm6yA8Gg==
X-Received: by 2002:a05:6a20:6615:b0:cc:5c57:7a0d with SMTP id n21-20020a056a20661500b000cc5c577a0dmr37867409pzh.40.1678778189673;
        Tue, 14 Mar 2023 00:16:29 -0700 (PDT)
Received: from vernon-pc.. ([49.67.2.142])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b006247123adf1sm878202pfi.143.2023.03.14.00.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 00:16:29 -0700 (PDT)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2] mm/slub: fix help comment of SLUB_DEBUG
Date:   Tue, 14 Mar 2023 15:16:01 +0800
Message-Id: <20230314071601.343817-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Since commit ab4d5ed5eeda ("slub: Enable sysfs support for
!CONFIG_SLUB_DEBUG"), disabling SLUB_DEBUG also disables
SLUB sysfs support that is not true anymore, so fix it correctly.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 mm/Kconfig.debug | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index c3547a373c9c..9a90a88ce053 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -60,9 +60,8 @@ config SLUB_DEBUG
 	select STACKDEPOT if STACKTRACE_SUPPORT
 	help
 	  SLUB has extensive debug support features. Disabling these can
-	  result in significant savings in code size. This also disables
-	  SLUB sysfs support. /sys/slab will not exist and there will be
-	  no support for cache validation etc.
+	  result in significant savings in code size, the /sys/kernel/slab
+	  will exist but will not provide e.g. cache validation.
 
 config SLUB_DEBUG_ON
 	bool "SLUB debugging on by default"
-- 
2.34.1

