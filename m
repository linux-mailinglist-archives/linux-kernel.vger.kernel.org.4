Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B066B05EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCHLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:25:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85E7B48F;
        Wed,  8 Mar 2023 03:25:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9397A219E2;
        Wed,  8 Mar 2023 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678274698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xId0hTIp/XCmCWrv3B55O+AcJP0XyWX+WeJ89KiTr4E=;
        b=me0qNlkQDZKBr9dcB+hnidcYo2leL7eEGi/Rzpmvz5ix9KuJ4b9t3lZhwr9toiaAsa6dQi
        nQtU8ze6ax+pJ5tlLCDPVXvBvV1otLLQCdAqWmdAIjS4dg0jkdDLJi5DMd4XuJdyKOvZvN
        2GZ4SUTFD7TElj0nw/x0aq/CRzsj32g=
Received: from alley.suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 64A532C141;
        Wed,  8 Mar 2023 11:24:57 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] Documentation/serial-console: Document the behavior when the last console= parameter is not used
Date:   Wed,  8 Mar 2023 12:24:33 +0100
Message-Id: <20230308112433.24292-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The console= kernel command-line parameter defines where the kernel
messages appear. It can be used multiple times to make the kernel log
visible on more devices.

The ordering of the console= parameters is important. In particular,
the last one defines which device can be accessed also via /dev/console.

The behavior is more complicated when the last console= parameter is
ignored by kernel. It might be surprising because it was not intentional.
The kernel just works this way historically.

There were few attempts to change the behavior. Unfortunately, it can't
be done because it would break existing users. Document the historical
behavior at least.

Link: https://lore.kernel.org/r/20170606143149.GB7604@pathway.suse.cz
Link: https://lore.kernel.org/r/20230213113912.1237943-1-rkanwal@rivosinc.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/admin-guide/serial-console.rst | 36 ++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
index 58b32832e50a..8c8b94e54e26 100644
--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -33,8 +33,11 @@ The format of this option is::
 			9600n8. The maximum baudrate is 115200.
 
 You can specify multiple console= options on the kernel command line.
-Output will appear on all of them. The last device will be used when
-you open ``/dev/console``. So, for example::
+
+The behavior is well defined when each device type is mentioned only once.
+In this case, the output will appear on all requested consoles. And
+the last device will be used when you open ``/dev/console``.
+So, for example::
 
 	console=ttyS1,9600 console=tty0
 
@@ -42,7 +45,34 @@ defines that opening ``/dev/console`` will get you the current foreground
 virtual console, and kernel messages will appear on both the VGA
 console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
 
-Note that you can only define one console per device type (serial, video).
+The behavior is more complicated when the same device type is defined more
+times. In this case, there are the following two rules:
+
+1. The output will appear only on the first device of each defined type.
+
+2. ``/dev/console`` will be associated with the first registered device.
+   Where the registration order depends on how kernel initializes various
+   subsystems.
+
+   This rule is used also when the last console= parameter is not used
+   for other reasons. For example, because of a typo or because
+   the hardware is not available.
+
+The result might be surprising. For example, the following two command
+lines have the same result:
+
+	console=ttyS1,9600 console=tty0 console=tty1
+	console=tty0 console=ttyS1,9600 console=tty1
+
+The kernel messages are printed only on ``tty0`` and ``ttyS1``. And
+``/dev/console`` gets associated with ``tty0``. It is because kernel
+tries to register graphical consoles before serial ones. It does it
+because of the default behavior when no console device is specified,
+see below.
+
+Note that the last ``console=tty1`` parameter still makes a difference.
+The kernel command line is used also by systemd. It would use the last
+defined ``tty1`` as the login console.
 
 If no console device is specified, the first device found capable of
 acting as a system console will be used. At this time, the system
-- 
2.35.3

