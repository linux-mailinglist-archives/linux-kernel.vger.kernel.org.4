Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FBB617DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKCNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKCNVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:21:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBBB13E22;
        Thu,  3 Nov 2022 06:21:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p16so1119884wmc.3;
        Thu, 03 Nov 2022 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OY/0Zt8FwX5kTy53FzOKqmm1vtlRPaq+T8e8ZY4Q7eA=;
        b=cgED+cyhzriZDjNBEDDn+Bf3yvyYUXqca6zfBlyWXDuH/fwDwvy6Cypk8fcRgh6WuF
         WP8Bl4IOtJFJ42X42WO+/nwjv2kXcdPzCoOvcfMDGDb4DJGTJm/6DDfzBCBXyfSgo7pU
         jhK11V+j61Z6W+6p9j5ccPGHMmVjr6nbI5m5Ss5C1C7twzksF8Ipg+/uFituJfnjIi52
         PH/omYypZGZJhKknpfWvT+iHjMm2LqftX59XEgSZwmwG1ZCUR0PnHygSMAS7QEYON1Ge
         gRuslMzkexi4WohZjS5mbKo0icfhrqby8uLT24WvSFVcfIJgCw4yOFMaNwOMDl3djkBY
         sPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY/0Zt8FwX5kTy53FzOKqmm1vtlRPaq+T8e8ZY4Q7eA=;
        b=dNifVwoXFLXswseqqWmT1giECBOP06G9RVC6nPRgIIQ+lS+ZkyKZpWfAbQprASy0bC
         sWcAhFEKI63z50hwhaBcYFZowCnX9uwJCpAFB2sfmmGR3yPSrWYZAn1LkeT0QCEFgQTV
         iv+coxIimNMQ0J5tZL92AgIFhzi0IK/gaYhY3H8RTH0TSMQwbsHYBARWpRuNkWxK4wyC
         FJE6LHep4iY2nMen29hBxjqMHeUK/Od6/+MGT9ioWx3j47Lz0m4aEywaLYOuf76ydlDY
         SHnHiZ7AHALNL7ewXHI5vmJOnJlKivzt4muMGnMKEYptVinNLZQlzbm/9W5YiR9hgmCY
         1NBQ==
X-Gm-Message-State: ACrzQf2pWGFpHkkrhgleBnX7sMfsgTxKNNNIjjtoUMtbwhnceum4887p
        9ChK+//10a3+O9NF35oactA=
X-Google-Smtp-Source: AMsMyM50VA6HkdWKwSWQjiT3ABQyyDKeFVP1Vnl5uf4bNgEtruDdzrvwMWKdOfsF00ADsAPra3CcFQ==
X-Received: by 2002:a1c:2987:0:b0:3c6:c0cc:b4c2 with SMTP id p129-20020a1c2987000000b003c6c0ccb4c2mr18877676wmp.56.1667481702566;
        Thu, 03 Nov 2022 06:21:42 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c448700b003c64c186206sm1190503wmo.16.2022.11.03.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:21:42 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: longhaul: Make array speeds static const
Date:   Thu,  3 Nov 2022 13:21:41 +0000
Message-Id: <20221103132141.79671-1-colin.i.king@gmail.com>
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

Don't populate the read-only array speeds on the stack but instead
make it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/cpufreq/longhaul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 3e000e1a75c6..25f8ef7bac47 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -407,7 +407,7 @@ static int guess_fsb(int mult)
 {
 	int speed = cpu_khz / 1000;
 	int i;
-	int speeds[] = { 666, 1000, 1333, 2000 };
+	static const int speeds[] = { 666, 1000, 1333, 2000 };
 	int f_max, f_min;
 
 	for (i = 0; i < 4; i++) {
-- 
2.38.1

