Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533155FF93E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJOI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:56:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B054CBC;
        Sat, 15 Oct 2022 01:56:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so10843489wrb.13;
        Sat, 15 Oct 2022 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0X+gCfLWk5TUIBEE4uVNIMOzTDG0E4qM1D5Qax11i2I=;
        b=pHpO7107OpquGnHJhSqOhbtPmX/HecNgQu22Nquh/DVdy3rGLndI7dIlVVUPIG8rmA
         zdevwbfTe4MW/OBTppIIzmYo12hvvmNEBuFsAndnPiaxSifKQM8iXDZeLm1wLJVHxyrh
         RmRsi2uRSJuFBWS0+KqnGvDdvP/tRU8sobo3QieMCZI9fnGYzruaILVk88E+CUwscDsC
         F4yuiWpg+5YnceLK7DZIBBhaszWVO1sykiSRNsXbJdHhW6xSNueWUJauJEYqnc5JDtqy
         tG/h1MTvlcw4tyoBdTmOAqnhiglUpGheU4BsEZrQy7jF+FZBSKLBGmOU61KQyj3H1iY8
         9J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0X+gCfLWk5TUIBEE4uVNIMOzTDG0E4qM1D5Qax11i2I=;
        b=ONdHulNuzauCd1rnPkCqe82FxXNcixzgikBv27Er+NPqnY02hjz3g7nEvUkCe8d0yD
         FOP+UT5+L96RlVQiba/PILTka4+A2CibmVR/w78DI1Dnd/fz6GoqiekzHd5rwzlhBX0F
         utCB76AGhDEvMS6o4S7dudKiPwzNPGyDfQh+mbwh1I4u3wcuBl6feqCmqX40fi0KHl5m
         n/s6obtLb6HnzivXxST7cWAfhcraIoVP5ijGb/mnTCTfTmVKkkyipR9xuoe+pTBKsLfE
         BhNGpidq2SsHur5RV+/Zg5CDuOoIxh/UPkJWwkmzC0yFeZDjtDn+0mZ8FSvHZDy+bC7s
         Ca7Q==
X-Gm-Message-State: ACrzQf0m7Uu8LIT0rV9WE/1Ajcd9WKgbZ+ACn4KlRR8Vg4FQyRcHvhrB
        OQWO0ey2n4AGCfGTO9sjyLs=
X-Google-Smtp-Source: AMsMyM6o2+150KN7ski7UAyqMdVqeFDCetxFBkOcmP65fzpy/I/gMe7dO3+Dny3SzZzEiz0NnF2mFw==
X-Received: by 2002:a05:6000:a1b:b0:22e:49e0:7ce3 with SMTP id co27-20020a0560000a1b00b0022e49e07ce3mr966759wrb.66.1665824214513;
        Sat, 15 Oct 2022 01:56:54 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b003b4ac05a8a4sm12432978wmq.27.2022.10.15.01.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 01:56:53 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     ezequiel@vanguardiasur.com.ar, benjamin.gaignard@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: Fix P010 tiled format description
Date:   Sat, 15 Oct 2022 10:56:51 +0200
Message-Id: <20221015085651.2471818-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only 31 bytes of space (without null character) for format
description. P010 tiled format description overflows that for 1
character and warning is generated when used. Fix that by changing Cb to
U and Cr to V, which is also consistent with some other descriptions.

Fixes: 3c8e19d3d3f9 ("media: Add P010 tiled format")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e6fd355a2e92..5e5616d5915a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1357,7 +1357,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
-	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/CbCr 4:2:0 (4x4 Linear)"; break;
+	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M:	descr = "Y/CbCr 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV21M:	descr = "Y/CrCb 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV16M:	descr = "Y/CbCr 4:2:2 (N-C)"; break;
-- 
2.38.0

