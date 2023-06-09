Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BB729398
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbjFIIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbjFIIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:46:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F0E47;
        Fri,  9 Jun 2023 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8c8LFaF/+nfjR8FUn1SGTVmbBSqzu+xt6KI9vgP+uZQ=;
        t=1686300408; x=1687510008; b=CvKa8vYe+22wXjpUl/Gyv7C2id9YYbYIlQlfkpEqQzSnL7B
        hnH9kKeKkj7zp68MoHo7D+2IHyZne2BECJy7/BCSGUdiKIQBKRS4yM0wnbd/rA3bVU3mmKilRvmEX
        0lziAhzVb2cP+pGyAOqSAF06WuuIBOWg7RJPxLKegSK+v/l7AIU1zzdA4DQTXu4MkKhys3wNmAs9T
        JhN/QXnP5QFlbnOHLK1ummdEP3xOkbU5ox8jazQuG9DHjaQwVeKUc9McIUPRYw8yHGOyxMRUrPPSd
        DzpQQQQtrD5EfxmR8zUNWQ15oMGIJg7nzrMZIVchY0pfivMrgUavXAi/34BlEiPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q7Xle-000seH-03;
        Fri, 09 Jun 2023 10:46:46 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 2/2] kbuild: enable kernel-doc -Wall for W=2
Date:   Fri,  9 Jun 2023 10:46:42 +0200
Message-Id: <20230609104642.170be0ce1cf2.Ibd08cad396b630b68d93b2469905ad55b375af65@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609104642.0a5f030f59a5.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
References: <20230609104642.0a5f030f59a5.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
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

For W=2, we can enable more kernel-doc warnings,
such as missing return value descriptions etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 scripts/Makefile.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a0b4fb58201c..ddd644bd032d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -101,7 +101,9 @@ else ifeq ($(KBUILD_CHECKSRC),2)
 endif
 
 ifneq ($(KBUILD_EXTRA_WARN),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) $<
+  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) \
+        $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) \
+        $<
 endif
 
 # Compile C sources (.c)
-- 
2.40.1

