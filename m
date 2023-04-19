Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B276E7D20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjDSOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjDSOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0094200
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:41:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so1579590wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915316; x=1684507316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbQkv8jwrzDkswGUNpm+pnkw/ViVbiTH2eyiHhJb3M4=;
        b=xpqwOKviV3x6su4F66G0lA+GLbxZZnI5CB6LrMkiVKlNfY184LccJ0g/wVEqGcKIsx
         RGVql6UqqH8puGBagZvlGoVC0DD1VpP35GIbxxfraL8jGnb0qHtaBSk7K93EpB4+PCtv
         nMoG71hok4guw52ZAJReJ4xRGrXk2mCRc904XOLgw63OUNHFide9KukVfKkngesDhGwb
         uXTSnIn1HfFEWPLCGxia1zJr+Crn9oewGMzuzbGIRM55foxtX/A7zXve63LtGtmmCGGh
         aoLEfRBTqy46CdBc57ZGzBXagrMFsIWzyX+2FHVWzsr47erJlsI9mR5R7gOKDnqFd4BE
         ITfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915316; x=1684507316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbQkv8jwrzDkswGUNpm+pnkw/ViVbiTH2eyiHhJb3M4=;
        b=Se4VBQN5ofFfm+a0eL7rU0z55Y+a5O0j0XUyAH3sRY8zIaRp9qJieKX7jblVPmDKa4
         npmOAh1JMqWeJlGCyqOBVRBWM0fX1lm4cg6olYLdLApyfvSYP9byTeQ+TedvpFr7w/k7
         oE3PjI8bzi0dldgdBC8/z+SfYrDyPjspuijvLoBdtNSrHdZNZ4SZHJsYZ4Y+nv6NAYJO
         ZRWeZLl7pGe347xUxziTwbzy4PBsx2h4JihdxWBcyKV0XsAuY0wMOt5nDuRpmfx+F1g9
         CWqyS0EnnPHfLmz89UEMS/9stwrAQaFepWpM9K4Jb439SaMsmRLJ0Nt/v3tiARfbcO74
         i7rA==
X-Gm-Message-State: AAQBX9cW0JxXmpJ/eiL+SfHhFCqIWmqPpclTQ+KsQ5s/PK2Vy/1iQbgg
        9fR/v0R0WFRzJpKpw4flS9Xt
X-Google-Smtp-Source: AKy350b2tHD6YYOyF6EJNHwhdDG0rJNjjB5sIpYsfjHVll/9aH5noTb+iMAlmgjsu/owIXVuGlVOuA==
X-Received: by 2002:a1c:740b:0:b0:3ed:276d:81a4 with SMTP id p11-20020a1c740b000000b003ed276d81a4mr17303138wmc.32.1681915316615;
        Wed, 19 Apr 2023 07:41:56 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:41:56 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Subject: [PATCH 00/11] drm/msm/dpu: tweaks for better hardware resources
 allocation
Date:   Wed, 19 Apr 2023 16:41:07 +0200
Message-Id: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIT9P2QC/y3Nyw6CMBCF4Vchs3aSXqhSX8W4KHSUiaGSDgoJ4
 d0pxuWfnC9nBaHMJHCtVsj0ZeF3KqFPFXR9SE9CjqXBKGNVrT3G8YPTTOEl6OqLs8qdjY4eCmi
 DELY5pK4/SKJlwr+zOMjQeN8cuzHTg5ff6e2+bTtH7Jp4hAAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=NLA8aCokPucqX6VgfqosaRbjjOEPuDhGV/zebS121ow=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2Sx+NGYnUY5kQUzXMuJpNkUO1J4MQIjtMlw
 LyJMlg0K7mJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9kgAKCRBxA//ZuzQ0
 q5HoD/9i3Ejx1LlCyQTcY4w5DlwreWOk6HnY4l/N3UMPC0w7x+mPamsZ/cVo9/uUtTy0c0GonyD
 j3iDZj6dvoTbozDGIZlfflLEORYJ7U7Rl8p7ILtlby7FDUc/tOzPTNj+umHN07JxMOvqtjpqSOE
 Eq1tdJ3x1pmrtE+PZhkNRZ3hA0RxDQIuya67zwFuo6ufl9cyB6S1rGKXbcIPuXpBAL62OkI0naF
 6+tHvguoYSez/ttIBx+nUtvQ0Lc0MxoPrAN7V4jLUmCtuX9OpkenNjGyzHt21PcE4zS8MUr0wdR
 C7Cq46GHDJ55bRgmeHCYAPCmZpoq+8AQjtHF7M+jbaipQCOfFihatTvjNmpb72FZ0Av2/WWrIUV
 vdSQsQXvjDyZm4rVjZ8HTOSHpRM7VV/54RrHvRHQ8LeIgZCpJ2Um2iWgR3Gt3prM95TE81NMbgS
 Eg2TeA6FJbL/qRnOxub6KXJt2TwsGel6hWTQibC1TTFx9ca36nhkRerIoDbUJ+n0giEcO/+wwN5
 HhT4nusm77Hz5vjB88rtS2ujUrqgBJjDQpy5Z2PZZ6wrvK3OvXxqB9liCswFiJxKt4RjcgV6ZEf
 XNMKq1uNSs3sMOo9S/1rKKD4rzvg1r0d0iASkk96naqx/FDa1htSCytlYpjaMmRH6YDQpFZ+jmV
 iMAK+6b2HNR3l5w==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series include misc fixes related to hardware resource allocations
in the msm dpu driver, some specifically for msm8998 (including hw
catalog fixes and cursor sspp support for cursor planes, instead of
using Smart DMA pipes).

This series has been tested on msm8998 with additional patches to enable
hdmi support.

The following modetest example command works now; 8 planes can be
displayed simultaneously on msm8998 in 1080p, including a cursor plane,
using a single LM:

modetest -Mmsm -a \
    -s 32:1920x1080-60 \
    -P 33@87:1920x1080+0+0@XR24 \
    -P 39@87:200x200+100+600@AR24 \
    -P 45@87:200x200+200+500@AR24 \
    -P 51@87:200x200+300+400@AR24 \
    -P 57@87:200x200+400+300@AR24 \
    -P 63@87:200x200+500+200@AR24 \
    -P 69@87:200x200+600+100@AR24 \
    -P 81@87:200x200+700+000@AR24

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
Arnaud Vrac (11):
      drm/msm/dpu: tweak msm8998 hw catalog values
      drm/msm/dpu: use the actual lm maximum width instead of a hardcoded value
      drm/msm/dpu: use hsync/vsync polarity set by the encoder
      drm/msm/dpu: allow using lm mixer base stage
      drm/msm/dpu: allow using all lm mixer stages
      drm/msm/dpu: support cursor sspp hw blocks
      drm/msm/dpu: add sspp cursor blocks to msm8998 hw catalog
      drm/msm/dpu: fix cursor block register bit offset in msm8998 hw catalog
      drm/msm/dpu: set max cursor width to 512x512
      drm/msm/dpu: tweak lm pairings in msm8998 hw catalog
      drm/msm/dpu: do not use mixer that supports dspp when not required

 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    | 28 +++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 10 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 49 +++++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 16 ++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 22 +++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          | 32 +++++++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  2 +-
 7 files changed, 107 insertions(+), 52 deletions(-)
---
base-commit: e3342532ecd39bbd9c2ab5b9001cec1589bc37e9
change-id: 20230419-dpu-tweaks-5475305621d9

Best regards,
-- 
Arnaud Vrac <avrac@freebox.fr>

