Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A938640BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiLBRDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiLBRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEFBF9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z20so7212591edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=rRSqOrKRxkHkRwNxoSy4VyopzzE9hshqNihi6pocRbI=;
        b=YWUvrRpFsKrxdzOsrJkzOL0M8ObEXBAQyzbmlIud74RorBXTOnbHVsVAPH+2fF/hMm
         P+nNs0gjQKrMf2KjA6ImWLIwuTmWrAB9Hj3y3rsnx7VsfFd610/F6VuNZCw4HtgemxuR
         /SUI3iER5mg76gprjEoMi4mAFOnPfz1Th5/GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRSqOrKRxkHkRwNxoSy4VyopzzE9hshqNihi6pocRbI=;
        b=nuIdfZaO/LxXtUwLUyLSBfb/BPjCJ4UCSxBsNFeNXklCnXgZiLCd3jUIPQ0Lzns2kG
         GnnbVXQl9D1ne6LnTZU4QvYQc2CxNMRX+Sm4vuf6heHqMY8TvKl8Gg/+cKSlTTJB8ET9
         wVVNu7kYiZdGFBXeEca2e/MJEj94GwOnyBCU8TJunRmJlT/xors3idcgB8fgFIinEbRz
         ZtIk8wtBBcWSVld/SxXHlN8jH/aVjbnS+mojU/L4yTj1zggKkL/cQROenKTOmtyvp3wo
         1Vy4Z+yEOiwXFpQC8rxTQpA+yZ9Np/tesijnTFsdC9YYa+pL8ipa4Cn8fJLHSeoOuhE/
         L5hQ==
X-Gm-Message-State: ANoB5pl7hFKJLApKzlr6UiWbVOubZBZjujiPSxFDwNT5P0j+IXBik9jA
        tATPyhGOTRrDhPe3B6OUlXePAg==
X-Google-Smtp-Source: AA0mqf5qFfC4CaMuQazNAE5BtZ5BoPYROKc9adlaY7YOMnedY+qShwvKQxHB1dSCpLh2cpuY1pSyhg==
X-Received: by 2002:a05:6402:289d:b0:46c:2460:cdf with SMTP id eg29-20020a056402289d00b0046c24600cdfmr3858386edb.103.1670000579282;
        Fri, 02 Dec 2022 09:02:59 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:02:58 -0800 (PST)
Subject: [PATCH RESEND v2 0/8] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:40 +0100
Message-Id: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=4P/OGbO11kxTP9OilepqO/3sCN1ElEME+3c5V0/x33c=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii+0xYNdF4ADpNjE0sA4rkRB5zG+nNdIqf12BFeJ
 2aJyrZOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovtAAKCRDRN9E+zzrEiPkfD/
 0ep+SLtgWJmTbi68AnRUCATjpVWPotzllksm8WQ8dkg6WTlI4YowDqhsZH9y3bN7yfQHnihpA8j6jV
 T92j/cuzL70ctFccQXc61fAUXlcKll6fp2YXRCNLM4sX6Wv+C/dw28vhGmulwucpyPMzxYZ6qHV21/
 dk8ywA01xMVQW36PtAqndetwlKhiKsGflTUGyc7+dKK/moor9Jvzm2peZX2S1ovHpDTbGXlVgMECK1
 TkKKXHrLgZD+fIoQWPm0Sa5lFx9j6VgR2tOSdMyAQbhh1VEc1K6P1E20bF8ZYnwJo8MJDW1xJr37UN
 n4JnFXtGk8jkl+3Df9WzigJBMQVCWfrcA52bQFFkESd+cHWP4oUWqGSp5OmnZ4T8+Wd5q5L7CjupiK
 mdu8Sf7MQUrS/330PUa4rit2qy3EGp6jEUGAFhaLfHxQA8uDrH3ntRhDBkJKOtGFpLMcdB9AAs5tnC
 BGqgvh4g+NXE1IYqV2ehOllKN7/HnE/P1yZEMFHGjViAYlXSm5scK5s0q78g3CVUXlQds/pUYSJefy
 tDS/lhk7JFXmPTS0Y6YzBCNkvT5fdpg7r/xBxJe+ZQ4cdVDTsbbOjVpaZM+DUwnh7PyXwwjdeptSKN
 sDZfoSc/8ON5eqSOgulumnoXnadvvrjaT7r1dJzMhdZZDVk7V1fy4ihgTnGA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some fixes for fixing hw timestamp on some Logitech and Sunplus
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Require 1/4 sec of data before using the hw timestamps
- Add Tested-by SunplusIT
- Link to v1: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org

---
Ricardo Ribalda (8):
      media: uvc: Extend documentation of uvc_video_clock_decode()
      media: uvc: Allow quirking by entity guid
      media: uvc: Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
      media: uvcvideo: Quirk for invalid dev_sof in Logi C922
      media: uvcvideo: Quirk for autosuspend in Logi C910
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestampt handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |  63 ++++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 127 ++++++++++++++++++++++++-------------
 drivers/media/usb/uvc/uvcvideo.h   |   4 ++
 3 files changed, 150 insertions(+), 44 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
