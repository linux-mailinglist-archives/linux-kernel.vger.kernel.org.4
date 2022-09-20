Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231855BE855
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiITOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiITONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4B13CCB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:12:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hy2so2783093ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=mVBcHjmkmE1JmtUWUm4fp2itJXzLFhGZsI0u5oGKVI4=;
        b=aFnR0WQiAIMVoPIRi+Cv/WB4JCc17NycfmORdqOtSPyX0hIo3abxqIbgGHYgdisuO/
         fCLITXZiHQ7jp7M04BWXxqqPbSCu3nqYAWjWpuAWu5jyGdcpmpMZmS9L4f+kLZqqOPhG
         GZ9yRmLlBww+1zhnarhGBG3EliKjz0UhXqOjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=mVBcHjmkmE1JmtUWUm4fp2itJXzLFhGZsI0u5oGKVI4=;
        b=J1nMwyVMQDsoQqSKBbA7EtrA7qyQSdTb/NU20Zbiri9UNidNp4FVRk5s+ZpjEzE94t
         F7KVtq2hFqOkQ83erpd+dDCdyaD4IjbAYzG56Y7M326QYnliIKGChzyrvE0MAcZRt9S/
         iADtmi7lUnkAqqZtofSEj3gZ951EGuqERgcinTjmITk1ZXcjexTz+2Y5pLB0bDGs9c+x
         En2ePChiZyBjHk+YK1yKIBX5dPGlG47tFHpGtmkHABdDCQswJEx2pSdhi4WZvGfkxXYJ
         lP2GYoqhQrpe2vpyTtQLPrPmnSK3AVjwCQ1Tw8j5ic3WZQggIZ3fHG1Bgod/01mij0xL
         g3hA==
X-Gm-Message-State: ACrzQf2149EQDP5HvpgTnFw58SlnXhnN5g0lIsMMo1dy2ykEycyQq7ve
        8I3JfaedtBDVYJYmWf4asR55+A==
X-Google-Smtp-Source: AMsMyM7FxmTBGF6Hq4ZaXX6J3lmI2zg0ERfugJbCv+MevDOPWZm8skxgVF0nRpJGNjIAurOFRQ341g==
X-Received: by 2002:a17:907:6094:b0:781:229a:2e8b with SMTP id ht20-20020a170907609400b00781229a2e8bmr9534031ejc.99.1663683122148;
        Tue, 20 Sep 2022 07:12:02 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id v13-20020a50c40d000000b0044e8ecb9d25sm86535edf.52.2022.09.20.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:12:01 -0700 (PDT)
Subject: [PATCH v1 0/2] [RESEND] media: uvc: Get menu names from framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIACnKKWMC/w3LwQ5AMAwA0F+RnjWZCsLfdFuxhEpWcxH/bsd3eC+Y5CQGS/NClidZurSiaxsIO+
 smmGI1kCNyMzm0mzVyjniKFjEc4+T6MEwr9R3U5dkEfWYNe31ajuP7ftFlKjlmAAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:53 +0200
Message-Id: <20220920-standard-menues-v1-0-839799192e9d@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=OXlIMvKL4DswKwPnV9StHKUAS7ffcCQTLjMucYgpdlk=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcor2o/REoB7hEPF4Bp9h2bCqK3vD4FsXC6abTqO
 tyNW9qCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynKKwAKCRDRN9E+zzrEiCCmD/
 94vExIikKph5Vd9SQITboEMtmMZ2kzvpyOF+AXflB433tsq5fiqiOGWmeLe/Si4+w1r7HADEDWSofe
 0ZEq7rNCAqeQ7UxhGvLPePKJskIbXJHC/kdIgTlHFqz5aFGt4yr6Nqay8x76m1Nvv6yYzGyGnquFGF
 g5pffdNXHImZ0KKDSyOQRBtwvyiYujJrbAhpuFaoiRyhd7IREN89ROZDnF7BC6DAfMr6FDCp4tqKrC
 8IQRy/NS9YCgr1gI+JpZspranNkHdFySSdMGk+LCJpXmag17qvkwNU65XTH7NOImjp5tig2cVGnxtn
 9IBpcWkqMqFBZ12TfZA+IXiQWZs+936ltddgDnuvxWAlUG1bp3XEawdizuVKdoFqyIw87V9Phv6z3o
 p6DhQEld0mSl1dybq2lmhFHBK/H/4HvJLzkFd2yFYDVNKTJn8TrIDabgAk/EZcymZiHsqH5m93q6VL
 kF1SrLXfSVHx0C0jcR69FkWcajKsmYh4FwjGLBRCMHfV2E44MOi9uhwHDYX9j3/bysSt/Qp6BJdDlX
 2Hl44BXCNlUff7KVMwWcEESv5IQbklXmG6wNPYX8INVSZDDr4CvISA16NGgZZHsQGlpje9f6Xi1nqC
 lR2YC/chLRWtboU/miOHvPQkXxKaVNHaLwZV4WH3hwKNqZbghqgiqMH3C0/w==
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

Do not have a local copy of the item names. Instead use the ones from the
v4l2 framework.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (2):
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Use standard names for menus

 drivers/media/usb/uvc/uvc_ctrl.c   | 136 +++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvc_driver.c |   3 +-
 drivers/media/usb/uvc/uvc_v4l2.c   |  81 ++++++++++++++++------
 drivers/media/usb/uvc/uvcvideo.h   |   5 +-
 include/uapi/linux/uvcvideo.h      |   3 +-
 5 files changed, 162 insertions(+), 66 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-standard-menues-6d703c57f231

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
