Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D206DAF30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbjDGPCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjDGPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:02:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81FECA1D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:01:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 18so8971998ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680879700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAhDf7i+3vxSoMiV+RgnjxoO0BcJaFaBbn0AD5nEvXA=;
        b=G6ve3hAnyTEJRy14eTqX/l9RZWVNv+NMlkBGQcoyTIWqCWhs33P1c1Ae+KDsoQ9p6r
         TlrceJJOBwzWfXQUolRm0+jjKrzR9AIIhbfJuOteHDAUzKUEcTCF0MfHSA7Zi7WnWVgW
         iMQCyNgeKRDTmIVahqDM6Xzf4bgOhHXudpTCkXee6erXggvKohmllFFXdkNAPC9CL/wi
         L/zT6V5diKITjU6XxKY8z44UG3QolVlI+mb1sJx/pQEV7zaN3C1p6QoXszty5GM04Xi/
         nunDZ9UZ0mvjJfcX6hgJrJgEGIvMKmmevn/nnR7vnTbKObFwmFtDBKCz2RG0TqnRRjR4
         kvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAhDf7i+3vxSoMiV+RgnjxoO0BcJaFaBbn0AD5nEvXA=;
        b=OFvnBI694mjaIa/gSUCp39sDZ0uYlSGjoo8c7qPOUxuMxwqmsUWAY0mcavSsKjEuDg
         DX4UGIjh6w8tPus8sZyOHN/GoL6CyBc74Z4S2W0aS5MvR8IWM/ZejDQT0LvSEQkw9Xv7
         EOjqdre4Q/RfyKiblbl4eBKv11tbt+8rKLewqqm5J7oRHZCPvbtYFCYiward/AL8qz+a
         kre1G8mqqlxoJZzQhUq0osGGJWCBqNA7f3yZFzDFJsQwq9ineEq8g1ZjFOPKHn6WqdDy
         Q00inBis/4HmywAzurBtYZPRcNm+moP/YVQ4haIcx+gRJtfj1/r51tnpHmzSrmwf0/LL
         fWMw==
X-Gm-Message-State: AAQBX9f9Y8O60T2E1P2Sr6Zc0VSAhvulGtaZNi9KDSryPZVLfrgQ6OBC
        pm5Hn9BbtwwDS+lMrsLetP1uLg==
X-Google-Smtp-Source: AKy350ZhLHlbvP9shxz6iWBscRQobN/8z9VRvSDLQlR7En7CPxTLBmyamyfI5isHmEzlsb6BkRwpQQ==
X-Received: by 2002:a17:907:2d90:b0:935:20d8:c3c with SMTP id gt16-20020a1709072d9000b0093520d80c3cmr3290390ejc.61.1680879699923;
        Fri, 07 Apr 2023 08:01:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090680cc00b00922a79e79c2sm2127213ejx.217.2023.04.07.08.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:01:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] ufs: hwmon: constify pointers to hwmon_channel_info
Date:   Fri,  7 Apr 2023 17:01:37 +0200
Message-Id: <20230407150137.79947-1-krzysztof.kozlowski@linaro.org>
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
 drivers/ufs/core/ufs-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-hwmon.c b/drivers/ufs/core/ufs-hwmon.c
index 4c6a872b7a7c..229e2ad70903 100644
--- a/drivers/ufs/core/ufs-hwmon.c
+++ b/drivers/ufs/core/ufs-hwmon.c
@@ -146,7 +146,7 @@ static umode_t ufs_hwmon_is_visible(const void *_data, enum hwmon_sensor_types t
 	return 0;
 }
 
-static const struct hwmon_channel_info *ufs_hwmon_info[] = {
+static const struct hwmon_channel_info * const ufs_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LCRIT),
 	NULL
 };
-- 
2.34.1

