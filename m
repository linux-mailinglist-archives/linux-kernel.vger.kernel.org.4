Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4A605D79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJTKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiJTKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:38:47 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1851DEC20;
        Thu, 20 Oct 2022 03:38:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSeueAo_1666262304;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0VSeueAo_1666262304)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 18:38:31 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, corbet@lwn.net
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Li <ashimida@linux.alibaba.com>
Subject: [RFC] Documentation: kbuild: Add description of git for reproducible builds
Date:   Thu, 20 Oct 2022 03:38:23 -0700
Message-Id: <20221020103823.31001-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status of git will affect the final compilation result, add it to
the documentation of reproducible builds.

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 Documentation/kbuild/reproducible-builds.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index 071f0151a7a4..13397f38c358 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -119,6 +119,16 @@ To avoid this, you can make the vDSO different for different
 kernel versions by including an arbitrary string of "salt" in it.
 This is specified by the Kconfig symbol ``CONFIG_BUILD_SALT``.
 
+Git
+-----------------------
+
+Uncommitted changes or different commit ids in git can also lead
+to different compilation results. For example, after executing
+``git reset HEAD^``, even if the code is the same, the
+``include/config/kernel.release`` generated during compilation
+will be different, which will eventually lead to binary differences.
+See ``scripts/setlocalversion`` for details.
+
 .. _KBUILD_BUILD_TIMESTAMP: kbuild.html#kbuild-build-timestamp
 .. _KBUILD_BUILD_USER and KBUILD_BUILD_HOST: kbuild.html#kbuild-build-user-kbuild-build-host
 .. _KCFLAGS: kbuild.html#kcflags
-- 
2.17.1

