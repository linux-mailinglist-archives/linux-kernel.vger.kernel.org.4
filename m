Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D2617E23
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKCNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiKCNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094621B1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i21so3020100edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=rRSqOrKRxkHkRwNxoSy4VyopzzE9hshqNihi6pocRbI=;
        b=eDSP4/qfB4HhOoJwSgclm/BG4wRe7tuDc4bLGmoW2eMG5VTFlUGjns89o8YMHbgl8q
         w48cmL8Bk46tjGC5pHjkEUyvk/cj1l1sLqxX7dnPTfpgdOH69CjMQ0EIh/49JT2L8umf
         wR+j9k4eSuyF5Y7ybvtjmTWtzrsU2J8LvfMhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRSqOrKRxkHkRwNxoSy4VyopzzE9hshqNihi6pocRbI=;
        b=aiqOd2qwgyfMLbNI2cA7YLxo7o/xEQCed7Xl8PtutP9PcEFVNEF/WOIGt4h8x/CN/G
         xSoWnfRgSHSS82qDuPsGgJ8ph21nIpNlfC31V9WwDLWnw5BqAJpybjrnIiYE6k9j+FSS
         IoJIUFmf0sSwNtuvxe/eXHrF75ux/CYoxghRREDnwJlMxYqzY3okKWyOtF/LcTNiPOGA
         b6j+NiuE8GMeqmIqfwgzn1HYXiZle1T00rK9TVbqjW/JB9qx4NkIfI4nlKMxU9WJS4Ak
         GHQ/m5mba2SpdHnTE1oSoaGZx0vN9Avgw4xAo1g4ZNWqjtjEah+9bByna4gBXGxOtqrq
         aa5w==
X-Gm-Message-State: ACrzQf1pdrZxuJd1YwYRAld2CIZ+CG0VDUQntgae5OZVAAa+GoAyJajO
        xjm7QW6MayRizRDjS5A9BWz6MWSuQn2RZgI8
X-Google-Smtp-Source: AMsMyM4C1uq7DwManv5dQGk/6pm+PD7Gl+quy/D0f1/PnxicZrfdqlzfoVq1assWjYnQaPo2rPbAwA==
X-Received: by 2002:a05:6402:2994:b0:453:4c5c:d31c with SMTP id eq20-20020a056402299400b004534c5cd31cmr30122150edb.412.1667482866317;
        Thu, 03 Nov 2022 06:41:06 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:06 -0700 (PDT)
Subject: [PATCH v2 0/8] [RESEND] [PATCH 0/8] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANnEY2MC/32NQQrCMBBFr1Jm7Ug6Rmxd9R7iIkmHZqBJJGkrUnp3gwdw9Xkf3v87FM7CBe7NDp
 k3KZJiBTo14LyJE6OMlYEUkepJYebCcUT/XiRwWUx4ob0w0Y166vQIVbSmMNpsovNVjes819JLWVL+
 /I62tsbj7+bWokLuXastXTut9OB8TkHWcE55gudxHF+EW/hsvAAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:41 +0100
Message-Id: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=4P/OGbO11kxTP9OilepqO/3sCN1ElEME+3c5V0/x33c=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8Td8q22paQkuG+nauzWdjT4d3DAL2+1xAm5SBXc
 VNOJmH+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE3QAKCRDRN9E+zzrEiLbNEA
 CDCs8TVydYHdrd3REjPhV0e/JDD6s4MAvIMhZC7fNkgY2yJEpncCfoQMVNoUJne/3nxfqhDJPXkLR3
 ntKctMcUgdAsdd0nhu2NqiY6Hb8OITPz6D/hHpCX4r6LF0DOk9824Yy2VpsAV9TftxW2LetX91fLGH
 nSwIQzkKtQ4Lg862YmByVLpgJUyIFOkXnS1N4Y1AIMT89ObtC8oNCeH0gVEGaBq0/Ti1G1ApwJoA9W
 nDSvRuUs25MKGLjp+v/iBKwJH8LE52tSt2utS1ZuksROE2OraM58m7VuIhvF5yybhK61zo35pczIXd
 I/VZwmYlYvlZlhDJ9rLUTjql9EuwVhTlyXyC21wEy2+g90TRYPfJmOc8XFaXeQultwY2stznLZLNGf
 884sAC3Pu1s033nuTaG8gFISE3Em5hJMlxy9wl/SUobujgfJTYKqJU/RPuohiMKM7nhuEwNq/SCgLA
 hvqAk7KSzeopzrfoL+tuaKYnrQI6mmZQbCDpoMUjyBBA1rhJFl3o6/oDxbZvhV9nRdtQ31vE3888pr
 36Abk7y9qa+LfL/L4W1L+pxafp6BIysijCoVgTaelZQOPT2gGJ21DkqlHKGVFv7fQuzFxUsEHQ+0D9
 +OmYiory88iSRPgEQRhFo2ACnQL/ZYz/qA43oqhnb5sCcI8u2mDscX4RyDgw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
