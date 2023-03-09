Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E676B267A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjCIOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjCIOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:14:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C01ABD2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678371167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ODObCz4UpLnL30PCazA7QvVVaLpuERoMVAQqToE74AA=;
        b=HSHtn1NP+akfpSog0xmMedtuMowsSM75BI/kqARTiPVsF4dB4uVCLqkOZvQZRHr+QJY5if
        eieRxTwumlfsAevQG6viTEhpOoBN9SCPlhuWdIaETLCMrbK4z9zlOs4r2mGlSnXhVR/OJI
        5YHvVJ58piutimOUk1atY6nGpjpPi04=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-PXDAVpEhMU-YdCDTQlwMVA-1; Thu, 09 Mar 2023 09:10:02 -0500
X-MC-Unique: PXDAVpEhMU-YdCDTQlwMVA-1
Received: by mail-qt1-f197.google.com with SMTP id l17-20020ac84cd1000000b003bfbae42753so1106895qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODObCz4UpLnL30PCazA7QvVVaLpuERoMVAQqToE74AA=;
        b=BSBweNRA0PXcvJZfARufOHXrhrDQLXorcscmEUlyms2xICXBWZg69QKd4jwAIHvtGu
         KByQP8ZvYh773ROHBvI8ThyHS3nsP7wP/LF8itBFctsFqIG5CzaG072ZCr8h9iTaaroF
         tKsNudKsbInofnMg+PYkVPPP60Hf5r2wD693q3eegfgmrh+P8OkmRPxgaFjcCFfNspFC
         PpDVWxXxdpyuofdkm/8GYI3Lb62frVhDEHxi1mfOmzCQ2xKz63nipWgX6HiPlrqQZX5T
         THXA0jqKkdQyaMyYrRzOOaAiilM2tXtyFPRLuOLpPsbbnW3CRLuZcVpIuPnHfdEA9tot
         Iarg==
X-Gm-Message-State: AO0yUKUL6XPy/BbA0vScmSoILkYdyBLDXgBHBp1AX9aFJT4el+7+e91f
        vOW+k+Ty8IDGVtjAD8GI+19nS4QI5TtLb00C4Kd7OgMGGq7dz801P/JBhWktzh7Q/+OZVnl9d0h
        EpoOZ1inSq0pmQa/ndrW5AgI+
X-Received: by 2002:a05:622a:1ba5:b0:3bf:dc55:ab0b with SMTP id bp37-20020a05622a1ba500b003bfdc55ab0bmr38055386qtb.42.1678371002402;
        Thu, 09 Mar 2023 06:10:02 -0800 (PST)
X-Google-Smtp-Source: AK7set84SFK+UksjKHoQN7ky4OZAF9Nw0lVdbFSnR+EKabrEC4f94ZV+uwnSojcAGif2fvgAjpoXEg==
X-Received: by 2002:a05:622a:1ba5:b0:3bf:dc55:ab0b with SMTP id bp37-20020a05622a1ba500b003bfdc55ab0bmr38055355qtb.42.1678371002162;
        Thu, 09 Mar 2023 06:10:02 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d17-20020ac800d1000000b003b848759ed8sm13644719qtg.47.2023.03.09.06.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:10:01 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     kiseok.jo@irondevice.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: SMA1303: set sma_i2c_regmap storage-class-specifier to static
Date:   Thu,  9 Mar 2023 09:09:59 -0500
Message-Id: <20230309140959.2616497-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
sound/soc/codecs/sma1303.c:1594:28:
  warning: symbol 'sma_i2c_regmap' was not declared. Should it be static?

sma_i2c_regmap is only used in sma1303, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/sma1303.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sma1303.c b/sound/soc/codecs/sma1303.c
index fa4b0a60f8a9..b6c132edf3bd 100644
--- a/sound/soc/codecs/sma1303.c
+++ b/sound/soc/codecs/sma1303.c
@@ -1591,7 +1591,7 @@ static const struct snd_soc_component_driver sma1303_component = {
 	.num_dapm_routes = ARRAY_SIZE(sma1303_audio_map),
 };
 
-const struct regmap_config sma_i2c_regmap = {
+static const struct regmap_config sma_i2c_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-- 
2.27.0

