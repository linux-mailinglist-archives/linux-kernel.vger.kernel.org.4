Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2F6FF8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjEKRzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbjEKRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:55:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4C5FD7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so15818389a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827686; x=1686419686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQScT8GkY2Eioro0tIS01FKpHQljEwNBJwJbRAB5I3k=;
        b=Svo6UN8Pbv71gJ70I0Gni20C5gG4GAiJs+Yp5rSmL84xqbB/yGpOnUV3QuigP/Yx2a
         Z0BIrLoew9ihGNebx0gT4Kjo/5i/wz3K3tBkhvWEzjfHE9T+GL2Lr2sQbfAO/m8ceHIv
         x6aDj8AkwcVnxSrEkBWDOR7EuRqwNeCZgqohFV9eYiYqkdfE+cr/3snjE6Xh0n2iBfl+
         27yLRtCP1iLjS6gF6leqjJtPGxwS0KUX2Y2f7tB01rSvfvcpf+G6nW81uAX8AQkSjzoP
         MbGe1nrCqmJajYxxGRGsEtpGAIUYif2tYz1d/goCrpjeiIVJ6xhLcm0YyjAYVXu+WUmO
         Lp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827686; x=1686419686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQScT8GkY2Eioro0tIS01FKpHQljEwNBJwJbRAB5I3k=;
        b=g/8Vju1WtBgeEZ4DjV/SUICyMDwBVU3gBJvvpRysdXsJ/WgBQjnf8YqSQUGm1UtAz8
         tIwZX40jg0dQytSVCmA8y2TqouKJOPkjZ4+hoe/vwBYJ1WuKdytNf6fn3C1ci0x/GLDQ
         WyECiU/iE1hH2Ku+LShU2kZWvHj5ZI+skF4ywIRcbKcyr34adKRSkkogOIiishJOajJ3
         x+YEtMY8rCo2xX5jaiJk6SRf0jrjG/58MvZGcNWjSB65bz7/Y/H/Q64bZDSNCdJ4nhFU
         ctGI7H6qeMvxvwo2zBbKI9L1O5OwANIm0tTOpkk5NI7kVETcqyyPk28stXM5JuU1PoyL
         6BAw==
X-Gm-Message-State: AC+VfDz5Y3VyL9G7//xILpGdiMUOkwCBTsSXWICzfNu6Kyr+awQXMEEc
        HLzUdXoSdIhDLDKarz2bcrpDWg==
X-Google-Smtp-Source: ACHHUZ6NPjqJnNGavsOCoRiaBb5w3G6IZ9ZGBFpmTNX8AUxhnLlj5X0g+1X2Ou+pSyzZuPTIG2891A==
X-Received: by 2002:aa7:c99a:0:b0:50b:c3f0:fb9d with SMTP id c26-20020aa7c99a000000b0050bc3f0fb9dmr17451185edt.41.1683827686036;
        Thu, 11 May 2023 10:54:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id j5-20020aa7de85000000b0050bc4600d38sm3085610edv.79.2023.05.11.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:54:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] drm/nouveau: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:54:43 +0200
Message-Id: <20230511175443.281970-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index e844be49e11e..db30a4c2cd4d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -211,7 +211,7 @@ static const struct attribute_group temp1_auto_point_sensor_group = {
 
 #define N_ATTR_GROUPS   3
 
-static const struct hwmon_channel_info *nouveau_info[] = {
+static const struct hwmon_channel_info * const nouveau_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-- 
2.34.1

