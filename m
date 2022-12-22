Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86E654512
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLVQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLVQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:25:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846AD4F;
        Thu, 22 Dec 2022 08:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC91F61C27;
        Thu, 22 Dec 2022 16:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7036C433EF;
        Thu, 22 Dec 2022 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671726340;
        bh=vvag379xei9QKBc4aAnNJasBDyZYO68DL42DBe0lDsc=;
        h=From:To:Cc:Subject:Date:From;
        b=qu1UtskEppTnHBeXtbhhQ5uhSofJOfc6DUqdGx662zT9xlQ++X0InCVEmaUBAYOSC
         lApQL5trAFN/5MzFqU59Ax1RJrb/UUhDDUqZHKsCyIj5YE9olIGPEuTv1+lbfyn9os
         gHpccr7bwXvmNFPjmaJqjsTwiED7CThiqBmsj0sAuvymBFyA5YdOEbDOgV0BypNr0q
         b7r/BxdyR41Bm4vRN3316IQUQNMpWRUQE9pf6mbp0KQ9cbHGwl/482YYW+WXF7YoWy
         oYRdKXwz9REOuy+OulhNWMQ/1fKT1Dbgka9XhkYGPFSFXAMOsBs6CU8LYPHisMq38x
         9WjB0c3Fx+Psw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/5] kbuild: refactor silent mode detection
Date:   Fri, 23 Dec 2022 01:25:31 +0900
Message-Id: <20221222162535.1578462-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out $(findstring s,...).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 25247f931872..e8ce3e2b30d6 100644
--- a/Makefile
+++ b/Makefile
@@ -100,12 +100,12 @@ endif
 # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
 
 ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-silence:=$(findstring s,$(firstword -$(MAKEFLAGS)))
+short-opts := $(firstword -$(MAKEFLAGS))
 else
-silence:=$(findstring s,$(filter-out --%,$(MAKEFLAGS)))
+short-opts := $(filter-out --%,$(MAKEFLAGS))
 endif
 
-ifeq ($(silence),s)
+ifneq ($(findstring s,$(short-opts)),)
 quiet=silent_
 KBUILD_VERBOSE = 0
 endif
-- 
2.34.1

