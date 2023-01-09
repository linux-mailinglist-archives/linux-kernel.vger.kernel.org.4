Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD79662268
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjAIKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjAIKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:22 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D15810FD3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:01:14 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u19so18619148ejm.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvr86EcVYprczQ7Mp47b1jJqfLxIkymln8np11xtzkI=;
        b=FCwhaykY5BgM/Vw2hOHnNX43Gnh3PkMvdOetmSPvTLpQwh3js+/qX/SlkVlyQ6fc73
         mfUbVlvY7rQfMkB+ojN/fEPz1BadgZVZzsL79EPfYfM6lTA0WMeaou4XHqk1Z/fkYtGq
         40ruNpDJNBUh1l0TdpuSp6sjKxZbkb87Jv1So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cvr86EcVYprczQ7Mp47b1jJqfLxIkymln8np11xtzkI=;
        b=DhyfAVjBYLdoRa51mzuEliZjj7pTo1BL8tBshtLI3vIhoHOPBCXsQqEsrzXvGuertR
         N5V2+Zi9noaGXj4RCHfPTbs6ZgcbtgvqQvwyCr9hyU/1eMsFLy/GvzcldpOJUTOuXiiU
         Hs6F5+RoGG9+lJ7L8fJwOUIrnBxTjmrpyXmglvkoz/l3ZK4gx212ib4nr5oPSmVvZDvo
         uPT7KT/nM0KriHie3n/Rzpao/mYOh7iCKG0naXR9A4AT24ZNuK/aXz/ZZo8UAWjPL8rv
         zcj/34vr+8jTW9AXe2bew5nQtwMTk7lKSFL1xGNKZ13roUNIpSGguWSwIUP+0Hqu9Sgp
         eI5Q==
X-Gm-Message-State: AFqh2kp5/3FkmyZPVpF848/ulnk3KcgeS7QRm52ZTGOjfRjGkpfJzJ5+
        nbFE89OV88hzHPdDnr6ZuulUng==
X-Google-Smtp-Source: AMrXdXvNvxEtV6UA+XKsChIrs28mvTcENXrswmEeaF1oibD0s99KRUVWg5Gq3/+ht8oX9boCGrYKXg==
X-Received: by 2002:a17:907:9d0e:b0:7c0:c10e:1395 with SMTP id kt14-20020a1709079d0e00b007c0c10e1395mr55736385ejc.1.1673258472965;
        Mon, 09 Jan 2023 02:01:12 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:cd22:9dd:6d54:8488])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b007c094d31f35sm3557548ejb.76.2023.01.09.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:01:12 -0800 (PST)
Subject: [PATCH v4 0/5] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/lu2MC/4XNywrCMBAF0F8pWRtJprEPV/6HuMhj2gSaVJK2Iq
 X/bnQpYlfDvXDPrCRhdJjIuVhJxMUlN4YcxKEg2srQI3UmZwIMgLXAaMSEwVD7mJzHNEl/p6pEgB
 paaIQheahkQqqiDNrmaZiHIZfWpWmMz8+jhedz/WsunDKKreZCwakRTFy0jaN3sz+OsSe3LC6wr0
 BWTGNYxSulKg4/lHJfKd+KajuJWHeiNl/Ktm0vJwnDpEgBAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 09 Jan 2023 11:00:47 +0100
Message-Id: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=RoEgR2V3s+l2yEuznl2FsB16WAvD8+V+KuBSRItNVRQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBju+XZDfuTHchTYMBEBnptnUJxvpJ9QI0AVvLXL554
 rpl/fcaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7vl2QAKCRDRN9E+zzrEiEgxD/
 4kd48Vii2lrHcdK+sAvfCtzC4Ou1ySl1CQqVY3C1jxHSmj6aKFOX++z4N4ssUB8eoac6NFHj7Y22ow
 RgmcWkISvoamDlZFBoRRlaXOBn6xlMdcLQyG8K6YrPtnqYPek59i8prkH4y4pgZZJ3cwn3OqJpFyZD
 swFPsH0hhgDR4tAXCsJ+eHOwdlBuQmII9oex7sZ8zb7qPJd/ckwKpqXBYa5M5cYe+UFJ/5NINfiinF
 Yz6m5yQz68gX9pmd4eraOZzpsmmRwsdqXqVHelrB65x5OSKPCqiNZiRFQGPSU2AoBPGWTcMPZsjK+V
 px6+RDJA+O4x2vSGtedqW5U30INEnjT9mFTU0AWYj7M1l+COdWMKAMafSFJ8uFLpS9vUDsxM8YlbY8
 LDO6fBcT1iPy1V2il2IecqmeCAVCo2V6ywxJMXCHiY46xzMDilWAo1WwgLBHTrSxY5kVPcommvGWc0
 baBaQ3pNJMeLS7/Q8zdv0utdkPJeV9tItmv3BAqby17JIjD2o+qlH89RoeSP5e2jRwHZRF3KisFpMb
 Rgq8Ij/Ye1DzmZK1z55NHzjFHxWt9v1Lt66YzVGct4kzLj42Ho/66n3F+daIbMbTqL0p28/U2K0lrM
 pL8w5reXDLVa9SkNdjmfgFCSwubEfnkO/WUvMQ4lxNAm4rXrKDggxoN/tbbQ==
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

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
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
