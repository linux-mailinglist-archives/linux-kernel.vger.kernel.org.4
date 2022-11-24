Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49F637B36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKXOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKXOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C12EE0B62;
        Thu, 24 Nov 2022 06:16:03 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoV3AFMGO8ondSC4f0jCTV9tLxBQy1OhE1Yrhn7xh+0=;
        b=md7ONus0jMF1BpPfrBcDMg+sY16nvrhmQvwJUvFELAQ91XOLvDhYjnUfB13KC9EAYqyTyD
        IvSu9MKAyNBRTP7rFkxi6wiViQOvpXrCMX/C53tBA3vPt49VcC+tHdAPhqS9ESUmlLEbSs
        SIEMk6x6dPGjgotThXlZSn3VvHaCcTb2gxoP1blGvseeLV/VkuhIcyK/MwDMP1fEakXBXz
        xcAz0+SeEMd0SchTmxIAE5Bb2hRAiJr0nmcW8ck7npBI1ib1JLbMtzPZ1CuTRQRU+9Y0Jx
        CfPgmK9cKlCGW1Y3ho39GOryxyrhU+tRB3DZkM/X2x2oA+WiLO5l3i5XGrnzBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoV3AFMGO8ondSC4f0jCTV9tLxBQy1OhE1Yrhn7xh+0=;
        b=91Y2vD/SQjt9Pjjp4ojoz7TqzUmtmIyf7s2f8Eq3rXdbqeROicaD8p1jLbTO9iGQgBBh8s
        JaPxRtHkVlZ/1rBw==
From:   "tip-bot2 for Steven Rostedt (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Update the documentation to reflect on the
 new timer_shutdown() API
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110064147.712934793@goodmis.org>
References: <20221110064147.712934793@goodmis.org>
MIME-Version: 1.0
Message-ID: <166929936027.4906.15038032251708772543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a31323bef2b66455920d054b160c17d4240f8fd4
Gitweb:        https://git.kernel.org/tip/a31323bef2b66455920d054b160c17d4240=
f8fd4
Author:        Steven Rostedt (Google) <rostedt@goodmis.org>
AuthorDate:    Wed, 23 Nov 2022 21:18:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:12 +01:00

timers: Update the documentation to reflect on the new timer_shutdown() API

In order to make sure that a timer is not re-armed after it is stopped
before freeing, a new shutdown state is added to the timer code. The API
timer_shutdown_sync() and timer_shutdown() must be called before the
object that holds the timer can be freed.

Update the documentation to reflect this new workflow.

[ tglx: Updated to the new semantics and updated the zh_CN version ]

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221110064147.712934793@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.375284489@linutronix.de

---
 Documentation/RCU/Design/Requirements/Requirements.rst  | 2 +-
 Documentation/core-api/local_ops.rst                    | 2 +-
 Documentation/kernel-hacking/locking.rst                | 5 +++++
 Documentation/translations/zh_CN/core-api/local_ops.rst | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documen=
tation/RCU/Design/Requirements/Requirements.rst
index 546f23a..49387d8 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any a=
ttempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via timer_delete_sync() or similar.
+with via timer_shutdown_sync() or similar.
=20
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/lo=
cal_ops.rst
index a84f8b0..0b42cea 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu =
counter using
=20
     static void __exit test_exit(void)
     {
-            timer_delete_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
=20
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index c5b8678..c756786 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1007,6 +1007,11 @@ calling add_timer() at the end of their timer function=
).
 Because this is a fairly common case which is prone to races, you should
 use timer_delete_sync() (``include/linux/timer.h``) to handle this case.
=20
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed. Any subsequent attempt to
+rearm the timer will be silently ignored by the core code.
+
+
 Locking Speed
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/zh_CN/core-api/local_ops.rst b/Docume=
ntation/translations/zh_CN/core-api/local_ops.rst
index 22493b9..eb5423f 100644
--- a/Documentation/translations/zh_CN/core-api/local_ops.rst
+++ b/Documentation/translations/zh_CN/core-api/local_ops.rst
@@ -185,7 +185,7 @@ UP=E4=B9=8B=E9=97=B4=E6=B2=A1=E6=9C=89=E4=B8=8D=E5=90=8C=
=E7=9A=84=E8=A1=8C=E4=B8=BA=EF=BC=8C=E5=9C=A8=E4=BD=A0=E7=9A=84=E6=9E=B6=E6=
=9E=84=E7=9A=84 ``local.h`` =E4=B8=AD=E5=8C=85=E6=8B=AC ``asm-g
=20
     static void __exit test_exit(void)
     {
-            timer_delete_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
=20
     module_init(test_init);
