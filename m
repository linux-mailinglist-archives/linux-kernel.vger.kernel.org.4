Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE15714C16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjE2OeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjE2Odz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:33:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43BA0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:33:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f6e83e12fso524373866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685370832; x=1687962832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zA7KinO5OidXXlXT0dxeVTaKbJRA3RvdNFBat8aRUyI=;
        b=k5FGK8yPPuvxifOZHjrpiRHwFZo3wfW1NEzZ+6PbFKf7dKtlW24T3V50GK4+tKEE6x
         YPmRuPLhxAY7uGB5lBmvVpIg3H0EI3iIsnbaDPitVVWrgfMsqZLDiycE4pjb+s15d0dn
         WXs7Hmh8aRUqdBfaK+7y39cKjFlDF8dzW01rxkh/sB6wRfwfsXtgs4ZQdBTUwzJsqFdG
         9yFtVSY9L0MGjiu42FU5dmq4uhOZOLQcbcywOeu75yswbvMqYJMGkEjyBmEtcOQC7QUl
         ZZw/DHGLsAWhSl0W/ArAkSzqg9RFlAy4fci/ZtTa1m2I8Fxdc4vj5RKFUOka8JT8EMSu
         EvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370832; x=1687962832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zA7KinO5OidXXlXT0dxeVTaKbJRA3RvdNFBat8aRUyI=;
        b=Lp2dQO6+RVJwZ2uzaI+OsVwRJMNA8vHkH8ZzzqKbvDxUVbymTAYl4oE4hm5tG4RyQD
         NHsiPOrLwgmVH0bXNtgasVy2wf5I7hQMJXJV5TVD6UkIoQ+IyEu/5Ya+GiTDiU0egdf0
         SkX2jU8bPHOUCIQKoJosz/UGzm8G54RR/BOPbMFxfYnjwFj0ZOfxEPJpAGec1drx1c0t
         5mfv86YKI2GD2KCFobLGYuf3BZKRgsz8FkYmn7hUAWvAwWjbu4TjYyh94Jk2ubJA1gpm
         1NttuoUIPFIE23aXHEBOt0IxT172e2LCKm52wxULtbsaKpGaupMP8Jjroo7ZcvuzOnMa
         N2oQ==
X-Gm-Message-State: AC+VfDy4c3W7yXP7FSSi8GPybQK5C33mGcEoA+1OSGwBldlHy9sVWMIe
        UQ44xlGJmhrxwHBFqAYP1xM=
X-Google-Smtp-Source: ACHHUZ4UKklCCkrEbHL5fyp/X8upP4UgWNK9i1ZzI3ZBUs4jr2Ya0xnj41eVYau3H83Ya0ZXB6p1bw==
X-Received: by 2002:a17:907:e86:b0:965:6d21:48bc with SMTP id ho6-20020a1709070e8600b009656d2148bcmr11905441ejc.75.1685370832586;
        Mon, 29 May 2023 07:33:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:b8b2:5ed7:fb5f:eadd])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090686c900b00965e68b8df5sm5962109ejy.76.2023.05.29.07.33.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 May 2023 07:33:52 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] ARM: ep93xx: Fix whitespace issues
Date:   Mon, 29 May 2023 16:33:33 +0200
Message-Id: <20230529143333.19278-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
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

This removes the following checkpatch issues:
- ERROR: code indent should use tabs where possible
- WARNING: please, no spaces at the start of a line

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 arch/arm/mach-ep93xx/timer-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index dd4b164d1831..5bfabbdde463 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -82,8 +82,8 @@ static int ep93xx_clkevt_set_next_event(unsigned long next,
 	/* Set next event */
 	writel(next, EP93XX_TIMER3_LOAD);
 	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-	       EP93XX_TIMER3_CONTROL);
-        return 0;
+		   EP93XX_TIMER3_CONTROL);
+	return 0;
 }
 
 

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.39.2 (Apple Git-143)

