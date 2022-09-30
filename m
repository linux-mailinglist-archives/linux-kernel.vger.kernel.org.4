Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532AC5F1519
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiI3Vly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiI3Vlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:41:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF44E1830CE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e129so5180092pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=U12h1tulyTWLbCHo9k/gp5lmN36RncBZG5run1h1B84=;
        b=c5qcuCBUlxRFF84dbaO4liM94ZnRawB2C6yLVtW2P6S93M1xGvvZaQgBSRuGXhVJyY
         B44/Z9SqsMfKyz9LeV5CtczacVV/jeQ/4pFNlX7YoSbJHvIs9S/7p3G7VSLT68O5V3m5
         VTLzYbxJsnEwTuOXQh6+NDNZUkLFEE4ht42hiHl4rZcFdGBij5EKLTgG30o1JVslbNzB
         Q8eWJqh+XdvHUWDma9jPtnVwvg1z4QiJv3Tb3EWiXO+KdNbrSja+dyPvcvtj1jDwIDSx
         notfSPuVfhYYvUQUlLrbssaCZK1ZGyqhGcMn6Zouc57KlLkYT7RhySj9R2kK0TwrLEf2
         xoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U12h1tulyTWLbCHo9k/gp5lmN36RncBZG5run1h1B84=;
        b=mVsOG0qqDP1sxzqPpDrqC7dLuPI2YDOjot9oiQRG7vSrEq+Su7jBrlDjRGgUEZsmDG
         qzHbGXUyZBbQsaeS4y47mAT2Rs8Gxm/38vE1t4+F5xifHCBpG1YYt8zRDfQAmrdzFtuj
         w3pzdK68xzfBlfhSinXVWByTeImnS2/acIjvHCfMBheG02HHe7OJl8xKSV26kxVXuyO1
         t7pmYpZA/BRQcpBm46dVvHWlHxRfoJ9BonNeKD4ponlgE1OX9O8lfMqmFyK3mzRQCWRA
         mZLyFsRGgyWrrfdRDlfx4NZqtzk9aON4/Q4HFVWU6tmdejuFdca8fwSxRH0zc3Mw4cS0
         3PZQ==
X-Gm-Message-State: ACrzQf2eX9CEobLuQmDGmGiecLPjLYfAIOuFvB2foyxjHfiEa3SMqEYp
        2Q1Jwzbodo50sBd5X6eG4pk=
X-Google-Smtp-Source: AMsMyM76iIPtlpcWQVZOjeTzjaEHIhP9J5ITCRQx9Mm7wYnAABGcO3Y9OQ3yYCtYQk7vXKKHjeeHPw==
X-Received: by 2002:a05:6a00:1688:b0:53b:4239:7c5c with SMTP id k8-20020a056a00168800b0053b42397c5cmr11114917pfc.81.1664574104246;
        Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p124-20020a62d082000000b0053617cbe2d2sm2281711pfg.168.2022.09.30.14.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:41:44 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc:     "David C . Rankin" <drankinatty@suddenlinkmail.com>,
        Steven J Abner <pheonix.sja@att.net>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [RFC PATCH 1/1] drm/amdgpu: Fix null-ptr-deref in amdgpu_device_fini_sw()
Date:   Sat,  1 Oct 2022 05:41:10 +0800
Message-Id: <20220930214110.1074226-2-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
References: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After amdgpu_device_init() failed, adev->reset_domain may be NULL. Thus
subsequent call to amdgpu_device_fini_sw() may result in null-ptr-deref.

This patch fixes the problem by adding a NULL pointer check around the
code of releasing adev->reset_domain in amdgpu_device_fini_sw().

Fixes: cfbb6b004744 ("drm/amdgpu: Rework reset domain to be refcounted.")

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
Link: https://lore.kernel.org/lkml/a8bce489-8ccc-aa95-3de6-f854e03ad557@suddenlinkmail.com/
Link: https://lore.kernel.org/lkml/AT9WHR.3Z1T3VI9A2AQ3@att.net/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index be7aff2d4a57..204daad06b32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4021,8 +4021,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if (adev->mman.discovery_bin)
 		amdgpu_discovery_fini(adev);
 
-	amdgpu_reset_put_reset_domain(adev->reset_domain);
-	adev->reset_domain = NULL;
+	if (adev->reset_domain) {
+		amdgpu_reset_put_reset_domain(adev->reset_domain);
+		adev->reset_domain = NULL;
+	}
 
 	kfree(adev->pci_state);
 
-- 
2.30.2

