Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1245974DC00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjGJRK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGJRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:10:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E5C0;
        Mon, 10 Jul 2023 10:10:18 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qIuOu-0006Iv-2k; Mon, 10 Jul 2023 19:10:16 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 3/3] docs: stable-kernel-rules: improve structure to optimize reading flow
Date:   Mon, 10 Jul 2023 19:10:13 +0200
Message-Id: <e25941af193a99b70ee27fcbaa61974fc63a50fd.1689008220.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689008220.git.linux@leemhuis.info>
References: <cover.1689008220.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689009018;df12a5bf;
X-HE-SMSGID: 1qIuOu-0006Iv-2k
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize the text flow to make things more straight forward to follow:

* remove a subheading without real purpose
* after outlining the three options add a section that explains them in
  more detail; move the "Following the submission" text that set in the
  middle of this to a later place in the document
* a few small clarifications along the way

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 156 +++++++++---------
 1 file changed, 81 insertions(+), 75 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 85d5d2368034..a9f36912b9dc 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -40,74 +40,45 @@ Procedure for submitting patches to the -stable tree
    process but should follow the procedures in
    :ref:`Documentation/process/security-bugs.rst <securitybugs>`.
 
-For all other submissions, choose one of the following procedures
------------------------------------------------------------------
+There are three options to submit a change to -stable trees:
 
-.. _option_1:
+ 1. Add a 'stable tag' to the description of a patch you want to mainline.
+ 2. Ask the stable team to pick up a patch already mainlined.
+ 3. Submit a patch to the stable team that is equivalent to a mainlined patch.
 
-Option 1
-********
-
-To have the patch automatically included in the stable tree, add the tag
-
-.. code-block:: none
+The sections below describe each of the options in more detail.
 
-     Cc: stable@vger.kernel.org
-
-in the sign-off area; to accompany a note to the stable team, use a shell-style
-inline comment (see below for details). Once the patch is merged it will be
-applied to the stable tree without anything else needing to be done by the
-author or subsystem maintainer.
-
-.. _option_2:
-
-Option 2
-********
+:ref:`option_1` is **strongly** preferred, it is the easiest and most common.
+:ref:`option_2` and :ref:`option_3` are more useful if the patch isn't deemed
+worthy at the time it is submitted for mainline inclusion (for instance, because
+it deserves more regression testing first). :ref:`option_3` is especially
+useful if the original upstream patch needs to be adjusted to be included in
+older series (for example the backport needs some special handling due to e.g.
+API changes).
 
-After the patch has been merged to Linus' tree, send an email to
-stable@vger.kernel.org containing the subject of the patch, the commit ID,
-why you think it should be applied, and what kernel version you wish it to
-be applied to.
+ .. _option_1:
 
-.. _option_3:
-
-Option 3
+Option 1
 ********
 
-Send the patch, after verifying that it follows the above rules, to
-stable@vger.kernel.org.  You must note the upstream commit ID in the
-changelog of your submission, as well as the kernel version you wish
-it to be applied to.
-
-:ref:`option_1` is **strongly** preferred, is the easiest and most common.
-:ref:`option_2` and :ref:`option_3` are more useful if the patch isn't deemed
-worthy at the time it is applied to a public git tree (for instance, because
-it deserves more regression testing first).  :ref:`option_3` is especially
-useful if the original upstream patch needs to be backported (for example
-the backport needs some special handling due to e.g. API changes).
-
-Note that for :ref:`option_3`, if the patch deviates from the original
-upstream patch (for example because it had to be backported) this must be very
-clearly documented and justified in the patch description.
-
-The upstream commit ID must be specified with a separate line above the commit
-text, like this:
+To have a patch you submit for mainline inclusion automatically picked up for
+the stable tree later, add the tag
 
 .. code-block:: none
 
-    commit <sha1> upstream.
-
-or alternatively:
+     Cc: stable@vger.kernel.org
 
-.. code-block:: none
+in the sign-off area. Once the patch is mainlined it will be applied to the
+stable tree without anything else needing to be done by the author or
+subsystem maintainer.
 
-    [ Upstream commit <sha1> ]
+You can add a note with additional instructions using a shell-style inline
+comment:
 
-Additionally, some patches submitted via :ref:`option_1` may have additional
-patch prerequisites which can be cherry-picked. This can be specified in the
-following format in the sign-off area:
+ * To specify any additional patch prerequisites for cherry picking use the
+   following format in the sign-off area:
 
-.. code-block:: none
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
@@ -115,53 +86,88 @@ following format in the sign-off area:
      Cc: <stable@vger.kernel.org> # 3.3.x
      Signed-off-by: Ingo Molnar <mingo@elte.hu>
 
-The tag sequence has the meaning of:
+   The tag sequence has the meaning of:
 
-.. code-block:: none
+   .. code-block:: none
 
      git cherry-pick a1f84a3
      git cherry-pick 1b9508f
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
-Also, some patches may have kernel version prerequisites.  This can be
-specified in the following format in the sign-off area:
+ * For patches that may have kernel version prerequisites specify them using
+   the following format in the sign-off area:
 
-.. code-block:: none
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # 3.3.x
 
-The tag has the meaning of:
+   The tag has the meaning of:
 
-.. code-block:: none
+   .. code-block:: none
 
      git cherry-pick <this commit>
 
-For each "-stable" tree starting with the specified version.
+   For each "-stable" tree starting with the specified version.
 
-To delay pick up of patches submitted via :ref:`option_1`, use the following
-format:
+ * To delay pick up of patches, use the following format:
 
-.. code-block:: none
+   .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
 
-For any other requests related to patches submitted via :ref:`option_1`, just
-add a note to the stable tag. This for example can be used to point out known
-problems:
+ * For any other requests, just add a note to the stable tag. This for example
+   can be used to point out known problems:
 
-.. code-block:: none
+  .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
 
-Following the submission:
+.. _option_2:
+
+Option 2
+********
+
+If the patch already has been merged to Linus' tree, send an email to
+stable@vger.kernel.org containing the subject of the patch, the commit ID,
+why you think it should be applied, and what kernel version you wish it to
+be applied to.
+
+.. _option_3:
+
+Option 3
+********
+
+Send the patch, after verifying that it follows the above rules, to
+stable@vger.kernel.org and mention the kernel version you wish it to be applied
+to.
+
+When doing so, you must note the upstream commit ID in the changelog of your
+submission with a separate line above the commit text, like this:
+
+.. code-block:: none
+
+    commit <sha1> upstream.
+
+or alternatively:
+
+.. code-block:: none
+
+    [ Upstream commit <sha1> ]
+
+If the patch submitted using this option deviates from the original upstream
+patch (for example because it had to be adjusted for the older API), this must
+be very clearly documented and justified in the patch description.
+
+Following the submission
+------------------------
 
- - The sender will receive an ACK when the patch has been accepted into the
-   queue, or a NAK if the patch is rejected.  This response might take a few
-   days, according to the developer's schedules.
- - If accepted, the patch will be added to the -stable queue, for review by
-   other developers and by the relevant subsystem maintainer.
+The sender will receive an ACK when the patch has been accepted into the queue,
+or a NAK if the patch is rejected.  This response might take a few days,
+according to the developer's schedules.
 
+If accepted, the patch will be added to the -stable queue, for review by other
+developers and by the relevant subsystem maintainer.
 
 Review cycle
 ------------
-- 
2.40.1

