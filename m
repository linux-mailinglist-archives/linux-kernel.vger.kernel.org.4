Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A5744D8E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGBMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGBMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:15:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C1E48
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 05:15:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b80ddce748so17433975ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300125; x=1690892125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cFvQbq7diNNN0bpBR8H7bBLc7lI4nnwBQk2weQsLw4=;
        b=iyviPkChWoFVJ5Q9yfgPuX+wGACeYXOZi7NWTe0N+dGDIm561PvInBcZ1S2r8lhNUE
         UBZn78lCPe2QaKRB4b5ECsX8ZvliF2d81bAGLpllw1YR3PYOfqzYn5z5SgYtP37k2aKL
         smrdUfQbiTf+/5t6mYCvMnY8iakmQcq45HNDeMhO/OlVbwjisv+cNo29UrKhJG1s9VTT
         I+l5d2aUOfzd+MWqi757W8t+pYO4KBfmO59/EnScP5r3EzV9B63jH8bt9rDefOnEXeam
         jijGpWPah4Z0+kxKRY3Pto1x3WOYgvda0CAqc9sYd4Y242zuiGrQ+VL4S0fnvvICQtKZ
         o1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300125; x=1690892125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cFvQbq7diNNN0bpBR8H7bBLc7lI4nnwBQk2weQsLw4=;
        b=gPRKZbLZDH9vtxnRY6QhuDxsjCKT//up4SUYObF1GojJH53+4IbS0UMr6YyeYECcOg
         tS0wAPQ8lw2YUvwzAJUrrUEE1l5eRp3lL6K8lP9rHGN8xvxGrusGT3MmWQtI/elSKrSD
         CSRLqOlb9YBTs13qXlflc7J5vjtET51QOo3Or8fyPubPqEvK2+Ft2nfJBhTExPoaNfY7
         2nWQM9xU3pSH3w+gB9GI1w7pRU8y+rZQHS69MtkSvSVsUEK38ZyLgozeml7exTf290XF
         9RnmkDg5fj/mZYMjcq9BJ7C8KhkADTSWg+eAX4pM+llcXLnjGzM6rXcJDMK2wL8JLoM4
         cleQ==
X-Gm-Message-State: ABy/qLahsTajV7ovVx6TSLUQ0lRBdhqCfnY4xeR3dFl1+zOja/jHiqWM
        mNaczu4JY1poOUdJNtV0LO1KdgtmmYE=
X-Google-Smtp-Source: APBJJlE1MnWjQdQ9dJe/mq1H0nt1nQxEvX4PMyDPZvHXffaDRgCRgKiz8dmKw0vIUwfY4yP6Gsqbsw==
X-Received: by 2002:a17:90b:50d:b0:262:f798:b60d with SMTP id r13-20020a17090b050d00b00262f798b60dmr5959855pjz.6.1688300124661;
        Sun, 02 Jul 2023 05:15:24 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id t4-20020a63f344000000b0052c22778e64sm13031137pgj.66.2023.07.02.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 05:15:24 -0700 (PDT)
Date:   Sun, 2 Jul 2023 17:45:19 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH 1/4] staging: rtl8192e: Rename variable currentRATR
Message-ID: <091a5abb231fb5c88d47f329ec3b5133b08d6b23.1688299890.git.yogi.kernel@gmail.com>
References: <cover.1688299890.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688299890.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable currentRATR to current_ratr to avoid CamelCase
which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 37c275cac40b..14c78f740366 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -277,7 +277,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 	struct rate_adaptive *pra = &priv->rate_adaptive;
-	u32 currentRATR, targetRATR = 0;
+	u32 current_ratr, targetRATR = 0;
 	u32 LowRSSIThreshForRA = 0, HighRSSIThreshForRA = 0;
 	bool bshort_gi_enabled = false;
 	static u8 ping_rssi_state;
@@ -363,8 +363,8 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 		if (priv->rtllib->GetHalfNmodeSupportByAPsHandler(dev))
 			targetRATR &=  0xf00fffff;
 
-		currentRATR = rtl92e_readl(dev, RATR0);
-		if (targetRATR !=  currentRATR) {
+		current_ratr = rtl92e_readl(dev, RATR0);
+		if (targetRATR !=  current_ratr) {
 			u32 ratr_value;
 
 			ratr_value = targetRATR;
-- 
2.34.1

