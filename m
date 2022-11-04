Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3958A619DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiKDQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiKDQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:52:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89C3E0AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:52:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b2so14814206eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9FY6kSnrF6Fw+WQiPYgIhDsvjEumyRCxHY8OEe9TBI=;
        b=RWREcHGh5CPc79gnkD8uLhdTZfkx+avTx+b0UPZ1fEOLcg9F5ERYo/rBoN/2wAScQ7
         yVyEZPoA/QbKeCV2CMUafolfbWgSCVGPLMJAWdqRr2ybYqYOGzOJ5MjUHmGUMoDFNzm4
         sLf2vyNAelGc3+SP18uNBQ85CRIggNKddLsPar5sqPSSBpkH9EGfBhNzTKy7/JDr7tyn
         wFNI3UZ8JmMgqw4kyo7/fKEta++3EMVq1B3GZ05voVNbp4MToNESKS60iwaC/3AAwEx2
         agE+Nf86bxliovM6XuwfgHJsxoJMIOnZKs0J6hTWMTr6obJ+24pZU7xLtavFSR+aUcmR
         +RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9FY6kSnrF6Fw+WQiPYgIhDsvjEumyRCxHY8OEe9TBI=;
        b=YdnIpqY2/cJ/Z2Ys3IdzOiYuK4WdOD0F9a5dt65TWdgE9Q+Qm9V6qK5IMlBPuH1nUZ
         YFpwUxG9vjpKEWwDDyvIJnzmJF3J614qaYXl2eYxEErWNsiAoKYRUJ8RDRaYNMHSE6Vi
         EUix1WUOEnafoWi4tWAjbWzqGFeDHHEfID/c+uokKo1oVWh/LT95WFbERkiigR9dOfJF
         hmKb3cMKW8DYpBuel53r/Vko1peRqu20qpG0KGIEeWPfXbU2BcA874CfJrpSR4hcudWs
         z+LEaNhZQIoPEEHLenWATQvZuL6pTR/O3k4HUmdGheCY4Vu2snO1zNeUNAJiQs8v2G5N
         Zsxg==
X-Gm-Message-State: ACrzQf2r1iVvWVf79Yvp4VaE+CDifKdRGqBd4/EDTv4yImiwToOIO1z0
        hOznMRbb5APP7O9wEI/Nh0BysaocE5o=
X-Google-Smtp-Source: AMsMyM5pSArWZLIAijLuJn0r8mFSS/LgrN+UUpxF0mDbdKyI8HmehnGV1CzV3ULPH/A8iMlzGy3JoA==
X-Received: by 2002:a17:907:608f:b0:78e:1b60:60e2 with SMTP id ht15-20020a170907608f00b0078e1b6060e2mr35798019ejc.382.1667580723838;
        Fri, 04 Nov 2022 09:52:03 -0700 (PDT)
Received: from debian64.daheim (p5b0d7d1e.dip0.t-ipconnect.de. [91.13.125.30])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b0078d9cd0d2d6sm2071777ejc.11.2022.11.04.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:52:03 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1oqzvH-000XQl-0A;
        Fri, 04 Nov 2022 17:52:03 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rafal@milecki.pl, srinivas.kandagatla@linaro.org,
        gregkh@linuxfoundation.org, a.fatoum@pengutronix.de
Subject: [PATCH v2] nvmem: u-boot-env: fix crc32_data_offset on redundant u-boot-env
Date:   Fri,  4 Nov 2022 17:52:03 +0100
Message-Id: <70a16eae113e08db2390b76e174f4837caa135c3.1667580636.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The Western Digital MyBook Live (PowerPC 464/APM82181)
has a set of redundant u-boot-env. Loading up the driver
the following error:

| u_boot_env: Invalid calculated CRC32: 0x4f8f2c86 (expected: 0x98b14514)
| u_boot_env: probe of partition@1e000 failed with error -22

Looking up the userspace libubootenv utilities source [0],
it looks like the "mark" or "flag" is not part of the
crc32 sum... which is unfortunate :(

|static int libuboot_load(struct uboot_ctx *ctx)
|{
|[...]
|       if (ctx->redundant) {
|		[...]
|               offsetdata = offsetof(struct uboot_env_redund, data);
|		[...]					//-----^^
|       }
|       usable_envsize = ctx->size - offsetdata;
|       buf[0] = malloc(bufsize);
|[...]
|	for (i = 0; i < copies; i++) {
|		data = (uint8_t *)(buf[i] + offsetdata);
|               uint32_t crc;
|
|		ret = devread(ctx, i, buf[i]);
|		[...]
|		crc = *(uint32_t *)(buf[i] + offsetcrc);
|               dev->crc = crc32(0, (uint8_t *)data, usable_envsize);
|

[0] https://github.com/sbabic/libubootenv/blob/master/src/uboot_env.c#L951
Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2:
	- drop endian crc32 check - handled by pending patch
	- added u-boot-env: tag to subject + adjusted subject
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 8e72d1bbd649..4fdbdccebda1 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -135,7 +135,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	case U_BOOT_FORMAT_REDUNDANT:
 		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
 	}
-- 
2.38.1

