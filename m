Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56A6EC94C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjDXJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDXJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:44:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277235BF;
        Mon, 24 Apr 2023 02:44:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so4041648f8f.1;
        Mon, 24 Apr 2023 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682329488; x=1684921488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hq10D5ykzbe3KUWcdYskLW8BAORaswBtu5uzMDTqt5A=;
        b=U7/zEOMeM9/qxhjxHA6L7mAqApbGQN47txM5tBDDdRkkvQ41dEP3DYr3dMr95JQxNG
         0QTGRAQz1xUraMMqUcLqLM848QPGKm0b5r+1sdeOernRKWNfI8i5lMDvHryJAfGsjgUL
         RjKJv9r3fEM7ChISxd5nxVnmU+PTB2w6dNE9s30mqdTHkWvRMaVv/hcftbr2AK3lIQUX
         +JQ6ZOrllfPqMe4fnQ0/C4jUMWpGx04jbjEOaqTSAP9PFHyBkvVQRxECiVJvmMT+ZLTL
         l887J5Dw2JyHqmA/WOd5j2W18Xs+jemFre32BHBbolqT8N4qjIhcIM1TF1KGhjTcpi3h
         ewHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329488; x=1684921488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq10D5ykzbe3KUWcdYskLW8BAORaswBtu5uzMDTqt5A=;
        b=HnMWR4W8jrSFaXVglYHtp4zl6xb9YoHG80V7LhMgzw9cu9piugWOKVPxoqVWE1ekbV
         gOcm4yWVmb4uAPVU57h0h8DHcMzijVQR+hFKD7HsICKLQ/Xe4jNYybJO69LgI4Ni9Axf
         Dj2QwyMal3+Hda8bDisWfHghhIXwm2uneKcFedXQN9s/8JWxSVMnx2IRlwAREKtq8OAn
         0ohGaYN8UeSihuIJ5+dg2nboYbXKlFK4dxBdywNw5g1Jkg4X0+8BqTvK/GFzumo0dhE4
         CBL9IXkzGxD82/33afKWY+a04GpMsMA4e21eOHws0WiKwSwKXQ73IRaOywpHNDmE+hOG
         vgjg==
X-Gm-Message-State: AAQBX9cEtLuE6gY7f9V7Tk+b6a+xRp23VGGmaC8wzFszt8DFOjl7Aq0+
        EFebhwUFBOgWflZqvrOkpScQx6U0HxU=
X-Google-Smtp-Source: AKy350YLznCxta7N/2YNUfLoLNVjp7FUIB1LFXPNZL789mYgiCnBXLVx6H4mCKf0AdLIX6EHWJaBdw==
X-Received: by 2002:a05:6000:1c9:b0:2fb:ad8:288f with SMTP id t9-20020a05600001c900b002fb0ad8288fmr9020156wrx.11.1682329487514;
        Mon, 24 Apr 2023 02:44:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003f07ef4e3e0sm19798161wmq.0.2023.04.24.02.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 02:44:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rv: Fix addition on an uninitialized variable 'run'
Date:   Mon, 24 Apr 2023 10:44:46 +0100
Message-Id: <20230424094446.105133-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable run is not initialized however it is being accumulated
by the return value from the call to ikm_run_monitor.  Fix this by
initializing run to zero at the start of the function.

Fixes: 4bc4b131d44c ("rv: Add rv tool")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/verification/rv/src/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index e601cd9c411e..1ddb85532816 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -74,7 +74,7 @@ static void rv_list(int argc, char **argv)
 static void rv_mon(int argc, char **argv)
 {
 	char *monitor_name;
-	int i, run;
+	int i, run = 0;
 
 	static const char *const usage[] = {
 		"",
-- 
2.30.2

