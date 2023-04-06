Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3596D9C24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbjDFPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjDFPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C455AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680794586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mb2Sx08sAZAB72OxlGRSKRYkFlVM9JheVxzU3a3tBgA=;
        b=P0uQDkqr3X7mYHvRMYOE1kiifp1XxYN9s1Gdxn9pqOIyQ/Les+1OLg/DuR3LEwtRqbdFYM
        aUZPqFPnttGIvU9O4OrqbrZjVL5f7XmqEsTJhz5L4yW/MytfIRWfCF8zZ4H/DdFoP9AYW9
        CsjYNbtcpF7olUmPx740g+zFU3V98TY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-4TCrieihN6y8Li-gvztyog-1; Thu, 06 Apr 2023 11:23:04 -0400
X-MC-Unique: 4TCrieihN6y8Li-gvztyog-1
Received: by mail-qv1-f71.google.com with SMTP id f3-20020a0cc303000000b005c9966620daso17908964qvi.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb2Sx08sAZAB72OxlGRSKRYkFlVM9JheVxzU3a3tBgA=;
        b=P73MiZhX6bHoeVI6GxFDs9EiVQVrZ5Lws0Djq5SwJvPXZeZnPrPPgK1hJ8XbFV69F1
         M6b1YXnYxHN9mOwBP1njuq3H1EX75kRhEKDdqiN2FB4JvZnlAOfwpXpuviIswqyVYouO
         xKC/rfIG5yjY7b2AxaL2Uj7yPgClqlF98kXYNXGXRf5H6uhHyeQpH1+EwmcXBSeI3mzK
         4bgQz+xeIgrXm0n7+TZApC75i1KqOimgnFYTL4VZeaqGgeG+iTnUPx8JO4KO/zmBxwWS
         vtLaVF8D4Lc09XXRYlc0/eL6kBZsCsLPmScSLwb+6hnuCGAnhVoLhrhrQs5sD08tWIAd
         rDuA==
X-Gm-Message-State: AAQBX9fyh9cpgNYS13NQw9tOIiLsyoxxfkaJWhCK9DzgFJMgdUs6rAXU
        igE0olJLB7jiUsmtGUcX4xGyPifSQ4reLQnHCPRLdFpbu+nUBiWjxPxu7tMySipaqqgz7Zg5lSr
        Lpka0JQN2065/BVcV7LsfL6G2O36MADzB
X-Received: by 2002:a05:6214:27c8:b0:5e7:9e1b:b26d with SMTP id ge8-20020a05621427c800b005e79e1bb26dmr251053qvb.16.1680794584148;
        Thu, 06 Apr 2023 08:23:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zr6EDiDUbNCN6HoQhjJ/hxrFFPN0pY0RRcYSf2GAMT0RjMAz8z2j2goR/9tR/0D9pNLsZoXA==
X-Received: by 2002:a05:6214:27c8:b0:5e7:9e1b:b26d with SMTP id ge8-20020a05621427c800b005e79e1bb26dmr251020qvb.16.1680794583895;
        Thu, 06 Apr 2023 08:23:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id da1-20020a05621408c100b005dd8b9345bcsm579903qvb.84.2023.04.06.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:23:03 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@analog.com,
        pierre-louis.bossart@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: max98363: set varaiable soc_codec_dev_max98363 storage-class-specifier to static
Date:   Thu,  6 Apr 2023 11:23:00 -0400
Message-Id: <20230406152300.1954292-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
sound/soc/codecs/max98363.c:392:39: warning: symbol
  'soc_codec_dev_max98363' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/max98363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index 4585ebb1e82c..dcce06bff756 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -389,7 +389,7 @@ static const struct snd_soc_dapm_route max98363_audio_map[] = {
 	{"BE_OUT", NULL, "AIFIN"},
 };
 
-const struct snd_soc_component_driver soc_codec_dev_max98363 = {
+static const struct snd_soc_component_driver soc_codec_dev_max98363 = {
 	.controls		= max98363_snd_controls,
 	.num_controls		= ARRAY_SIZE(max98363_snd_controls),
 	.dapm_widgets		= max98363_dapm_widgets,
-- 
2.27.0

