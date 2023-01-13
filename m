Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86111669912
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbjAMNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjAMNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EC66983
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so52469018ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=l1RIwBp0yJ5lH1L64wuQ7APSBGMzI08Fx77HiM0sRVY=;
        b=W0Mfb3U70T2Wycyjf93CaAwwa1HXqY1j/j1XwfFi/rJR2gi68CNenGYB7rYxQdm954
         iFxhSm8Q5nuGXAJnjS32hAxm8oNf7fpg4pbkIicLhBBdGazzrYb3xI++X91P7BgXLyDJ
         ftAXsqsroGAVfZwHxnALShlKOXn06/Ar/LH60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1RIwBp0yJ5lH1L64wuQ7APSBGMzI08Fx77HiM0sRVY=;
        b=2TvvzkhRf/CDqc0SYBCrKlenF6tMwjnViXCwotYVR/7crpV/CBb7oo4Je6DmWYKNtx
         io26P2ocCNoBDVmX8/77RXxizvsuAHmfnKw+rYbI7bXuZxzMOTc64v/4NW+pGQRX+jpl
         xxsSaJZJujIxIxoC75F9gUCJG5OBzYuFfXL1b/hqapAWMUSoCzM4w72H+aR538ZvNBTY
         QpUGP8/wUIiBSJ4cDO4a40qOZQwb+o5JvqTiEo8/wB1tgRe+ASNFjFaihfD4rsP5CQb1
         PIR5Pyq2q7SM8IqzN8eaUoQA5VSQKvyn6xHXy0XHya3I4SbJesHSaMIpN1u5FNqc+cAs
         Nv5Q==
X-Gm-Message-State: AFqh2kr8RwUij4q1zvNyWiBzNril33FJ/OCyxEEO9YDdYJ5yRPz9t77G
        UNCTZsttRo9mkPBuLtNTZWzhSbLILEtXmva5HUQ=
X-Google-Smtp-Source: AMrXdXsj8WQWlFQFhf+/b95rd4ELndF+V7LikSRF6HmSd6L9j3//DasuGYrr3HBTX9TfvkxfEokm0A==
X-Received: by 2002:a17:906:6d8a:b0:7c0:f907:89a2 with SMTP id h10-20020a1709066d8a00b007c0f90789a2mr58259617ejt.61.1673617742791;
        Fri, 13 Jan 2023 05:49:02 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b023:4272:bddc:acf2])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709062f9700b0084d3bf44996sm7072888eji.142.2023.01.13.05.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:49:02 -0800 (PST)
Subject: [PATCH v5 0/5] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5hwWMC/4XNzarCMBAF4FeRrG8kmaZt4sr3EBf5GU3AppK0FZ
 G+u3PvUuR2NZwD55sXq1gSVnbYvVjBJdU0Zgrtz475aPMVeQqUGQgAYUDwghVz4PExpQHrZIc7dw
 0C9GBAq8Bo6GxF7orNPtI0z7cblTHVaSzPv0eLpHP611wkFxyNl8pBq5VQRx/LOKR52I/lys4kLr
 CtAClBB9HJzrlOwhel2VaaX8WZi0XsL6oPXxS1rShSrA7By6bVFsyHsq7rGzxXxVCOAQAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 13 Jan 2023 14:48:46 +0100
Message-Id: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0PV0sUQqxlmjE21EwLCffDJjqS6YLgkk2HDuasuWIrM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjwWE/Q89zpxJmxeKVAldSf+ac05R3bvBuUSMjq2d+
 wk6nBpqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY8FhPwAKCRDRN9E+zzrEiEq/EA
 CUllrcopo8nrPc3h0qC25Jp+7tmZL+y4qDktkIO77bc66ngbYk4XewGHaEKoozUQF34vq9ZwqtX7yW
 ExIdhS29fj6k8Aohui8kvgwrp/iHM4/b1jd+e8M4zXGLmZMXJod3YDVBV1d14vQNUbddmulvy4pe04
 jN4Z3sjsW0gad/p3OMBR9Q0dC8QmYWbRQJ8ZAct9LyI0Qy0ECo2A7gW/pPzZdDWpvlZDKZ56iuT3Px
 GZul4vyxaV+Ar2HG/ksaowHTHI8auwkgOVhDz1Fa/NShEkfSAKKmsNxBOcKm4x6FPtW3sJD3CGeFG/
 s3HVpaaPzK5mfpbCNHutEAzDFgPKe8yqKCbBzGGkq86KA1F3C+ij3FmeCna1rpk9nelpk/20nzS6I5
 Bz+NwKAzBybsk4gkG7yp8NaCWTaRsmXQt4ezy2SAQUoBQ6Dm74BJvSq90V7pb/IrEgwveKLDYvQ1l3
 mmKXL+vGni7jugK5WBElF8AK7yHAvhjTag2oPoSQIERnpC22+W+RgGoJXjV2uFiVQ+VlulOJVTv3iJ
 10bkMa/ErOFBq44AlG6lPuZaoNwpCNkGb2oHm7/dDg3gnjWab45v+Lgw+NMNGFQFL39HDy9hIUfKi2
 UXcCwkTG65eixpu2WwEe2LO2+Fwn15yTelUSjCN9NkKTilrySEap4dnuTryg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
Ricardo Ribalda (5):
      media: uvc: Ignore empty TS packets
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |   9 +++
 drivers/media/usb/uvc/uvc_video.c  | 123 ++++++++++++++++++++++++-------------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 3 files changed, 91 insertions(+), 43 deletions(-)
---
base-commit: 73d6709376914f577a61bb29e596fa93ec66598c
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
