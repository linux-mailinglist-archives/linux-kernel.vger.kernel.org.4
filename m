Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085DF6A96EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCCMDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCCMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:03:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41548768D;
        Fri,  3 Mar 2023 04:03:05 -0800 (PST)
Received: from localhost.localdomain (unknown [182.179.171.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08B366602F6A;
        Fri,  3 Mar 2023 12:02:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677844983;
        bh=Hi8NWUOMMhmWak92kY1THi2+V5As1Gogx3xi3UhkAYk=;
        h=From:To:Cc:Subject:Date:From;
        b=JGNkfj0R1zmjv3rck3W64LfaNpmhpZiJvB4SF6QxmIUFL6E894MBBQ9jLy7cLa0UZ
         /WhSqN1k2/TX29VIffjcQeg+keZDXGN66tQtoHqU7Rdv1RWq1UmlUkcoCTKHjvuCqQ
         EGBzKHC8GmC5getS+aJ7vEaKCdXIMA6jNRNXJQWgkOzKGOLzVqDv87zPXVDKcXNcHi
         isDRmxTMhl25NtPlhcGviYxsFdMoj4GzFHp/zX+kPgS/J1FAZfh49fW7OwRhwA+UI+
         wUp1z15IiQ/VpF21BNu5IjileBKwv60BjkKkS7nPhhXV9PYYgVV6z1mm1pHFmIAedG
         66fkI/Ppm0EGA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Kun Liu <Kun.Liu2@amd.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: remove dead code
Date:   Fri,  3 Mar 2023 17:02:32 +0500
Message-Id: <20230303120233.1878140-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The less than zero comparison of unsigned variable "value" is never
true. Remove dead code.

Fixes: c3ed0e72c872 ("drm/amdgpu: added a sysfs interface for thermal throttling")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f212cae0353f..0ffe351c1a1d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1738,7 +1738,7 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (value < 0 || value > 100) {
+	if (value > 100) {
 		dev_err(dev, "Invalid argument !\n");
 		return -EINVAL;
 	}
-- 
2.39.2

