Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C45874E719
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGKGUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGKGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:19:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E53E4F;
        Mon, 10 Jul 2023 23:19:57 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qJ6j6-0000FA-55; Tue, 11 Jul 2023 08:19:56 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 2/2] docs: stable-kernel-rules: make rule section more straight forward
Date:   Tue, 11 Jul 2023 08:19:54 +0200
Message-Id: <f83e812879caa978a51a1a7cae7c359f29fc093c.1689056247.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689056247.git.linux@leemhuis.info>
References: <cover.1689056247.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689056398;82679b42;
X-HE-SMSGID: 1qJ6j6-0000FA-55
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak some of the rule text to make things more straight forward, with
the goal to stick closely to the intend of the old text:

* put the "it or equivalent fix must be upstream" rule at the top, as
  it's one of the most important ones that at the same time often seems
  to be missed by developers.
* "It must fix only one thing" was dropped, as that is almost always a
  thing that needs to be handled earlier when the change is mainlined.
  Furthermore, this is already indirectly covered by the "Separate your
  changes" section in Documentation/process/submitting-patches.rst which
  the rules already point to.
* six other rules are in the end one rule with clarifications; structure
  the text accordingly to make it a lot easier to follow and understand
  the intend.
* drop the 'In short, something critical' from one of those notes: it
  contradicts the "real bug that bothers people" aspect somewhat and does
  not really add anything

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v1->v2:
- also drop the 'In short, something critical'
---
 Documentation/process/stable-kernel-rules.rst | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index de0046c0586b..d3f040c2738e 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -6,31 +6,29 @@ Everything you ever wanted to know about Linux -stable releases
 Rules on what kind of patches are accepted, and which ones are not, into the
 "-stable" tree:
 
+ - It or an equivalent fix must already exist in Linus' tree (upstream).
  - It must be obviously correct and tested.
  - It cannot be bigger than 100 lines, with context.
- - It must fix only one thing.
- - It must fix a real bug that bothers people (not a, "This could be a
-   problem..." type thing).
- - It must fix a problem that causes a build error (but not for things
-   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
-   security issue, or some "oh, that's not good" issue.  In short, something
-   critical.
- - Serious issues as reported by a user of a distribution kernel may also
-   be considered if they fix a notable performance or interactivity issue.
-   As these fixes are not as obvious and have a higher risk of a subtle
-   regression they should only be submitted by a distribution kernel
-   maintainer and include an addendum linking to a bugzilla entry if it
-   exists and additional information on the user-visible impact.
- - New device IDs and quirks are also accepted.
- - No "theoretical race condition" issues, unless an explanation of how the
-   race can be exploited is also provided.
- - It cannot contain any "trivial" fixes in it (spelling changes,
-   whitespace cleanups, etc).
  - It must follow the
    :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
    rules.
- - It or an equivalent fix must already exist in Linus' tree (upstream).
-
+ - It must either fix a real bug that bothers people or just add a device ID.
+   To elaborate on the former:
+
+   - It fixes a problem like an oops, a hang, data corruption, a real security
+     issue, a hardware quirk, a build error (but not for things marked
+     CONFIG_BROKEN), or some "oh, that's not good" issue.
+   - Serious issues as reported by a user of a distribution kernel may also
+     be considered if they fix a notable performance or interactivity issue.
+     As these fixes are not as obvious and have a higher risk of a subtle
+     regression they should only be submitted by a distribution kernel
+     maintainer and include an addendum linking to a bugzilla entry if it
+     exists and additional information on the user-visible impact.
+   - No "This could be a problem..." type of things like a "theoretical race
+     condition", unless an explanation of how the bug can be exploited is also
+     provided.
+   - No "trivial" fixes without benefit for users (spelling changes, whitespace
+     cleanups, etc).
 
 Procedure for submitting patches to the -stable tree
 ----------------------------------------------------
-- 
2.40.1

