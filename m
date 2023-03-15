Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE66BB4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjCONaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjCONad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA21A955
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so31780150ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmbQJ7O/6JS/WmDJaNmVYSgRY/QPgP7mF5MHe8za06A=;
        b=VX9FTX1C5SOdJP5ixptJW06u0wqD4ynrX+CaKddF8/mWnQYl9lhvpKvjXAZL2i02jB
         3yoo+Lu3eGxvl2gVOngB0stFX8IVaTCLFlnRnWz5WEmBsT1smTXm7k4u2AXeuuNDs/sn
         08sUuCpwbeV87KdndzWMAXn3OXRfC0IL9KuVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmbQJ7O/6JS/WmDJaNmVYSgRY/QPgP7mF5MHe8za06A=;
        b=KLXxx7KA1369WTKEXtpq/qH1kPxR2kSCzSnjONiITOWHK0bOrnkXrv5dSDgtVPyJ3d
         kvo3zay4mPXJqHngw96hc3Y2iM3BCzoZp+bxFppqlykWCYDpfP8EFl9qeqdVgPAGASdU
         KPoGF7g4CbcLxADyOax5fcjjFCL4Ne88xb9ni1P8SU82LSF2HZPgothacdnd3NzvzW3/
         Rc7eWzM+L5+qyAfWJl+D7sIYSklQZgCIPX0W9XBDm/COf6gx5O4ZUwVAXsD3kVR04pf5
         rqJWJ61vgcYOAjfEEnc6BgCxoLIqe0N18dGGBP9bcemUgBuvdOwNvIag0frhOOnsd8BM
         n7ow==
X-Gm-Message-State: AO0yUKWseJtrCR5U2on6PKOCj46mkRTVzP2+JLGBUAB8PjZhWM+bozSm
        C6RqOMf76G2C6JQE4gmBBqFEKA==
X-Google-Smtp-Source: AK7set+PGfTpCqPv6IwyWXvoSb+55iasIIGLzWC6uYyQe4vFSGX96XlvfP90ostOw6UEUA/rCr7hxw==
X-Received: by 2002:a17:906:f85:b0:909:3c55:a1b3 with SMTP id q5-20020a1709060f8500b009093c55a1b3mr6410804ejj.38.1678887026258;
        Wed, 15 Mar 2023 06:30:26 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:26 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:12 +0100
Subject: [PATCH v9 1/6] media: uvcvideo: Fix negative modulus calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=A9fEA5iTFV9nHf0HSMuMBzuGKXvge+iAmSWSfQdkDBc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchnkB533tmnBAKDf+UejFGP1U+2lotRHOUIf/Nt
 jV+F5KaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIZwAKCRDRN9E+zzrEiDbSD/
 9p34Y29eU+uEnTxl5viO6CIXN1ajPgdEhMo5S6EMhNZb38al/aayV7sOh/ynB7lSWgz8vA3zHQGV1v
 myTb1fPsHRAWtQpXkznTmnTL3BXJlXEvVIYIQ4IfEpPYLx5sDSKXCrjjIDKTYdb6KfXVzPE72a8mYH
 WibUfX+RlHaAUPoLwpwsR24BE3xPtuus25vkcT5i6HzAQfuce93rNJFeW8kzxeSzHCQP2gsvKFQP31
 ABqqx8708mk2F1lxvKOImrof6ceHXrDfCd+aZSOVafHiAS1eb2PoeF7tCE2NduLb9Q8kd2qtPxO638
 dOETkqE6LrXK/SeWPCFx98l4Vyt5pWnyXEh59H+PUEAvOvmy4Jj5P7oIQFH8tpzF8g5j9rkWK3E/He
 bTOc/WC8mOuYDExo+vATpUWRPWgDEaD+S1PHDx+VHek0EXk/IwV/QO8AajosPw4LiCggsxxwolqk/8
 sEoUW0nJg0lEIbphVf4DaWGMPJJsjPkefBB9H+FWrkLN1B+4xsyABcKjyvZU8jG6gcvJWAhDRx6Oto
 1cCkBeGw6cRfPEaPrYI6lXJqvqOgJI+2R2rnmmYZhfH5AqeR/qVbQBy4BnYZcIJJ14q+bBna6df4pL
 DYT+WNMqJNtwcH39JtjaZTsLHtBilTlpchSc+tb5hEu+5N1xxdySAtZ01wDw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If head is 0, last will be addressing the index 0 instead of clock->size
-1. Luckily clock->head is unsiged, otherwise it would be addressing
0xffffffff.

Nontheless, this is not the intented behaviour and should be fixed.

Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d4b023d4de7c..4ff4ab4471fe 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	first = &clock->samples[clock->head];
-	last = &clock->samples[(clock->head - 1) % clock->size];
+	last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
 
 	/* First step, PTS to SOF conversion. */
 	delta_stc = buf->pts - (1UL << 31);

-- 
2.40.0.rc1.284.g88254d51c5-goog-b4-0.11.0-dev-696ae
