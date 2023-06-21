Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720D739238
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFUWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:06:31 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9F10CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b58e439696so2568303a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687385190; x=1689977190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JK0VrOChNls2gnXAPFXNlAkcfaLHX3qumvUvMuZb8fQ=;
        b=HBT7aNvQ9/0lOZBGTU/aMMtPfSpX+gUV4x1qNSU/y1cNhwhauphSbs0iFmIfoJZE0T
         6sbuM1r9v5WAemGBX2UyyEAavocyO0wdp2G0bRBtzXp3X3stQzvqGUHydBmiVBP5ZBRQ
         EFXcpSWNo30kWz2nwG8H++kcRJgqTZd3bkaYiJ6d802ovuXEKhJ8g1Jk5DIg4ZO7GwYV
         xBDn/BYWSfDAwZnUfM4mS07iQdqnNScE/vcpiqYuM3UltJfGUYP3Zao84EYgXTV0wiH0
         0MGyp58MfUtTVdz3iAGkwoHHT2q5lX0utM/ycEV5IHgI5nC3614rZh3TDctMyxAGrXjA
         odNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385190; x=1689977190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JK0VrOChNls2gnXAPFXNlAkcfaLHX3qumvUvMuZb8fQ=;
        b=BCjHOLf5hpuS7sBaqcmn1Ox7yLI6QluOrIEh68CRUMwX2XSwIuRmjgMVVNUDVKWXCX
         ijH9R/xR3ySNHCVp8d6ycZSq+uY1jJ1V1ALqpoMZw3Ftf3FQm/yfSe8fPDmDoBX/0zIm
         IaNaErL+QrJ9FtCCYdC2qwyNh1RT+d2lHwkeRaWPeJc5Y6iMVsygLHCrw+1yGVPb8oy0
         sMYNSoZa29V+2FbwAbI00o1D3xaaVBZocPuiK+DEtD+eroUIuUiVmGOnBxa6bbh9na3W
         7bdRkveE4WUfcisY0Gr+wEtQNfI68WNe4dA7YmHFzStvH0Vsj2nc0g+xUdpIfhxbkzev
         UyIg==
X-Gm-Message-State: AC+VfDwO9mDfE1aEuFY/t/ykdCeFKmkajv73xdQPJ0izO/xyZij+Giny
        1g72u6mMM0MUPC1lL9+iJgQ=
X-Google-Smtp-Source: ACHHUZ6h3GpYT62+BblCthS6pKiZlBs3ZJNxN8ROaGRwulVHq+v+K7zceKJauT9/jXHC1ihF4HUPEw==
X-Received: by 2002:a9d:6a54:0:b0:6b5:e151:baec with SMTP id h20-20020a9d6a54000000b006b5e151baecmr1423495otn.14.1687385190363;
        Wed, 21 Jun 2023 15:06:30 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d7d07000000b006af8b60e2c3sm2288987otn.74.2023.06.21.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:06:29 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH 0/3] drm: panel-orientation-quirks: Add some quirks for 
Date:   Wed, 21 Jun 2023 19:06:12 -0300
Message-ID: <20230621220615.1253571-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirks for AYA NEO devices:
- 2
- GEEK
- Founder

The quirks have been tested by the JELOS team that has been patching their
own kernel for a while now and confirmed by users in the AYA NEO and
ChimeraOS discord servers.

Joaquín Ignacio Aramendía (3):
  drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
  drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
  drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.41.0

