Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467966B24AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCIM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCIM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:57:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC7DEE2A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:56:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j11so6595889edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678366565;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=3hEN9kfNj9gTKEH0LlSIu6oz8mSE87xpVl3u2NmGO2g=;
        b=FWLNUjd+Ynbth6x89rL+ykVLkpMYbVkpCp3HSaxo6CbqO5QQe4+PXxbwbZpFxkjWDJ
         43JE15NPIwUml8t4w1DvGgUjf+eoBnjy/OfhTQbRHn8sYHMaTz6E4YK4eyA6FIRyOGH8
         EzkGTdhx85Ue7GRIF+eIZeJK2dhZUgtS8jJ6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678366565;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hEN9kfNj9gTKEH0LlSIu6oz8mSE87xpVl3u2NmGO2g=;
        b=sdanciTTCOwSry1eS/VUFOEgonhy6//1wDMR+36BwA2CDylSItzRMx/SmOozznXIWx
         Vy/RFmzczUBEyRktGABHZruNkieQvY6qEA2vyVVYUMuto5QXPyYGEXdWm2b3N/rbak/A
         4eaZ7LcgYkqu5d/DgZ+/yk1XcbVFTnL1sEUxWA7PjCfkAVlu7Iggs8xtY0hx0TG1ssJB
         wxp8hnEMgv6/4atogYvzpOd+k3xKwpRQeAS2+JsyjJWDe8cmL7SOzM0HSi3sEOgg0xFr
         7P1PvcuBgfsA3aZ+2EsY7rZkgWuwQhVPgs22iWZIAQkRWUpHPhUPWFbgRpG9xli4/Vk0
         zsiw==
X-Gm-Message-State: AO0yUKW7ixmEYMnWQlwKo6RCUSoAKfufPADn0VzAQmXqT2/fETpbW0rF
        fVifBGPMQ23N6zLIDNp5nV0hhe/3Kio3HbpC/8Uc+w==
X-Google-Smtp-Source: AK7set+xYtytCIou91jM3HL21244bqhv9iytfgk58tmFByebgnjvXPymi04RHL9NV4smKhyJw+Y4PQ==
X-Received: by 2002:a05:6402:1347:b0:4ab:1c69:5c4 with SMTP id y7-20020a056402134700b004ab1c6905c4mr20419573edw.26.1678366565719;
        Thu, 09 Mar 2023 04:56:05 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b008d92897cc29sm8799523ejc.37.2023.03.09.04.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:56:05 -0800 (PST)
Subject: [PATCH v6 0/5] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLXCWQC/4XNTWrDMBAF4KsErasgjWVZ6qr3KFnoZxIJYrlIjk
 MJvnsnWQZTr4b34H3zYA1rxsY+Dw9WccktT4WC/jiwkFy5IM+RMgMBICwIXrFhiTzd5zxim934w3
 2HAANYMCoyGnrXkPvqSkg0LbfrlcqU2zzV39ejRdL5/tdcJBccbZDKQ2+UUF8h1WnMt/E41Qs7kb
 jAvgKkRBOFltp7LWFD6faV7ql4e3aIw1kNcUNR+4oixZkYg+x648BuKP2+0pOitdCDDRqlMm/Kuq
 5/1LiNKtQBAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 13:55:14 +0100
Message-Id: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=vFDd6F/oQe7T08+5tHLxWw+TIQKM46tu1jJzBD35has=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCddIaY0laEbtS5YjEMwM17StDsQcgYqu4iPMa2So
 pnxu8ZOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnXSAAKCRDRN9E+zzrEiDtID/
 9oYFOnO/M9vyMucuEO2OaxJMvXLBhLbKizVB6nvvKcZm0q/3ZdxTEtaE327Y6nMqI75UlNU7VTcEHg
 2cFUJIAtnA/egh08Ln30OlHH4PMiOjEinQaXMSkgHVFZle4gcMiHsL76eLbywmrz60Ji4izHjBrVpE
 TwXlsPcJ9vejsPacXblOIhI05bx+AGckhfnLVS/FeoUUKV5k4yLB/h7FqWl7iGocC8Sw8v/XrxCxm6
 qi1BpUdCG7LO6bpsDI7T+KfQuiWhnq56EtJMVHsrwlqAbjzi7XrQmpOkua8ug58qXeqNg9EhYeiSX9
 bnR1cgAI+gOxNyF0+pwQ6jfbpfherFQt6NIYncIIkbcfc7O0/A3hnq34gB0e+6WCKLt2+PefbzD8WJ
 fn8Kdtw09YVyjVSPqj66uPmg7paDnSt1ymKQmmq2ysMn7pgMv5imQZspEt0gZr2k2BjYebwuwGCxN5
 kttAspOUB3ILWaq7L+fcShez9zV1a70iyBdcF2ur3hht9eIUkclSpg/AAbli4R76fShsSAiJ6uDmMt
 LOWaC/SD0xMAWvdBgA4q1oFgxgdlGloOaGQCiI15kgbsxHJXUJLTS21kDQ7SkQ+PGa6CIW51s95uno
 z3dpAoDTwZg6csVtMIu1caetSGklBYK/xUC/5oG60YHKDprYeFjU8IeArtpQ==
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
Ricardo Ribalda (5):
      media: uvcvideo: Ignore empty TS packets
      media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
      media: uvcvideo: Allow hw clock updates with buffers not full
      media: uvcvideo: Refactor clock circular buffer
      media: uvcvideo: Fix hw timestamp handling for slow FPS

 drivers/media/usb/uvc/uvc_driver.c |   9 +++
 drivers/media/usb/uvc/uvc_video.c  | 128 ++++++++++++++++++++++++-------------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 3 files changed, 96 insertions(+), 43 deletions(-)
---
base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
