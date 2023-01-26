Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0C67D1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjAZQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjAZQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:38:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09CB4AA62
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:38:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCB4618E8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB66FC433D2;
        Thu, 26 Jan 2023 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674751097;
        bh=6qtgNxbECemucjlcZnysho52hl61i0+xb+1L04Nx6II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDHMo0oZscx3hvSa024f66iPJ8KgOweUrlORbRbz4kuAV3jGG03zI0+Rh7a9uh2eK
         2snSerZvJ/fwoQTAP1ZIkxcXe67XQc10Ba4YA3WjK/zdncb8TuMTTtzkK1gcCfr7BN
         GXcUX5N/xLoi/tCDUAD7/8W7bcxaL7OPD2XuJkNyMaI/c1nPYSuFyG4nanzJLgxJyk
         R03PHKS/sF1Yq2GLeCRE1XCI5YlVJrmRJqQWkkDj78WxWAzwtWDTmC7wSqhuiYnYv7
         acpJD2iIggHlvEUWeXbeEvK2GBMMT50jJ8VNvAF/reJaU2Eg2m8RRIdpKnzSpLF64h
         1w/ob8zWBSKqw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] accel/ivpu: avoid duplciate assignment
Date:   Thu, 26 Jan 2023 17:37:55 +0100
Message-Id: <20230126163804.3648051-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126163804.3648051-1-arnd@kernel.org>
References: <20230126163804.3648051-1-arnd@kernel.org>
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

With extra warnings enabled, gcc warns about two assignments
of the same .mmap callback:

In file included from drivers/accel/ivpu/ivpu_drv.c:10:
include/drm/drm_accel.h:31:27: error: initialized field overwritten [-Werror=override-init]
   31 |         .mmap           = drm_gem_mmap
      |                           ^~~~~~~~~~~~
drivers/accel/ivpu/ivpu_drv.c:360:9: note: in expansion of macro 'DRM_ACCEL_FOPS'
  360 |         DRM_ACCEL_FOPS,
      |         ^~~~~~~~~~~~~~

Remove the unused local assignment.

Fixes: 20709aa9435b ("accel: Add .mmap to DRM_ACCEL_FOPS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/accel/ivpu/ivpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 2bc2f1b90671..a29e8ee0dce6 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -356,7 +356,6 @@ int ivpu_shutdown(struct ivpu_device *vdev)
 
 static const struct file_operations ivpu_fops = {
 	.owner		= THIS_MODULE,
-	.mmap           = drm_gem_mmap,
 	DRM_ACCEL_FOPS,
 };
 
-- 
2.39.0

