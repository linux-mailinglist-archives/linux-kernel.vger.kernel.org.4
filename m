Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654E1723C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjFFI5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbjFFI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:57:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345E310D8;
        Tue,  6 Jun 2023 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Jfqh7+Yp3/D9bkuECnNj4TIYjvEwVcWvp8C30R7kuM=;
        t=1686041836; x=1687251436; b=hwGdMiArSI6kAYcv6P3jHPE9yN8Xe1y/FWd2nqq3hz7J3w+
        lD/2pi1MlCR8/iRbJV6eijBRT62RgKW79Yt7f6EQ2cQEDDwOKGtom8Jwt+1KoWBsItq20P+YKab6N
        Ex9fbSySqEGhBCeIMkhUmff2YjIeWBuoo5Qtr6Ej1PWjpHoTC78I0IgGZofnZpxzte2nbbqjqufgy
        aiu5B66SFluWDk+MKY2m3dv5y0c9IS2nd+HPl62UyA6lnUJDmEyM8wlxEuXh2JfMPFXaVpB1TsY8w
        V96FBFuiDo40swNQJNh+keurzyvytTC82G8q4HR43OUqfADcaBUvsWRA9rLYLJ0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6SV7-00FTy6-1G;
        Tue, 06 Jun 2023 10:57:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/2] kbuild: enable kernel-doc -Wall for W=2
Date:   Tue,  6 Jun 2023 10:57:06 +0200
Message-Id: <20230606105706.eb8a57848349.Ibd08cad396b630b68d93b2469905ad55b375af65@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
References: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
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
v2: - create command-line instead of exporting an
      env var, as suggested by Masahiro Yamada
---
 scripts/Makefile.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 90bb5badb0e9..920eeee2cb6e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -102,6 +102,7 @@ endif
 
 ifneq ($(KBUILD_EXTRA_WARN),)
   cmd_checkdoc = $(srctree)/scripts/kernel-doc -none \
+        $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) \
         $(if $(KDOC_WALL), -Wall) \
         $(if $(KDOC_WRETURN), -Wreturn) \
         $(if $(KDOC_WSHORT_DESC), -Wshort-desc) \
-- 
2.40.1

