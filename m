Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF576E5486
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDQWDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDQWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E82108;
        Mon, 17 Apr 2023 15:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1568C61245;
        Mon, 17 Apr 2023 22:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637FFC433D2;
        Mon, 17 Apr 2023 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681768978;
        bh=vUU+KW+lRcevWVHbFKGeuCq5A0RIw1YokU/NkRrs8BI=;
        h=From:To:Cc:Subject:Date:From;
        b=LcD0zOD12PuE1Ko376iSMy7sb31KU0Wep9/V4PjZ0cS9VI4jY7RR0hH/TjF6IxKWp
         UlFvogGwAYjMSauoQPfZE8Kvq90CUwEgkcJk/JK8dilaUoZcTgiauqbonWxckUOAkj
         z0frVHSCKmx+Rbd0hcre3cunNgxYEiOlMUIVyYJH5ePW3co7nAUiXmb8CMZU9VY0sb
         cCCdSb+xfusR1VjOAi5RS/TUjyE0j6+0ZgfjjmMQ/KpPfOo74nezxaW1J359qbOvp1
         8ewtGeA9hhEqk6k0cFMkSkBoBZbLJiK2xZ/eAmNGlhfBWHeaHNZzVzChvwHJKwh6Mq
         Za7j7tqIPdvdQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: stats: include uapi/linux/module.h
Date:   Tue, 18 Apr 2023 00:02:46 +0200
Message-Id: <20230417220254.3215576-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

MODULE_INIT_COMPRESSED_FILE is defined in the uapi header, which
is not included indirectly from the normal linux/module.h, but
has to be pulled in explicitly:

kernel/module/stats.c: In function 'mod_stat_bump_invalid':
kernel/module/stats.c:227:14: error: 'MODULE_INIT_COMPRESSED_FILE' undeclared (first use in this function)
  227 |  if (flags & MODULE_INIT_COMPRESSED_FILE)
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/module/stats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index d9b9bccf4256..bbf90190a3fe 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <uapi/linux/module.h>
 #include <linux/string.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
-- 
2.39.2

