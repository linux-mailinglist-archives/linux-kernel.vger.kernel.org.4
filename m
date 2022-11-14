Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74D2627CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiKNLtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiKNLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:48:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA122BCB;
        Mon, 14 Nov 2022 03:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5E0FB80E6C;
        Mon, 14 Nov 2022 11:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F72EC433D7;
        Mon, 14 Nov 2022 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426344;
        bh=G+vw37jjgRCPwdc1JxfhASj9yJQMYjGyuVjD7aOBanE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNTVR7Yx8lZnY0lqCRyi5JIDpYvNn2+K4wTQzUi5xXUVgDX06l8t75Ij7EeS8NQlZ
         o06lTGdDbvZHpYMT522j6EAJwd06l5nk1A7aNKe/tvWylCIsMdnE4KM+MTEalUJRzI
         ayuXBvGeo9yYSyVLjfdNsFq03GLKfLBDxCQdPwFKwk1g+8y0oTLsjLruT9Q0Sw7xHT
         qPNVVdhkm6DKE/RlJDKRg+AcDo61w7nHGAkorUnJttKILR7M3vUgjwJzVqc814df+2
         JOcdH2JCbjj+mVGZQyq0t+w1L2DXuin1C9565yCq5EFq0jwP4qFGVTDa0cZzh//G7T
         /KxlRioeirYBQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 44/46] scripts/bloat-o-meter, lto: handle gcc LTO
Date:   Mon, 14 Nov 2022 12:43:42 +0100
Message-Id: <20221114114344.18650-45-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <ak@linux.intel.com>

gcc LTO can add .lto_priv postfixes to symbols. Ignore those in
bloat-o-meter to allow comparison of non-LTO with LTO kernels.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/bloat-o-meter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index f9553f60a14a..ab994b3bf6e2 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -45,7 +45,7 @@ def getsizes(file, format):
                 if name == "linux_banner": continue
                 if name == "vermagic": continue
                 # statics and some other optimizations adds random .NUMBER
-                name = re_NUMBER.sub('', name)
+                name = re_NUMBER.sub('', name).replace(".lto_priv", "")
                 sym[name] = sym.get(name, 0) + int(size, 16)
     return sym
 
-- 
2.38.1

