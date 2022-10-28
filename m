Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4668D611DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJ1WtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJ1WtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:49:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2E61EA561
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:48:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso11115395pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0xiJp4XHOD7FpE79mlTo4FZ8hKLVDdbQ6PJGlmtm0c=;
        b=mzDl6TMyHJf63jH7iKtcAAGM8XDN0rgDSAUs7hfgOey2i6dDPc9aOOCZYNZNETkm2j
         yVEIR85X+aSQjrVbZpYjQoDLmGgkswWXkfsecH1i+hYCnMCRGj96w+Nxrz2B/QCGVpZQ
         gtgV0voDj/MPBaheBlaJn/W0fjq4tkMXfBnrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0xiJp4XHOD7FpE79mlTo4FZ8hKLVDdbQ6PJGlmtm0c=;
        b=us+P5QHKaw9R6Pg+6ouWNJtttfJ4G7k5JOtQAJFKwKumYf47F+r2cC9fgErj7eHHSp
         pGey63k2+HajugNTcdXAfJ1Fiv1FejiRvrsd0/YL2KfcID8bKbdByAGBf2XEtA7/L7qp
         hVn+rf+MAbp9EhxyPwobjyrJlnwP5gqlToo9wwl9rxaacHN9CwbNwCFOjq60MKiMEAGb
         VLzPzJy80aSC9QXiyIUy/vG/K0lBBz3Fv10RIPboBzyFK8VHxRwAr+H1H0PYVL0he45r
         s81TsuJ+Tj8eATajKHfEETKeofa0ltMmWz2iAipWcNtRm6TOTe9+51TA9HqzOxq0plV9
         oT0w==
X-Gm-Message-State: ACrzQf2O/MnJOLSJEIXCdzWfxDrPtexB1ytWWbjPrw0N/eEY/eAvEhkY
        DOmqezFuWGPSmhi+MaZQWDrYnQ==
X-Google-Smtp-Source: AMsMyM6gOemtrc+N4udmSmBnnTAvh0sGPbgP5WutWSSxft54Cqt48ebDSnWboQa9R6hvi7GWIMFDSQ==
X-Received: by 2002:a17:902:848c:b0:17a:b4c0:a02b with SMTP id c12-20020a170902848c00b0017ab4c0a02bmr1355571plo.122.1666997302622;
        Fri, 28 Oct 2022 15:48:22 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id bd13-20020a656e0d000000b0043c9da02729sm3161736pgb.6.2022.10.28.15.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:48:22 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] drm/amdgpu: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 15:48:13 -0700
Message-Id: <20221028154718.2.I30f27b240e63cc269076556407e6eddcf5177b5e@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028224813.1466450-1-briannorris@chromium.org>
References: <20221028224813.1466450-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver often takes over 200ms to start, so it can improve boot
speed to probe it asynchronously.

I did a short review of the driver, and apart from an issue fixed in the
parent patch ("drm/amdgpu: Move racy global PMU list into device"),
there don't appear to be many cross-device dependencies or racy accesses
to global state, so this should be safe.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3c9fecdd6b2f..2d180e48df1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2793,7 +2793,10 @@ static struct pci_driver amdgpu_kms_pci_driver = {
 	.probe = amdgpu_pci_probe,
 	.remove = amdgpu_pci_remove,
 	.shutdown = amdgpu_pci_shutdown,
-	.driver.pm = &amdgpu_pm_ops,
+	.driver = {
+		.pm = &amdgpu_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 	.err_handler = &amdgpu_pci_err_handler,
 	.dev_groups = amdgpu_sysfs_groups,
 };
-- 
2.38.1.273.g43a17bfeac-goog

