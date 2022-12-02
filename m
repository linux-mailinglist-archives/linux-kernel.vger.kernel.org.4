Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF40640C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiLBRWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiLBRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECFC9D2C3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so13034963ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1aPiVVPlDCTllBooA/cyjkx+Y2V7OSiqGOhFRZ36VQ=;
        b=IxByCPcfz52cTjbTUwN9fgOj6PnMnGahYA4D0I8s/mvxj1OKSMmPnHkCkGnL21MAiv
         W7aVZXSCrZ8kgANumWp6xzJCsnhy3ss+ZEB1/naDxPGe0nKDm4mcF8ZkLBFwGU/7MHUM
         wgXDwFDZB+bbqMRHRn6N4fuN5u8qtqUfTzdZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1aPiVVPlDCTllBooA/cyjkx+Y2V7OSiqGOhFRZ36VQ=;
        b=QfGyDIjxkaiHftn1kn5JIg4Dh1WWj6NlDvpEwaRPcSoBrCLS37BVOKvpBiuAK+OwEe
         wtZ84Bw6R35aphOTcp0FjsjwtfSHOfE/wuFyWOBmWDxjxMIQUrBhffxcEDM17WWOA1Ig
         U1d50H4R1Ei+VhWwuvZVgKhSd8UO34BtyAqbLtjCxzpFF4q+1nUvCu7iVwu8FSvE10Zb
         YHnATB3ugMFS2TYW/EDfVqo/Q8jI/yD67phMCP1oT0+5Rx49SnUpO4CDQAWCmDx0GCi6
         JAcNm8wPtKpyqZ1ouYBYEkTa3HxtMhd9lw0xuUbgBCHpMHEQ26R/zro5zwckHusTEGnA
         0Aqg==
X-Gm-Message-State: ANoB5pkqPg8GLVmpQ0hwlYaIZYPZyamFXScz2EPe+p/fFTRdICe2FLwh
        Ap0vAo6ghMfFvR7tutDeq3BvYQ==
X-Google-Smtp-Source: AA0mqf58vmIx5s+b1HfIhaIXZqjzqJHQji7aPfW00SR16AxnjCB2+Pf4gGBLfuGY1HlfhBUVWHh2Bw==
X-Received: by 2002:a17:906:4e8c:b0:7ba:9c18:1204 with SMTP id v12-20020a1709064e8c00b007ba9c181204mr39579362eju.262.1670001713325;
        Fri, 02 Dec 2022 09:21:53 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:52 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:38 +0100
Subject: [PATCH RESEND v2 4/7] media: uvcvideo: Do not return positive errors
 in uvc_query_ctrl()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v2-4-b0ceb15353ac@chromium.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CrX1QP0MUpT5GPNS9+y3kLIDIjsOHF6cFLdPMYSyV0Y=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQop6CSX4WKA8eEwB7KCAVyCeS/f5mL+1jPm51Z
 w2ePrMCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0KAAKCRDRN9E+zzrEiBncD/
 4ymJjJEZahs1/dcQ6bbs2dRSxIPYY4z6ip53LnN1v8aiXVNs38zmQpamI0E4D3idP8W8YLqFaUpJj1
 VuaKlsIMzd0FkwkrmL2FX9c/5Pcxeq7kXRZ3dimv52i7KkU51etyTQiNT+HNHsiRW6iFoyu3nF2krB
 Ifu8QTRJ/FMW/aFQK3aQgQIIP1WdH2FoJZxyHTU0cJufBFZOxvpTw349g4ameJ4Yd4RLDs8enVf2fD
 CUVspusW9j5a2FKBq3JS6qBAhDNoyC5r0OU6DEg4WSTiSsKG/6YFMZ7AnwuDq00PjyQQBVJegS2LBl
 7SzZBdSNaD27CvrqPPY+oHRSGdYAc+4AnV9qcAraJaVCoa1Ym1JgCTJx0PMmq3ar7nNBg9qBmUkpl9
 CPhJsK5t9zTK1WmLo/PsCyBfpnh61KWNX5t/lMcn1YwwU6aj1a1vTtSKVXWuFc3+Trzp76KThakFyy
 0ZIjsXZQSbphInK/AyKcmo0UMbfi+gLUzsfogSvNnucR9aJQpHo2xThNPnkJPiL0+fUrSQ4eZOaFMP
 dVOlJ3CmM/z9ZVyiaHXWfPf48pkriKxLwNn7jegVhXLir88b9SCyhbzwEEgWk8ZapV40Lkd9gBme6G
 HRAVQIqF9M2BxQkAdLZAeyxDtB4Nb9Etfwq1kSToDJ0lWWYk67/eUxZjee4A==
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

If the returned size of the query does not match the expected size or it
is zero, return -EPIPE instead of 0 or a positive value.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
