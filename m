Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF36F71B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEDSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:02:58 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3681BCC;
        Thu,  4 May 2023 11:02:56 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f182d745deso8688755e9.0;
        Thu, 04 May 2023 11:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683223375; x=1685815375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZDZ8YxdhDn5mPRZaBC8fY/+Z68in9GRyIAk1Dnoetc=;
        b=Kl79NMdhU4m3mUbihXEUL8U6/uIEw0kekZUvEQ4VVd/whqOl3+kOn7yzi8w47q1F1e
         7/nlT2XrZduHKJHJIsZvkAZFjdyRoB8ehWCcQ/lngm+PjcvVccCDUzVajmjU+sZlF2fG
         3tSe2DcYsV3wxDY0YE1PI/F7iSHBEumgPadM7lx0Vbhc/c+tM7ZftQAakgft2fen7RAA
         CKECkkiZLNnCfoP4Ho3vf8eUsDY14sop6i+SvdIdIsrFHKnfaLqMw4IkAmcj6C+Pies0
         HmQau+tm0hzMlRYjD7aUWovGGFv/ZpHI6jWCKG7+JgPDsdwS+iWZi3B6nfQHiVSjC1lx
         AgHw==
X-Gm-Message-State: AC+VfDxxRFr+ZV4NJ8ZYIKTNmnLgzMWP7HC0+sSU5A5SOxmbNEvKl0VN
        H7BBxs4VmZQVnKH/5Wp5sqtwiEd3W9HlUVYi
X-Google-Smtp-Source: ACHHUZ7DBR9JLJxcGYEzgKy6RZn8Pk58Li37tq9w2jOkGLDCeZjMsgu0U1JZXU2UqbD7d8dCxpFZQw==
X-Received: by 2002:a1c:6a0d:0:b0:3f1:72ee:97b7 with SMTP id f13-20020a1c6a0d000000b003f172ee97b7mr393450wmc.15.1683223374722;
        Thu, 04 May 2023 11:02:54 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003f03d483966sm5560826wma.44.2023.05.04.11.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:02:54 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-openrisc@vger.kernel.org (open list:OPENRISC ARCHITECTURE),
        linux-parisc@vger.kernel.org (open list:PARISC ARCHITECTURE),
        linux-sh@vger.kernel.org (open list:SUPERH)
Subject: [PATCH v3] docs: directive `alias` for redirects
Date:   Thu,  4 May 2023 21:01:52 +0300
Message-Id: <20230504180210.727364-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and several redirects for moved main arch pages

Problems:
- The documentation lacks hierarchy
- Relocating pages disrupts external links to
  the documentation and causes confusion for users

Benefits:
- Users can easily access relocated pages from external resources
- Using redirects frees up options for reorganizing the documentation

The solution:
- Introduced directive `alias` which declares previous path of
  a moved document as the argument.
- Redirects are implemented with Sphinx extension rediraffe_redirects.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes:
- complete new implementation
---
 Documentation/arch/arc/index.rst        |  2 ++
 Documentation/arch/ia64/index.rst       |  2 ++
 Documentation/arch/index.rst            |  2 ++
 Documentation/arch/m68k/index.rst       |  2 ++
 Documentation/arch/nios2/index.rst      |  2 ++
 Documentation/arch/openrisc/index.rst   |  2 ++
 Documentation/arch/parisc/index.rst     |  2 ++
 Documentation/arch/sh/index.rst         |  2 ++
 Documentation/arch/sparc/index.rst      |  2 ++
 Documentation/arch/x86/index.rst        |  2 ++
 Documentation/arch/x86/x86_64/index.rst |  2 ++
 Documentation/arch/xtensa/index.rst     |  2 ++
 Documentation/conf.py                   |  9 +++++++
 Documentation/sphinx/alias.py           | 35 +++++++++++++++++++++++++
 Documentation/sphinx/requirements.txt   |  1 +
 15 files changed, 69 insertions(+)
 create mode 100644 Documentation/sphinx/alias.py

diff --git a/Documentation/arch/arc/index.rst b/Documentation/arch/arc/index.rst
index 7b098d4a5e3e..c2be040f04c3 100644
--- a/Documentation/arch/arc/index.rst
+++ b/Documentation/arch/arc/index.rst
@@ -15,3 +15,5 @@ ARC architecture
    =======
 
    * :ref:`genindex`
+
+.. alias:: arc/index
diff --git a/Documentation/arch/ia64/index.rst b/Documentation/arch/ia64/index.rst
index 761f2154dfa2..c4f973f17af2 100644
--- a/Documentation/arch/ia64/index.rst
+++ b/Documentation/arch/ia64/index.rst
@@ -17,3 +17,5 @@ IA-64 Architecture
    serial
 
    features
+
+.. alias:: ia64/index
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 80ee31016584..11be66e23de4 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -26,3 +26,5 @@ implementation.
    sparc/index
    x86/index
    xtensa/index
+
+.. alias:: arch
diff --git a/Documentation/arch/m68k/index.rst b/Documentation/arch/m68k/index.rst
index 0f890dbb5fe2..9b5c34510fb7 100644
--- a/Documentation/arch/m68k/index.rst
+++ b/Documentation/arch/m68k/index.rst
@@ -18,3 +18,5 @@ m68k Architecture
    =======
 
    * :ref:`genindex`
