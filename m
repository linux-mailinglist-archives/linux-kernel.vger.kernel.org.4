Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA763640BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiLBRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiLBRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:19:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF11E785B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:19:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ml11so13068729ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=r/RdQpRDc/P3p5PuMcx3RxG10Ut5U2wPQz1yCcrQs0Q=;
        b=HzxHuLouTRvA3KjA2OBUGJkyjrJsTTCyeds0LYUc4MEDNmtV4h1eSfqOa4jK6SWkqX
         zT7TdZry17LePKM+EvXbOs5xTw19lJEFcUWIPbNyboDMq14qQninfXyWf5BjAFyXIgpG
         Z6VUGquxvE2DzNiryD+Jfj/yagd+CKvckd2nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/RdQpRDc/P3p5PuMcx3RxG10Ut5U2wPQz1yCcrQs0Q=;
        b=vbsb1/NfjN/YzdexIuDqRRxBuE6z3yM1o9MWHlUkJgGSpOuyENvrzMidRigFNwCXa6
         cn3MweEAV7OOQn28+A4JLKT+mcKqQ/hUfL5+v2VOWPFvWyCZOYovcb/pvudPoJ1X0F6e
         3MmB5kq/3G+CuJyaU7/rlQvzBd+ZymT7pKVFkC+ULPor3+fJrGbKvL4A4Rbv6f4nVJ/3
         B/vUO6QV7MAWcy2TRBsdzOgvW9U2XpEVnbtFBVTh3aEt4//KeHFMhc0a2lCAOL88dkdt
         n7irEhSly/tpF9A42QNHj3Fm1gxP3Vzj1jlB60qd+6++7HeudKnfknMHsAbt8NjuUjpe
         gEWQ==
X-Gm-Message-State: ANoB5pnVMLYg9XHqb1Uyt6QIJQI5nNFQS4bgZ105aYtYO+C7fsPfjJYr
        NzAbxmfQT/V3CTqs4KMC5v5b3A==
X-Google-Smtp-Source: AA0mqf6c9wbxGNnv16nmDSnRa3AMqPPV1Kw4oGHEw+22EO8NTOtinsOXsGc0Dt1L1CQA5n29ygSn+g==
X-Received: by 2002:a17:906:39c8:b0:7ad:79c0:5482 with SMTP id i8-20020a17090639c800b007ad79c05482mr51357594eje.730.1670001584143;
        Fri, 02 Dec 2022 09:19:44 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm3117864edq.72.2022.12.02.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:19:43 -0800 (PST)
Subject: [PATCH v4 0/2] media: uvcvideo: Implement granular power management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKIzimMC/4XNTQrCMBAF4KtI1kaaSdOkrryHuMjPYAOaSGIjUn
 p3B5ciuhreg/fNwiqWiJXtNwsr2GKNOVHotxvmJ5vOyGOgzKAD6EboeMGKKfBbfmCptiFXoxFajB
 hg0IxmzlbkrtjkJxqm+XKhcor1nsvz/aYJOscfYhO84wKkteCsNHI4+Knka5yvu1zO7EReg38GkK
 GEVEE4J7w0Xwz5z5Bk+F4bNQSjlcYPY13XF0lCe9xAAQAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:19:30 +0100
Message-Id: <20220920-resend-powersave-v4-0-47484ae40761@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        Max Staudt <mstaudt@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=kciBkpg9OytuPzxiqiWfbkAo1WlMycZv7Sn0Qh/anFY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijOlKg2WE+mgx19kj8BfWLXFrt21VuBIwjiigxpp
 S4ciJfCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ozpQAKCRDRN9E+zzrEiGlND/
 9de/F0ouT85wAcxMUsezJriMfv2tJLWDFZA0+HYtzm3cgRovk/352X+3fEv8WQTgLNmJsl1hbQFK2g
 8iNOjYeW/O0HciAtITljyDQi1udgCvcIOcAVv3gLXlUClMNQHJYhC96lysYhMCh9OOi/1R4a5G3TbN
 yVjiU5gQR2hCDVfdHlqo25XKTpXrFl+MDm7btoJN9JcIOA5xP0wJqZocICS3yt9TYhjBJESSV/KZLX
 HEdMKKVZ3tmK3xnyOrbcJK1o7McsrgHVu/kc3Kte1Urfqd/by4DDyoWSZnCXYltBjmgWElAJh5POVp
 1xFPCtKiVqNQTnMZmLeKQVoP+UewDxg6pg1b35psB5Slha75rjhSVmPBCrhuATsx/b2aNmjZk/x/xI
 ZOtNOZTs3L4Wail5H2NIfgr8dL8HDdE1zOT82msp2/siKWkJVc8Qk6y/pdXOYfPQP4eNQPEXpsRdeF
 eFmNXtBZr3UcjlDFzDh/oXlkdhOsDn9pbcWwXoM6ksjAau7mZqIC8I0PlVA3bbxTgnMhc/Mx7VBszz
 qpnj8VIaP1t5Ab3M3RfQZDA+T6nfuq5uPLh2fBgXtk7YMvOMXQtSRsUsSTUNdRJhP1ZiRZnmqtHf2g
 pfOHt6aQGfnmIu0dZsSucura6lggiY5b+gLWp+YOfN4dMOwGncEgfqID2N1w==
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

Instead of suspending/resume the USB device at open()/close(), do it
when the device is actually used.

This way we can reduce the power consumption when a service is holding
the video device and leaving it in an idle state.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Max Staudt <mstaudt@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4:
- Remove patches to avoid crashes during device removal
- Link to v3: https://lore.kernel.org/r/20220920-resend-powersave-v3-0-c47856d8757e@chromium.org

Changes in v3:
- Rebase on top of uvc/next
- Reorder series, and put "controversial" patches at the end.
- Fix "use-before-set" bug. Thanks Max!
- Link to v2: https://lore.kernel.org/r/20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org

Changes in v2:
- Make access to uvc_status contitional
- Merge with Guenter race condition patchset: https://lore.kernel.org/lkml/20200917022547.198090-1-linux@roeck-us.net/
- Link to v1: https://lore.kernel.org/r/20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Refactor streamon/streamoff
      media: uvcvideo: Do power management granularly

 drivers/media/usb/uvc/uvc_v4l2.c | 193 ++++++++++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h |   1 +
 2 files changed, 159 insertions(+), 35 deletions(-)
---
base-commit: 58540610e464d8b2ba46a11b81c3e6fcc4118fae
change-id: 20220920-resend-powersave-5981719ed267

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
