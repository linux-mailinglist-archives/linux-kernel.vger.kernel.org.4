Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB84649365
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 10:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLKJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 04:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLKJt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 04:49:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC210FD9;
        Sun, 11 Dec 2022 01:49:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C67EB80915;
        Sun, 11 Dec 2022 09:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12EEC433D2;
        Sun, 11 Dec 2022 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670752164;
        bh=3GMvyRizM+Rxblh7pHwRbabkGYlPbTfIEjgrgW67JR4=;
        h=From:To:Cc:Subject:Date:From;
        b=tlxoHj+2xtDqNBEqNRf8IF0m7ZkxeDb7Yu/5Zs2b510WNs6EaenMSHFv8svwpUU5B
         4Szgb6+Pn4UHMwRmr7ubmnUIBEv4uYeQ8JJYbaGefew1qSvkDh47ZNmtsSXggqdn/u
         eCyF/uBLHxOg7dzhOU3xVqi2BueWZnmNouEVg2ZOc6fZgWrv8GBEjQ1o0ddD+KbQ01
         64iNEJyr7vFkM1H+sx7frCHzYT8sT0yV6mfjB3GoU07Sr60r01SqwiMi0QFZlzT740
         Q3meivDTL3+SdQjZbsYoZk16VhkXTSeDSXf0ntWWP5F7bEfQ8QUdNqX6yRwsKDEhod
         S3wV1AOBedpzg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: do not sort after reading modules.order
Date:   Sun, 11 Dec 2022 18:49:18 +0900
Message-Id: <20221211094919.2717594-1-masahiroy@kernel.org>
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

modules.order lists modules in the deterministic order (that is why
"modules order"), and there is no duplication in the list.

$(sort ) is pointless.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modfinal | 2 +-
 scripts/Makefile.modinst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 25bedd83644b..4705d32388f3 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -13,7 +13,7 @@ include $(srctree)/scripts/Kbuild.include
 include $(srctree)/scripts/Makefile.lib
 
 # find all modules listed in modules.order
-modules := $(sort $(shell cat $(MODORDER)))
+modules := $(shell cat $(MODORDER))
 
 __modfinal: $(modules)
 	@:
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index a4c987c23750..f4cff42069ad 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -9,7 +9,7 @@ __modinst:
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-modules := $(sort $(shell cat $(MODORDER)))
+modules := $(shell cat $(MODORDER))
 
 ifeq ($(KBUILD_EXTMOD),)
 dst := $(MODLIB)/kernel
-- 
2.34.1

