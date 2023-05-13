Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7A7019B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjEMUhw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 13 May 2023 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjEMUhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:37:51 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750462D51;
        Sat, 13 May 2023 13:37:48 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxvzr-0008Qx-U4; Sat, 13 May 2023 22:37:43 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pxvzr-007djV-0v;
        Sat, 13 May 2023 22:37:43 +0200
Date:   Sat, 13 May 2023 22:37:43 +0200
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH v2 2/2] perf doc: Add support for KBUILD_BUILD_TIMESTAMP
Message-ID: <ZF/1F1P+b9qZ/vVH@decadent.org.uk>
References: <ZF/0jJkAOXxzGAMc@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ZF/0jJkAOXxzGAMc@decadent.org.uk>
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

When building man pages from a Git checkout, we consistently set the
man page date based on when the input was last changed.  Otherwise, it
defaults to the build time, which is not reproducible.

Allow the date to be set through the KBUILD_BUILD_TIMESTAMP variable,
as for timestamps in the kernel itself.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/perf/Documentation/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 8a7d7078e386..4407b106d977 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -250,9 +250,13 @@ $(MAN_HTML): $(OUTPUT)%.html : %.txt
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
-# Generate date from git log of the doc input file
-PERF_DATE = $(shell git log -1 --pretty="format:%cd" \
-                --date=short --no-show-signature $<)
+# Generate date from either KBUILD_BUILD_TIMESTAMP or git log of
+# the doc input file
+PERF_DATE = $(strip \
+              $(if $(KBUILD_BUILD_TIMESTAMP), \
+                $(shell date -u -d '$(KBUILD_BUILD_TIMESTAMP)' +%Y-%m-%d), \
+                $(shell git log -1 --pretty="format:%cd" \
+                    --date=short --no-show-signature $<)))
 
 ifdef USE_ASCIIDOCTOR
 $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
