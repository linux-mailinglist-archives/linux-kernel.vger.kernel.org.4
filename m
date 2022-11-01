Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74CD6145C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKAIe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKAIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:34:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5111A1E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:34:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d26so35247534eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=IrnxhycyH4ZLQVbvKxGksFSJ83XprCvJaMVzjl9CDyM=;
        b=gwpKHV9VnpITXBtR887Q+/HcekEwCx46vkcYe7LNUVpRQcCDZ4CpdYUt3HRc52WbOr
         +6jN/MT5Nr2D9IJsdMICTBf3KjN2UV0E6OjZEX39G9+6UzpAa8u3rNxTyTfPBzmDcmvk
         oCcqGS6dfI/JM1lj6/JuYUsTnDJ82elU4c9/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrnxhycyH4ZLQVbvKxGksFSJ83XprCvJaMVzjl9CDyM=;
        b=zLdZarFbN4HRzVenpVygjFKGPvtDpRFCnNRsmMCq7Tqge6Cifh7j7/+IkFY3y/72hS
         swjf/7A4j6XtUkmZ3R3n+CjOk4V/W3+jQhS3jw2MeVNq778ClUYlrZuW7hZA/Bv7DDme
         qc8jTyJpRQo458zawsHhC403/mw8lkUlZWm8IwGYTKRtCHdHZjni9smezVrqeqAo+/B+
         gewoqUor6/mf0S0LaYQFIU8n9Ka/gQ3yISRRgbms1Ehn6hnp1ZkMB8dQlDQriZX57gm4
         k5VdpWD1uMci5M8m6geZsPBYvVcx2FL6YmlWWuAEdzDUgKJUa6Z01dmsGzL8J9uDqSDL
         Eo/Q==
X-Gm-Message-State: ACrzQf3PLCsIfTIloNE0Qq1t7iMJfTz53XJNyt6oY/Jj1jEOCvbcIw8/
        1hXL0hLPay1DWLMf1z1TNRB01kxYMmaPrATS
X-Google-Smtp-Source: AMsMyM71r23gFNOKw3UTVxGfL9Xr6F33RCyyjyksKQzdJ3pXvc7ALI50nSkAAiP7Z67ZojrF1dOZyg==
X-Received: by 2002:a17:906:fd82:b0:770:7e61:3707 with SMTP id xa2-20020a170906fd8200b007707e613707mr16899114ejb.143.1667291690845;
        Tue, 01 Nov 2022 01:34:50 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:7782:437f:aea6:1ec7])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007030c97ae62sm3904075ejh.191.2022.11.01.01.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:34:50 -0700 (PDT)
Subject: [PATCH v1 0/1] media: uvcvideo: Disable autosuspend for Insta360
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABraYGMC/w3KMQqAMAwAwK9IZgOmFKr+Jq1BAyVCoy7i3+14cC+4NBWHdXihyaOup3XQOEA52H
 ZB3bohTCEQTYRqfnHFhVPKTKXEOEPPmV0wN7Zy9G53rd/3A5vhUbRdAAAA
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 01 Nov 2022 09:34:34 +0100
Message-Id: <20221101-instal-v1-0-321f3d96ad92@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CXl9Hu/uecq6/DdQYEr3K4jx8KyroE3PMMxTWKI1Qpo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjYNod23hIBblqI+A1iTmGFdD0+QUfolMB9cbtagDd
 evqhI+6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2DaHQAKCRDRN9E+zzrEiA/aD/
 0ZGxRPwokG8paJZzJQezjDEGVZ84ZzuWpKJ3z+w+obwMpjWgqI+vsHQ0cjNUuMMCKXmu3Pt3D/Z4bb
 LB886zsrj4Moe/YnKSSQcCrp3BLQ0Xw3HtESH6K42Li5QMLiPbnbx0xTCOSXdVSRdRc0470sHi4/XZ
 8G5vpiKnTsrIu6DglYIOvnDbSEGjOuCh26RJ85OS4Hl+pDAMZlTXJsOSooKxQK+rfz2fVbsphzVkxN
 ukN5/HXDX7ePgPNBsXbepRH9cc7hnvv4iMkde9XhPOW72L1C+Nji4/fVANOKt00mybCo2ZR/sGyTs0
 aYOvbemxkuk0SS1mQ7tWTReFXKvfNyVapnfG0ojVt62X+XFxGAgqn5aGxkJDEJh+DRS/d2T+wrBY5B
 64uo6DvkOcBaxu/UdgCaA+dtxH2NvXjyhCyxJXKBIl9+mJMr/WEh6d6RHzTwL7ox3txLsDgkhfuIOD
 xHXYNN/JSc1FVSpVpOLqT2aihAr2EE+OzbTAzcJPjv3TtCalGflTL5MH4Gf8ApKQYVBQdMP6H5Mgtz
 oYIq9W48WJM5Cmu5MiMA35SIfO+wf+5k8gMzy2AxkAIG1tZfaX+as16DaPg1TTNsUZrkx2NfH3n0Br
 31ArJxfqD6N0Bdv2AJ6bKnqbXGJ7EYFwK7nVwYMvhaEW/lFM2XzskIVMl8cQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not handle properly the USB suspend and makes it barely usable.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      media: uvcvideo: Disable autosuspend for Insta360 Link

 drivers/media/usb/uvc/uvc_driver.c | 13 ++++++++++++-
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
change-id: 20221101-instal-9a77ba1cc448

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
