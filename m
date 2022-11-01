Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2B614440
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKAF26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:28:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C225C2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:28:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f27so34550049eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=mLLaysSuJEBJmq4sM2/3WJnvnspl1xlfoXtzR3zcwiE=;
        b=jKQD3RKVt+JF3+JRSxzlBJ5AZbG4ITysv0VFVsdOgfpm6dawvOzbDvrZDgxW4ITcpr
         OpZMjvkttJAo7CXGXmix++vunXjGBMHY1Y9oI82Emdep/6TYAbMfkRBkBCF4A8Hu+mUs
         wMMn7f1jG29Lr6JtGoEqpP+OR6x1vKWzT27PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLLaysSuJEBJmq4sM2/3WJnvnspl1xlfoXtzR3zcwiE=;
        b=V/KtfvZkJngz6TTyEJICjI2Xni+0AIlA804PZAlT5hgy8/pnNyauZfH5sj431gyUN4
         0GInutaOpF6ArC9mil0Oy4curS3on/uLnCq60YH5IPBwuOcuWXnJ0yXqjtLO5zLkwmrI
         52v88NgkJu1LMO34VSoWCE676W53rklieCpSx5+Pan+ws6Y5wItT7HNFArdvFCfQkftB
         kdAZUHSoi0ZoMWUr4Z8LvIV+MrAiKdi0dzFk4mSHEmwSvn1EdsJL+ubrIVWMcxys7GUx
         5GWy4fu6QsJhMgBLdrv4ZJNbDWCJqfuB5jFQjtw0VXaDOFm+V40bcJnECWZKs8DO6L+g
         DKGA==
X-Gm-Message-State: ACrzQf20QLL+V8dWtm18mss6jQjib9Bj0G3DBnHIcX9fo6Pe/XKqD4uG
        HRglsEFOb3//egb2YnExlKD5EA2hni4Or+l/
X-Google-Smtp-Source: AMsMyM72ooIHroLANvzgeWtnRj9mscZI3pvV0H/IcJYko8wGqzo2tVS8SB0NX+j26kOQHYL7f1QUjw==
X-Received: by 2002:a17:907:3e87:b0:78d:bb06:9066 with SMTP id hs7-20020a1709073e8700b0078dbb069066mr16793518ejc.387.1667280534204;
        Mon, 31 Oct 2022 22:28:54 -0700 (PDT)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b0078d3f96d293sm3797074ejc.30.2022.10.31.22.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:28:53 -0700 (PDT)
Subject: [PATCH v1 0/1] media: uvcvideo: Limit PLC for Acer Easycam
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAIiuYGMC/2WMQQrDIBBFrxJmXYsztpB21XuULtSMUUgUNBFC8O6Vbrv6vM/jnVA4By7wHE7IXE
 MJKXbAywDW6zizCFNnIEmEKFGwLofVqxgdanN/jAbJQbeNLixM1tH67sd9WfrpQ9lSPn71in3e/6GK
 Qgrl6EbEitTkXtbntIZ9vaY8w6e19gVWiTvWpgAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 01 Nov 2022 06:28:40 +0100
Message-Id: <20221101-easycam-v1-0-71d6409963da@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=i37Itz2F3nuoYLwGHdL9mqlH2N5yT0vdCtQhYAf8opc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjYK6NUFd8We5P0mT9v8CiN/fUU6S/MgJjq/7ilnC1
 AzW98bWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2CujQAKCRDRN9E+zzrEiCtcD/
 94/ujx1oieFjEQ64nX15vQ6tUBdmKi6v8MYxlW/8cUI7Tm8dJyfJRjkGiP2boD3BlndQPThdD0AtXK
 AxilXAzGpo5inO+MLsQ8klTmdT2x6ctLIQEXc9rDCz9PvVkk+mYOt+5O2/tHoHupigz4Kk3u3/+/An
 Tm8eBZG68fJvML3DZW52dhfg59oRMJxz+iRmq+GiqTmGFwUu/S6+4FG7qt/hTLTY44mPoiHbJE6Q63
 wvAYs1eUV/TAXC+/pzEM/RUwnhEgeM7CuorctrML4+5P2lDvsJZVOyniNRj/8BeTUzguCiBsdZy+ec
 egNyUe6oxCHgddAIIqT74ag+rDcIG5/YGPRSdYYu8Me7qT7tAYrF7lQd3MfM7Xmo9Sk933TMubbF4Z
 3eStkI3nLDWbZEbuK3Aul6UY4OJOblSE6fD9/+zGf7UwDFlDDW8U5ntKnr/f2Dl5dLPfvDTmUnEcp7
 U74Cfm83m9EqRpjhKRcl3piaFd7SHSv2m9QoKE79bryHNkTuoIknrWuILLo3tcdzAe1OCnt8zJaFVY
 /9MjF3TZMI9xvXzoTtn3XuvrZfFNk5PZRcKfdcyekdR7dJA7BObyltYEGdb9xPZzmda8VSHNDq3oR8
 4fVDZaAf0882Rb0EFq7wD87Y/4SgctFJNHjMoUh5aeeknEEyFD6KJ4gDk21Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another Easycam with invalid PLC control.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (1):
      media: uvcvideo: Limit power line control for Acer EasyCamera

 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)
---
base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
change-id: 20221101-easycam-8f1ab598b12f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
