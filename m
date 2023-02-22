Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9F69F87C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBVP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjBVP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:57:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000D3B87B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677081418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GScpUkVmR1trk5NKo/KgCoCbwLxTQg040xij2n32R0k=;
        b=HyhSGnircdImN9PIP7NHmo0XSpWLvwccFI+a9ucaSl5Jmx6Igibb60hruPwzgPDZoW6BEl
        fbtMjOOu9u8bRCRHktxN39QQPh2XEAO6D+Lz7jEjZ72697DtybcznfoKrPAgNOypt3BD4l
        xpvkpb6u6MU7lnnSpv80N+jZt5dSygE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-DGTuPN3HPXGUyRLmYJeb_Q-1; Wed, 22 Feb 2023 10:56:57 -0500
X-MC-Unique: DGTuPN3HPXGUyRLmYJeb_Q-1
Received: by mail-qk1-f200.google.com with SMTP id m25-20020ae9e019000000b007421ddd945eso2693496qkk.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GScpUkVmR1trk5NKo/KgCoCbwLxTQg040xij2n32R0k=;
        b=JzyIFBt2mVcSBDNUcvc3MLkc2gGFFDJxWoyNt0mu/ZOu4NESY0P8VoWAnO6jeOnba0
         JdNi/fie/rfG1NbeQqofuQ0fOShmZz3yeUpMi59W5e3/j1+5rsUUiQ7armh6XOeKTEya
         HYkr3kpm85SaHbUU0p6yMo+IlSBmEPuEG7UCNXz07HOkomz7nGml4134WbWsJ0MvOMSS
         mOUUHEahMzCxpwXg7GIsICkhlF5p3A1WvBM79OkeQFRhYSgYDpG5Xc6We2ZQSNOM7dIk
         Eo5NWCYbBvNoDHCUXgsP+xLxHAgIshdKlbtMBe7fsAgOZfHmaHxi3gwLWPa2FAf6oShJ
         RuuA==
X-Gm-Message-State: AO0yUKVR/zOYefgK0MCQeTiqRfK2e/dE3F9I3BEtawbpACgQn33706mp
        GBnenXQtlKyuAPqelIP7/t474l7BkBFC2J0AL4LpPfDlmcRT8ivqCoBKJYP2tP5E7XmRSkKxCKu
        cXHQ6xRUnknWoYxSBJa1kjaKpH54BPw==
X-Received: by 2002:ad4:5aa7:0:b0:53c:9354:9721 with SMTP id u7-20020ad45aa7000000b0053c93549721mr17269885qvg.21.1677081416440;
        Wed, 22 Feb 2023 07:56:56 -0800 (PST)
X-Google-Smtp-Source: AK7set+9amRNsc788f8Ah1EHOFjNZAoWEKdId2TpDxnPM1JRKz/kP2UH4h79UWQqmJg4CwTyIG4HZA==
X-Received: by 2002:ad4:5aa7:0:b0:53c:9354:9721 with SMTP id u7-20020ad45aa7000000b0053c93549721mr17269856qvg.21.1677081416191;
        Wed, 22 Feb 2023 07:56:56 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t78-20020a37aa51000000b006f9f3c0c63csm589967qke.32.2023.02.22.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:56:55 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        tzimmermann@suse.de, javierm@redhat.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/msm: return early when allocating fbdev fails
Date:   Wed, 22 Feb 2023 10:56:49 -0500
Message-Id: <20230222155649.2001467-1-trix@redhat.com>
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

building with clang and W=1 reports
drivers/gpu/drm/msm/msm_fbdev.c:144:6: error: variable 'helper' is used
  uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  if (!fbdev)
      ^~~~~~

helper is only initialized after fbdev succeeds, so is in a garbage state at
the fail: label.  There is nothing to unwinded if fbdev alloaction fails,
return NULL.

Fixes: 3fb1f62f80a1 ("drm/fb-helper: Remove drm_fb_helper_unprepare() from drm_fb_helper_fini()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/msm/msm_fbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index c804e5ba682a..c1356aff87da 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -142,7 +142,7 @@ struct drm_fb_helper *msm_fbdev_init(struct drm_device *dev)
 
 	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
 	if (!fbdev)
-		goto fail;
+		return NULL;
 
 	helper = &fbdev->base;
 
-- 
2.27.0

