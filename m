Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374DF6803A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjA3CBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjA3CB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:01:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3A1C5BC;
        Sun, 29 Jan 2023 18:01:23 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675044082;
        bh=vYyMbUasWdCcvNPaIYP2QI+GHBd2HKwQKJ5zNSkk/nQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MIpOIVAbYklI+C6pMxe3MqlL57ZzePhpgZKCp/eLM979qOdBQrjfuc88TArxS3Plr
         YnWnntrqhbSo5+2t4Ql+bUTmfZFLQjD2DeFCsC8AKBnhj52aer2wU+XHoBTtlROYPF
         rmhHR40vmd/3gXfseDay+TOU16M5nkfe6Fd5DZ+Q=
Date:   Mon, 30 Jan 2023 02:01:20 +0000
Subject: [PATCH 3/3] dyndbg: add source filename to prefix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221223-dyndbg-filename-v1-3-cbf8543009a1@weissschuh.net>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
In-Reply-To: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675044079; l=3530;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vYyMbUasWdCcvNPaIYP2QI+GHBd2HKwQKJ5zNSkk/nQ=;
 b=Ic4BdYeIZIuB1IAlAnRTvv0I8Xq5+adDWvwdrjCGK62ROXHMF17kYJXayQl+UfVPErSjcmgeEyUs
 YYsNYTPDCOQPK6c/m0RAk/WhydWf00V2psJBmFkTWIVMQEpmomth
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
 include/linux/dynamic_debug.h                     | 4 +++-
 lib/dynamic_debug.c                               | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index faa22f77847a..f9fa8163fba6 100644
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
index 41682278d2e8..0c77105d583c 100644
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
index e96ea427d8af..fa7418e35197 100644
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
2.39.1

