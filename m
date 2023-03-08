Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254BE6B1577
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCHWpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCHWps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:45:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595390B59
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:45:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw28so71930830edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678315544;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=l1RIwBp0yJ5lH1L64wuQ7APSBGMzI08Fx77HiM0sRVY=;
        b=mgiP69T+eDIx6MSx9UoTePey0ChBWaMtS4KdAhzFRWQHE2Rog4S3k1vLd/vlxqBGbz
         lyahe//EWWag78QJy3z2hXAKRplZdKtK24sMw9EJ5XKqkwnkIhy62nyo4D2Wbr9r9Ctz
         wQOXp+h969P2Gb+xmICo5PMbp6iOM5d+B561A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315544;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1RIwBp0yJ5lH1L64wuQ7APSBGMzI08Fx77HiM0sRVY=;
        b=kV8+Wm+GdKivamXeBoEB74CgIkgO5YAC6586BV4FsbzhiQxv+pYa2Gn3b7TIpr8zel
         iJswQPcRgwreYc5XMJpAB+D9dhQHTZDNBGHx5LpikkBA6VzLbKWKn/tUnd/EuLSiWJlR
         3+jkZUoQPl96R+1GpeNBj/xY3CSYGWTZ9jS4d+YxzEK73Y6945F2GvIsoHQ7P3r3gWab
         5ffF+1CRJdQ/zEPNjUs5h+G4Hi6rkzEeRU1xb/d0Y+H8wCJJ0b2EzcXrcywAILLvpdGf
         7CXDMSbPrmTMvyn+vwJz2s/EhkBZP+hYtODr+iA539U9JutbwamBs28UKC2UpXihVguB
         4oNA==
X-Gm-Message-State: AO0yUKXqni/yKI3MJpjyrjda8gZOI3nNsE0nccKGcEmXFooHca5YMEN5
        QfjkWE0se5dRU4Q5VpU4VC2Mfw==
X-Google-Smtp-Source: AK7set9JOYdRL0/NqQbuA2tqbVxLqz2WxBXtC/Mhnbn4bxIrUqE2XEYic9yx9qejTKYXp7nSZNPV+A==
X-Received: by 2002:a17:906:4bcd:b0:8b1:812f:2578 with SMTP id x13-20020a1709064bcd00b008b1812f2578mr17599087ejv.45.1678315543904;
        Wed, 08 Mar 2023 14:45:43 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm8040167ejb.97.2023.03.08.14.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:45:43 -0800 (PST)
Subject: [PATCH RESEND v5 0/5] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 08 Mar 2023 23:45:31 +0100
Message-Id: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0PV0sUQqxlmjE21EwLCffDJjqS6YLgkk2HDuasuWIrM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCRANL7TII2hMFUYOFih2OWPvHpKKNih7ph6pLjKl
 +VhzVbyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAkQDQAKCRDRN9E+zzrEiGbAD/
 9W37DQmFo6MV8sHK8d598i0ugBkAVi78huGpp2TLf2HceMhcpLl26YWnCQLtI6oh+uFzpj33kfd4UP
 gekxsSimluhB52INzwTeSn8sR1FN2bWYkHu8duwVkjoJjgyKf1Wig8nanEv0DPKC9g1JJkR7iOYbsd
 ED5CYY0TElRlSOPYqE9MfoGPLvq3eXBc7pz82t5XWAqP86a9balWGjwNZUcxMMp9YEj72D1HQD6oJa
 a9HsxCmHN6iSZ7dinViroJm1V6SpFlj8djzD8oaiLlJ5lA3RAbtwbS9UWhk4wWhRSI6T1jkS1bBthN
 4cF12W1vp5zxKHusVKVYK+Q701lu4jD5y2+FPWU2fSWsK10d9DMu3pFSTWpsP7cNC3PFy2i8wW10x+
 +8Qh/Pi2G1z1DWaAkqNpS2MbayHtm6DLCfAKqOHN5Z+CjsXQ7UxAXoWZPeMlQkL5L5VUhpzNzQ4kZn
 tpzNdW9BzQo/Qnyy76MU+V09moQz3u4/Ka5ddVXVxU1j1ePnaSkHoVxBHAxTnm6J0Sb2ENyOvk2iEE
 1dT0HegKk5GdrWlkig8N22bhTcHosfJLXxopUz+zh+AsaYnV9FN30n0GwvxUnO0NQme5OhoU0TELft
 OPtxmET3yamNzz/UB9VgocjN4sbmDRdt/g8EnaIDYKXfWbZ7eWn3BEy4o/1w==
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
