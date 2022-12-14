Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4364D32A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLNXRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLNXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:17:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C8A49B54;
        Wed, 14 Dec 2022 15:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=y0gEuKH/snXM4reJy2iBZS+D2gCI2H3vX+4OuvIo0bc=; b=WM2hd1+A7xbC3EX2XAewetR6CY
        4aE6Tob6Zk3nTaQkZAvSxIFgG9kWjPyBYnuAS/f1tMp+mTlpmjHuTl92WqsLk5twX90wvUfjkzwWe
        wSaFZi/uJqeRGdLMVFpX5daTrInynpPuuWAHi9lSEIC5nKYcJrLFOKjCdIgp5odkUYUKqjjRxufCg
        omqyg9YSduPAlksP3XnL1rJ01niy3ldlvoaqShmGTWojYMWIdg9c3GUyzEj8xs5TGKHIJiXM3aKJ1
        bz+tsjIaZFNCrPL3r6GBJmLpUVbTtCjGhxmF+kNnbyZTxhNoVbswMMlJs0PCZZevC4McSNLU8mvlD
        KWbCHt/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5b03-004Cjf-MO; Wed, 14 Dec 2022 23:17:19 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, linux-kbuild@vger.kernel.org,
        alison.schofield@intel.com, dan.j.williams@intel.com
Cc:     dave@stgolabs.net, a.manzanares@samsung.com, mcgrof@kernel.org,
        lucas.de.marchi@gmail.com, linux-cxl@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Modify default INSTALL_MOD_DIR from extra to updates
Date:   Wed, 14 Dec 2022 15:17:18 -0800
Message-Id: <20221214231718.1002194-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default INSTALL_MOD_DIR of using the /lib/modules/$(uname -r)/extra
directory for external modules assumes distributions will have something
like  /etc/depmod.d/dist.conf with:

search updates extra built-in

However, only some Red Hat release have and use the extra stuff for
years now. Meanwhile, the depmod.c tool in kmod has *forever* used
the "updates" directory as part of the search path by default *if*
your distribution does not have any depmod.d configuration.

If you compile and install an external module today, even upstream
kernel mock drivers (tools/testing/cxl) the modules_install target
will pick up the new drivers but will not allow override of drivers
from updates to override built-in ones.

Since module-init-tools was deprecated over 11 years ago and now kmod
has since its inception used the "updates" directory as part of its
default search path to allow overrides, and since the "extra" stuff
was in practice only used by Red Hat stuff, use the more distro
agnostic override path "updates" to allow external modules to
also override proper production kernel modules.

This would allow mocking drivers tools to not have to muck with
depmod.d config files or assume that your distro will have extra
on a configuration file over built-in.

With today's default you end up actually *crashing* Linux when
trying to load cxl_test with the default "extra" [0] directory being
used. This fixes that and allows other mocking drivers to do
less work.

[0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 scripts/Makefile.modinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 509d424dbbd2..c12ae5c108d4 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -14,7 +14,7 @@ modules := $(sort $(call read-file, $(MODORDER)))
 ifeq ($(KBUILD_EXTMOD),)
 dst := $(MODLIB)/kernel
 else
-INSTALL_MOD_DIR ?= extra
+INSTALL_MOD_DIR ?= updates
 dst := $(MODLIB)/$(INSTALL_MOD_DIR)
 endif
 
-- 
2.35.1

