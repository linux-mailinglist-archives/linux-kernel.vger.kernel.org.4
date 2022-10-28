Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43F611A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ1Sjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ1Sj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:39:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1913D244701
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:39:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso10608909pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds8fIMyaNA48AptZtnD7lRg8k6tUlPBhxOTWMASKHUs=;
        b=lUEI5WN7vVAo0vJruFg2Ec2nTRmNeG7C630IN0qUPxyNQRHjk0JBpAF5gnfd1IEpn5
         +rT3YPCjISfTgbLpN4UpbGjFzTzK2KsPGhepkTYDrz8iPCu/Sada01cZ0kroNyLiXsqR
         Qor3Zlynf1oZbwN8Lkxr2X9uUODEKHq5dr4f8uRHnQmTL/EfUqOwGLFM8oamFLVo7kmR
         DynpwoxQ8hWCxSCN9xBP2tRmQcqBImZ9Ka6wFE/tkWvyebxTwx5TOVEAS1oYvGNvAGlP
         dKWujbm9NERzYXf4FFkksQl24S4hsi9hEw8h7dvyLhs/AgbrqCKE9V3AkNjQubZMkk8E
         EGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds8fIMyaNA48AptZtnD7lRg8k6tUlPBhxOTWMASKHUs=;
        b=2rjTCw6UEc+a2A8LI7IdSNSYRtVo9RDb+Ew/abnim2puSeUr77zQgnW830+1J+WQ+e
         uK6yBdRkoPfwVG2Xfx+Imf/tAhs/Xz7f3J4s9aA4Mv7PRnRscW/B9DQZwWbBLziGwD0e
         +TPaYBhNuer8KDNXUqqgfBSvvDNENUv1bGoGq3bR1Llq2rUKsvdS/zYV/W0EXS2tw4P2
         XojMOUiYIQxt6nBVpirH7rCKpT1PJBa7Q3A/FmjXxn5oKGT8MR4QWcUOuyNEuNrQ5Ccd
         I+/pE2KpJmDaCbLCRZe4pFRnnK4Cl+0sdgVQ7ok22XnMw3BJoRUCfxVOfh0ZFOV826gy
         as4A==
X-Gm-Message-State: ACrzQf1hrHTh+kcLmjdvGnjxme0zUYNDOTT2lImBjLWzTZABPAhpVaZk
        5HOpFFnA0sVDqxmjKnLqcHo2AhB0nSbFcg==
X-Google-Smtp-Source: AMsMyM4YHS+3+8yTNHdCc+lWtJQfRJfbt7nlOQrZf75uUDtOtq22MUDNdEpjqozqWE/nk5cIyY6e1g==
X-Received: by 2002:a17:903:41c7:b0:182:a32f:4db5 with SMTP id u7-20020a17090341c700b00182a32f4db5mr389153ple.22.1666982363604;
        Fri, 28 Oct 2022 11:39:23 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0018696c5d61esm3418137plh.151.2022.10.28.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:39:22 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:39:19 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: replace ternary statement with min_t
 macro
Message-ID: <Y1wh1zYMAbbKSrGB@marshmallow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ternary statements that pick the min of two values can be replaced by
the macro min_t(). This improves readability, since its quicker to
understand min_t(type, x, y) than x < y ? x : y. Issue found by
coccicheck.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
Changes in v2:
  - Use min_t() intead of min(). Feedback from Dan Carpenter.
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 6aeb169c6ebf..54004f846cf0 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1551,7 +1551,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 		wps_ie = rtw_get_wps_ie(buf, ielen, NULL, &wps_ielen);
 		if (wps_ie && wps_ielen > 0) {
-			padapter->securitypriv.wps_ie_len = wps_ielen < MAX_WPS_IE_LEN ? wps_ielen : MAX_WPS_IE_LEN;
+			padapter->securitypriv.wps_ie_len = min_t(uint, wps_ielen, MAX_WPS_IE_LEN);
 			memcpy(padapter->securitypriv.wps_ie, wps_ie, padapter->securitypriv.wps_ie_len);
 			set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
 		} else {
-- 
2.34.1

