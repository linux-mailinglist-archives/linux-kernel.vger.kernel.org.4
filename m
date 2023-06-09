Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE8728DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjFICW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFICW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:22:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D772722
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:22:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b038064d97so2597465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686277374; x=1688869374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZNQ2dwun9ILIVzofEMrA4Cmr+QYtV0Q1ZZ8saKo7xw=;
        b=WkDwkn1/WB5jnSlCxQ4wkHE9sI0ZarvkXYG1ZCyFEDDaYxLP8JNBxejq113NJeo2Lk
         NOCHF+B/xT4QnJQhPwvxpW3bEXoEyjZGFjDbNOy3wJMoFuxNrBgx3Pnq/szGIq2mxUA0
         i9FMVWC+tyQQ8Co47k0gKlO28s/VtvPxZpHOLdDag0vxKEEVgRunAZY87UngMjK4QIbs
         hOJ4BHCkSzanrNFHjoncETCv6/jll9CTbZMtyLLHKAJsErlfysr1BF6Js9kGZn/I2+vw
         3/p/fISchG41ic2iKqtaMxpql6H7IQ/PgZ2BfRJZ9ki4E+PNKkbyxIhdj5mzG8iJnpjc
         dovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277374; x=1688869374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZNQ2dwun9ILIVzofEMrA4Cmr+QYtV0Q1ZZ8saKo7xw=;
        b=XiXEB4lZ5wtct658L6aWm6XrDK1IGaqD19nOaaUGBsrZhSqVCQwvo6UsAo0MxfVV1W
         zUf4/EnCNI2PGs9RzQHTO5idFF55G2Pksrkl1jqCCbkfP0Rb/saf0vazMv4WZVofcoEZ
         kvnBIrj4JrcwBFqU/dzllATfZWjrLPuTXLyuQlk2sip9MqvrImpdSrv+4amAG5ef+2Cg
         zc/lDtUWIKNPdbppJHkI2mpso8sZ7Iaw4TaVaTSdxc5kbYJ1XJCt7cYDoJURTS3aZpC6
         RJ16anjuoKDv2pVOPkjytlLGhgS5vBV7arAQEGPArISpNGQuZBkbqsyR6h2/4m/RcirO
         rg6Q==
X-Gm-Message-State: AC+VfDyJBrDNthQRJJEuFlKTP+zU900K6zQzXowQCH3t1Z9IE4QHOX53
        bZP0f2E7HdwREqk4gsgWOBSZgjrIGmM=
X-Google-Smtp-Source: ACHHUZ7S8PzzT3ZCK9MYwEDpXDs4cPLrK5FLl+ipxNczZtfOlmbG2FpYQHm8fOb/XZNrE61ZG2G6yQ==
X-Received: by 2002:a17:903:2444:b0:1ac:a88a:70b6 with SMTP id l4-20020a170903244400b001aca88a70b6mr4458110pls.31.1686277374452;
        Thu, 08 Jun 2023 19:22:54 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3aa3:2af1:e3f1:5039])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b001ac95be5081sm2014846pll.307.2023.06.08.19.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:22:53 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/5] xtensa: xt2000: drop empty platform_init
Date:   Thu,  8 Jun 2023 19:22:36 -0700
Message-Id: <20230609022240.1694244-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
References: <20230609022240.1694244-1-jcmvbkbc@gmail.com>
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

platform_init doesn't do anything for xt2000, drop it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/xt2000/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index 0dc22c371614..08bc9b0ede3e 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -68,12 +68,6 @@ void __init platform_setup(char** cmdline)
 	led_print (0, "LINUX   ");
 }
 
-/* early initialization */
-
-void __init platform_init(bp_tag_t *first)
-{
-}
-
 /* Heartbeat. Let the LED blink. */
 
 void platform_heartbeat(void)
-- 
2.30.2

