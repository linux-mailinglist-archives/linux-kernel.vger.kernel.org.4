Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783156F2BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEACO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEACO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:14:57 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42EE4E;
        Sun, 30 Apr 2023 19:14:55 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-2f833bda191so1105640f8f.1;
        Sun, 30 Apr 2023 19:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682907294; x=1685499294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF2Oq+4K4N5QrRxu/ofhiyU4ka4upW1zrADy8lB3cuE=;
        b=PKKfCuDg2FFpsyKPwverRrurvazHKM/00biQQV+UOTz9IluBCGu9EPNmEhedbGh9sa
         a3+WnulHyyVbV16ByjohZBR1ZoTlqyt37pPxyfYyTq25Vp9fxcF1B6SyzeF54uSlV5hL
         2m8EPPgkPVvU++Ma3BPINyDqABAVy40i0ZkQYQAwZ++qrUJ84mjLk/g8SGiRx+V8Mq+T
         3qXuUBe/zzHvVrgF86aFBe1sMZnW7W8pu7qK4hxNm/KHQAwXdh1Wzkxyt8d8fWq2Hix2
         gTB6Y7MxPuC44qzzt1RhDrvyPQIX+X1RFPW0/NQUitbSIj2W60Ygz0RaDOqY5PoE3aGN
         zKzQ==
X-Gm-Message-State: AC+VfDzITdLYa1BDp0Fhup21DZLWJ1N/3wEVTqijwFq/uvBzFLisubGN
        lE2C6dppHMRglXVdpUbNnKM=
X-Google-Smtp-Source: ACHHUZ5rVWvxu8Sibinq6YwcXcWI6z+7WASAxvSNQ9LLZxDkWeF5bCHy7NVBndlye7bH+pGkGQxPIQ==
X-Received: by 2002:a5d:5186:0:b0:306:2b5f:8d0a with SMTP id k6-20020a5d5186000000b003062b5f8d0amr2029597wrv.56.1682907294075;
        Sun, 30 Apr 2023 19:14:54 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b003062d3daf79sm1568660wrb.107.2023.04.30.19.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:14:53 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] docs: automatic redirects for moved pages
Date:   Mon,  1 May 2023 05:13:36 +0300
Message-Id: <20230501021338.182770-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problems:
- The documentation is not well-organized
- Relocating pages disrupts external links to
  the documentation and causes confusion for users

Benefits:
- Users can easily access relocated pages from external resources
- Using redirects frees up options for reorganizing the documentation

The solution:
- To prevent the need for ongoing maintenance, extract renames
  from git log since specified age
- Input the renames into sphinx_reredirects module

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes:
- added the extraction of renames from Git.

---
 Documentation/Makefile                |  8 +++++++-
 Documentation/conf.py                 | 17 ++++++++++++++++-
 Documentation/sphinx/requirements.txt |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 023fa658a0a8..fae385cf4d6d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -91,10 +91,16 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
 	fi
 
-htmldocs:
+htmldocs: Documentation/redirects
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
+Documentation/redirects: $(srctree)/**/*.rst
+	git log --since="5 years ago" \
+		--name-status --find-renames=30 --diff-filter=R \
+		$(srctree)/Documentation/ \
+		| grep ^R | cut -f2,3 > $@
+
 texinfodocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,texinfo,$(var),texinfo,$(var)))
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 37314afd1ac8..16c5036992a0 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -16,6 +16,7 @@ import sys
 import os
 import sphinx
 import shutil
+import re
 
 # helper
 # ------
@@ -55,7 +56,21 @@ needs_sphinx = '1.7'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat']
+              'kernel_abi', 'kernel_feat',
+              'sphinx_reredirects',
+]
+
+redirects = dict()
+
+with open('redirects', 'r') as f:
+    for line in f:
+        p = r'Documentation/(.*)\.rst'
+        m = re.search(f'{p}\t{p}', line)
+        if not m or os.path.isfile(line.split()[0]):
+            continue
+        redirects[m.group(1) + '.html'] = os.path.relpath(m.group(2),
+            os.path.dirname(m.group(1))) + '.html'
+
 
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..0b067e985edb 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,4 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+sphinx_reredirects
-- 
2.40.0

