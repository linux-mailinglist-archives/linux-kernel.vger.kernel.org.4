Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0963617FAE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiKCOhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKCOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:36:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F210CC;
        Thu,  3 Nov 2022 07:36:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z14so3069813wrn.7;
        Thu, 03 Nov 2022 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ES1nm1fALBWsnWNeWE6cH/eUHmHK3mjzRJulJRIoib0=;
        b=BGB0/7WZRrgNq7UIH13nwkr/vZC7rpLEpdwB1j5uv7fiDc2R66SM0IxRpYYngznkZ1
         2PhfAKwaNYtN8epe2pz7zXl56PWJUlgFjJzuuhAd34cnQXPOJF8mKCq2hFumPn1PD9sR
         1jUIgGJGqXHpvDn8/64AFxUzZ28y63i8bc7D6Q0mo3xlN1hmFAMBf1Rt0/LnSsQlG/pY
         wXs4vlZJWv0w7I/9VhHCDirO1Q+MErL2cDuRY/t/61aWBDyAvXO1qmqlzzjQ8siCr7FO
         hVP6h4oCeismtmPb2e9DpenpMpTmvB7zW0GVjgiSw6U7QJkNEhUwV+aTloHSUgZ3sTy1
         4Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES1nm1fALBWsnWNeWE6cH/eUHmHK3mjzRJulJRIoib0=;
        b=sOBE6LarX8tEwBxAVf0HdPgDplNHLORv1ubXjhAoahLeB5f9cJEN9ZSjKyx5jkMZNP
         jBzuSrI1h7X53ARcttBIfr4hYfvLzeACLCmN/eLzJNf34pCa0PYByyaj3ifbRgUoz4vk
         ZVj3FWwmz7zWpKXcYQpuh824TZ6b+FsUD8//+aS3F3yDwDk4L4Avrtdl7P3zLwHPT8YZ
         mk4qWHJA1bkMKq52sABs8u1lOxUAbPtYkt4uFlMLelquQjRvkCEnl5iuDN5MC6BcE2Nf
         xEGGoboAYbP2uIWKv5jeAwPj01Ma5C4O0ctQVMmGDkPgTXtyZtfQcXN0N8muRY/cyUzD
         JWyg==
X-Gm-Message-State: ACrzQf3Bu3y16N6WkEQ2oJ3Cxd7L6ceN5apL72B5Hk5xNBF1bnPcL2tD
        /t89/xbUBJ/Ex1DpgHuNa5U=
X-Google-Smtp-Source: AMsMyM4Rs1cxPouTtEmcWcmnfuAmM1E7ih1x9jR0C3RQk+T+gxcvtSZpeBWL9tYSm1ugs+0DUotqyg==
X-Received: by 2002:a5d:6a90:0:b0:236:4835:ca94 with SMTP id s16-20020a5d6a90000000b002364835ca94mr18846026wru.187.1667486215679;
        Thu, 03 Nov 2022 07:36:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d4307000000b00236883f2f5csm1005803wrq.94.2022.11.03.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:36:55 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: SPEAr: Make read-only array sys_clk_src static
Date:   Thu,  3 Nov 2022 14:36:54 +0000
Message-Id: <20221103143654.85275-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array sys_clk_src on the stack but instead
make it static and add in a missing const. Also makes the object code a
little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/cpufreq/spear-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 7d0d62a06bf3..c6fdf019dbde 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -39,7 +39,7 @@ static struct clk *spear1340_cpu_get_possible_parent(unsigned long newfreq)
 	 * In SPEAr1340, cpu clk's parent sys clk can take input from
 	 * following sources
 	 */
-	const char *sys_clk_src[] = {
+	static const char * const sys_clk_src[] = {
 		"sys_syn_clk",
 		"pll1_clk",
 		"pll2_clk",
-- 
2.38.1

