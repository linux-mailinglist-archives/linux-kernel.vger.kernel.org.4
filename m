Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1FB6E8E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjDTJg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjDTJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7846AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 317A96424D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE97C4339C;
        Thu, 20 Apr 2023 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983364;
        bh=LXMqm3TC5OJnmpftw2vrGio9Z7V7lnJWwoP/cnd93A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfNDss0cD+pqEvuFUewry+SFcpqcBhpg+iwHuOqpTPJP86oB/VFpRQiEJbVdywQx2
         vJFgFl1rX4M3HYNrV+wtRV/MwzK21dCtVipw73uIJLaUW6GwBtNgS2r/sH9RpGXQ+j
         vV1IRfIlhRsP34PmHYbV4XRt0g+uDezBX/iIFsyVPqC9IHlaFUYxnPM4xZHS+p/khq
         OP8T66Ruk+9uqve6qtSIE/77d334qoSLS5bmXg5n77+5JMGFRbuPd42iJqb3deNOgu
         62ETQjujmZnlvK/7FFN94UG3gHPbSgO7Vt8kYdycH0jt1o42kM6yuRAr5qAcd8Rg3o
         Zoay4PG97KWBA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/4] tty: vt: distribute EXPORT_SYMBOL()
Date:   Thu, 20 Apr 2023 11:35:58 +0200
Message-Id: <20230420093559.13200-3-jirislaby@kernel.org>
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

There is a list of EXPORT_SYMBOL()s at the end of the file. Put them all
by their definition. This is how we usually do that.

give_up_console() lost its VT_SINGLE_DRIVER local ifndef protection as
that whole code is under this check.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f44d5b8a102c..c4d333277ef7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -135,6 +135,7 @@ const struct consw *conswitchp;
 #define DEFAULT_CURSOR_BLINK_MS	200
 
 struct vc vc_cons [MAX_NR_CONSOLES];
+EXPORT_SYMBOL(vc_cons);
 
 #ifndef VT_SINGLE_DRIVER
 static const struct consw *con_driver_map[MAX_NR_CONSOLES];
@@ -162,6 +163,7 @@ int default_utf8 = true;
 module_param(default_utf8, int, S_IRUGO | S_IWUSR);
 int global_cursor_default = -1;
 module_param(global_cursor_default, int, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL(global_cursor_default);
 
 static int cur_default = CUR_UNDERLINE;
 module_param(cur_default, int, S_IRUGO | S_IWUSR);
@@ -174,6 +176,7 @@ static int ignore_poke;
 
 int do_poke_blanked_console;
 int console_blanked;
+EXPORT_SYMBOL(console_blanked);
 
 static int vesa_blank_mode; /* 0:none 1:suspendV 2:suspendH 3:powerdown */
 static int vesa_off_interval;
@@ -190,8 +193,10 @@ static DECLARE_WORK(con_driver_unregister_work, con_driver_unregister_callback);
  * saved_* variants are for save/restore around kernel debugger enter/leave
  */
 int fg_console;
+EXPORT_SYMBOL(fg_console);
 int last_console;
 int want_console = -1;
+
 static int saved_fg_console;
 static int saved_last_console;
 static int saved_want_console;
@@ -223,6 +228,7 @@ static int scrollback_delta;
  * the console on our behalf.
  */
 int (*console_blank_hook)(int);
+EXPORT_SYMBOL(console_blank_hook);
 
 static DEFINE_TIMER(console_timer, blank_screen_t);
 static int blank_state;
@@ -639,6 +645,7 @@ void update_region(struct vc_data *vc, unsigned long start, int count)
 		set_cursor(vc);
 	}
 }
+EXPORT_SYMBOL(update_region);
 
 /* Structure of attributes is hardware-dependent */
 
@@ -984,6 +991,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 		notify_update(vc);
 	}
 }
+EXPORT_SYMBOL(redraw_screen);
 
 /*
  *	Allocation, freeing and resizing of VTs.
@@ -1305,6 +1313,7 @@ int vc_resize(struct vc_data *vc, unsigned int cols, unsigned int rows)
 {
 	return vc_do_resize(vc->port.tty, vc, cols, rows);
 }
+EXPORT_SYMBOL(vc_resize);
 
 /**
  *	vt_resize		-	resize a VT
@@ -1368,6 +1377,7 @@ enum { EPecma = 0, EPdec, EPeq, EPgt, EPlt};
 
 const unsigned char color_table[] = { 0, 4, 2, 6, 1, 5, 3, 7,
 				       8,12,10,14, 9,13,11,15 };
+EXPORT_SYMBOL(color_table);
 
 /* the default colour table, for VGA+ colour systems */
 unsigned char default_red[] = {
@@ -1375,18 +1385,21 @@ unsigned char default_red[] = {
 	0x55, 0xff, 0x55, 0xff, 0x55, 0xff, 0x55, 0xff
 };
 module_param_array(default_red, byte, NULL, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL(default_red);
 
 unsigned char default_grn[] = {
 	0x00, 0x00, 0xaa, 0x55, 0x00, 0x00, 0xaa, 0xaa,
 	0x55, 0x55, 0xff, 0xff, 0x55, 0x55, 0xff, 0xff
 };
 module_param_array(default_grn, byte, NULL, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL(default_grn);
 
 unsigned char default_blu[] = {
 	0x00, 0x00, 0x00, 0x00, 0xaa, 0xaa, 0xaa, 0xaa,
 	0x55, 0x55, 0x55, 0x55, 0xff, 0xff, 0xff, 0xff
 };
 module_param_array(default_blu, byte, NULL, S_IRUGO | S_IWUSR);
+EXPORT_SYMBOL(default_blu);
 
 /*
  * gotoxy() must verify all boundaries, because the arguments
@@ -4227,6 +4240,7 @@ void give_up_console(const struct consw *csw)
 	do_unregister_con_driver(csw);
 	console_unlock();
 }
+EXPORT_SYMBOL(give_up_console);
 
 static int __init vtconsole_class_init(void)
 {
@@ -4783,23 +4797,3 @@ void vc_scrolldelta_helper(struct vc_data *c, int lines,
 	c->vc_visible_origin = ubase + (from + from_off) % wrap;
 }
 EXPORT_SYMBOL_GPL(vc_scrolldelta_helper);
-
-/*
- *	Visible symbols for modules
- */
-
-EXPORT_SYMBOL(color_table);
-EXPORT_SYMBOL(default_red);
-EXPORT_SYMBOL(default_grn);
-EXPORT_SYMBOL(default_blu);
-EXPORT_SYMBOL(update_region);
-EXPORT_SYMBOL(redraw_screen);
-EXPORT_SYMBOL(vc_resize);
-EXPORT_SYMBOL(fg_console);
-EXPORT_SYMBOL(console_blank_hook);
-EXPORT_SYMBOL(console_blanked);
-EXPORT_SYMBOL(vc_cons);
-EXPORT_SYMBOL(global_cursor_default);
-#ifndef VT_SINGLE_DRIVER
-EXPORT_SYMBOL(give_up_console);
-#endif
-- 
2.40.0

