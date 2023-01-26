Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14067D1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjAZQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAZQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:37:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D2582B5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:37:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E7F6618CF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27F6C433D2;
        Thu, 26 Jan 2023 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674751042;
        bh=ryGPUF32nKHhyabeNtGfSAa4/G/lqURWY+WbhlGb5d4=;
        h=From:To:Cc:Subject:Date:From;
        b=a61HN6PfIq8jZ5UL1z9LnrQxD+UAyZesy8pbARYvfoRvKhEvXkNmw73mH4GZ+Gbzu
         kMhoTCgaYwFbrrVbBQ8ntHLbEW1UcnvipjIHH76OfLBHwDxcDd6Qf3xY3URYICuplx
         HfOuzanT95nZX2Kv3vBXguOsb+tEj9oN2uO+zSTN0YVqjCHWcMmPuiiv3Z8s57E6lQ
         CwbkWfxxSuqmvUG3j3TKHop3fXj2uFUgaBrNlOp7SQdM/Ed4Zeb4xUIoqq4XyxxvR+
         KkgfO9SUgRP7Abf45QWf9UuyZwb0b2c2/V95adL15dw7Id7MVn5QiWMkt09dh3fTol
         zElob/Nx4NGYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Finn Behrens <me@kloenk.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Date:   Thu, 26 Jan 2023 17:37:06 +0100
Message-Id: <20230126163719.3585002-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_VFIO_MDEV cannot be selected when VFIO itself is
disabled, otherwise we get a link failure:

WARNING: unmet direct dependencies detected for VFIO_MDEV
  Depends on [n]: VFIO [=n]
  Selected by [y]:
  - SAMPLE_VFIO_MDEV_MTTY [=y] && SAMPLES [=y]
  - SAMPLE_VFIO_MDEV_MDPY [=y] && SAMPLES [=y]
  - SAMPLE_VFIO_MDEV_MBOCHS [=y] && SAMPLES [=y]
/home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_remove':
mdpy.c:(.text+0x1e1): undefined reference to `vfio_unregister_group_dev'
/home/arnd/cross/arm64/gcc-13.0.1-nolibc/x86_64-linux/bin/x86_64-linux-ld: samples/vfio-mdev/mdpy.o: in function `mdpy_probe':
mdpy.c:(.text+0x149e): undefined reference to `_vfio_alloc_device'

Fixes: 8bf8c5ee1f38 ("vfio-mdev: turn VFIO_MDEV into a selectable symbol")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 56b191d128d8..44a09dfa8a0b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -185,6 +185,7 @@ config SAMPLE_UHID
 
 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code"
+	depends on VFIO
 	select VFIO_MDEV
 	help
 	  Build a virtual tty sample driver for use as a VFIO
@@ -192,6 +193,7 @@ config SAMPLE_VFIO_MDEV_MTTY
 
 config SAMPLE_VFIO_MDEV_MDPY
 	tristate "Build VFIO mdpy example mediated device sample code"
+	depends on VFIO
 	select VFIO_MDEV
 	help
 	  Build a virtual display sample driver for use as a VFIO
@@ -209,6 +211,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
 
 config SAMPLE_VFIO_MDEV_MBOCHS
 	tristate "Build VFIO mdpy example mediated device sample code"
+	depends on VFIO
 	select VFIO_MDEV
 	select DMA_SHARED_BUFFER
 	help
-- 
2.39.0

