Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D174C860
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGIVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGIVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:18:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C3124;
        Sun,  9 Jul 2023 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1688937483;
        bh=kUuLnBpZagTGgZtfp6+QNMKvlzerXhW/GswEr/rGnGU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oQJndrWXNLPFkfEsbCL20lQD4wIQAtsXltvpk2M1oDAu91Vhs/CgoEFb/LiQWtiWu
         tREFnKhizlmZM6UoZFXx2d37OZpm6dxxLwv9cFHl+0a0Wn/nnM0bpOpD3p9UkEyej3
         eF0q5GAd7UqtqL+UeDEi1ohKdwcVWmNJKrA3p1y0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 09 Jul 2023 23:18:00 +0200
Subject: [PATCH v2 3/3] dyndbg: add source filename to prefix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230709-dyndbg-filename-v2-3-fd83beef0925@weissschuh.net>
References: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
In-Reply-To: <20230709-dyndbg-filename-v2-0-fd83beef0925@weissschuh.net>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688937480; l=3618;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kUuLnBpZagTGgZtfp6+QNMKvlzerXhW/GswEr/rGnGU=;
 b=0WOHyfoM7dB2NU4GYhRWg43mpN/12HWhB5REzdPm0u9Kq+9flHZjYLLM2bPyiaoJWhqhq4z6h
 UJaqZ/JjgUaCuXm9GZ0N2ZF4xKcciDn6lFz9CJ9jrI4i1u0tplDQoRF
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the line number without the file is of limited usefulness.

Knowing the filename also makes it also easier to relate the logged
information to the controlfile.

Example:

    # modprobe test_dynamic_debug
    # echo 'file test_dynamic_debug.c =pfsl' > /proc/dynamic_debug/control
    # echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
    # dmesg | tail -2
    [   71.802212] do_cats:lib/test_dynamic_debug.c:103: test_dd: doing categories
    [   71.802227] do_levels:lib/test_dynamic_debug.c:123: test_dd: doing levels

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
 include/linux/dynamic_debug.h                     | 4 +++-
 lib/dynamic_debug.c                               | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 8dc668cc1216..0b3d39c610d9 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -216,13 +216,14 @@ The flags are::
   t    Include thread ID, or <intr>
   m    Include module name
   f    Include the function name
+  s    Include the source file name
   l    Include line number
 
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 the ``p`` flag has meaning, other flags are ignored.
 
-Note the regexp ``^[-+=][flmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-flmpt``.
+Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
+To clear all flags at once, use ``=_`` or ``-fslmpt``.
 
 
 Debug messages during Boot Process
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 061dd84d09f3..4fcbf4d4fd0a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -37,10 +37,12 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
+	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
+	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 166229dfe171..6fba6423cc10 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -92,6 +92,7 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
+	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
@@ -836,6 +837,9 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
+	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
+		pos += snprintf(buf + pos, remaining(pos), "%s:",
+				trim_prefix(desc->filename));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);

-- 
2.41.0

