Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A272EBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbjFMTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjFMTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:12:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180292
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=SrpgzuH0KR9yBiTvlVofkEktvkwwH5sLm2fMqoWHD5Y=; t=1686683527; x=1687893127; 
        b=L9yh2Ai3tnqdzXvMDzeif6BWzWw0fxn8jn0fd97zCgMCZLj8q5hBMga3E+kl5t9bnMxyuxCdwho
        /g3wBQHDAGjGDN5NdUM3CG+UHjUc4v1FC3yLVVfi91l+wubBPw2/LUG4BzqKq3z+zN/NbvykH5+Fj
        WCigeAizo+ILcGopGQy8rplvrobyS2r8JdWLE7Fk1LB9HdbqcKGbtQ6IdQYeKhT0rMEFucIZC3AnT
        +9YklRYgMYBuxsMol0GRHDwUJPilBdASxxYCkFytG1VsZdJRyDNiWVjdyLUj2K4Myrnu90CYZPe3f
        Q68ul3O+GTRNcWvn89iwVeccIXb/Y99gF5Lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q99Qx-005B5P-30;
        Tue, 13 Jun 2023 21:12:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gdb: linux: make SB_* constants gdb-parsed
Date:   Tue, 13 Jun 2023 21:11:59 +0200
Message-Id: <20230613211159.b1faefb1a1bd.Ie873f66db5555c014c4afc15678e4fd5cfeca226@changeid>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

These now contain "UL" suffixes due to the use of BIT(),
so they need to be parsed by gdb since python doesn't
understand that.

Also fix a comment typo while at it.

ticket=none

Fixes: f15afbd34d8f ("fs: fix undefined behavior in bit shift for SB_NOUSER")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 scripts/gdb/linux/constants.py.in | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 471300ba176c..646fffddd862 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -48,14 +48,14 @@ if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
 
 /* linux/fs.h */
-LX_VALUE(SB_RDONLY)
-LX_VALUE(SB_SYNCHRONOUS)
-LX_VALUE(SB_MANDLOCK)
-LX_VALUE(SB_DIRSYNC)
-LX_VALUE(SB_NOATIME)
-LX_VALUE(SB_NODIRATIME)
+LX_GDBPARSED(SB_RDONLY)
+LX_GDBPARSED(SB_SYNCHRONOUS)
+LX_GDBPARSED(SB_MANDLOCK)
+LX_GDBPARSED(SB_DIRSYNC)
+LX_GDBPARSED(SB_NOATIME)
+LX_GDBPARSED(SB_NODIRATIME)
 
-/* linux/htimer.h */
+/* linux/hrtimer.h */
 LX_GDBPARSED(hrtimer_resolution)
 
 /* linux/irq.h */
-- 
2.40.1