+
+.. alias:: m68k/index
diff --git a/Documentation/arch/nios2/index.rst b/Documentation/arch/nios2/index.rst
index 4468fe1a1037..bfaf0e963db3 100644
--- a/Documentation/arch/nios2/index.rst
+++ b/Documentation/arch/nios2/index.rst
@@ -10,3 +10,5 @@ Nios II Specific Documentation
 
    nios2
    features
+
+.. alias:: nios2/index
diff --git a/Documentation/arch/openrisc/index.rst b/Documentation/arch/openrisc/index.rst
index 6879f998b87a..b59d97d6f8b7 100644
--- a/Documentation/arch/openrisc/index.rst
+++ b/Documentation/arch/openrisc/index.rst
@@ -18,3 +18,5 @@ OpenRISC Architecture
    =======
 
    * :ref:`genindex`
+
+.. alias:: openrisc/index
diff --git a/Documentation/arch/parisc/index.rst b/Documentation/arch/parisc/index.rst
index 240685751825..aaa708c7f98d 100644
--- a/Documentation/arch/parisc/index.rst
+++ b/Documentation/arch/parisc/index.rst
@@ -18,3 +18,5 @@ PA-RISC Architecture
    =======
 
    * :ref:`genindex`
+
+.. alias:: parisc/index
diff --git a/Documentation/arch/sh/index.rst b/Documentation/arch/sh/index.rst
index c64776738cf6..5a12d76abec4 100644
--- a/Documentation/arch/sh/index.rst
+++ b/Documentation/arch/sh/index.rst
@@ -54,3 +54,5 @@ Maple
 
 .. kernel-doc:: drivers/sh/maple/maple.c
    :export:
+
+.. alias:: sh/index
diff --git a/Documentation/arch/sparc/index.rst b/Documentation/arch/sparc/index.rst
index ae884224eec2..f2731a4925c3 100644
--- a/Documentation/arch/sparc/index.rst
+++ b/Documentation/arch/sparc/index.rst
@@ -11,3 +11,5 @@ Sparc Architecture
    oradax/oracle-dax
 
    features
+
+.. alias:: sparc/index
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index c73d133fd37c..2154bfe2b6ca 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -42,3 +42,5 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+
+.. alias:: x86/index
diff --git a/Documentation/arch/x86/x86_64/index.rst b/Documentation/arch/x86/x86_64/index.rst
index a56070fc8e77..d4eb610b0080 100644
--- a/Documentation/arch/x86/x86_64/index.rst
+++ b/Documentation/arch/x86/x86_64/index.rst
@@ -15,3 +15,5 @@ x86_64 Support
    cpu-hotplug-spec
    machinecheck
    fsgs
+
+.. alias:: x86/x86_64/index
diff --git a/Documentation/arch/xtensa/index.rst b/Documentation/arch/xtensa/index.rst
index 69952446a9be..a794bddddad4 100644
--- a/Documentation/arch/xtensa/index.rst
+++ b/Documentation/arch/xtensa/index.rst
@@ -12,3 +12,5 @@ Xtensa Architecture
    mmu
 
    features
+
+.. alias:: xtensa/index
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 37314afd1ac8..068f85e5dd1f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -16,6 +16,7 @@ import sys
 import os
 import sphinx
 import shutil
+from importlib.util import find_spec
 
 # helper
 # ------
@@ -57,6 +58,14 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
               'kernel_abi', 'kernel_feat']
 
+extensions += ['alias'] # uses rediraffe
+
+if find_spec('sphinxext.rediraffe'):
+    extensions += ['sphinxext.rediraffe']
+    rediraffe_redirects = { }
+else:
+    print("Skipping redirects because sphinxext.rediraffe is not installed")
+
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
         # Sphinx c function parser is more pedantic with regards to type
diff --git a/Documentation/sphinx/alias.py b/Documentation/sphinx/alias.py
new file mode 100644
index 000000000000..e00605d07dbd
--- /dev/null
+++ b/Documentation/sphinx/alias.py
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+
+u"""
+    Directive `alias`
+    ~~~~~~~~~~~~~~~
+    Provides browser redirects for moved pages.
+
+    The directive declares previous path of a moved document as the argument.
+    Redirects are implemented with Sphinx extension rediraffe_redirects.
+
+    :copyright: Copyright 2023 Costa Shulyupin <costa.shul@redhat.com>
+    :license:   GPL Version 2, June 1991 see linux/COPYING for details.
+
+"""
+
+from docutils.parsers.rst import Directive
+import os
+
+
+class AliasDirective(Directive):
+    required_arguments = 1
+
+    def run(self):
+        env = self.state.document.settings.env
+        if 'rediraffe_redirects' not in env.config:
+            return []
+        env.config.rediraffe_redirects[self.arguments[0]] \
+            = os.path.relpath(self.state.document.current_source,
+                              env.srcdir)
+        return []
+
+
+def setup(app):
+    app.add_directive('alias', AliasDirective)
+    return { 'parallel_read_safe': False, 'parallel_write_safe': False }
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..9ff99beb5ed3 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,4 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+rediraffe_redirects
-- 
2.40.0

