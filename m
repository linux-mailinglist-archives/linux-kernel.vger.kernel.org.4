Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808AF6B278C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjCIOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjCIOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:45:02 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE4BF9EFF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:44:21 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g3so8005572eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678373059;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=j0QCaTZpFQda66tbkDh4NA2798g5mrFM2KijxKnqpqY=;
        b=JXlcZf5TJBTXPGC4CRaGGUxnbLNWt6tq33auMN/90FORiWH3AMH77DpWVbvaymIWwB
         SW89Bb99rq8cYHyJwN1KtIo951dij/3LxxmD8xXkrEsLVgOG+Ww/jjk9zV5HSlHY/P04
         iJhKxP+XILgPJjWgASKARUzJh39GHmxlDktWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373059;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0QCaTZpFQda66tbkDh4NA2798g5mrFM2KijxKnqpqY=;
        b=A5/IwSKVej3ERCGltOoykFF16R/YBAhkiF9g6fSFIeImgZY385j/q2i7os3g4dvVfw
         H86jwF3NvYc+ijNV8UPKGmlYCCt+PzMkAprKFPlh/PqaeO9a76cNHcMDWtuuKGqqw96f
         uwEFC8tX5R4fZd/3/IMnDqqrMhCaSibsxeEDXx9WTwH4Vpomq1VMZ/Jz8rJlhszQpLPa
         AgcPVWUdu3JUmxUZxSGNwWYzLSSCGdppC6LSM/IgV75z+xiPyDLAKx17IB5a7sy1830w
         Y9ABrbpjIchIAqFOKT3ErpedkliM/hfcapOsuw5OudMO2FqJy30jhjnwnYxt5kJqaxmw
         e0pA==
X-Gm-Message-State: AO0yUKVDOlZMgzCCgPEiy1V8x9tzBSbsVC1IxrHyPBrL8W6EsSSQxOyE
        KERbT0w0nR7b/0HytfSC1SYK/DOwHuD7X3wdnrNhHg==
X-Google-Smtp-Source: AK7set8sU/asqDzlZBJayNJABHwje8blfJCPJx2Zc8Gx6DoijRVWLy2bRAZjzpxeW3chkoaU8+mnaw==
X-Received: by 2002:a17:906:1604:b0:879:bff:55c with SMTP id m4-20020a170906160400b008790bff055cmr24474305ejd.1.1678373059532;
        Thu, 09 Mar 2023 06:44:19 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004bdcc480c41sm9708931edj.96.2023.03.09.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:44:19 -0800 (PST)
Subject: [PATCH v2 0/3] uvcvideo: Attempt N to land UVC race conditions fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALTwCWQC/3WNwQqDMBBEf0X23C1JLKn21P8oPZi4mgVNYKNCkf
 x7Q+89DW/gzZyQSZgyPJoThA7OnGIFc2nAhyHOhDxWBqNMq1rV47xT3Ehw5cjY9Z3VTnU3mjRUxQ
 2Z0MkQfahS3JelloHzluTzuzh0jdeftUOjQmvuo1Z+stTbpw+SVt7Xa5IZ3qWUL2dRYMywAAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 15:44:04 +0100
Message-Id: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Staudt <mstaudt@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=QHnRbL/75sY1mg763dtX1ee9LADH3yYE98GBTazRZhk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCfC2dCdyamuJtcwg32/a/jrzGAHWDnDucmFsS0bW
 3fMT20yJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnwtgAKCRDRN9E+zzrEiEOjD/
 wI+h055aamjDQj8n6RWHDvLNqfRqM6BUIQGHopUnkQZRlFoK5Sucbg2e6n9ZIJ2pEe6BlEPZYrxv6g
 8MHx0gI1BLjSj5aEDpWwQ5emZ9wlvYsm6K3l4z67lmLr6ARj2TbBzvWql8hIeypb22oxEnNtzpdYzc
 EL4e/Umrg5Dx7WJWipslAr70Tg4kfZctuzSnnJaqd70I0ThSBjfFsYrs+6MvZtlCUZJxGvw+ecsIVu
 42imzYtKHsDb0+wGwkcUszX8zww5HYW1MSKQLd1eficFMdlh4RnrPV0VN7xG/PWeL0i8BqRZ0inETj
 +QQy4f6BZItd2++M+CxDuuj5+lu1H+Fc+pMDTaY3k5JaW1W7yFDFXPnlnr92H3UcFhIahUWWhWbzsp
 keEleIyGsDXQIazJWBHUd1Q2SvS0leefGoC6UTGt/MUzyw0UGL0brVSOdEv/zBm9Mw9R5G031Y6fva
 mn8vZK1yAnDW5tvIen4fWq0E4mvJ9WarvUNsL8RHWmE6W0nKE+4Bn3c+bOrJuXKzGgnohCTmch7R5P
 8dhjuQVaqO27vZSgw8khjgtL1Q9piU/u2mI45wQcEPg5vX1xJwCa65PQ8t0D9JMs9/QIS7f/e3+WLy
 kuzaHmE5BduEzpnMrA0HWvCtONkA9GlufqK3dw+PZQN/CwEiKxrwpGiY3LAg==
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

Back in 2020 Guenter published a set of patches to fix some race
conditions on UVC.
https://lore.kernel.org/all/20200917022547.198090-5-linux@roeck-us.net/

That kind of race conditions are not only seen on UVC, but are a common
sin on almost all the kernel, so this is what it was decided back then
that we should try to fix them at higher levels.

After that. A lot of video_is_registered() were added to the core:

```
ribalda@alco:~/work/linux$ git grep is_registered drivers/media/v4l2-core/
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:  if (!video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev)) {
drivers/media/v4l2-core/v4l2-dev.c:             if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (!video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (vdev == NULL || !video_is_registered(vdev)) {
drivers/media/v4l2-core/v4l2-dev.c:             if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (!vdev || !video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-ioctl.c:   if (!video_is_registered(vfd)) {
drivers/media/v4l2-core/v4l2-subdev.c:  if (video_is_registered(vdev)) {
```

And recently Sakari is trying to land:
https://lore.kernel.org/linux-media/20230201214535.347075-1-sakari.ailus@linux.intel.com/

Which will make obsolete a lof (all?) of the video_is_registered() checks on
Guenters patches.

Besides those checks, there were some other valid races fixed on his
patches.

This series is just a rebase of what I think is missing on UVC even
if we fixed v4l2/core with all the video_is_register() checks removed.

Thanks!

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Max Staudt <mstaudt@chromium.org>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Actually send the series to the ML an not only to individuals.
- Link to v1: https://lore.kernel.org/r/20230309-guenter-mini-v1-0-627d10cf6e96@chromium.org

---
Guenter Roeck (3):
      media: uvcvideo: Cancel async worker earlier
      media: uvcvideo: Lock video streams and queues while unregistering
      media: uvcvideo: Release stream queue when unregistering video device

 drivers/media/usb/uvc/uvc_ctrl.c   | 11 +++++++----
 drivers/media/usb/uvc/uvc_driver.c | 12 ++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)
---
base-commit: 63355b9884b3d1677de6bd1517cd2b8a9bf53978
change-id: 20230309-guenter-mini-89861b084ef1

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
