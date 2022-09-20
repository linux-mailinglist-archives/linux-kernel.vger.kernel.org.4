Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592385BE816
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiITOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiITOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECE501A1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id go34so6498760ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=Ez73OqelWaiqQZHywKfWdNpRrtBd+18CkyxFZ5hGr0Y=;
        b=UlBDZ1GQ58SNE6hpCueSS50fM0PqqoWSYmfrotNUGHrgwVpvle5qTcCifVp/apMx2M
         BTprcfs4ef7jcG+TscNzvAwqntJPHTWG+2p70zhywo5CppVXOEGupC7Jco1mtQurCxk7
         Fm3ZJrGzVnVu/m8xG68WniPAyAcK/NvKCEydY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=Ez73OqelWaiqQZHywKfWdNpRrtBd+18CkyxFZ5hGr0Y=;
        b=4KyHLFhwG3bFVtPb9PwUxm0WKYOGLub6uANO/E6372mco/U7uMJKQsqgRmPnAL1WWN
         t/5JlTKBWe0eYEd2sULmgEodmFTfRneW66mCsfc28Qe/+XaBhwUlznHdFtU+NLimDWbM
         /Fo11VqEKJhJKStrERo0g5tsIfoeUhTNe5w/VNe0YTsuNMInfq84d8S/sXW8H4lYMbo2
         IPX6ENgQ3ZgLN8owCosVddG/uuKk1QSy9dfMyBBe2hGFV0JjqetTW4WB6yXQOyxSSQw3
         zfNExEfmcaE5C1EVG/GvihbAI+IrAteoz9tZjq7fWW8DAvZD0QY/uZmWUpwbN3716XYw
         MxwA==
X-Gm-Message-State: ACrzQf2Yuh/qIWkNLnODqPJ1HME4dkcu5Yh4oNffYI+IzYGhiq1cpAdQ
        ghmAL5XzI8yatbHyQM+B+KBWe6kOYFXZ3+XuQfI=
X-Google-Smtp-Source: AMsMyM4eZUBk6faCshpGpemqa5t2IkhLQULsUqhPZnk5xpBw5YLvmCWlAltE9twH+zpkRf/GHw3FNQ==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id wu11-20020a170906eecb00b0073c5bcb8eb3mr17045139ejb.284.1663682906247;
        Tue, 20 Sep 2022 07:08:26 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0077016f4c6d4sm936564ejg.55.2022.09.20.07.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:08:25 -0700 (PDT)
Subject: [PATCH v1 0/8] [RESEND] [PATCH 0/8] uvcvideo: Fixes for hw timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAEbJKWMC/w3LMQ6DMAwF0Ksgz1gKLhKlt0nIV2MJ3CoGOiDu3oxveBc5qsLp1V1UcarrxxqGvq
 OlRHuDNTeTBJEwS+AKh2Uuv103+B63L6cHRCaZ5TlmajFFB6cabSmt2rGu9/0HOhEd5GkAAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:08:06 +0200
Message-Id: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=5kkRIOhBcFJuwoPAXjOCfdki8Mn/TxMLn0AJ9wHdAog=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKclIJvMQfMSSPDIBD4bvuSvmb7trva0SsHL+vrQr
 XokHjv2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJSAAKCRDRN9E+zzrEiMroD/
 wNM0O/O4VM7t/deoikeZsDTcn6KQbgh2huS7YpM4avdUQOirkv5v8YpV1Vbx5LOcj9aIDpZKrwm78A
 09Fty56532kyF4PLoicBnTgy42BMBVU/N47eHGAeaDEx2T3mtOhHq4xpemf0fID+MwFBDQKUZAgsMl
 HfmLrfr7/yjoH+mSJ2nYvovOIGdekOIZPJu0WsCugI1k+4u4gE3x28EgSkzB45tEqxoZCSKm3SQ0y5
 rJZ4mnaqKvcBrVVby3/tWaBDn8FffMF5VNFsHmt5QjwIlEal2afGKWkhZhc20pAWB4uX3TrgI+15gs
 MGZjwD9uAUfPgKqXW0fcshT76zTcyVBMhYpPGo7ZRgRMr+WbhafmX7XeAZt79zqXcsyEJKts3L2Cr2
 BSXiyXEs80uH1CR/Og2rTd6pvIQx6lygeEE6DMFbMfl0Cy12FpJjtHQ8o2GMW68obo2rRBXC42DBUk
 pNsj0dhre3RdbPIPXFWDpJb9iQBj17WwuevRjZvKtRmtSwL0UtjYdYeN8e98QQrbZRcQiHKzn9vcWi
 GeGxoz3H2UdfW5J+xpHVci11o2C5ZvHjrs3JbSV7g+j1+AClIxoGqPrwOlb2qiP8HzMzuiFmkWSztr
 hBHCeh31BOsJKVMVc/fJ2nJTVd0WQAMIXVOUj+tpWYWqDNAWB4Yxhtugc2Mw==
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

Add some fixes for fixing hw timestamp on some Logitech and Sunplus
cameras. The issues have been previously reported to the manufacturers.

Also include a patch to fix the current hw timestamping logic for ANY
uvc 1.5 model running at under 16 fps.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: hn.chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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

 drivers/media/usb/uvc/uvc_driver.c |  63 ++++++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 119 +++++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |   4 ++
 3 files changed, 142 insertions(+), 44 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-hwtimestamp-b3e22729284d

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
