Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9365EAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjAEMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAEMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0D44C49
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m18so89516993eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=jDIN/LN5iKZAfDzOK2/vDqrbiANS5NlsPHtGPN+HXKk=;
        b=Sd4K2nYoFsN29HDUl1A17uVD8EkvvbwIshsCV+Jx8XxDYLcfoQ62nDDL7DiR8yN3QD
         WthoahQSp7kQE5gFtNk/uWWgwpX3R2K9+AN/PWaDNHcWqrafzcWj903rbvgFCSMfv59l
         OAn+HONqjzRGVxknanmQS8TnIluG2Ql+e313E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDIN/LN5iKZAfDzOK2/vDqrbiANS5NlsPHtGPN+HXKk=;
        b=5pm5Xbu3AT7/IowynAcj+QB5MoqzBlYjgrFbC9lkDQbqNJ+FkGNFuzl3pNkbB8leqj
         5eGT3Wh7GxAFA0Yqt3u24e2NK4uKyyMMfliZWMnA9NDhK30SAmS9VRGWd2LyIDM5TEKI
         1oCa4Y9TBc7zqrMF65YVjhaWxzfp679YERxjiJx6JyOH5dkN0C+UUQyl6VQtJzZmVwWa
         wTBrZGFdxr0I/WcmwfrN4a2rGmdTS3/Bd1Hm5i+r51T2qs0lYt1RnJsS54bqM3WEY0K5
         hP4e8lH5jyLQki9y62N37WbN7u23QZJu3jLmC6D4YEYZ/LX/cfYPKxYEjYPvaP+7LrIn
         klWA==
X-Gm-Message-State: AFqh2kqEd5BOY6r4JR+LS9S4gLU+7qr9RiuCVjsCK/VD9OHI6wcbsTQZ
        mrCEliT62MxQHLmBuwMMxDa/Kg==
X-Google-Smtp-Source: AMrXdXtEOc60m3ZB45z9eYfWFMlKHS8fsbheC2tAge3kVUJl3P9BjhAm8N7z+djXNgERDon5z/xSZQ==
X-Received: by 2002:a17:907:d68e:b0:7bd:43e9:d3ab with SMTP id wf14-20020a170907d68e00b007bd43e9d3abmr45885365ejc.52.1672922007104;
        Thu, 05 Jan 2023 04:33:27 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:26 -0800 (PST)
Subject: [PATCH 0/6] media: uvcvideo: Hot fixes for top of next/uvc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvDtmMC/w3LQQqAIBBA0avErBtQS6RuY+OQA2LgkBvp7rl88P
 8A5SascC4DGndReeqEXRegHOvNKGkanHGbscbj2wlvIo/BhWB3ux1H8jDzKyrj1WKlPIf6lvJ9P9
 fvdwdfAAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:11 +0100
Message-Id: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=/ctyG02EXwNDXaa0+umj5JIX2lRhtMJ5zLi7/RDjJl8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsN7vXpjh6qG4PPyaoraAmV0OwcpiAlO3tHknLSa
 JzXkF6eJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDewAKCRDRN9E+zzrEiGtoD/
 oDAmWbTIKc5CrxwnAhilQCi19r3q9pm9ihlDVWAHAAjJfe8plIpqEYZ2GTVF6/ug42exFqsyGrmelK
 EBjAvsVA8o7Gcvkjj0dMY4VctCOT+u30kqnY56EHFTc6c8sAobPYa4l9Yw20R2lNT20CdTSWJ5DSQo
 HWvxUlECgUBEI4SOWU9FVE6BglftPbQBF9Qashmm3lZ2jsPyT7Gu+R/xFGhso2H0m6z0XjRc2FUGyE
 dqm9S80N8iD96HWrHF/dfp/5QDUjlrElS5D1nxmL+Zd1gxXSVhZAUeNH2HqQTtMNWGJXYR7irv7KYl
 lz1uS6ZQZ3QPKj2IklDm/3KM9teZk5BGRa9mC+Dqq7STXiXz5kH1Ohtu/H0tWWTYt0JaawvTm+AdxS
 fEqplzymYYrB+NFbEjiUYwGV5nr4vHJCQ7c8K6sL50EH95iXoZ0R9IN3HUweb8X7hI++vUaJNWjUf4
 1CI13erX6sLBfbdjc1Z1yy6ZwBA5LAgAXoOlAC6TGPQz9Nj8/wljbK2Hn5Co/k/ntHmm4An6bdZvB+
 3K3Xieb/AD+W6ErASVP99T+APRJftPFsMp8mD1m6BHxHFVumO3XqUdgw5u/azxvXkuH/SSKZWegMx5
 kH08rd1Zc8d4z6LQWSbLUzuTRQMaPRH9QpyG+HK5oxSHWp4WPQplz3xOJKsA==
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

Hi Laurent

Here are some fixes for your next branch. We have not sent yet the
patches to Mauro so I guess it is better to drop the broken patches
and their reverts from this set.

If it is too late the revert patches have the proper Fixes: tag

Thanks!

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (6):
      Revert "media: uvcvideo: Fix power line control for Lenovo Integrated Camera"
      Revert "media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU"
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Refactor uvc_ctrl_mappings_uvcXX
      media: uvcvideo: Refactor power_line_frequency_controls_limited
      media: uvcvideo: Fix power line control for Lenovo Integrated Camera

 drivers/media/usb/uvc/uvc_ctrl.c   | 75 ++++++++++++++++++++++----------------
 drivers/media/usb/uvc/uvc_driver.c | 25 ++-----------
 drivers/media/usb/uvc/uvc_v4l2.c   |  2 +-
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 4 files changed, 49 insertions(+), 54 deletions(-)
---
base-commit: fb1316b0ff3fc3cd98637040ee17ab7be753aac7
change-id: 20230105-uvc-gcc5-7277141399d5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
