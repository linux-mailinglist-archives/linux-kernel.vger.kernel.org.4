Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C949687A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjBBKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjBBKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:23:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D3B76C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A2A61A41
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1679FC433EF;
        Thu,  2 Feb 2023 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675333431;
        bh=GQnjXYU/0vipHeT3iMCCPZhv1dMM4Kiss8fVyftaCCs=;
        h=From:To:Cc:Subject:Date:From;
        b=FO9KuJmGsOGokap/NEOXVwllrmT7/6YtYkfeRLa2ZwjrTHQ8zI26aUPp0/nfeN/t9
         cCjFtnkV0KssN6qacocE4N7GjxfflefrDXQveEVBTwUnlElU2mExy2WxQfZKlBfS7K
         OzuhIA636DPK8xJWjTIqf8hskhTkaHv6Bd4lDXGK/RdjnQCYLvghkCO/ZmcDrxHxF2
         6/HD5LaqWB3sh7Oo3FI2rtBPSwh6EWDxMQC8g+XWGDreVmqxGZaVN7yFioYRFEcssv
         dgo+j/smoUfTQO3+YoiJHuG2BIYZILCwOU7xMD3GfXCykI0vYvLbxrFwXsnAFcqgkK
         aX4YKVSLCPpqQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        Danilo Krummrich <dakr@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: allow DRM_VC4_KUNIT_TEST to be a loadable module
Date:   Thu,  2 Feb 2023 11:23:32 +0100
Message-Id: <20230202102346.868771-1-arnd@kernel.org>
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

In configurations with CONFIG_KUNIT=m, builting the unit test
into the kernel causes a link failure:

arm-linux-gnueabi-ld: drivers/gpu/drm/vc4/tests/vc4_mock.o: in function `__build_mock':
vc4_mock.c:(.text+0x6e): undefined reference to `kunit_do_failed_assertion'
arm-linux-gnueabi-ld: vc4_mock.c:(.text+0x9c): undefined reference to `kunit_do_failed_assertion'
arm-linux-gnueabi-ld: vc4_mock.c:(.text+0x100): undefined reference to `kunit_ptr_not_err_assert_format'
...

Allow this to be a loadable module as well to have Kconfig
sort out the dependencies correctly.

Fixes: f759f5b53f1c ("drm/vc4: tests: Introduce a mocking infrastructure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/vc4/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
index f423941c028d..91dcf8d174d6 100644
--- a/drivers/gpu/drm/vc4/Kconfig
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -36,7 +36,7 @@ config DRM_VC4_HDMI_CEC
 	  and want to use CEC.
 
 config DRM_VC4_KUNIT_TEST
-	bool "KUnit tests for VC4" if !KUNIT_ALL_TESTS
+	tristate "KUnit tests for VC4" if !KUNIT_ALL_TESTS
 	depends on DRM_VC4 && KUNIT
 	select DRM_KUNIT_TEST_HELPERS
 	default KUNIT_ALL_TESTS
-- 
2.39.0

