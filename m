Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39F6DBFF1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDINKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDINKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:10:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D66D40DE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:10:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so4976685pja.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681045846; x=1683637846;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fXaACdefbFVmBrFv928AIoW85GWTWRcXqxLif4tfE4=;
        b=kypOjEp3OjhhaD6eQjroTPNErS71sIcg4B7CgLJE4CbJ72YHcRWmQ/YHjx7gWvPypV
         hPAD35ILDpdbLWwJGFQYnCWJbV0ii8O5C0T75WVgRgtJ2Frf9dHM+hdSuRYL0yRSm7tr
         ApW65cEkPLjZ3AmcUe44Z/ofjtp+Gp4Y/1QcWHmIIKDj9ssbA0+LvXu4rXLibf2eW3E6
         RpLQTHuqczhTOznO+iVpRTKJGTgKidKyMD+5RIWVaX8KoEewwf9YaLlG11C6oUA8cqFU
         IT0qhY0o0fAmWmU1Bd1TtQJ17kUu8Y97Z04NPfS8AqzbCXb5PRHS6pH81QpX/3jTsT1W
         0omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681045846; x=1683637846;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fXaACdefbFVmBrFv928AIoW85GWTWRcXqxLif4tfE4=;
        b=qiYw/5bS6mkuOmap3/Udgvcro0WCdYoAT5mAI/QpH/Ao+Pv+6pPiBcUhqUHIIY2E3H
         1AThurHSJL+NU/q52Z0UhdhXZnrWP6FCpaoR94DtFzUTIcFaXsu0juT3h+3O8cx/XCG3
         jVk4RiXBDA5yQV0d8gR32sEgN+u8qGCiQxY9G0gRsC8OPpPAXv08oiEIO4VqOqIaRJaW
         9qcfWZII3Fcm/Dat7yNSvn+izUmB4YW+Ov9YIH8OC3EFHzVflGJWRPvt3nldhU+2Qefa
         DWxxDuOW5jBIcQ5nVCdkfYQ0XXIY4KvVZgFPX0H132o9IVzsdn3k9D25rdn5Zl5NSNiG
         HpLg==
X-Gm-Message-State: AAQBX9f4Bug0zYCg9YI3RUeB96oj207d9/+ckWf68vbOE0VzyuV2SB5m
        HFjqHSP/NOzSTxk3jErPNMV/Cuqe4TE=
X-Google-Smtp-Source: AKy350aSyeEYO12iU5WlgKGZxNvq2B9kn59UQss/k/1V6yf1gkplfHevPLEE3Abb/DeJdUu6W+jwig==
X-Received: by 2002:a17:90b:164b:b0:237:f018:6433 with SMTP id il11-20020a17090b164b00b00237f0186433mr9924203pjb.27.1681045846058;
        Sun, 09 Apr 2023 06:10:46 -0700 (PDT)
Received: from Zephyrus-G14 ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id jg14-20020a17090326ce00b001a1fe42a141sm5898218plb.115.2023.04.09.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:10:45 -0700 (PDT)
Date:   Sun, 9 Apr 2023 18:40:42 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix comparison to NULL of variable
 rf_set_sens
Message-ID: <ZDK5UvVHa96ejEfU@Zephyrus-G14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparision to NULL of variable rf_set_sens as per Linux kernel
coding-style. These issues were reported by checkpatch.pl.

CHECK: Comparison to NULL could be written "priv->rf_set_sens"
CHECK: Comparison to NULL could be written "!priv->rf_set_sens"

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index cb28288a618b..a67edb81a820 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -311,7 +311,7 @@ static int _rtl92e_wx_get_range(struct net_device *dev,
 	/* ~130 Mb/s real (802.11n) */
 	range->throughput = 130 * 1000 * 1000;
 
-	if (priv->rf_set_sens != NULL)
+	if (priv->rf_set_sens)
 		/* signal level threshold range */
 		range->sensitivity = priv->max_sens;
 
@@ -813,7 +813,7 @@ static int _rtl92e_wx_get_sens(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->rf_set_sens == NULL)
+	if (!priv->rf_set_sens)
 		return -1; /* we have not this support for this radio */
 	wrqu->sens.value = priv->sens;
 	return 0;
@@ -831,7 +831,7 @@ static int _rtl92e_wx_set_sens(struct net_device *dev,
 		return 0;
 
 	mutex_lock(&priv->wx_mutex);
-	if (priv->rf_set_sens == NULL) {
+	if (!priv->rf_set_sens) {
 		err = -1; /* we have not this support for this radio */
 		goto exit;
 	}
-- 
2.34.1

