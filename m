Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506367549B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjATMfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjATMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:28 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14231BD17C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:35:24 -0800 (PST)
Received: from ip4d14bd73.dynamic.kabel-deutschland.de ([77.20.189.115] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pIqc5-0007pV-Ex; Fri, 20 Jan 2023 13:35:21 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?UTF-8?q?Kai=20Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] checkpatch.pl: warn about discouraged tags and missing Link: tags
Date:   Fri, 20 Jan 2023 13:35:17 +0100
Message-Id: <cover.1674217480.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1670152844.git.kai@dev.carbon-project.org>
References: <cover.1670152844.git.kai@dev.carbon-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1674218125;93060bd7;
X-HE-SMSGID: 1pIqc5-0007pV-Ex
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, please consider the following checkpatch.pl patches for review.

The first two changes make checkpatch.pl check for a few mistakes wrt to
links to bug reports Linus recently complained about a few times.
Avoiding those is also important for my regression tracking efforts a
lot, as the automated tracking performed by regzbot relies on the proper
usage of the Link: tag.

The third patch fixes a few small oddities noticed in existing code
during review of the two changes.

Ciao, Thorsten
---
v3->v4:
- address review feedback from Joe (do not allow leading spaces in
matches, check if Link: is actually followed by a URL in one go,
and use m{} for matching https://)  (Thorsten)
- catch Reported-and-tested-by as well (Thorsten)

v2->v3:
- address review feedback from Joe (grammer fixes, use of $herecurr, use
of --no-merges in commit log quote) (Thorsten)
- warn when people try to add version information to the commit log
using code suggested by Joe (Thorsten)
- add a patch to make existing code in a nearby area use $herecurr where
it should, which Joe noticed during review

v1->v2:
- add commit messages explaining the reasoning (Thorsten)
- approach the usage of wrong tags with an allow list as suggested by
Joe (Thorsten)

Kai Wasserbäch (2):
  checkpatch: warn when unknown tags are used for links
  checkpatch: warn when Reported-by: is not followed by Link:

Thorsten Leemhuis (1):
  checkpatch: use proper way for show problematic line

 scripts/checkpatch.pl | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)


base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0

