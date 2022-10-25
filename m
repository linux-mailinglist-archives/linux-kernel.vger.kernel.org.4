Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28F60CF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiJYOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiJYOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF287F98
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt23so7465713ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=9br0ZyOHSVRhHpxSm/lkMcBl8HPRwiAhy4oQ/5+vON0=;
        b=NAdRz4uGX5vaYMHtHre85T1/QAn0YaWEuk8cU9Z9GAJwiFmiRCcjFLABG34ksbMNIX
         2AgLu1CU3iIh1MuYdw+Gkb3zijx+3ja7hOyY94P2ZOFzVTqcvo5bMeCF/GoTKyMY1ou9
         uKcPMd06uEez4mmoxRRHqSGa5lsGaJkmzIfU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9br0ZyOHSVRhHpxSm/lkMcBl8HPRwiAhy4oQ/5+vON0=;
        b=KVyuwCVGkzPG20GDpyP/P4ZMQJiLpkt/4OHG0yBXcA64D0PmNKkciL8CuEvf33oexf
         V2hauIytQ6C03IQ7EbL/0/IrZAjYUkB0Xy43jtiZ2KA32xClqF37KeHzeneCoSD0JGbd
         1zOW+yR2z+qzJwG+0AqXOSa+aOj4s6uLwTKKVg5Dh1Q6XTdqAVQXvvpjnmh+acwWbyuf
         ersoD+djEBAp64Sd0UkLJh1TaKWEqtFpSH/M9hWTApD10QHgkwfg1SIqxtSKIwt+WaF3
         w0wG/kRbEruRxiRYQqnNjaQOgQp/Wf0aGvLbPkMx6A3lZSEZdfDClY0k2FMj4X1BUWL3
         6YTA==
X-Gm-Message-State: ACrzQf3OQBG43zfAxznNWWitk4hY5yphbfEyWoYdOQhuyN7bRAKUHJcQ
        fOKl7lcLZA7WfB32xpDML4qYMST1dk3SS62S
X-Google-Smtp-Source: AMsMyM61qXwVmlnqt0k5KkxZYdzhgAkGlWy2KA4EsgiC22mCWd+K662gcSJCRtVF9teJJTqiudgNzA==
X-Received: by 2002:a17:906:2a93:b0:78d:b87e:6aab with SMTP id l19-20020a1709062a9300b0078db87e6aabmr32745951eje.157.1666708511050;
        Tue, 25 Oct 2022 07:35:11 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:10 -0700 (PDT)
Subject: [PATCH v2 0/8] [RESEND] media: uvcvideo: Implement granular power management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAO3zV2MC/32NTQrCMBCFr1Jm7Ugyxf648h7iIm2HJtAmMmMjUnp3gwdw9fgefO/toCyBFa7VDs
 I5aEixAJ0qGL2LM2OYCgMZItOTQWHlOOEzvVnUZcZL39nW9jxR00LRBqeMg7g4+iLGbVlK6YO+knx+
 N9mWuP9ZzBYNWqqdo8HVXd3cRi9pDdt6TjLD4ziOLwiD3s+4AAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:21 +0200
Message-Id: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@google.com>, linux-media@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=gYbwqdZCjHzTHN76p6vLT9g8wCagTeQkq1M2o9SG/ig=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/Pz3t7i0pQeRgei7wYcq59IisYUZgO1FSKep7HW
 DevTUTeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1fz8wAKCRDRN9E+zzrEiMfpD/
 wKeFHwQ7Yd35g10O6CpjuxcDxqRM+C6KRi5ku+F6MFlRcd7FAmHntUew7Ply59K8nrUlQHqfPDO3Nv
 H9DD2L7GP2QLcM+eRtB0ivRuLf92XQKYePJA6oIO8te6wGrk8KFX/nKvt4s6ns9OJv5SXSZzHzF6DH
 p6x/O1VjJ8qU700kmpWPjzLGSoLIWXwfSiijggfH7Om3M6gImpmI1WIPlPVCD0U08ohRr3KCLcubU5
 zqJFJDcI/b0UAhYTZgy8Dq0apyNkyqt1rpCty8uPjkayhnJGDAYWJh4/SOzYBVWVdfTUFIGqLXnwOR
 dmtGMhjIYUHLjevtCacsIiah3t+bW73xERk3HEPebnBhIP6TqoMkS615h/rhGwgYXPIWLs+0Zw0M4F
 84iWZQiPxDU7MhJuUEsbUDAAAdWG+uknBg0Nko27cT/BzV0RmRmYXEO3XmXmWMFH+KtIVo23fzZ/oS
 j6vrd/MIXEF5XTt5EWxYa2ZAykRztgjA3zQNXSknP1oIhgjrVy+j3UX6jwGmBnJDirEbxu8fMH5jk1
 cEbFb1Hq5Qn7I5DO2ooX9e4TpyZcpBRXKj561lcm4RwKiaxKCYCYtYwE7//FD2GfWasHpWtGVlQuUI
 HfhUs0wDFVLBK93YBKf1VSsQbf5U7pg+byTniWywvsZWp0Y1nHH3UkiM0BwA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

And now that all the access to the hardware, has a common entry path, 
use it to fix the race conditions to hardware disconnects.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Max Staudt <mstaudt@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Make access to uvc_status contitional
- Merge with Guenter race condition patchset: https://lore.kernel.org/lkml/20200917022547.198090-1-linux@roeck-us.net/
- Link to v1: https://lore.kernel.org/r/20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org

---
Guenter Roeck (4):
      media: uvcvideo: Cancel async worker earlier
      media: uvcvideo: Lock video streams and queues while unregistering
      media: uvcvideo: Release stream queue when unregistering video device
      media: uvcvideo: Protect uvc queue file operations against disconnect

Ricardo Ribalda (4):
      media: uvcvideo: Only create input devs if hw supports it
      media: uvcvideo: Refactor streamon/streamoff
      media: uvcvideo: Do power management granularly
      media: uvcvideo: Only call status ep if hw supports it

 drivers/media/usb/uvc/uvc_ctrl.c   |  11 +-
 drivers/media/usb/uvc/uvc_driver.c |  28 +++++-
 drivers/media/usb/uvc/uvc_queue.c  |  32 +++++-
 drivers/media/usb/uvc/uvc_status.c |  34 ++++++-
 drivers/media/usb/uvc/uvc_v4l2.c   | 201 ++++++++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 6 files changed, 262 insertions(+), 46 deletions(-)
---
base-commit: 1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2
change-id: 20220920-resend-powersave-5981719ed267

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
