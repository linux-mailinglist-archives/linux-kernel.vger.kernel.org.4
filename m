Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0C60CF56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiJYOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiJYOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:41:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E3CE9A7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:41:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so13033866ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=VlQIi+yWsREsm4PbEFci1yyfl5Bxh5Wh05SXkdf2/oE=;
        b=WSbhXDecQ6UZV0LzcVzWyCNJjJYMwMUbOrb6PGiPBI8fQaFDy6cBXDHBDosTJ4x8AL
         DeoUWQIM39HA9WHLlgM/FrGqDE+gzEQH2wIZ6mfrSEVMBK5V1gS2o/OD/IuW0ADsNa5A
         VSQtWgVl8kYFxAQQxiTHZNtM1Z5+kOFaupjRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlQIi+yWsREsm4PbEFci1yyfl5Bxh5Wh05SXkdf2/oE=;
        b=UuscqAn8X8yqnyPM1GA8NvWWoTbBJlOCP5AS3O9VYMh724oxytfnwOQJJbbKqvM39i
         PsA4IpD0lkBK/yfX7EzujeUAl8uTQlEVoypRBofSwzkghxcjjKlxZYu2QnEfVomGGA3C
         xv2/X0rUpv04GWuQBuu7lq3ePw3tw9IQEYt6zruoY52SW3YS7cQxjZv6NU4Hsf95IsYy
         EhkKfzE97whJUQtL4eP+hvzwqnMTIKOdY3A+PtotCy0vT2j8a/OSqdYyi7lKQ89BhRZu
         SVCgtx36e/HSNExazAEpJi5kGmaq6twWAd+bECqGMerZ6gkBv8yNANa7lxi537/x8WlA
         a58Q==
X-Gm-Message-State: ACrzQf0yeuc6LtfQVKJaS6spcDu8FEvM61Y0oEiGlg3tOMa2N+lAwe85
        3rYbYC7ubvb3ouQ6fbzJAdcC5A==
X-Google-Smtp-Source: AMsMyM7cv3FLT05dgKzO1MeeqspWJLX9roFJARyw91hGmK0lm2d601mBeGtRk+4rHDFVLGMRqLu4Jg==
X-Received: by 2002:a17:907:75d2:b0:7a0:72b8:236a with SMTP id jl18-20020a17090775d200b007a072b8236amr15921485ejc.47.1666708870288;
        Tue, 25 Oct 2022 07:41:10 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id kz12-20020a17090777cc00b00734bfab4d59sm1500813ejc.170.2022.10.25.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:41:09 -0700 (PDT)
Subject: [PATCH v1 0/1] [RESEND] media: uvcvideo: Handle cameras with invalid usb_strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAHz1V2MC/w3LwQqAIAwA0F+JnRuoUEF/o7bZIBa47CL9ex7f4XUwqkIG+9Sh0ismtw74eYJ8Ri
 2EcgxDcCF4FxZsltCeKlowM2/s2a3kGEZI0QhTjZrPUbRd1/f9Ii4c9GEAAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:41:00 +0200
Message-Id: <20221025-usb-string-v1-0-4c351b6907bb@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=721; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=HS9crhUmx//ZE5EikyWreNBNGmdK2E7sBUiEO7VxSXo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/V/HOENVGKtlg6nyBSnKRyFCfSj2UsZP53RtwYV
 W4n+nWCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f1fwAKCRDRN9E+zzrEiKnPD/
 4nR++LM/8UpdNK3LneR8a/C6b+gEs/P2axzOW1QFJtcr12XYJumksRrhEy3NDVq8ycBGbIc1M24KfD
 U/u/HXCDiaMoD+HeVAkzTWNygNoqtswzbkr4WQl0EpKA1kTUGGD+w0QqeD0RY+tDOzkm6wGBr/Nidp
 BcDL7pdIqTZtC3ilGbEBoCrr5nwlp3CBWs2mAgQLB371a3gkqVoQOJlZ62qUU7jZDHChEg7jJNKqZc
 D0XY3tJ9g5nfXUT/qL776o59lsc4N9iLYwnm3x4eaFd4g8c2EcOblqF26sFyRLWKFEUiHZzV+Ak0e/
 6ApsU/INrZPWpzejjkyN5TAARFvoRYbE2jroGlCRkP+r70HhP4M951eg5lVKIA3AvctJZQAK+5bqhk
 VFaxrLavlFrsc/PIOldzVrsWNtUJgP0Hr7eVWcaI1qvT/h9YBCQ8Z0BjzJ1gaV2gGSyhzF6PkQIhab
 YBl77QICbY0BxTnj5ErUzJPIPIS/igL9qfmiC+3i8uOrUUvLv+0a6B7jC5lLJTgRmhSbK7uCbBQgGx
 YBBbHeVbVJ1zUar/zjhbE+hDRev5x3B874XMRYsnsxCKyDVgOn3104h7fKs99GBCQ8I9QkvSRLALq/
 mKz0bs+ZL3i1FB6HK4H8lT25azVkK1z7aKMBI20lZn2LPY97wXbozwANszMQ==
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

Resend a patch from Guenter that felt intro the cracks...

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Guenter Roeck (1):
      media: uvcvideo: Handle errors from calls to usb_string

 drivers/media/usb/uvc/uvc_driver.c | 48 +++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 29 deletions(-)
---
base-commit: 1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2
change-id: 20221025-usb-string-cff7f1f06e0f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
