Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B985EB2E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIZVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIZVLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE7186D9;
        Mon, 26 Sep 2022 14:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57FB61425;
        Mon, 26 Sep 2022 21:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C17C433D6;
        Mon, 26 Sep 2022 21:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664226670;
        bh=wBlxcdqMbsu8JzbcV8TV943wkyA6SKcwME74jFBnb3o=;
        h=From:To:Cc:Subject:Date:From;
        b=jTX9cNJdn9LbGPylOQjsdTT/NvpsjIOUpOvir9tgdhQMv37HCySum+DdpXe9NnOxl
         GwUuSMYTYiKg+bpIZYocanK6OTwANzzGxa6SAIntimr2XW6ZFgMegFgaGLel6t7cE/
         iEGhHm4VUkf+aO9c/cB3U0LkvTsVmJAiKkvx4TEp8Ab48CbEyx02aiHx8oDAPDnIm8
         B82GAa5GXcti8cX2X5aUMxPTyKpHhU6Ko3akJjua0vI+e87DzESK8oBBs0DjtjKpuD
         cXKu27TcCg9Fut5JQco3IMHAxer93uTK8FZrUwQq2H5PRV7gM/aWnp5sYzS+CuosWm
         ca16GSFwFTApQ==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     Arthur Grillo <arthur.grillo@usp.br>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: linux-next: manual merge of the driver-core tree with the drm tree
Date:   Mon, 26 Sep 2022 22:11:02 +0100
Message-Id: <20220926211102.684323-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/gpu/drm/Kconfig

between commits:

  ba8f16cd08190 ("drm: selftest: convert drm_damage_helper selftest to KUnit")
  fc8d29e298cf4 ("drm: selftest: convert drm_mm selftest to KUnit")

from the drm tree and commit:

  84ec67288c10f ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/Kconfig
index 198ba846d34bf,2438e0dccfa16..0000000000000
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@@ -51,9 -50,22 +51,21 @@@ config DRM_DEBUG_M
  
  	  If in doubt, say "N".
  
+ config DRM_USE_DYNAMIC_DEBUG
+ 	bool "use dynamic debug to implement drm.debug"
+ 	default y
+ 	depends on DRM
+ 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
+ 	depends on JUMP_LABEL
+ 	help
+ 	  Use dynamic-debug to avoid drm_debug_enabled() runtime overheads.
+ 	  Due to callsite counts in DRM drivers (~4k in amdgpu) and 56
+ 	  bytes per callsite, the .data costs can be substantial, and
+ 	  are therefore configurable.
+ 
 -config DRM_DEBUG_SELFTEST
 -	tristate "kselftests for DRM"
 -	depends on DRM
 -	depends on DEBUG_KERNEL
 +config DRM_KUNIT_TEST
 +	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
 +	depends on DRM && KUNIT
  	select PRIME_NUMBERS
  	select DRM_DISPLAY_DP_HELPER
  	select DRM_DISPLAY_HELPER
