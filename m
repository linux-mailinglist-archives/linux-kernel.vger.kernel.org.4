Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D46DAF28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjDGPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjDGPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:02:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E494C677
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:01:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id 11so8967089ejw.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680879692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtGb16tBjxkovykHXXbCrUa53MVGjlTZMOjOseRt8rM=;
        b=r0F33I2XoabXfti3UwTtIZJxPHe2Efl5b/RxPNaY8dTHUCMZloxcxvsGAD9Rmv8gjC
         G123r4wSWerz2Kfcz1VW0xrr2MXFCf/xjIDyBnBXuvCSYd2poCZuVlEkpsXsi69a8l2R
         JnexK4UyDqYufuOyTgVV64bTbAqDpD6LHg4d/ybhZaZXT2KgFphFkcecImeFUKVRMPss
         Y6X1bW238dUm1pipBSZe6oB6Lvzpl8RmqBq6pvrFpuphJODN6iP2Q+6KIj35XgREfG1C
         rMS/W8Vv4ZlAkrXwqbh8XVn3JoPrAh71Nmeq+zdClumEGEJWvl68JvMECSUM9ZKQh8Yr
         PUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtGb16tBjxkovykHXXbCrUa53MVGjlTZMOjOseRt8rM=;
        b=D4wpQZBcKiFyyPy+90EPyPsikbjICkrIwp+EPcP5nzRoCkTmvo1FSYMl9pT9ADE9tL
         MThDiTKia6qPDFx2Ey8oDBSHKcQlg00iZJhht8PbDIyEHnCMdqZLpLbUC74fFMO4KA9M
         GHMQUGFCWqjqGpQ1H8LdVJnWK+Wx9CII153aiazfdL+SmPklQSKvxJD0fZAgvYNMVemL
         A3QzQopSdrh7ybZFM4EzJRO+JL2xTBVE3/3WWXCUNrkRlKNn3rvSlzHwwiR3NLKGUfJ4
         A9xtgOMCrgm+XVP6bHVwdcsAptrMHDT8pTAWQ0tgkaT7xreuh9LecaNOsGyEV//8JSTG
         pZcQ==
X-Gm-Message-State: AAQBX9cIUbLIBR8D6Gx/4DL4eL+emvSWOew6l405js/R2uJIHGDBwMLm
        feAt/bk6CojxlpLQn/HLRVghLA==
X-Google-Smtp-Source: AKy350YVhdN7mbXAUhtrSYyehX5rFsHMmqNBdy8d7pxXyw9M8G06EIdOKjXdxuUZpKm/pSzkcl3Fwg==
X-Received: by 2002:a17:906:19d0:b0:949:cb8f:2640 with SMTP id h16-20020a17090619d000b00949cb8f2640mr2531331ejd.65.1680879692060;
        Fri, 07 Apr 2023 08:01:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id gr12-20020a170906e2cc00b0092595899cfcsm2127024ejb.53.2023.04.07.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:01:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Date:   Fri,  7 Apr 2023 17:01:30 +0200
Message-Id: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This depends on hwmon core patch:
https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/

Therefore I propose this should also go via hwmon tree.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
index e695e36ff753..65304354b34a 100644
--- a/drivers/vdpa/solidrun/snet_hwmon.c
+++ b/drivers/vdpa/solidrun/snet_hwmon.c
@@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
 	.read_string = snet_hwmon_read_string
 };
 
-static const struct hwmon_channel_info *snet_hwmon_info[] = {
+static const struct hwmon_channel_info * const snet_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
-- 
2.34.1

