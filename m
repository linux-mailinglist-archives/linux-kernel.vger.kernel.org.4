Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE86164FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiKBOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiKBOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:21:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89D29C9D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:21:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k7so7000319pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODaPlzoiM2wGPR3JeVuPfzDqwHYUcKlkdeyiRb2Q0lw=;
        b=dak2HCVpbEaeVp7CSu+TOT5ppVs2qsQOQoQSzIcU5YzTb/X4cctoidWvx1Y+mWXgJC
         rXX14WjJcAycOPiZAuyD4EzZv2OO5H4Q/wDFdS3UAgSZdiPyC2TKLzRvcKzZBENjx8ru
         5e2yu0z4x08FDLahkeTp4/kViprl7KWaAGk2SlNTVWpTrZ62TIDl1s8J5d+EFO3dSFky
         SI+BDDgi1kOnposCaxtKTnpGtgGRzbqLpkduGlzGqiNb1rKPmGgVaMh4lLPGhknmmoWv
         njo7EXv22zsqXyOUBlSzmhOAs2/e0UMzhM4TXQP7R76rtCXpCKE/QzvkWvarmcNiUYhJ
         NWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODaPlzoiM2wGPR3JeVuPfzDqwHYUcKlkdeyiRb2Q0lw=;
        b=kiKMhCWAfmpFBw567y+t86SYYgn5Ts+qikx0z+lMsegX16nNzs7ZOq/39Ak+plBUdh
         bvH4PWNmhstYNj1M+2DWUOGBN7q3tAXRn1R6MW0GJrd5dwhhCHk5kuiBzwcDPC4e0tsD
         SKfHQjIvYbuGtkclBpO5dVGacidsdaHAOC5RDRuFhO/sDG0keWvlFfAqz4tZ3tQafTcy
         1rNmZOkRMBXZadk8yozYXAceV4JybcilrliWTnt95e84H+1No9Q16zqqow45L28sJCO2
         FO+yVHWKMWJ9AaePkv4yedv1PVP3RY6Dh4Tjgkmw7S+0/3qkIfKkvDRSiZ2dlWlv+lIH
         gK8A==
X-Gm-Message-State: ACrzQf1U6mg8UVI9bfNJlFKg8yoEd+qQkgIcidrqbF03irdC5u1K9qU8
        S50AHhRjQ/sSbbjDAXi44uj9fw==
X-Google-Smtp-Source: AMsMyM5+KOZ2eFs9n0BP9un2hL/Hu0/DT+cdPD/ekZdtg2xoj2pGgUf72pgOM6m+al2whrRTmykuEw==
X-Received: by 2002:a17:90b:164d:b0:213:6a84:2529 with SMTP id il13-20020a17090b164d00b002136a842529mr26114236pjb.32.1667398905990;
        Wed, 02 Nov 2022 07:21:45 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm8817773pfp.19.2022.11.02.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:21:45 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/4] PM: domains: Drop genpd status manipulation for hibernate restore
Date:   Wed,  2 Nov 2022 22:21:01 +0800
Message-Id: <20221102142104.2006554-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102142104.2006554-1-shawn.guo@linaro.org>
References: <20221102142104.2006554-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd status manipulation for hibernate restore has really never
worked as intended.  For example, if the genpd->status was GENPD_STATE_ON,
the parent domain's `sd_count` must have been increased, so it needs to
be adjusted too.  So drop this status manipulation.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6471b559230e..97deae1d4e77 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1374,20 +1374,7 @@ static int genpd_restore_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	/*
-	 * At this point suspended_count == 0 means we are being run for the
-	 * first time for the given domain in the present cycle.
-	 */
 	genpd_lock(genpd);
-	if (genpd->suspended_count++ == 0) {
-		/*
-		 * The boot kernel might put the domain into arbitrary state,
-		 * so make it appear as powered off to genpd_sync_power_on(),
-		 * so that it tries to power it on in case it was really off.
-		 */
-		genpd->status = GENPD_STATE_OFF;
-	}
-
 	genpd_sync_power_on(genpd, true, 0);
 	genpd_unlock(genpd);
 
-- 
2.25.1

