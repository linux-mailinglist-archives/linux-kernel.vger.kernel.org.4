Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B061808E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiKCPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:07:05 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2EB1CFD6;
        Thu,  3 Nov 2022 08:04:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so3557231wma.3;
        Thu, 03 Nov 2022 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v209CplkpUexHsLlLnwCwseFS2Qb1ruqSsIW0PYiNeA=;
        b=FnqJS9esJc1rzfl3RzJiNomY6iTabfrM6+V56r+OFNSM1+adygP9+qnt7w7/isqrkN
         MIp0hyS/kh4MzF+lmviuby+wvS6gADHcdfu3RROEKIHiUgvKlcwVQQXbrbq6vOh7jvba
         i61CtfL5GgEnaPW6B58CGwfmkFhyyZ1JTsU6/eP9Ooed7z7kGoK3tEpzxudSxpxLG2CQ
         BUqeZQvWc8KhdqPTCvE5v4SW58+bvIeBpMDq8P+6zGhuqefVTbXoiW7RqH8y1EOlbGtx
         IQK21K+GV0OOV2GsNDyITe6GgDaqSbUdpBNCnAmglNDbo+dRJK2F4b//N+z7zyOQBog8
         LZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v209CplkpUexHsLlLnwCwseFS2Qb1ruqSsIW0PYiNeA=;
        b=KugtcHhjco2BsrtfjTaIEqxg5hCUn/QCtqYISfAsFFwHVPfIFr5Cj0tBYG8a7AKNjq
         9OgIWNBTnnkAe19S+1NDkc3IF7+RyYMV07VCCPHOq0kVVk0I+KQe+vj16toFhPJUJix9
         fyPkQ6zkxpBzpQKiNwvhXncY2conKh3RDRf+sK/aotH2Ua2Z/NV56m/hEMJvoCruTQYT
         qCRgpiAO+ngeALPKAUjiAge5f7odCnF9GZWNRyFf1sEx1QZf+hGI9txa928nrgKfk/kI
         Cqb7bfNGRRk/7D1lnM5/MqGAC/kuP4AD+yByJ2uJylM7ji9JBQP2YrQCZ2QtWqIcg9Ji
         hjGQ==
X-Gm-Message-State: ACrzQf1JYlibvop25AqyVbG9av69keZcj5hr84GegSd6wenYjxp5Esq7
        2HLGO7ZbpTVfYONmBpNXMUA=
X-Google-Smtp-Source: AMsMyM4GJ7vFlVmtsfEUAkqDrWX9Q9yjRnOWWVaXvdKs22w4PlP49L1cTKGvahuZdbEAtlDTgEVHeA==
X-Received: by 2002:a1c:acc5:0:b0:3c6:eebf:feee with SMTP id v188-20020a1cacc5000000b003c6eebffeeemr20120360wme.122.1667487872148;
        Thu, 03 Nov 2022 08:04:32 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b003cf6a55d8e8sm209996wma.7.2022.11.03.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:04:31 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] cpufreq: longhaul: Make array speeds static const
Date:   Thu,  3 Nov 2022 15:04:31 +0000
Message-Id: <20221103150431.87598-1-colin.i.king@gmail.com>
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
make it static. Also makes the object code a little smaller. Replace
hard-coded loop array bounds with ARRAY_SIZE.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: replace 4 with ARRAY_SIZE in for-loop as suggested by Joe Perches.
---
 drivers/cpufreq/longhaul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 3e000e1a75c6..4c57c6725c13 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -407,10 +407,10 @@ static int guess_fsb(int mult)
 {
 	int speed = cpu_khz / 1000;
 	int i;
-	int speeds[] = { 666, 1000, 1333, 2000 };
+	static const int speeds[] = { 666, 1000, 1333, 2000 };
 	int f_max, f_min;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < ARRAY_SIZE(speeds); i++) {
 		f_max = ((speeds[i] * mult) + 50) / 100;
 		f_max += (ROUNDING / 2);
 		f_min = f_max - ROUNDING;
-- 
2.38.1

