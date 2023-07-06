Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB807498D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGFJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjGFJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:59:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE787199E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:59:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so5935437b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688637588; x=1691229588;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dzgfTpUADHR89gqDoPU9ysqJa9QsDW5j+s8pKt5q+bc=;
        b=AakCV45/0sahFCAXprX+Pg9csDM7DLLf2u7uhF4A/r5vb7Cjt57qvA24/5pfyXMyCk
         4oPQy+yk4NHwHrd2dntMlQvYIPFsoEoaaxq+xJjx6wn10qS66vyuzWPf46VXknQAAbaA
         lvGeVRESZBco8li9XHns1zoZvNT93sRnYy+6ZbBvhKEEl+8dK7FvqW1SHni/lJYMILQc
         TZLldBHHCpJaD3TBbZjk+t2/AKeg6lRUcs4eKL0W8RC4jCAS6sdll/B34xWZMsE6Lydl
         bY2ErOYnLmLUD79RUXetQtJWU6qEfzfQPyF73kALiD96xXRrQxbGXoEuVAOIbZRjhSdG
         JJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688637588; x=1691229588;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzgfTpUADHR89gqDoPU9ysqJa9QsDW5j+s8pKt5q+bc=;
        b=YOMPVAjiW61P89wABxGpNIyIjVWP+07O2Eiw/UwfYa9cTKAeA/GSi8VXV2/g4FE9p4
         ZR0UcOaVDBTbTBnKyBPrHqx8oOSzml3OLaXfeivshKlojs1LwlrzWqkYwS+wA83d/JMi
         k5v09NofSYBZJUWNs9Ran5d6HkNgLP0NfB09xr0qmydN96w3AjUkCbe73b5kpUS9LRop
         c/G2BUaM/Of7/5AxYgRziEFRyh2DmvIKG20v5YZxkpFU7oKza1cJzeOy8XjYsIBrAhWQ
         Hi++vL60fxvGS6K+193cG9hVxe5kCat0A8WfqGnzp3XtBni9mM1+vJ3FtwEL9B6CgOcM
         /FtA==
X-Gm-Message-State: ABy/qLZbFBQCnLMoPJkgrMIu9m6IgRvgUHElADRRoKsPPPFDZMi2lDdR
        inE7HHyo57T3pEKMYODa+u9Qa3u2LiU=
X-Google-Smtp-Source: APBJJlHMfBRT0M+aS1/KhC3L1hUXt/ZIyP6zjytaAb3B1jYJL1X9408X5DeAZ3GsTlTZs+Vk/S01TiWcKf4=
X-Received: from koudai.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1150])
 (user=koudai job=sendgmr) by 2002:a81:4506:0:b0:577:619e:d3c9 with SMTP id
 s6-20020a814506000000b00577619ed3c9mr11980ywa.10.1688637587943; Thu, 06 Jul
 2023 02:59:47 -0700 (PDT)
Date:   Thu,  6 Jul 2023 02:59:14 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706095915.2256452-1-koudai@google.com>
Subject: [PATCH] scripts/gdb: Fix lx-symbols command for arm64 LLVM
From:   Koudai Iwahori <koudai@google.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Koudai Iwahori <koudai@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx-symbols assumes that module's .text sections is located at
`module->mem[MOD_TEXT].base` and passes it to add-symbol-file command.
However, .text section follows after .plt section in modules built by
LLVM toolchain for arm64 target. Symbol addresses are skewed in GDB.

Fix this issue by using the address of .text section stored in
`module->sect_attrs`.

Signed-off-by: Koudai Iwahori <koudai@google.com>
---
 scripts/gdb/linux/symbols.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index fdad3f32c747..c8047f4441e6 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -89,23 +89,27 @@ lx-symbols command."""
                 return name
         return None
 
-    def _section_arguments(self, module):
+    def _section_arguments(self, module, module_addr):
         try:
             sect_attrs = module['sect_attrs'].dereference()
         except gdb.error:
-            return ""
+            return str(module_addr)
+
         attrs = sect_attrs['attrs']
         section_name_to_address = {
             attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
+
+        textaddr = section_name_to_address.get(".text", module_addr)
         args = []
         for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
-                             ".text", ".text.hot", ".text.unlikely"]:
+                             ".text.hot", ".text.unlikely"]:
             address = section_name_to_address.get(section_name)
             if address:
                 args.append(" -s {name} {addr}".format(
                     name=section_name, addr=str(address)))
-        return "".join(args)
+        return "{textaddr} {sections}".format(
+            textaddr=textaddr, sections="".join(args))
 
     def load_module_symbols(self, module):
         module_name = module['name'].string()
@@ -125,10 +129,9 @@ lx-symbols command."""
                 module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
             gdb.write("loading @{addr}: {filename}\n".format(
                 addr=module_addr, filename=module_file))
-            cmdline = "add-symbol-file {filename} {addr}{sections}".format(
+            cmdline = "add-symbol-file {filename} {sections}".format(
                 filename=module_file,
-                addr=module_addr,
-                sections=self._section_arguments(module))
+                sections=self._section_arguments(module, module_addr))
             gdb.execute(cmdline, to_string=True)
             if module_name not in self.loaded_modules:
                 self.loaded_modules.append(module_name)
-- 
2.41.0.255.g8b1d071c50-goog

