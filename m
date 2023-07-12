Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B97506E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjGLLth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjGLLtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:49:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7C199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso73914135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689162494; x=1691754494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBRkWVB0g8Qm8dyh6//o7Lwn4Q/uU6uVP9gh0M6sy3E=;
        b=fTIJA5YWg1SqPJuzssiDs0yYHsqNJ66pstFXEt7VlU1tk8rVnITiG8JTQmwgl6hV8a
         pSBRdwZaQ+pYkTnPGFrXvqEz+lRTDiG8MO4k6cwQYV4EgsNIJhNSKcferBqERRW+LZZE
         kd3O9+1koszCdxgeP8kAK39Kq/PzenfZSPuF+rBe/vpMRKIWGzyAL+40FTlmqOI3Go5D
         TO9WAlj//Q2nTbFJQyIS+GoVuevgITahxz53lRKXA2KUbC8IoLTKYV8omFo7KymmqicB
         d29bf/G5ipf67kPN342AatvB+Z/5HHMT4ENfjMif5A7HM9J5hH6exDsDBPd8LoyyX9Gt
         M0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689162494; x=1691754494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBRkWVB0g8Qm8dyh6//o7Lwn4Q/uU6uVP9gh0M6sy3E=;
        b=HSf1dqmeHvv7Lih4rFusdtTYPDS9XaVck33/I0u1f2Aoayn7XTSO1s+aX2S04ExRpk
         wVGAAFAeAu6zTBa7GVDZMfftcItCVKPJuABtevDKgiPQZRW7nqexXu4VT5P+NzWqhaGp
         4Ooft4P9PvT4f8n18hSlRiNWQugua07OgZZ6yehlVe6SQgaeV9pHDhg8PEjlVys7MHFe
         9ATVgexvtIeaSp4+ePaWs3OaXCjTB8O4o1Sj5aEeOa237yhAyeizarTZXMi0nerqgEEj
         stg0PUyKodP/tKDJajknbg2uJ5/YzncVV4SobXdouP75HD4ZEHkQBP3hs5j58uXSq4fx
         z9ig==
X-Gm-Message-State: ABy/qLbLpM7jd1G4Wt6M2rOxkzgnUn0/bOQ3qcqeOiW2tGUAKhldr8n4
        u/XAeJaWP+ITe+KLkAx4oIclnw==
X-Google-Smtp-Source: APBJJlGcJ3tEr6V0Cb+m/2D2hJhmyD6Y5xsrI4FPimHxiVjapWiwFvDjPqdbTOabDiu5YYe0P/y2oQ==
X-Received: by 2002:a7b:c7d9:0:b0:3fa:964e:e85 with SMTP id z25-20020a7bc7d9000000b003fa964e0e85mr18987790wmk.5.1689162494106;
        Wed, 12 Jul 2023 04:48:14 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d4482000000b003143867d2ebsm4867463wrq.63.2023.07.12.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:48:13 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 1/8] hwmon: (pmbus/mp2975) Fix whitespace error
Date:   Wed, 12 Jul 2023 13:47:42 +0200
Message-ID: <20230712114754.500477-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Fix whitespace error reported by checkpatch.pl

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 2109b0458a8b..130cfde52e42 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -600,7 +600,7 @@ mp2975_vout_ov_scale_get(struct i2c_client *client, struct mp2975_data *data,
 	if (ret < 0)
 		return ret;
 	thres_dev = ret & MP2975_PRT_THRES_DIV_OV_EN ? MP2975_PROT_DEV_OV_ON :
-	                                               MP2975_PROT_DEV_OV_OFF;
+						       MP2975_PROT_DEV_OV_OFF;
 
 	/* Select the gain of remote sense amplifier. */
 	ret = i2c_smbus_read_word_data(client, PMBUS_VOUT_SCALE_LOOP);

base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
-- 
2.41.0

