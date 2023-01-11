Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E965665688
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjAKIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjAKIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:52:43 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641A101D2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id bj3so11973287pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=wqCK+F3NQ/WGaXLcIcOMDouMxXDEFoEvg+1KtOppxeY=;
        b=DTcmeYWP40XvxuO4qpiqRHULNmiwo8+64irQJ7KINs7kMqbXY7UXrX2RP+lHjFwfuY
         IrrfYTghgFE/AvAVNXFpoBYXjbN52LGaYNTGAqg57PmydTAcbhGbRH/zsJnQJm+hMUcm
         Cz4ukJygPdmAJKtFSQri5BZi7CViCGCx0nwqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqCK+F3NQ/WGaXLcIcOMDouMxXDEFoEvg+1KtOppxeY=;
        b=zBpfXGObSGXNzWcReVQYqsNSqRhE8uxERAQfkLP5te7fGL45MyytqAAHd6+Fi/gO55
         ehbsGcPH/CTHGQZgXwAhERdfh55k8/0nriib7Jio6yXgy7KzoDnxZpWZivsoiHwlJALG
         p3aspo6F8RpCzFLdH4KQrknhnpCJCbBphaLgMbn8tac3AuHQnAlVsJuszqExRJwM+cWR
         TWe5yztxg14Aa6NMFna748dgBDRikoJs4c9pczPZy37NaJcK22mNvtbpfk9rW8Rx1FED
         TwYKpEQ/QrB5I8qnpo4mm+yCQBSbi36OjboZqLb7DJa4gC68ffKVqtCLOUI7gT9fOXpL
         hJcQ==
X-Gm-Message-State: AFqh2krtKE6V7yvbm76jJcgB3CUBgWz31MwjCJxQicmW2iVGHAKSqwBN
        V49aeJQyVrmzZIkVqsGWcFAwLQ==
X-Google-Smtp-Source: AMrXdXum8ArM4pB9qETHPJODnPDp/suBqyLyoixncGVjhBx1UAuymc1r+iaUvuZWqudNJObqgHXXLA==
X-Received: by 2002:a05:6a20:1384:b0:af:864d:e7bc with SMTP id w4-20020a056a20138400b000af864de7bcmr103740756pzh.25.1673427162145;
        Wed, 11 Jan 2023 00:52:42 -0800 (PST)
Received: from yunkec1.tok.corp.google.com ([2401:fa00:8f:203:c84:581:fd3a:b32b])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm9566612plb.22.2023.01.11.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:52:41 -0800 (PST)
Subject: [PATCH RFC 0/3] meida: uvcvideo: reimplement privacy gpio as a separate subdevice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANV4vmMC/w3LQQqAMAwEwK9IzhaMgoqfkbQuGpAqDS2I+Hd7nMO8ZEgKo6V5KaGo6RUruG0oHB
 J3ON2qqe/6oWNml0tY76RFwrNa9huKY0zC44R5hKcavRicTxLDUWvM5/l9PzD2TzRpAAAA
From:   Yunke Cao <yunkec@chromium.org>
Date:   Wed, 11 Jan 2023 17:52:37 +0900
Message-Id: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Yunke Cao <yunkec@chromium.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-4d321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

privacy_gpio in uvc were added as V4L2_CID_PRIVACY in uvc video node in
https://lore.kernel.org/all/20201223133528.55014-1-ribalda@chromium.org/

Userspace applications often require to constantly poll privacy control.
Currently, polling privacy control requires keeping the video node open,
which prevents the camera from autosuspending.

This patchset adds a separate v4l2 subdevice. Userspace access the gpio
via V4L2_CID_PRIVACY in the new subdevice. Applications can poll the
privacy control status without opening the video node and activate the
camera.

The non-gpio V4L2_CID_PRIVACY in uvc is not affected.

Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Yunke Cao <yunkec@chromium.org>
---
Yunke Cao (3):
      media: v4l2-ctrls: Expose v4l2_ctrl_fill_event()
      media: uvcvideo: remove entity privacy control in the uvc video node
      media: uvcvideo: reimplement privacy GPIO as a separate subdevice

 drivers/media/usb/uvc/uvc_ctrl.c          | 17 -------
 drivers/media/usb/uvc/uvc_driver.c        | 44 ++----------------
 drivers/media/usb/uvc/uvc_entity.c        | 76 +++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h          | 19 +++++---
 drivers/media/v4l2-core/v4l2-ctrls-core.c |  9 ++--
 include/media/v4l2-ctrls.h                | 12 +++++
 6 files changed, 111 insertions(+), 66 deletions(-)
---
base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
change-id: 20230111-uvc_privacy_subdev-1e7a167e86eb

Best regards,
-- 
Yunke Cao <yunkec@chromium.org>
