Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD56E8E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjDTJhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjDTJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806D3C05
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71F5E61243
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE4AC433EF;
        Thu, 20 Apr 2023 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983365;
        bh=zxxQxxfZMAX2tSIR37Rb1lSFTjLRW4QpM+kVnrL9Y8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9zP9VthsK89QwIljInnAIyQMj7niZ+oNxv6sDDU+CANoYWhoUSJQ4/9ahX/92bsR
         F71JG7u0/jy0CPD9k2hCW1WrQL1njl/QFQydv3dbKHAhdCTbonwLANvlUzQBbLI/t0
         Xs8yo6kVqPWWaDSprmTfegQyKYXpp2aFGlEK1/UMh15zZbHGJemGX9S3pK1WnD53nQ
         2gBHZIX+cmzlTFR1Z+e+xNJDG6cM2KBO4m8GIf050Z5XDCOIJlAwoTEvHjaapVVZeO
         T6bLh8h6Ym0Y9O7jgwKgVY2yXQ4lV83L+XubxvINX4uxNMeJ1cKzl9NDCGZCSmO3yV
         +3HPB2TgAlKxg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/4] tty: vt: drop checks for undefined VT_SINGLE_DRIVER
Date:   Thu, 20 Apr 2023 11:35:59 +0200
Message-Id: <20230420093559.13200-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420093559.13200-1-jirislaby@kernel.org>
References: <20230420093559.13200-1-jirislaby@kernel.org>
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

VT_SINGLE_DRIVER is defined nowhere. Remove its checks. These were added
long time ago and never used.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c4d333277ef7..1e8e57b45688 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -137,9 +137,7 @@ const struct consw *conswitchp;
 struct vc vc_cons [MAX_NR_CONSOLES];
 EXPORT_SYMBOL(vc_cons);
 
-#ifndef VT_SINGLE_DRIVER
 static const struct consw *con_driver_map[MAX_NR_CONSOLES];
-#endif
 
 static int con_open(struct tty_struct *, struct file *);
 static void vc_init(struct vc_data *vc, unsigned int rows,
@@ -1008,10 +1006,10 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	if (vc->vc_sw)
 		module_put(vc->vc_sw->owner);
 	vc->vc_sw = conswitchp;
-#ifndef VT_SINGLE_DRIVER
+
 	if (con_driver_map[num])
 		vc->vc_sw = con_driver_map[num];
-#endif
+
 	__module_get(vc->vc_sw->owner);
 	vc->vc_num = num;
 	vc->vc_display_fg = &master_display_fg;
@@ -3575,8 +3573,6 @@ int __init vty_init(const struct file_operations *console_fops)
 	return 0;
 }
 
-#ifndef VT_SINGLE_DRIVER
-
 static struct class *vtconsole_class;
 
 static int do_bind_con_driver(const struct consw *csw, int first, int last,
@@ -4278,8 +4274,6 @@ static int __init vtconsole_class_init(void)
 }
 postcore_initcall(vtconsole_class_init);
 
-#endif
-
 /*
  *	Screen blanking
  */
-- 
2.40.0

