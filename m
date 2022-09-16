Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496B05BA3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIPBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIPBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:25:19 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A152FE3;
        Thu, 15 Sep 2022 18:25:17 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12803ac8113so50004825fac.8;
        Thu, 15 Sep 2022 18:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=we/qDjsEEkRmB9uRokHCLu2f8y3YPtpNWkqYAj/IL98=;
        b=f8i35YrWhB0or5muFx5oxkQzENiuEKEXDc5ZHWoxhKbi5qXXW76jxZqhxUp7FYx8f2
         6bPI58cjBHJo/KAbMcqX7njm+QCwec+ovmhwK1Rs6gogjFkaznpbGtxTCWi5rZS/gKNo
         Qbq1nkjii3S9vN1rnU609oCG+DCxWxIBsMrDWCz+c7GOp3U7CHhGUQus6FE/fQG3P1/S
         aUrfc1VLGiwqlID1o/QM4XbC61mcH/jbFZu7JLGSk/TNZhEdMm3Lr/VW72rYWZLkI25Z
         B8p6el1JuRN0f/Gs03EvoJ2aqzR9xwiMK1Xwy6H8qM6PzgJHDGsXf1QOXknerWnL5xzz
         XAOg==
X-Gm-Message-State: ACgBeo0BYoyTVMrO1JRq0WxGw3eRf0B1EiRrik9vYkWfZ3YlYrAN1cGj
        AR/DGq7Z4fewFG6gVeer2g==
X-Google-Smtp-Source: AA6agR74FXyXUTi7l5UGPuM/qMCgePdrF2GBBhtCUwsTv5ymPHxdQD0p3cQoMVOmVMJOdbdfMEK2yg==
X-Received: by 2002:a05:6870:2418:b0:101:9461:787c with SMTP id n24-20020a056870241800b001019461787cmr6892531oap.196.1663291516113;
        Thu, 15 Sep 2022 18:25:16 -0700 (PDT)
Received: from xps15.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id ca6-20020a056830610600b00655bb503564sm9242321otb.50.2022.09.15.18.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 18:25:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] dt: Add a check for undocumented compatible strings in kernel
Date:   Thu, 15 Sep 2022 20:25:09 -0500
Message-Id: <20220916012510.2718170-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a make target, dt_compatible_check, to extract compatible strings
from kernel sources and check if they are documented by a schema.
At least version v2022.08 of dtschema with dt-check-compatible is
required.

This check can also be run manually on specific files or directories:

scripts/dtc/dt-extract-compatibles drivers/clk/ | \
  xargs dt-check-compatible -v -s Documentation/devicetree/bindings/processed-schema.json

Currently, there are about 3800 undocumented compatible strings. Most of
these are cases where the binding is not yet converted (given there
are 1900 .txt binding files remaining).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile |  3 +
 Makefile                                   |  4 ++
 scripts/dtc/dt-extract-compatibles         | 68 ++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100755 scripts/dtc/dt-extract-compatibles

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 1eaccf135b30..bf2d8a8ced77 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -75,3 +75,6 @@ always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb,
 # build artifacts here before they are processed by scripts/Makefile.clean
 clean-files = $(shell find $(obj) \( -name '*.example.dts' -o \
 			-name '*.example.dtb' \) -delete 2>/dev/null)
+
+dt_compatible_check: $(obj)/processed-schema.json
+	$(Q)$(srctree)/scripts/dtc/dt-extract-compatibles $(srctree) | xargs dt-check-compatible -v -s $<
diff --git a/Makefile b/Makefile
index f09673b6c11d..7f19e1725b2f 100644
--- a/Makefile
+++ b/Makefile
@@ -1419,6 +1419,10 @@ PHONY += dt_binding_check
 dt_binding_check: scripts_dtc
 	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
 
+PHONY += dt_compatible_check
+dt_compatible_check: dt_binding_check
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings $@
+
 # ---------------------------------------------------------------------------
 # Modules
 
diff --git a/scripts/dtc/dt-extract-compatibles b/scripts/dtc/dt-extract-compatibles
new file mode 100755
index 000000000000..3a6dd3c40ac1
--- /dev/null
+++ b/scripts/dtc/dt-extract-compatibles
@@ -0,0 +1,68 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+import os
+import glob
+import re
+import argparse
+
+
+def parse_of_declare_macros(data):
+	""" Find all compatible strings in OF_DECLARE() style macros """
+	compat_list = []
+	for m in re.finditer(r'(IRQCHIP|OF)_(DECLARE|MATCH)(_DRIVER)?\(.*?\)', data):
+		try:
+			compat = re.search(r'"(.*?)"', m[0])[1]
+		except:
+			# Fails on compatible strings in #define, so just skip
+			continue
+		compat_list += [compat]
+
+	return compat_list
+
+
+def parse_of_device_id(data):
+	""" Find all compatible strings in of_device_id structs """
+	compat_list = []
+	for m in re.finditer(r'of_device_id\s+[a-zA-Z0-9_]+\[\]\s*=\s*({.*?);', data):
+		compat_list += re.findall(r'\.compatible\s+=\s+"([a-zA-Z0-9_\-,]+)"', m[1])
+
+	return compat_list
+
+
+def parse_compatibles(file):
+	with open(file, 'r', encoding='utf-8') as f:
+		data = f.read().replace('\n', '')
+
+	compat_list = parse_of_declare_macros(data)
+	compat_list += parse_of_device_id(data)
+
+	return compat_list
+
+def print_compat(filename, compatibles):
+	if not compatibles:
+		return
+	if show_filename:
+		compat_str = ' '.join(compatibles)
+		print(filename + ": compatible(s): " + compat_str)
+	else:
+		print(*compatibles, sep='\n')
+
+show_filename = False
+
+if __name__ == "__main__":
+	ap = argparse.ArgumentParser()
+	ap.add_argument("cfile", type=str, nargs='*', help="C source files or directories to parse")
+	ap.add_argument('-H', '--with-filename', help="Print filename with compatibles", action="store_true")
+	args = ap.parse_args()
+
+	show_filename = args.with_filename
+
+	for f in args.cfile:
+		if os.path.isdir(f):
+			for filename in glob.iglob(f + "/**/*.c", recursive=True):
+				compat_list = parse_compatibles(filename)
+				print_compat(filename, compat_list)
+		else:
+			compat_list = parse_compatibles(f)
+			print_compat(f, compat_list)
-- 
2.34.1

