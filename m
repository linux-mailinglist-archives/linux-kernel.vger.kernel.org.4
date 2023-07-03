Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4A7461DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGCSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGCSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:11:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46240E6D;
        Mon,  3 Jul 2023 11:11:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b852785a65so30018315ad.0;
        Mon, 03 Jul 2023 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688407898; x=1690999898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IhdYP/22dBSoxvMuKvWYSpUplc7xlf7E0Ak61tHyTo=;
        b=VZA4n/DN1QFCSrPzFmHJ1ZapCsXI7MW5ozRUIRfGn/haqF3uRiSFySHGKSliDu8U3l
         4t5/jXPiHVpDk5ZQjhZidMVhtpORBwRHVoWaUzIFK5M/FHIWFdF9DUn9OgMAYU0qq1ha
         CzHr931w6W+rdHJqr9WlW8HZg/pEICbhk6uSxTgINPVAx2eV8m/Y18fnWTPLtg7H1T17
         daX9popzNofjW2DluL728dOJV0xloaJ9xPbdkmBY5vDcj4dVFqu0SPYNjF4WGYX3q8ME
         ubLi+TtO7pSmUgqENdsdu6+Wxh5wKS44l2t+K1K+nKivaTRpLWFpAqw0oH20Z8lb2jdb
         GyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407898; x=1690999898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IhdYP/22dBSoxvMuKvWYSpUplc7xlf7E0Ak61tHyTo=;
        b=cBHSTOlpliYYdC3FooGBmNsRMStY7mLzL/7MJ4d8ToElsori5ezSv0wWz8KZsO6wjk
         5KcF330FXLwgo9KUMrRmlRc9ebd/MqvnYk1vvQOs+TLtg88EZpxPM6sbLkb4de0w3k6h
         O/TrxiOz2CA8feuGJK/k/D3R08YEPRnfbAhizh93N5IwmyXqW7QwXtd/Fpv+Ypf7SAUS
         X802OZCBQa9BNm7akLav2hqvpVTy0LrIk4/L8Bp4Cc+egAc6M560V956M2ETNEU/hJRc
         11UQahQKBncBBDK45Cd/1YD6MoYtsmyse0crpju3D7S0XPHZJ9YGGa7Od2+e2f+mstCj
         5U4w==
X-Gm-Message-State: ABy/qLbakRHRPB5l0NO+ZC9ro9i00W75O9+rfr04dDWQr14gArucQdiK
        L92Pmhbt4ui5gt/TxdzwpjykNzghzbs=
X-Google-Smtp-Source: APBJJlH9uxUr74T3itDXphOGFeNhR6089Pr8UOtA6dNGiJn+j1gQnOZ/lHsdEgILnIhgz3oqUoYqCw==
X-Received: by 2002:a17:902:e743:b0:1ae:89a:a4 with SMTP id p3-20020a170902e74300b001ae089a00a4mr15745490plf.8.1688407898512;
        Mon, 03 Jul 2023 11:11:38 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:feb2:139d:d966:84b8])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001b86c526feasm6204072plf.28.2023.07.03.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:11:37 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] xtensa: ISS: fix call to split_if_spec
Date:   Mon,  3 Jul 2023 11:11:27 -0700
Message-Id: <20230703181127.1346607-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split_if_spec expects a NULL-pointer as an end marker for the argument
list, but tuntap_probe never supplied that terminating NULL. As a result
incorrectly formatted interface specification string may cause a crash
because of the random memory access. Fix that by adding NULL terminator
to the split_if_spec argument list.

Cc: stable@vger.kernel.org
Fixes: 7282bee78798 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 8")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- fix commit message wording and add cc: stable

 arch/xtensa/platforms/iss/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 7b97e6ab85a4..85c82cd42188 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -237,7 +237,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);
-- 
2.30.2

