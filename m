Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2B5BFA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiIUJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIUJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:12:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D18E0DF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb3so12099603ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=LybwIQYtr5MkOTsSbogVgHlZvfV5O5f7swHU1e23Nnk=;
        b=egZp0Rml8k4jjLCOsHwcmHh1L9sWdlJgMorMbk2GRcf0vceavyDxP/WcASdBDreOwg
         JgKGMRDQ58z1vmnIJOuyDQh68etgBZMYrt/kwpjZc2BYO46/PsWzUSZnaLNl3ylHDQA4
         fRCGOTVchb89CiqnvXiyr6hNs40DL4txuTHoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LybwIQYtr5MkOTsSbogVgHlZvfV5O5f7swHU1e23Nnk=;
        b=fQ00Kp1G6Wua2liS5lfM1pPZjbMappV0LDfU5xsO8gRqMvd3HkhImZhSRaba5ZH0Vm
         xSRrNfxTllVKnyOYUndMgVWlFAmGPp1t3Ai3Xe49cQH56HQTJWddvmG4ZC7n0JcfaTUD
         Z2iqMrgeuCiYNxlJkzb+rVzTPaOcgfXlVGILiswbaWsQj3SSmjAIYGj59VnQYJAnMgUe
         Yn9cIsPXckJsEAsrOz1uXXzlOzRtJ21EpWKaRdtRHDA6DFUIczl/jiq/8w+Qw2WUh+Mc
         V3G+ZUJmfCFlnDSLnJ2IywILF/FtqqMoNn63eL9sTnBp+kFgX29gdaL4UTlAg4LDqKVK
         /mFg==
X-Gm-Message-State: ACrzQf1W2ej3Hkc0G67lWDfc0sye7cGdZk7VPrI1BcqdVHL9vp/KowZy
        UnfPkywavf402krNQlorCJwnvA==
X-Google-Smtp-Source: AMsMyM4i5eVUZne/tBb50eoZT3/VrVBXyyzugtl+8P/mEgREwzQKDFKEQeYlI2xrvc+8yy59hHvZxQ==
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr4663976ejc.628.1663751556184;
        Wed, 21 Sep 2022 02:12:36 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:160b:cee7:2e8b:f72c])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090690c400b00771cb506149sm1031913ejw.59.2022.09.21.02.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:12:35 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:12:13 +0200
Subject: [PATCH v2 4/7] media: uvcvideo: Do not return positive errors in
 uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-v4l2-compliance-v2-4-7c0942040004@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-7c0942040004@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=lvRGgJW7MhPUQfG+nYO+p570MCZiCiBKUgYSsY4PyFM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKtV5+230xmqcztWIiAzDF9bOU+34FX6pKIqnJMNS
 zDAVOy+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYyrVeQAKCRDRN9E+zzrEiPQvD/
 0TEGaZJdF7hZPJcNp9WCq2QkGpwgnohRus+Cu75w0dlKQAu5KSrllfNIc7LtlVjzQZX1QXv3FnwQDb
 ZQa1G9eUMA3xiSO6ukeTusG29ehbBzFDPqK3dFPH1/nOs6x+XcxLGpIBtdaPv4Ao5y3oMWpyH0CxQe
 Ip76bsHdjlb5RPm6vr/oK2ylR+MtaWPC51ZHz480qkSwwg+aysXJcZZMlgP59311fVRu39VySpBtn5
 vjL1SCLcMfSOjSaukBCqaucFRibBZ2je5X+yhJUuWRMI6WGLZCNel5IFg1/VxmXBz49VrblYfKSX92
 HWctoOzRpcypeJG+qf/X+KiMVA2/CfkIylXLKjb2KfDutZes4I1GJd2cP6cCNZm5/des8QBaGy9+V2
 TWmoOnTRXs3fNCtCFV8k0T/tsCawkWl6uSJL2SlVSGnfL3+JAfB2YSNgcjr8sSofN7X7cW1tguKQc3
 qGHVpochn3iplcax4euE6A+YXLF8AoC0NGrezBUt3yIoqMg3pdNJ3XB6fk2EMy87P2iHqPTFrrU1fS
 SwpkQvf6sWbAD0Gp5svFr+3hH6mqtjiLlIAOYjvduRLgbmBD5RqFIL0ZPOlqqQAh/A/3PvSToaL/E3
 7nEdFHexN5c03sBj10Zs3RHjNfx4mQNMR7HNuGa6pIOIXtjJX/EQljlifhJw==
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

If the returned size of the query does not match the expected size or it
is zero, return -EPIPE instead of 0 or a positive value.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 497073a50194..902f2817a743 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -83,7 +83,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 		dev_err(&dev->udev->dev,
 			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
 			uvc_query_name(query), cs, unit, ret, size);
-		return ret;
+		return ret < 0 ? ret : -EPIPE;
 	}
 
 	/* reuse data[0] to request the error code. */

-- 
b4 0.11.0-dev-d93f8
