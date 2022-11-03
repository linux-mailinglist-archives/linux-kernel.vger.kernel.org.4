Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC51617E27
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKCNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKCNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891E14D08
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t25so5283291ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAg+4sE8YWXZby15NLt6b6O/GKFL5SevR49ad/qG3jk=;
        b=SMyq39jz27v0UrDE6kGVfxQdShfBOpq10vZia79dqcfy27jOmkJO/FvC3wfsnPq6u8
         UB17Yu/BHFm7jD/SGZMYnaCS/9EC6FGBdn3KUsUkwf8c0Da4TNRULlmUsEdqq6cTKFlE
         rZU2PZSKMGhTZsEsfs9H22Qnw96dRctJqzMsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAg+4sE8YWXZby15NLt6b6O/GKFL5SevR49ad/qG3jk=;
        b=R6uAiZ+0skaRdCbUE8QM2vRZQAU0osBktsuLNBClrxbP0HnPKcWddgD6mA8+p7DrIt
         9iSQeRcox6ECAw/T+q6XrejRxrdsIvzCXDfvRG3T9z+gM4CCW2TUns7+rVcAoja9oId1
         Xc8SVzqH5I5OMrggP25I2mb4ny9kDMsZcdPFCYJRbg9RIVpTEJd5v2rrTx2hIWIEtok1
         gNSl3eWzdB/3SudMTCAeh6icN904ji8d/BDDQDRD8rFBVJo3S32XIqPRskI/EkpxuiWi
         sDn8kSIZ3vd18yg6TQYvgBlAGdjQSyiEM+4wdcm7srqMBGiE8uSt29pLhHBsJLFJChfn
         vnnQ==
X-Gm-Message-State: ACrzQf0Ass0h8iuHl5GrGCS1BknLq/OejjkzAukpgftzkT6L2luUkf3T
        7DdG1fA/XqTFL9o0Ra9abdCixXmBYsq8BwK4
X-Google-Smtp-Source: AMsMyM5/QswgOwLDp5cypP1Clq1S8HPZ5lp4altI9Q1vKLb/Jl7Dh9G9Kzo3MTXUH1z/fFMAXGCovg==
X-Received: by 2002:a17:907:7fa5:b0:791:9a5f:101a with SMTP id qk37-20020a1709077fa500b007919a5f101amr29207930ejc.453.1667482867070;
        Thu, 03 Nov 2022 06:41:07 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:06 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:42 +0100
Subject: [PATCH v2 1/8] media: uvc: Extend documentation of uvc_video_clock_decode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-1-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=gsofO9f2SLuiO/HN5/Ipi1+oiVUCCXFoWuwu7SisXO0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8Tkf8fp0z5WECCeQG2bF7AvURn7F3S2iH2qhsIO
 knUeB0WJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE5AAKCRDRN9E+zzrEiAC4D/
 0eMu92YYKKbxptcTPKn7A0zBrhc5nLaRpFtHdgj0lDQy1Q20fJkEjfq1JycRlpuPG/uhdQkNbC/JxK
 RvNX+hxKjfeS0HWHONZ+SKPeCTPc8QqaG0l/wevvVP/xOEiO/sMkI4w/eXg8/DVyMuqXsBRENQsqoW
 LlrAHGKG0z6GMcq4CdhN3K3pfggU2cBDJDYWlVFjYXEzAIUQArDFBhelOpq0EhQ8KDP8I3N8e4Jnvh
 pcNdHlLz3BJlPkJV0P5pls6JDsO5vjtk9n0DFAMYNueD/mF+atg3DbmtPP2AFktMgj0PthWOElLbUN
 gwcytbgmDRWAfpJQj/sxn+wJqlo6RE6JtjnLMYqjHqjEvjEOQkYPy4YYsLWu6eW/TvUNDHY7pQLM2P
 tJkYuc9RyMXe/MlhrE407oMErfEio+l77pdlKTkbepSzwp7YnU+UOkiFRD19mTOrfmvR5Cn0kNjMUw
 k3XsrT5WkRfZbFR9k9lNi5rxFkbw+Eq39ubp5UwOjZOJ61Nhgvr7YBDk9euV9xXbAbzF+PWkS0nN5A
 Q9sBFyRpFCpyp4fiNUvI7D2maHxha9mzxxvzcquAldn77Lk/qXLHjHLNvXE8k/BFXV4U0WYtNCJrWg
 P9jKnplmbPLZ+OkyeWhv/S+M8tqianWhBZXKqUY1pCMoBBv+CPg111q2Uy/g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a explicit reference to uvc 1.5, explaining how the algorithm
supports the different behaviour of uvc 1.1 and 1.5.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..ab56e65ca324 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -517,6 +517,9 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	/*
 	 * To limit the amount of data, drop SCRs with an SOF identical to the
 	 * previous one.
+	 * This filtering is also needed for supporting UVC 1.5. Where all the
+	 * data packages of the same frame contains the same sof. In that case
+	 * only the first one will match the host_sof.
 	 */
 	dev_sof = get_unaligned_le16(&data[header_size - 2]);
 	if (dev_sof == stream->clock.last_sof)

-- 
b4 0.11.0-dev-d93f8
