Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68F565DDFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjADVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjADVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:05:59 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FAB1CB13;
        Wed,  4 Jan 2023 13:05:58 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C8E10221;
        Wed,  4 Jan 2023 21:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C8E10221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672866358; bh=/I5jMGvJI4yDPfyzKH+NYcFJAt8liqbzAxDN2FpN6jM=;
        h=From:To:Cc:Subject:Date:From;
        b=jLcGO8MF9b/Ygv163ibwGYWRpan+j7m6K7c1f0O352sh2jK4HXT6ESowCHPFWa4UE
         asO3bh93g9LQiC8mvdE1falMTaj5tl33JvC7N/+rLFnDENPLU56y6+F1YpvVBRF06K
         3uHNyj1d15QCZgirkM2hIsehZD1IuMqmEdwBtHdGg8KmSlABfoxQVGI3zqVGtn4Trd
         679wDPG07KjKeGf+qKXfc8/GAdFiFBO1fDNir1g3035zjLJx1LnvEw2Hpgl775J/R1
         TwgG1Pi6yjNINoPSbYQLL5GXIGHVu7jKS1PtjJaiLLc8kf6h7SZExHrj2EHTa0uWos
         STfiuLvwirOkQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH RFC] docs: Deprecate use of Sphinx < 2.4.x
Date:   Wed, 04 Jan 2023 14:05:57 -0700
Message-ID: <87sfgq9fii.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] docs: Deprecate use of Sphinx < 2.4.x

The Sphinx 2.4 release is three years old, and it is becoming increasingly
difficult to even find a system with an sufficiently archaic Python
installation that can run versions older than that.  I can no longer test
changes against anything prior to 2.4.x.

Move toward raising our minimum Sphinx requirement to 2.4.x so we can
delete some older support code and claim to support a range of versions
that we can actually test.

In the absence of screams, the actual removal of support can happen later
in 2023.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index a5c45df0bd83..44899be7b2cc 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -31,6 +31,12 @@ def have_command(cmd):
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
 
+#
+# Warn about older versions that we don't want to support for much
+# longer.
+#
+if (major < 2) or (major == 2 and minor < 4):
+    print('WARNING: support for Sphinx < 2.4 will be removed soon.')
 
 # If extensions (or modules to document with autodoc) are in another directory,
 # add these directories to sys.path here. If the directory is relative to the
-- 
2.38.1

