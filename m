Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D591C64454B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiLFOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLFOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:07:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274E2C11F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:07:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c66so14121690edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=RgnE4WEHR/7YmZGFoH+WV+HSsx21+thOQaH+skdfgOM=;
        b=FdEpsray+PsOn8PAMhEgak9LVnC4lJ1On6m6ct/FZWqVQ3cjd1W4PiCULdffDqgLeV
         X10JWzLYPz/kOCrBJAnIBTqlcRJM6prAoTUTcZe/0BLws+zOx5WnncmMWPFqbz38+eD0
         ow8VrrWQKktZeI6dYY2ZNjmSqD7PCSqZ7Vhew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgnE4WEHR/7YmZGFoH+WV+HSsx21+thOQaH+skdfgOM=;
        b=y4e6slKhuDPFWpRdi9I1ivNBgbVx+rdpkbJmQw9TEfG6d/P9U8mJfOxY1d8IvCPOSZ
         iyjrRD8yqd5NaFwq/6rnS+qhTd2YJ2WLHd67wBepTAlLXA3839cpfYL//3vE2ciXeA4M
         C8SRfs0TLyn0RLO8koT9snx5EKZosZ6E4IF2Iog6Cxr/mAb6GZkG7Q99s/RJtc0jYMLl
         Zmj2/1AK0BM8vDtCYtq65ABJJq8lS5Le62KkdM67Z0zw6rT378Tt66j/UtSKS/AOcEh1
         wTZEE4F2HzPmGLU+27FjA9GlsGBEafRAY4CdO/NNKK0kuPIrGBvttpFkg9/kFPAApRst
         2duQ==
X-Gm-Message-State: ANoB5plSs9rmxRmHD1FZsBhEVowS45zWQgMw3JxtuNdIdYRLPs++mC0M
        pg/oPFKi63wDiFpM71piUQLg7A==
X-Google-Smtp-Source: AA0mqf6xL1UN0HbphQW2OQ4/szP7oL5exFr3cpWlLqtbIMXVXcRYVcbO2Ren9GtjZTf8zkDG3faCvw==
X-Received: by 2002:a05:6402:25c6:b0:461:b825:d7cb with SMTP id x6-20020a05640225c600b00461b825d7cbmr53356368edb.167.1670335646152;
        Tue, 06 Dec 2022 06:07:26 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c82e:c2a2:971e:1766])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906305500b007838e332d78sm7388027ejd.128.2022.12.06.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:07:25 -0800 (PST)
Subject: [PATCH v5 0/2] media: uvcvideo: Implement granular power management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5Mj2MC/4XNTWoEIRAF4KsMrmOwSm3trHKPkIU/xbQwo0Ezhj
 D03VNkGYb0qngP3ld3MagXGuLldBedZhmlVQ726STSFuqZZMmcBSpEtaKSnQbVLD/aF/URJkm7en
 CwUsbFCZ7FMEjGHmraeFhvlwuXWxmfrX//vpnA5+0fcYJUElCHgDFor5fXtPV2Lbfrc+tn8c7exC
 MD2bCgbYYYIWn/wNBHhmYjGeftkr2zjh4Y5sgwbBhnvAlklFvgj7Hv+w/w/0J7hAEAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 06 Dec 2022 15:06:54 +0100
Message-Id: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Max Staudt <mstaudt@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=TstQ9mml1nlOSf+yBkBiXBtArPOP6g0jK9E75Si5V6E=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjj0yCH0v/ONKhtaOozuV4Cxx9zy57h5MYjeugc8+r
 IiYqwfCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY49MggAKCRDRN9E+zzrEiNQzD/
 9PC+Fszp7/hqwtG9rMKLt/07vCc2HuqPTswOGsc3Cj7bQ0fLn7B6B9PWpRU/f6lcztzoLYMnwooGj+
 uR0df6Y1dxE0FZ4QgftHu6poqa55mbnnzBqxAJuHa+muA0Ee1ByAqeBmL+4mfusDVhxV5Gqhp191jG
 cR3JxOdmDEnLOvQsqe1srxqVADbX6VNeN7O34sgT0ZxD56CfZgSzXdhdTD/I4MT8J985mNzHTTbOZa
 IS/FVetTGb0yzmuPqoaiDE2WL0J2GZ/rbCtg2n4fPBx/0on62EF3DDgksOVBxbYqE0MN52/fwlX9gS
 7nHNEykQpk2j0IstB89tIvL/j4GumkjsAywMy7K0qHinVQUnqQtEmDJBqistXSVu0ZQEaG+Hjfs9PY
 yCHw0MB0LSIQk4jKwuXJhkQD/L+RuH2l71h+yoJEg5pm3ZpGvfSJHQLZL/Ev6PFs89AIa6dusf8ioF
 8X0n1uSQVoEleWgSxiaWrI6VSz+DETMRhD9onr/t1/c1MoIFmpESbM2JfRfsFY35o0UmxxFymao7eb
 CYecpaHBKlfe4a6T79V1jgnyJ90yFdfXlIhttZOuRJh4Ex79FyBoyIE2DeUDQdrGZaNcaNu6U/7nlr
 asGS6mTT6rYii5GWYQrqpx5Gnaelxalk3RpQ+9adCFPAqBKxHABhBh09FGBw==
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
Changes in v5:
- Improve uvc_fd padding (Thanks Sergey)
- Take the mutex always in the same order.
- Link to v4: https://lore.kernel.org/r/20220920-resend-powersave-v4-0-47484ae40761@chromium.org

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

 drivers/media/usb/uvc/uvc_v4l2.c | 217 +++++++++++++++++++++++++++++++--------
 drivers/media/usb/uvc/uvcvideo.h |   1 +
 2 files changed, 178 insertions(+), 40 deletions(-)
---
base-commit: f599c56de2bfcf5ff791b0f4155e997e08e364f0
change-id: 20220920-resend-powersave-5981719ed267

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
