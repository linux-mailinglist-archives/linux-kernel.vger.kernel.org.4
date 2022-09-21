Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301A65BFA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiIUJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiIUJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1168C461
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hy2so8439002ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=fZx/rWrR7bth2k3zX90922HeFwXDXF4+XRCwzM0uxDU=;
        b=XTQI0onfMaHBbtdQRuQf8MDtTygrDqa/VSdYaoxUM+eeXFUGyDA4s6uMV+EW6KJZVE
         4uA4zUWou6VgpnP1jfM+PNq4tAyqOnwdltiKlX5aFCmI0O9TiZl0uazpwsZO09h8+dOD
         5vsyWR64mnxxsJvirPzNyf7n0gsEcZmXYABL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fZx/rWrR7bth2k3zX90922HeFwXDXF4+XRCwzM0uxDU=;
        b=pBGDCgiQbcUW5RQOB349exhGv/axz587hXSS/PO04334cgXz8Xlq+c0zPzo3WfIj3G
         IMGYZaMbM7W8UX5hLkh1zdUYFx8RAcPFS1SmMrv0VrS4d+j/il7I81uNg3z640pheW3K
         DGB1zGFPzZy1CRLWoSruRx/pZYWkkru+GKIgxwqwVUGFJe8Le+dAVCMyn0B54xFDTRbN
         WNfuMueEt/O14SPTUY1qBBYxOn4qAE8lz83eET2U9QH1U0tEdPUVteUMN7V0nvKJBw3u
         qJ7b48Zr7kYuY1oQP7FYl3b3kirhlrQr4XE1/PjrmtAX1A0KYaG7MMZU7rAnIt1oVFW4
         lfNA==
X-Gm-Message-State: ACrzQf0ezroPGqpZRuB8o+D4Fd81kCxej1Zh7KhjeFZB1W0UqvRrFG6M
        I5ja8tS60CDPrYC5UimJXTzlqQ==
X-Google-Smtp-Source: AMsMyM5C5U51pqKsCjwMiaIc9LnHXhy1k02TcRKZqYKkqXUVk0pBMQXu/uScAX+Mmnt0Zi0QsklyMg==
X-Received: by 2002:a17:907:7293:b0:782:2665:aa39 with SMTP id dt19-20020a170907729300b007822665aa39mr588302ejc.303.1663751555406;
        Wed, 21 Sep 2022 02:12:35 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:35 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:12 +0200
Subject: [PATCH v2 3/7] media: uvcvideo: Return -EACCES for Wrong state error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v2-3-7c0942040004@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=l3Tve8hGJ5W5tTbag9O5QNFnAI00qvVi1fN45JRNTAM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtV41S1sqbl3AcCGC0bbfcwzPIlmTH+3xTAvTXu1
 WH5B4Y+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVeAAKCRDRN9E+zzrEiJZYD/
 sHsPdAVHioOyDsFUawCfvmCQEtk3WOcmFioNVLGFFdB9Jw2J3myyLOCET3ojk3irhXmXIi5EyP5JK2
 scg6aBpNHP+066OOhMwymngr1F74FEz/9Y6CD7oflu7DhUColNSr73o3e9X7j0Oba4tCX1YZktm3ty
 kbEB3a5STpzjlLMqSbE/SpRy5eQ64FKNexZGJc+ZGlOYREdEoHhVXU6Qv+eFRhDfmfyscZl5RVCuXJ
 pX5IyTiyS5fT5Pix82M/oXlpjWpZAUcMS8jKNTt3ZgFTVQ6djCI2yt9VR3qFY4uykkhz39rF28IBIt
 9wD96ZzR+eldZq288z+b7Z/JJKBvX15VLztM8MHWzkf2IpoVv0qXp9h5P9KSTcv6pXq7Y5S8K7wS8i
 +CprRps6omD7uPJVDhDPJNavD+9rO7OrzBiwEyW2rWfybZEqWeQVnGwXsTfKjpdEPH3Tk9JiYAS1tM
 RV3pQgB06j+SBNFwYZfomyhwouzBzQtb6wSPTVFjBPspxK1N0Kwhn7zKirlqgQU2qkCwXTkJ1h9mQq
 NHS0+mKCAFZ2lB8KmOq/PkC2YSPMjjIpBjiVB9OjN7k0bhkA9Oo3aRr3B7A5ES1CcuQcfTXN/OJEkj
 NUdyF8a/2x7QVzGr6PjG24nKfveBBwsW3pTChO+e9MiWaW5EdAA8G8zIAtgA==
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

For error 2 (Wrong state) return -EACCES instead of -EILSEQ.
EACCES is a much more appropriate error code. EILSEQ will return
"Invalid or incomplete multibyte or wide character." in strerror(),
which is a *very* confusing message.

Suggested-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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
b4 0.11.0-dev-d93f8
