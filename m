Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3D5BE840
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiITOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiITOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:11:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9A5C9E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:10:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so6497365ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=QRaocU8eSFGco1nPW/fXtB0qB+ouE09WBE3eywp5Hko=;
        b=Rib76J+E/mKw4BOLCEBUHiPlkD6+CzCu7GBQ/p8esMKLB3iQMYQu+26YGq5vrL/MGM
         LuZ2cqWGglcsI84d0SQOykSd0SSs9m8XBP5KBJfei/GOOTRMPvVqCcBbQZKx11GG6HLD
         XJ+KnRjFx9mpaci8Iv8WE0xDwireGCqLbuoAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=QRaocU8eSFGco1nPW/fXtB0qB+ouE09WBE3eywp5Hko=;
        b=StFYYVNLbziwe3dhYNEPh29GS9FY9iXD2Mymlh0oLU/5ep1eHKu5TsgOWuacoCgilg
         MUc0XYrEgpUZhwxJM1swDS3JnYnI6w8nga5phw1E5+9Fs8CAJGe280CA09gGPUVGs8pf
         PNjg8uSK2A9yqMk6ZsqFAovWSCkukNN9zKc+Es/Dalj9b5gCsLz33B1ieavooOFjsh8t
         EcSoi07KxxTFAMzbXDqI75MPFGXCaqmtvNYu1XWk9g2hCg73iTfJEe+39SE75Xo6RPki
         1Q6jIW2Sbfz1QuxlPX9RE1ixYKoc5nZnNaJjKS6wKaBGRakwa0ECR1pO+5trGUkt3MMY
         iBmQ==
X-Gm-Message-State: ACrzQf0bGLuQOn4h7kbMgQyzm0cibjgF2g/bPTe4Gu9mQc3TwiqQl7l3
        XC/gpWw8gy3dbnLL8eXd+hhxpHn2MGP+b+kjfYA=
X-Google-Smtp-Source: AMsMyM4Y6GTilNeOo89rSnxQML5BPxfhWzxENWUsqLAwXZijB+YlBE4/XuBSBnTgqt+lWAiC9e8dzA==
X-Received: by 2002:a17:907:6e1e:b0:781:d329:6061 with SMTP id sd30-20020a1709076e1e00b00781d3296061mr1781589ejc.424.1663683002453;
        Tue, 20 Sep 2022 07:10:02 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b0044e796598bdsm115488edv.11.2022.09.20.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:10:02 -0700 (PDT)
Subject: [PATCH v1 0/3] [RESEND] media: uvcvideo: Implement granular power management
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAK3JKWMC/w3LQQqEMAwF0KtI1gbawKid21T70YJESRhdiHefLt/iPeSwCqdv95Dhql4PbYh9R8
 uWdQXX0kwSREKSwAaHFj6PG+b5An/SFMeYUGQYqbU5O3i2rMvWov72/X3/yEGghGcAAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:49 +0200
Message-Id: <20220920-resend-powersave-v1-0-123aa2ba3836@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=bpKuoNr/usmL64u3YMWUH61CEr5VHlHTtHVvjlGIabw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcmxc3Ni9BedQQEySMuNPCG/Jv+8lr+YXMc5q6bX
 3e2HqH6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJsQAKCRDRN9E+zzrEiJUyD/
 wNwCVcSWx0QQVNSnUzJ/9MH+afJREZYThMxHqkX4WHkv0zN+wyIRlU1FAiFYpJF4ZAl4eERdhQB8At
 s2tLSF+DfSYviQPr8GJvwdECoL2fS15xSYqjrdsTZA7axDWKoGE2rzQjT1FPPo4pJT4XgoD7DBqfx6
 uN0e1N+vNiEPbEooUfLspTPOQQQ2HSAwJfXlp8m0exEuGPjnhZWBby9fjKJHcjt4E2wajk+LwVpgcx
 kn/ia+0etk1tJbai/Z0za1vMjRvRgzioFbUGa2UZirL2lu0WQKkQbAjpraI1o4LCSZ0khXaiFgpKld
 tQGq0Av1qEk0JsKah6Y7fjyjcyxImEmtVpA8Uk1IKn5qvuFidL2n8VjPWHZ9gP8tfDKmjR9MwuDXTK
 DZianTLIqe1webHdcaJr6qQ/+vF8QZgaaegVUeOTzoa7iWdOhQQFXQPoLh9c2brufLIDCda+w29+o4
 Mi9vhKJnLL2nvfY5zhI/Wu/ChPc7FhgKPzgTfUrxQTOA3AeKybxEkZAdZsMt8OqMMHBdIPGooilmvk
 1Mau7+hbJAiwE59xhNIGmCwIQFV8hPdm9KSa33OH51Eqx/XBxunNW/L3973vcqK3UG51tztNRNUr0F
 IP91yjV4Kwy8nLEslnm1FzcsR0TBgUwKgYAu0GqlxqNM0emsUE2IWP85wd6Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (3):
      media: uvcvideo: Only create input devs if hw supports it
      media: uvcvideo: Refactor streamon/streamoff
      media: uvcvideo: Do power management granularly

 drivers/media/usb/uvc/uvc_status.c |  23 +++++
 drivers/media/usb/uvc/uvc_v4l2.c   | 193 ++++++++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvcvideo.h   |   1 +
 3 files changed, 182 insertions(+), 35 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-powersave-5981719ed267

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
