Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCED6BB4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjCONag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjCONad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B82158B7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn21so45398209edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887025;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=S00GVGfpH62zVLKL+pWKAZ6rgymvfTFNSeJRipskyaA=;
        b=VWsJ5H7iAmcdMxrt11FYLFQv/WQtA83yqkm+4ktEVkP8LJ4mEea/7j7kigpxGKtHNt
         Bt8qcJrzwoxDAe/4SFpHMAYkhQt9wGpmdjc/xQc3lqyY0UfJI9EfXlwZjW5z18m3u9Rc
         QNxqnOkSEokRSHFS+vqqBjW7nz6hGmI6Emeck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887025;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S00GVGfpH62zVLKL+pWKAZ6rgymvfTFNSeJRipskyaA=;
        b=HqwLFEfD1a7X417aQgvHnOqMsPx4lMglP4oHXBYk/8ttBnnoHcgc0MiExlfyU1afNF
         TOrxwsCEdaky5XHyFItP/VQW/jTeIb3f0OSA9zbXjFHoZ9wrrR4yPZ7xewI6CKOdSgEy
         xxl7SA//1WEBoNhwy2rhyCIvaW1pIzu59/lQPxnAEG+cMFYamIaWrkOZqowWlXzIUKky
         +pCdaTMdtK771aoV2h6w5/UuTuo9ANbBYolShLcnplW+4nYbUrpUoCBaEhrgFzqSIGf5
         VgH0hYUqD9Cech+zAFWSOoaRr50tWNrJcVM3SEyI+k2F0YOEkVfJ7SwFtfmsBJ66Y+MZ
         9FIg==
X-Gm-Message-State: AO0yUKXO7Cr7aRXWT7CkeINyLV2Uj4LhP1d/IH7e0rE/1SmUDvTUdfZL
        nFzFAe43e9Tvcu2h0T+ly8q0kRBtRI6q0zASP4s=
X-Google-Smtp-Source: AK7set+2+SzTSAGSts4LllytJAq/VCVCFC0EoSXUth2sMT6fbeZZYY67wcXFeFWFDW4q4t0ygcheZg==
X-Received: by 2002:a17:906:e093:b0:921:a224:cd15 with SMTP id gh19-20020a170906e09300b00921a224cd15mr6562072ejb.15.1678887025568;
        Wed, 15 Mar 2023 06:30:25 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:25 -0700 (PDT)
Subject: [PATCH v9 0/6] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPIEWQC/4XNy2rDMBAF0F8JWldFGsl6dNX/KF3oMYkFsR0kx6
 UE/3snXRZTrYZ74Z55sIa1YGNvpweruJVWlpmCfzmxNIb5grxkygwEgPAgeMWGc+bj11ombGuYbj
 wqBLDgwenMaBhDQx5rmNNI0/l+vVI5lrYu9fv30SbpfPxrbpILjj5JHWFwWuj3NNZlKvfpdakX9k
 niBn0FSMkuCyNNjEbCgaL6inoq0Z8Doj1rmw8U3Vc0KcHlnKQaXAB/oAx9ZSDFGGGsTwaldgeK6S
 uGlGSD9+A9JjUcKLav2Kdyltm6GJ0DeaC4vuJIEZhDCoAQovqj7Pv+A+VBy5KmAgAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:11 +0100
Message-Id: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3771; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=VHBq6cpsZ0egMBCxjAjNFSaNVhm6QQaPPkD01swGuzA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchlj0Vwr4478pfFpJlqoiQCdYYT8V3ag2a4yRLX
 Srr5egmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIZQAKCRDRN9E+zzrEiEhxD/
 4xmyImn0ShU5I7h3jFbF85qiMJR0c4oI9AQ9ZM6LLhb5bUkyKFmzpx6AeStRllr8GsQGH/uH47CrpR
 IXU+tvKgs8c3wFPdRxNeQm8KnDr8Qh6MLnrNuBvs6ZtLG4yFHctA3aO50ijWllHA7wufpjQJGYX1Oc
 MycZrkuBSDLR4RtCDt33SxktA3Kkeb+fZlAgsAodMxpNw+ZWkKbZYwes8GYR3qgp0LWOYEVHLurU21
 Y1fsQZaWCKp6n9ajwg5fqHQFWrluVwRZOlCFSHixL9memV817zvw0d8X9I705hRtC2CROYPTD8CD6M
 eWoNpLoKjgdR6JjKF6QqlABOoOQ7Jhr+EAh1twuKYwNkQOj+Pb8/eHhpk5BHrNz0KrpR2s9DuA1/Mr
 LoYco6L3iA3KMMzW2J8caIMif6slMAm7m6mGcyrpSYu1F8kJlhb6XX1eujnOkp+B3v8BFveM5L//aN
 Wyx4ytmCu5es+1Nljh85cZerWPki2E52Abapu8ncsojYBH7qP9EG/A50IjC4C/bXoNnYR2uiIbyFC4
 jO8xu4AjUghLVXIwjuNe6TIfY2X6uEqkNG0hdq2cjahiE1nGGXW/UI75JcDAdom7Ymh2J/vk/Di37Y
 CT+sDczjrOdTL4vHKw8Th2I6Lo6P6DDDGLsWaBz18AO7dU3cJrBajEI3leQQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some fixes for fixing hw timestamp on some Logitech and SunplusIT
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

@HungNien, the logic for empty_ts has slightly changed since v4, would
be great if you could test it on your end.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v9:
- Fix bug on add_sample(). Sorry about that, click on send too fast :S
- Link to v8: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org

Changes in v8: Thanks Sergey!
- Move last_sof save into uvc_video_clock_add_sample().
- Improve comments on add_sample().
- Link to v7: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org

Changes in v7: Thanks Sergey!
- Fix all negative modulus, including old bug
- Improve doc for 1/4 second accuracy.
- Link to v6: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org

Changes in v6 (Thanks Sergey!):
- Rebase on top of linus/master
- Add missing host_sof assignment, ups :(. Sorry about that!
- Improve comments for empty TS quirk
- Link to v5: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org

Changes in v5: Thanks Dan
- Check for !buf on empty TS packets.
- Link to v4: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org

Changes in v4 (Thanks Laurent!):
- Rebase on top of pinchart/next/uvc
- Use heuristic for UVC_QUIRK_IGNORE_EMPTY_TS
- Link to v3: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org

Changes in v3 (Thanks Laurent!):
- Rebase on top of pinchart/uvc/next
- Fix hw timestampt handling for slow FPS
  - Improve commit message
- Quirk for invalid dev_sof in Logi C922
  - Improve commit message
- Allow hw clock updates with buffers not full
  - Fix typo and improve messages
- Refactor clock circular buffer
  - Improve commit message
- Quirk for autosuspend in Logi C910
  - Improve commit message
  - Add comments around the quirk
- Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
  - Improve comments
- Allow quirking by entity guid
   - unsinged int
- Extend documentation of uvc_video_clock_decode()
   - uvcvideo on commit message
   - Improve comment
- Link to v2: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org

Changes in v2:
- Require 1/4 sec of data before using the hw timestamps
- Add Tested-by SunplusIT
- Link to v1: https://lore.kernel.org/r/20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org

---
Ricardo Ribalda (6):
      media: uvcvideo: Fix negative modulus calculation
      media: uvcvideo: Ignore empty TS packets
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |   9 +++
 drivers/media/usb/uvc/uvc_video.c  | 141 +++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 3 files changed, 108 insertions(+), 44 deletions(-)
---
base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
