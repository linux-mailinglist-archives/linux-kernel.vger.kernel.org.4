Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD85BFD32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIULqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIULqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:46:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FA923FE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x29so6680495ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lP4IkEyc6NQgR5/fjvStSKdnasa2RR9aagLo80bh+wQ=;
        b=MPI/QeQUdshERgTnwLtRSk5quf7LAJzsftQ1mPmIdNedAIcthsmN9PRc5w2X28K42j
         XGKsYtELeqKNGAZrCb4qsLxkG/i44/u9ZyfllmSj5uW7CFV/MRRrvIbeU9wVJaQi/pYI
         eKVubX7NU0Vy0rVYbsWOiFEwz2t6GHKvLyJ0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lP4IkEyc6NQgR5/fjvStSKdnasa2RR9aagLo80bh+wQ=;
        b=UB//yryaQL1ZBTL6Fe+nltYBFJ6MyDsPOaLAMi00y+L8Kg99IpXJSNp+Cdo+T10u2Z
         9Wqa3chG+HLlb88DZOM6czSD4/xB6XoErAUxK2AL4MMlailI4AoWTSdRho9iIr+61wgT
         yRjTFL4VSRWFIygL83wUdAPuU/4tuudjDc52zGpuGrrpv28cooXmlTTvwBO640ABC/5A
         IpqlAS1ur4/kGTOhovRPs/8Shovezx4M79ueltJBlgQkFZ+YiT4MkD1nvwnPUTCUvWgj
         v7OW1Gtds4SdCSd/Wtiz5nrUkj8y0qouSzP1CIzHiUcZrwI+BZdsn0xm9p260tlVnBMP
         jJVg==
X-Gm-Message-State: ACrzQf0GwAN8LwesPL01to20vzad/Wp3jZOejspGM8otunFSVbwj03pZ
        vsifMFQOXROED57m5EaYIHanbjOMhaLGqybH
X-Google-Smtp-Source: AMsMyM732ZUNotQGUDNxF21frMfuDbk4ozqj74BrluY9t9deQILNLqwUs1Z8aYhVn5H+pf9gPFRwtg==
X-Received: by 2002:a2e:a4d3:0:b0:26a:cc7d:d50b with SMTP id p19-20020a2ea4d3000000b0026acc7dd50bmr9336996ljm.77.1663760792217;
        Wed, 21 Sep 2022 04:46:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] rtc: isl12022: stop using deprecated devm_rtc_device_register()
Date:   Wed, 21 Sep 2022 13:46:16 +0200
Message-Id: <20220921114624.3250848-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
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

The comments say that devm_rtc_device_register() is deprecated and
that one should instead use devm_rtc_allocate_device() and
[devm_]rtc_register_device. So do that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 79461ded1a48..2dc19061cf5f 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -246,10 +246,13 @@ static int isl12022_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, isl12022);
 
-	isl12022->rtc = devm_rtc_device_register(&client->dev,
-					isl12022_driver.driver.name,
-					&isl12022_rtc_ops, THIS_MODULE);
-	return PTR_ERR_OR_ZERO(isl12022->rtc);
+	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(isl12022->rtc))
+		return PTR_ERR(isl12022->rtc);
+
+	isl12022->rtc->ops = &isl12022_rtc_ops;
+
+	return devm_rtc_register_device(isl12022->rtc);
 }
 
 #ifdef CONFIG_OF
-- 
2.37.2

