Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40160E03C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiJZMGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiJZMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:06:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF48C444
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy4so20600687ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=K+wpoucsam8HgjE7xBOxIEpNYkP1ktkxz61ClGB46cA=;
        b=dC2Bv6FiSin0CSgAmVosmCJ+eai2jsU4rN1dPyG7x5VF6lNE3GAE8mMf2hHW7V1VF8
         oIh0skyKGZlWNsx8abHrGIvDtz6t9DzJ3ON6l1/f3pCD5lbZRKelJ7xW00c+H/KcgGY5
         quZAWM8CYxggSYKIimYsWgdcqdSVrayXGx99A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+wpoucsam8HgjE7xBOxIEpNYkP1ktkxz61ClGB46cA=;
        b=ZrCtrsZZXG/vM1yazoc/fJFxl4n3jVtkmrfsD77x0RagN+g13A2P7qlid7xp7IYNjn
         fkd+qHCsuZ5HDkbANQ9QlbFPzqrdvzyKZj5cT51BNBcMEp3X9GFvc+YivMh+/Kmjhcv+
         2LjUbdsHro7Ql/aDxoYjinhv+6GABwrEQXyTbRL43h34TrhaFL5QrH8+qAsOQiPxDdPf
         JVOI06GFRpnxqcePZyOBQMBNbzuOBpWtnnrsx7R5n9kTiNGd8R0KreSJmAt1n9n6AyoQ
         VObCiMMJ47VFRvYGLygEWgWlHJMtRVu45ALT74zeAfDbbNV9b/Iu3omiatZCeV7CqgPC
         dAlg==
X-Gm-Message-State: ACrzQf25H3RA+Jyy1DxuUeGwvBAyK5n1xNJPPSSWSK0920cRWnnq9T4/
        WDVEIIwIgYrqXAzdVjJ4VgAduw==
X-Google-Smtp-Source: AMsMyM4SbImw6oySJMAAfoVMocz3nXstLQnkTAt7GJU/SUOzO6yR6goVVHT63Aka80haSRWvTP3mfw==
X-Received: by 2002:a17:906:8a79:b0:78d:9c52:2196 with SMTP id hy25-20020a1709068a7900b0078d9c522196mr37655250ejc.328.1666785992938;
        Wed, 26 Oct 2022 05:06:32 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b47a:bedd:2941:1e3f])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b0079e11b8e891sm2892546ejr.125.2022.10.26.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:06:32 -0700 (PDT)
Subject: [PATCH v3 0/7] [RESEND] media: uvcvideo: Implement granular power management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAK0iWWMC/4XNywrCMBAF0F+RrI10JvTlyv8QF3kMTaBNZGIjUvrvBpcudDXcC/fMJjJxoCzOh0
 0wlZBDijWo40FYr+NEMriaBTaIzYiNZMoUnbynJ3HWhWQ7DtDDSA67XtSZ0ZmkYR2tr8O4znMtfciP
 xK/PmwL1XH+IBWQjAZXWaLQaVHexntMS1uWUeBK36hX8Z2A1WlCtA2PAquHL2Pf9DW1Ro1b8AAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 26 Oct 2022 14:06:05 +0200
Message-Id: <20220920-resend-powersave-v3-0-c47856d8757e@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=uU/LmE44MSUPsey8KnAa5kWGvA94mQwkg8xaCFAERoA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjWSK1SyHP0O/9Kxa3PCVstmSDBxTK241wwbsqASRI
 th7m0cCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1kitQAKCRDRN9E+zzrEiJS4D/
 4i+YRp0fM4oXkgRQBjq9z29Zew4gpRz0795b0yAKFpAHKvx28MrKLK4CmjNpDnq1FOoK5FvN69jwCz
 RecszvK6yFN7ttZV9xr8WWwJU9e4yBYMM4//FOL9tPNOJoKfdLK8X3WAxUmex58lwNZwnEbPxgGiRv
 OsLG8hKeoCLvqT6nAvHI85VwZFW5skhx+ka7vXncjnQ+yIR7/WeSXjRnJQxP0fHm3sqP7Gk1Ix8ENE
 DEkD8tNUceV8KJS+kvDEkl3ZvBa0gtC/UU9Gn0zvexhChMo7sO9mibD4k6657/t6b2TKWJvY78Uomk
 AAmAjnyiMdpPkpKQDWH07lpyYI/MwEqnE8oUaQlM0DNqeUpa7OMd3w2Xz+4B/smNZEK0Z8yVI4Fbhw
 kodZ1BETIVK29tAIksWFlpUMkSnjG2kVTH77Ak1L69S+t1gnptTqjf7GOZ+vExCfA3Df/+YXa/SMhU
 p/8XH//UVXn9ZIQkTbJDjp8vRogi8f6IfqmVq69Xi6ytOMqKDam2jdDMj7tL42rKamNAl3NbajDjYO
 AI6b+jykS7Cjtf5m/QmZ+KVa75+fdS1jXAm3z2i5oPQrcmoUKBzDjnAJtPrwwmgfVnvcxWLNVI0ek+
 7YI5AAhoNK/d3igObYCXg7bL/qnRX/jSJxdaGBSvskADFcdF45nttqkLhKLQ==
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
Cc: Max Staudt <mstaudt@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
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
Guenter Roeck (4):
      media: uvcvideo: Cancel async worker earlier
      media: uvcvideo: Release stream queue when unregistering video device
      media: uvcvideo: Lock video streams and queues while unregistering
      media: uvcvideo: Protect uvc queue file operations against disconnect

Ricardo Ribalda (3):
      media: uvcvideo: Refactor streamon/streamoff
      media: uvcvideo: Do power management granularly
      media: uvcvideo: Only call status ep if hw supports it

 drivers/media/usb/uvc/uvc_ctrl.c   |  11 +-
 drivers/media/usb/uvc/uvc_driver.c |  35 +++++--
 drivers/media/usb/uvc/uvc_queue.c  |  32 +++++-
 drivers/media/usb/uvc/uvc_status.c |  11 +-
 drivers/media/usb/uvc/uvc_v4l2.c   | 206 ++++++++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |   2 +
 6 files changed, 248 insertions(+), 49 deletions(-)
---
base-commit: 58540610e464d8b2ba46a11b81c3e6fcc4118fae
change-id: 20220920-resend-powersave-5981719ed267

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
