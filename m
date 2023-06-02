Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F76720259
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjFBMpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjFBMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EDA13D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 734A06500B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ADDC433EF;
        Fri,  2 Jun 2023 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709946;
        bh=5tsFEnVqyWViniqebIjKt9Ya28HTseKy3clt1psmZfY=;
        h=From:To:Cc:Subject:Date:From;
        b=O7//ivusxkzvhpdpQH02dhNTkRC0sOvOF+YB0GwZhXGeBCAxwHULuqQQ9EpYeA7Y7
         HqqWMyv7IKFQe3LBqy6LE7meK3hQOkXI2u0n7KqpER8SIEKY3OpcxsZ8JqXHVK/mFQ
         l4y9ojcLWGGvBnGtYeHIGYcZYjgBCydx/1IUBI6lJwHfCISxvWbVvGVOhMAR/nxe5l
         YOqXBfenMxlami2rOk0x2hxi6TmMy2uVKFH+VoupA6dmdZ72/6C/x2A+EFO4j98FZn
         dT1cOVWYEQtQms+qsyzg1s8YBmiRMoQUi97nkETQ7gauSh8kyFxpU1LCjBVDlMsnK1
         TukFu1vyjOKpA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tom Rix <trix@redhat.com>, Carlo Caione <ccaione@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: venc: include linux/bitfield.h
Date:   Fri,  2 Jun 2023 14:45:24 +0200
Message-Id: <20230602124539.894888-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without this header, the use of FIELD_PREP() can cause a build failure:

drivers/gpu/drm/meson/meson_venc.c: In function 'meson_encl_set_gamma_table':
drivers/gpu/drm/meson/meson_venc.c:1595:24: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]

Fixes: 51fc01a03442c ("drm/meson: venc: add ENCL encoder setup for MIPI-DSI output")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/meson/meson_venc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 2bdc2855e249b..3bf0d6e4fc30a 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/export.h>
 #include <linux/iopoll.h>
 
-- 
2.39.2

