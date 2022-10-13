Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03405FE2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJMTwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJMTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D83E749;
        Thu, 13 Oct 2022 12:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B2361943;
        Thu, 13 Oct 2022 19:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CE3C433D7;
        Thu, 13 Oct 2022 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665690731;
        bh=kq+VTXRBGbc+Il1oDeRNKtbpzt1wNk0H3ymavMN0cx4=;
        h=From:To:Cc:Subject:Date:From;
        b=uoUYfrVMEBJbURQxqlU6KXgElBz3QDSyKK/kQwPTBqW7GVzP926PPsIf/UaAJ3VLx
         1hWgWs2vGn5upy9Vz6+udxL8TLJ233v35pnl7JWt/HZckH0512g34uwa38zr6VtJGm
         0HX85rljaR2tFBXTPxVoxA0PEQfoXMl5J7zz8GxZlIZI0J8d3COA31Y2r4eIBHBVad
         SFP/OIITI2f/TrtDC7Skvoz/rNeL7MvHdbRKqvA9IfUQRyoEW52Xoxyi997lSgpGsd
         koDsRsFrvPfL9bI5VzvP4Iyi7Wn/zkHMqJikIhn+mkJCopz7x+g7sOipV/8hYQrUdp
         wndA8KT3oXTbA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Flax <flatmax@flatmax.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] of: Define of_match_ptr() with PTR_IF() to avoid unused variable warnings
Date:   Thu, 13 Oct 2022 12:51:53 -0700
Message-Id: <20221013195153.2767632-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
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

When CONFIG_OF is disabled and a driver is built in, it is possible for
an of_device_id structure to be unused, which results in a build warning
with W=1 due to -Wunused-const-variable.

For example, in sound/soc/codecs/src4xxx-i2c.c:

  static const struct of_device_id src4xxx_of_match[] = {
      { .compatible = "ti,src4392", },
      { }
  };
  MODULE_DEVICE_TABLE(of, src4xxx_of_match);

  static struct i2c_driver src4xxx_i2c_driver = {
      .driver = {
          .name = "src4xxx",
          .of_match_table = of_match_ptr(src4xxx_of_match),
      },
      .probe = src4xxx_i2c_probe,
      .id_table = src4xxx_i2c_ids,
  };
  module_i2c_driver(src4xxx_i2c_driver);

A configuration with CONFIG_OF=n and CONFIG_SND_SOC_SRC4XXX_I2C=y
produces

  sound/soc/codecs/src4xxx-i2c.c:28:34: warning: unused variable 'src4xxx_of_match' [-Wunused-const-variable]
  static const struct of_device_id src4xxx_of_match[] = {
                                   ^

because of_patch_ptr() expands to NULL when CONFIG_OF=n and
MODULE_DEVICE_TABLE() expands to nothing when MODULE is not set (i.e.,
when the driver is built into the kernel).

This is a similar situation to the power management suspend and resume
functions, which may or may not be used depending on whether or not
CONFIG_PM is set. The solution for a long time was to make the functions
as __maybe_unused but commit c06ef740d401 ("PM: core: Redefine pm_ptr()
macro") adopted a new solution involving IS_ENABLED() and PTR_IF(),
which allows the compiler to see the referenced object at least once in
the file to clear up the unused warning, while simultaneously allowing
the compiler to eliminate unused code in the final object file.

Do the same thing with of_match_ptr() so that unused device IDs do not
cause warnings. This would have prevented several added #ifdef's, such
as the one added by commit 527a7f52529f ("perf/smmuv3: Fix unused
variable warning when CONFIG_OF=n").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/of.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 766d002bddb9..f2a8d411a0f2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
+#include <linux/kconfig.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spinlock.h>
@@ -405,8 +406,6 @@ extern int of_update_property(struct device_node *np, struct property *newprop);
 extern int of_attach_node(struct device_node *);
 extern int of_detach_node(struct device_node *);
 
-#define of_match_ptr(_ptr)	(_ptr)
-
 /*
  * struct property *prop;
  * const __be32 *p;
@@ -843,10 +842,11 @@ static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 	return PHYS_ADDR_MAX;
 }
 
-#define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
 
+#define of_match_ptr(_ptr)	PTR_IF(IS_ENABLED(CONFIG_OF), (_ptr))
+
 /* Default string compare functions, Allow arch asm/prom.h to override */
 #if !defined(of_compat_cmp)
 #define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.37.3

