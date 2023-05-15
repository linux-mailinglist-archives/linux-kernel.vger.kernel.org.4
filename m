Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34D702795
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbjEOIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjEOIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:52:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E951AE;
        Mon, 15 May 2023 01:52:24 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pyTwK-000721-PL; Mon, 15 May 2023 10:52:20 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] docs: quickly-build-trimmed-linux: various small fixes and improvements
Date:   Mon, 15 May 2023 10:52:19 +0200
Message-Id: <6f4684b9a5d11d3adb04e0af3cfc60db8b28eeb2.1684140700.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1684140744;00699a24;
X-HE-SMSGID: 1pyTwK-000721-PL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* improve the short description of localmodconfig in the step-by-step
  guide while fixing its broken first sentence

* briefly mention immutable Linux distributions

* use '--shallow-exclude=v6.0' throughout the document

* instead of "git reset --hard; git checkout ..." use "git checkout
  --force ..." in the step-by-step guide: this matches the TLDR and is
  one command less to execute. This led to a few small adjustments to
  the text and the flow in the surrounding area.

* fix two thinkos in the section explaining full git clones

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

Hi. Let me know if you would have prefered this as five seperate
commits. Ciao, Thorsten
---
 .../quickly-build-trimmed-linux.rst           | 49 ++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/quickly-build-trimmed-linux.rst b/Documentation/admin-guide/quickly-build-trimmed-linux.rst
index ff4f4cc8522b..f08149bc53f8 100644
--- a/Documentation/admin-guide/quickly-build-trimmed-linux.rst
+++ b/Documentation/admin-guide/quickly-build-trimmed-linux.rst
@@ -215,12 +215,14 @@ again.
    reduce the compile time enormously, especially if you are running an
    universal kernel from a commodity Linux distribution.
 
-   There is a catch: the make target 'localmodconfig' will disable kernel
-   features you have not directly or indirectly through some program utilized
-   since you booted the system. You can reduce or nearly eliminate that risk by
-   using tricks outlined in the reference section; for quick testing purposes
-   that risk is often negligible, but it is an aspect you want to keep in mind
-   in case your kernel behaves oddly.
+   There is a catch: 'localmodconfig' is likely to disable kernel features you
+   did not use since you booted your Linux -- like drivers for currently
+   disconnected peripherals or a virtualization software not haven't used yet.
+   You can reduce or nearly eliminate that risk with tricks the reference
+   section outlines; but when building a kernel just for quick testing purposes
+   it is often negligible if such features are missing. But you should keep that
+   aspect in mind when using a kernel built with this make target, as it might
+   be the reason why something you only use occasionally stopped working.
 
    [:ref:`details<configuration>`]
 
@@ -271,6 +273,9 @@ again.
    does nothing at all; in that case you have to manually install your kernel,
    as outlined in the reference section.
 
+   If you are running a immutable Linux distribution, check its documentation
+   and the web to find out how to install your own kernel there.
+
    [:ref:`details<install>`]
 
 .. _another_sbs:
@@ -291,29 +296,29 @@ again.
    version you care about, as git otherwise might retrieve the entire commit
    history::
 
-     git fetch --shallow-exclude=v6.1 origin
-
-   If you modified the sources (for example by applying a patch), you now need
-   to discard those modifications; that's because git otherwise will not be able
-   to switch to the sources of another version due to potential conflicting
-   changes::
-
-     git reset --hard
+     git fetch --shallow-exclude=v6.0 origin
 
-   Now checkout the version you are interested in, as explained above::
+   Now switch to the version you are interested in -- but be aware the command
+   used here will discard any modifications you performed, as they would
+   conflict with the sources you want to checkout::
 
-     git checkout --detach origin/master
+     git checkout --force --detach origin/master
 
    At this point you might want to patch the sources again or set/modify a build
-   tag, as explained earlier; afterwards adjust the build configuration to the
-   new codebase and build your next kernel::
+   tag, as explained earlier. Afterwards adjust the build configuration to the
+   new codebase using olddefconfig, which will now adjust the configuration file
+   you prepared earlier using localmodconfig  (~/linux/.config) for your next
+   kernel::
 
      # reminder: if you want to apply patches, do it at this point
      # reminder: you might want to update your build tag at this point
      make olddefconfig
+
+   Now build your kernel::
+
      make -j $(nproc --all)
 
-   Install the kernel as outlined above::
+   Afterwards install the kernel as outlined above::
 
      command -v installkernel && sudo make modules_install install
 
@@ -584,11 +589,11 @@ versions and individual commits at hand at any time::
     curl -L \
       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle \
       -o linux-stable.git.bundle
-    git clone clone.bundle ~/linux/
+    git clone linux-stable.git.bundle ~/linux/
     rm linux-stable.git.bundle
     cd ~/linux/
-    git remote set-url origin
-    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+    git remote set-url origin \
+      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
     git fetch origin
     git checkout --detach origin/master
 

base-commit: cdc822dda6f82269b94d5fa60ddc71d98c160fa0
-- 
2.40.1

