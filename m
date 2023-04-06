Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F66DA4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjDFVxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbjDFVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:53:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCBDA5C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:53:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id n14so39334550qta.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680817987; x=1683409987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvuLaQlfcdzowVRz2UW3WmE+TQu4S9UuQ9EBK7qTqIU=;
        b=lCriK1DMTJoP9HrHtbZpak4Uv/NzWiHHkf2AyXbFNPTUbUY9q6g2NtCHl+4xZbM51m
         YNZP82AUq9QTYjOfn0Oxt5hu7nQbsy/hyg+2BtbQT6uopEjmuLCXwRUcpDaSWLOIIrbu
         ej6SzufgL6sS76zt/RT/4+Ne79WGgCETekMUKa6MtrC0kUwDE6Jl6RL14Fqtm0Jy8VqO
         iysUrf/nt6iUhci6R34OK314qdh1ErWRsfGjH5DI7758m58xOtnizI/18trPtyhiUX9U
         bze3qiN5ppd0iLXI8xFfUKDAhV8C8TzmIzHWliuTClqVCYELvKESVYosxzIUhG2jAK4E
         j+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680817987; x=1683409987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvuLaQlfcdzowVRz2UW3WmE+TQu4S9UuQ9EBK7qTqIU=;
        b=5zaMtnTRdze02RM97LCCUai5Uow+YbxHLiRFJ8nCj0JzaZb9T36RQqs2IDFZazoF3h
         aKuqvDgG4U0YEUmC/QoTpKWSePIOUmO5gS/LBtnwCG4TfgR/bUv7XuO4R+WAc67qkJhR
         HUkaRZHY19DOXv89Hfpw3G8NWfXDnde62Sh5VA4Ix//pk2TGfBgl9BqkyjjhFJubB+pP
         f2qajRYindhv7ZLYDzqc6+Egg87dVwg9lH8592B9jJw8XqD6+a+WiDkpDC7N+FW55mVs
         MBXKU6f6kBlkWNm/V35fw4voL0yoIbEW0+WKsccq2izmoE+/DiYBTrVGIC3mh8kzNAdH
         yFDw==
X-Gm-Message-State: AAQBX9d2etM6x+izWRCZgW6hkJY4Jmw54hcORJR4stpnlwZ0MYqNbG4H
        uO6muOGCef8ofkPA+oFPZPoYT9evFBrthg==
X-Google-Smtp-Source: AKy350Y8MEZbm6sesGUzT+r32fqW+encg7zV0McZquX6hd9VBR1Hq+rqZEraXBGwqdfPdKOZH3fBYg==
X-Received: by 2002:a05:622a:60b:b0:3b6:694f:d710 with SMTP id z11-20020a05622a060b00b003b6694fd710mr502818qta.50.1680817986960;
        Thu, 06 Apr 2023 14:53:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d137-20020a37688f000000b007468ad71799sm787295qkc.64.2023.04.06.14.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:53:06 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kapil.hali@broadcom.com, akpm@linuxfoundation.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH] scripts/gdb: Raise error with reduced debugging information
Date:   Thu,  6 Apr 2023 14:52:51 -0700
Message-Id: <20230406215252.1580538-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DEBUG_INFO_REDUCED is enabled in the kernel configuration, we
will typically not be able to load vmlinux-gdb.py and will fail with:

Traceback (most recent call last):
  File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/vmlinux-gdb.py", line 25, in <module>
    import linux.utils
  File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/scripts/gdb/linux/utils.py", line 131, in <module>
    atomic_long_counter_offset = atomic_long_type.get_type()['counter'].bitpos
KeyError: 'counter'

Rather be left wondering what is happening only to find out that reduced debug
information is the cause, raise an eror. This was not typically a
problem until e3c8d33e0d62 ("scripts/gdb: fix 'lx-dmesg' on 32 bits
arch") but it has since then.

Fixes: e3c8d33e0d62 ("scripts/gdb: fix 'lx-dmesg' on 32 bits arch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Hi all,

I added the Fixes tag because it really was not a problem before,
however it now is an issue and the commit in the Fixes: tag has been
backported to stable already

 scripts/gdb/linux/constants.py.in | 2 ++
 scripts/gdb/vmlinux-gdb.py        | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index c5e6de285b57..36fd2b145853 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -41,6 +41,8 @@
 
 import gdb
 
+LX_CONFIG(CONFIG_DEBUG_INFO_REDUCED)
+
 /* linux/clk-provider.h */
 if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 4e74d6d4fa09..2a72f91059b5 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -22,6 +22,10 @@ except:
     gdb.write("NOTE: gdb 7.2 or later required for Linux helper scripts to "
               "work.\n")
 else:
+    import linux.constants
+    if linux.constants.LX_CONFIG_DEBUG_INFO_REDUCED:
+        raise gdb.GdbError("Reduced debug information will prevent GDB "
+                           "from having complete types.\n")
     import linux.utils
     import linux.symbols
     import linux.modules
@@ -32,7 +36,6 @@ else:
     import linux.lists
     import linux.rbtree
     import linux.proc
-    import linux.constants
     import linux.timerlist
     import linux.clk
     import linux.genpd
-- 
2.34.1

