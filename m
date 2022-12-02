Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41068640B03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiLBQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiLBQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:45:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07DC7267
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:45:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id td2so12847813ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=RPphcWVh7UNeplFOvV4VO8hoaj8/g9ioN7P0vM2qKR8=;
        b=GwhM8ATAw4Jmj1P9+N/o+/cGEiQjTgigEbVEJXkTKRCD5BMaPlr6BtJRVGnOomKIOU
         GdDCiGSep0+x4fP26x8w+MQn5U2jweW4QyvitZOs2Mt5xRmqd1upOeSaO3PRxIdtupCT
         3ZEdW3Mbu13tBFX1TCCCTCYFUGolasZsU3kfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPphcWVh7UNeplFOvV4VO8hoaj8/g9ioN7P0vM2qKR8=;
        b=F2dUD9xfZwX/FQDJo4OmIU99fP5Re0OUl3lazkN4zzZrwKuqRHlCOJPosvm82jCOhU
         MbvTjHkUlfL2rNd8E1TMTXTBlj75EkQWsJZm1i7zhFMm4dy3StF3xWJOhfV7NGVj+hft
         nOypkUvlyXsLb1n0Q4B/wWC3dW2cUp8tHi4hoERm2KORJlNeeEOdHxSJ/EEbBVDMuRF+
         wbQaepWgkJ9EC37Fl7DzBY9nPEMuSrsYF6w98hJMRtExDwdXzuI9bK7WaxkEKGOxZRv/
         FZLuffwRsuhswfqh3szb949WkJmSVIZ5PKehfrzPmRTEW8f+IrNQyUiFt4WEc+ywycNZ
         PdLw==
X-Gm-Message-State: ANoB5pmS+fMOrAwQ1kj4XHKznKpOJ1NWZBZ0zF8KDDguEtqy1VuFJ69J
        jDPjpi25sH5q6um1lqk+NVuvMA==
X-Google-Smtp-Source: AA0mqf4csQFXIuJCIlYytzopKiljfyVL0pBNR97D42g+eNqHjNaN2I9zVzykF1UI9lu0Aacby27xIw==
X-Received: by 2002:a17:906:19d0:b0:7c0:a7e3:cf10 with SMTP id h16-20020a17090619d000b007c0a7e3cf10mr9463877ejd.587.1669999515446;
        Fri, 02 Dec 2022 08:45:15 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t15-20020aa7d4cf000000b0046c53c3b2dfsm111981edr.38.2022.12.02.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:45:15 -0800 (PST)
Subject: [PATCH RESEND v2 0/2] media: uvcvideo: Limit Power Line Control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 17:45:05 +0100
Message-Id: <20221101-easycam-v2-0-ffe3e3a152df@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=cEazZ8iF+PvRrDR+R/rL9s3vH7vWgL/cmAKb9jbP6wM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjiiuT1JRumGtTKlUkCWhTzNrwm0UdY4qDb1qazwBN
 sxD7IVeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4orkwAKCRDRN9E+zzrEiKVtD/
 447b6H616ZbTTvmXJoqQ23LHiI/DKXC3L40peMQSKSS5wnrldWLBz5OdeSSbxi9WATKHbReuK12Lsq
 jrwVcFhtOfgIqqGqmk7gT4PCcJSZN7GMBGG/Bj1IY6uixDs/8jK7K4kFjVd7tRsjmAnQ9hVzGs8g32
 9pFKdYsE+F/ROuzi5/BL69MYpO8jsYkvwK1QBqoiMCMZUQg1jjOhPvTN3FRmRZE6kl9eqB/QvNE4uk
 qGG7qar8kB7/sT1cQ9IGDtj/6jIEZQoD5fIu+l3sxBSTTkKNA3+/lu5LDisQuNpq5lvMm2XlMxy/Kq
 s5Am3Tb2Neo83sQyzN9UlyRcOnpIMOa5cAe3091/hOiHZUQ6Hr2JtcEAaEhhyVOMiA6+HYVm0v35sF
 RNYRWNa8OqcSSOWqBUJ059H3MOGqf5CF0+K8FqkVpMJMmRhm+wrXwQgPJ9jkDWwz81tIhb5Dq2hEuk
 Vtoguu/NvSAe5/4lUNwz755WMkdocJNDHdLeS/IgyeDEn189IdRcIkrtkIvRN1KHnxiDDJ5cHBv6Ev
 Ud1xjxdGxJ2ciZj2IHTgNWg4CVlNQPCFgo5q2LMHD8wP5Jh521qwVxY8yDWiuLocFNctrb+bnU+J8V
 1UVYaFJEmGMoCmcaxxH51iGyYspDaR8mu2yu8lmWj0IItvJBvuq+CXJ022EQ==
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

Another set of webcams with invalid PLC controls.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- Add Lenovo Integrated Camera
- Link to v1: https://lore.kernel.org/r/20221101-easycam-v1-0-71d6409963da@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Limit power line control for Lenovo Integrated Camera

 drivers/media/usb/uvc/uvc_driver.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
---
base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
change-id: 20221101-easycam-8f1ab598b12f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
