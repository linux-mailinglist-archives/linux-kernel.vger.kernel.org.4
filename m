Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E3A7340FA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbjFQM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjFQM1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76E100
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687004805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=szv0cF+bl4sIifpCG+zmQZUts/OGqmFER4Ll8Eqs/O8=;
        b=TkTGJ6t8bc0ozyONrd/T6EmLHXf9e0DUDa4IMqBygAeydPQIe+gpzaLf5n44pBHo6HU4YC
        VeQoXM30fJlYATPELhBTUngDr+j73mXyjWCxKdNFoxlzidjY2Ql0PKTKdxKF4I4b2G2pQO
        0gpUs4JN+ueDTRgxBEwCRRrqpEHnwyA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-0Gap7E0ZP9m3vzOacEDqgw-1; Sat, 17 Jun 2023 08:26:43 -0400
X-MC-Unique: 0Gap7E0ZP9m3vzOacEDqgw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62fe9513320so21414476d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 05:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687004803; x=1689596803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szv0cF+bl4sIifpCG+zmQZUts/OGqmFER4Ll8Eqs/O8=;
        b=gwbqw+QzFcekwH0x/zg0qdTf1bM79W+t5CWgdcSYiRBi6fD26IlixCsDaVdTBfqFP+
         +6UYrrM4C/3+Ia4wMo7GwVrBXwhr4lbQEUpfU6xAUDQ/g7Uy2Ldq++dRo7Z92jzdcarz
         +NE+Lz5wTwqQ3P1xKU3cV8ukYrF/zMt9qxeVwzodzq0WreFER7EKd+jX9joC7lY8ZlKE
         u8x6yMT+eC+wV+cAgvjWop64MVM4GFCzYNkfdm1aRoY4zZ7jW6pFMaxIPW9TrataFlCy
         tU+rY4d4Kqg6fr9fKYYP7dU9PLSW5f0ARbNk21WccJHuxN+PGbRgFx+6Y+R6jGQBsWQK
         /ALQ==
X-Gm-Message-State: AC+VfDw46ZVyjEwgRoBt8kTRyshAlIWbXvqpgREB7AuDkBbc6mdrGv3B
        DUQAMIaWc2oOEXiTEAitpb1QyehE/9B+miJ5Fjl9obzptJnWgmj5T87db0sUOaFnvxzyFjvWOt8
        5ML3KXSy9V/3AwbGCtyFAlzlX
X-Received: by 2002:a05:6214:2aa9:b0:621:41f6:1f7b with SMTP id js9-20020a0562142aa900b0062141f61f7bmr4669467qvb.7.1687004803051;
        Sat, 17 Jun 2023 05:26:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lHXpX8/GVgXs6SRlViW67tYe8C1zdG42GI7bVdDa/NP1rorw/xsL8eLyxOx5KpbTQEieK0g==
X-Received: by 2002:a05:6214:2aa9:b0:621:41f6:1f7b with SMTP id js9-20020a0562142aa900b0062141f61f7bmr4669446qvb.7.1687004802772;
        Sat, 17 Jun 2023 05:26:42 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l8-20020a0ce088000000b0062df235c6d9sm5050098qvk.18.2023.06.17.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 05:26:42 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@analog.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: max98388: set variable soc_codec_dev_max98388 storage-class-specifier to static
Date:   Sat, 17 Jun 2023 08:26:35 -0400
Message-Id: <20230617122635.3225639-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
sound/soc/codecs/max98388.c:890:39: warning: symbol
  'soc_codec_dev_max98388' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/max98388.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index 8062a7115007..b7d1d5c7b72f 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -887,7 +887,7 @@ static const struct regmap_config max98388_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-const struct snd_soc_component_driver soc_codec_dev_max98388 = {
+static const struct snd_soc_component_driver soc_codec_dev_max98388 = {
 	.probe			= max98388_probe,
 	.controls		= max98388_snd_controls,
 	.num_controls		= ARRAY_SIZE(max98388_snd_controls),
-- 
2.27.0

