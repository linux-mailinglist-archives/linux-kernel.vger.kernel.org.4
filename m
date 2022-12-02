Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF1640C05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiLBRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiLBRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A2E7879
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bj12so13034889ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxw2Ty4M46rsTuihUXRiS/Nyvg7teTU6EvDgGOU8X18=;
        b=jJEVHDdlvpUPCZhRaERran9eUhOM2qlOOFnRvqqedej3zPhgq021ZTuEjKL2vx3Out
         b4kvxDCjksOswC5RpRzF5475S3alzk2VfBobREeil0g6d3/kqEjadY7zGkArNg7AirEA
         lZs9jbuWvXKaDNHErwa1oINVxV5f3Y8fHla3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxw2Ty4M46rsTuihUXRiS/Nyvg7teTU6EvDgGOU8X18=;
        b=qFKH+7/XvwGibP4KvoUM4WG39+VNgqamLbQrz68OsIMg6IiEF5w5jPJkzBbD2gJvT7
         pEhN66RCGr/Gxiaccz0APVsr4vi6qzey4zW7PggHDhxPBJUr2wYSNwNq3Oe49ImiLRkZ
         8jD2S3jDYTcMsDlpM0FnYDlK1pi8/emLoys/6YIgYiQUQHdYwr11nfwDe32TC/jzxI7b
         F7ndY9Tr2LyNatHgjzmTOddjQkmhO9MU2sosIyewnhCsuVIop54+QQqKI3DCM5H38UUB
         lK4kkE2RPK/88DNn6eUKoi3ITq5MVCznvK2w5bW5TRjYav4fRYHE5ipUA2y72kjsNPme
         FSOg==
X-Gm-Message-State: ANoB5plwx7OLGJWu7MK5uwWyrqviVcEjeb/NIctK7//e8s6D8fVCfctX
        FVpgm3lmKeMKxDHBwW+0GqUs7A==
X-Google-Smtp-Source: AA0mqf5ngiwbD9mStRSED8Dqbs841Uw8JJSsairpGupHjMXbrcVc0NQ0viZ2vxp9N3+lD4bS/MV+DA==
X-Received: by 2002:a17:906:a019:b0:7be:e774:5aad with SMTP id p25-20020a170906a01900b007bee7745aadmr11360543ejy.426.1670001712399;
        Fri, 02 Dec 2022 09:21:52 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:52 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:37 +0100
Subject: [PATCH RESEND v2 3/7] media: uvcvideo: Return -EACCES for Wrong state error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v2-3-b0ceb15353ac@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0oIT1Gw1hO0u+7q6An7Ai/dJe13xUDjVNu6Ry1clGFI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQmpIoIjFr3y9ZZLwbmXpabLfWEY4uztWa1E3R0
 pSoPKi2JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0JgAKCRDRN9E+zzrEiAbNEA
 CaYQocLmpu+Q7+j7T3rRhdnpqASN9EbtMtNzOxii2/ubnfHq8sWhoBFOqlh5IlyN5ItBymGP5ZUzVQ
 F9Jm+m2UXqvIMvNJAFdDpMyh39BGX53KocfkJJz1w3OO6q0uD/owPRd0P30tC0c6PTIunSLHguVnDz
 m3bP+NxPjJth125jxjTCyBPG416uvP3gRcAYT/nH61IDmaMMutBFgBkxTMhdRCkCc0iQ1notbaFR4c
 M5jXlHqroH9o1iYVed2w69/mTRUJSXkv/u06WKGmr3VLD/WhQ/WjkaPbO9eGUEOdrHBuGC1/nUWGik
 LEWOvGvOpYV/3QWlbs0ThkJDeqy5ZhPuVLAepKGLSEI722isfSbCt2gH8mdawjwS5rFEfM4glXY77g
 8FzLCNdn9/CPEyoyH9+mDzSPmx/zl4Rojhbygg3inwSyvkZIZMpkGOk6J9hM83bX79TsxiJgq1bv3A
 DwZAR4Tz5YlrCsGQYCmcjQb0k3VnP32Iszz/y9nFMfW1dQVZO2ed71fvMK1QStR2CNXtLeAcPTXL87
 5agpKQmlJA7QANvJRYHbu9ftRXFAhOC2FjTe9ZoqclTupa/XTX8GCyY15ibV+a65ueo2Xe6weBxJtO
 Q4ofJX028Tnd37JPaCN+e71KmtbiqLQMFPa449J5eeoUuW083H9WX/Tk2fww==
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

For error 2 (Wrong state) return -EACCES instead of -EILSEQ.
EACCES is a much more appropriate error code. EILSEQ will return
"Invalid or incomplete multibyte or wide character." in strerror(),
which is a *very* confusing message.

Suggested-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 2cf7f692c0bb..497073a50194 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -108,7 +108,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	case 1: /* Not ready */
 		return -EBUSY;
 	case 2: /* Wrong state */
-		return -EILSEQ;
+		return -EACCES;
 	case 3: /* Power */
 		return -EREMOTE;
 	case 4: /* Out of range */

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
