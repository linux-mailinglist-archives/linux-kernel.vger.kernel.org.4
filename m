Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D860C7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJYJTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiJYJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:18:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4B16C21F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n12so5484633eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZsnAEsVBgH1SY91CR++8td8qF2as+jKuxUWas/0RKs=;
        b=Cl79DjzTRn03eNRK8pRGb+1+9qKEHx7kjVeCsRj6yDY9YL7wYpqdl8tf2x0/D2AHOe
         I8oqybJP0UMBnm4fr59i7sQWPu7Sl5IrZ5T8NGNhOWOtVuthXbl8dtBF/GgjGEDz6mu+
         1YaT0i36R7P1uF8QIwOUJ9xqfzdEKsIOzFXyTBM8QKYrpNJdJEfCPHgAnZMmrXz61uD8
         mwU3MqcTGBk/dkXb7QVV1T3ZauAt3YABcVh5BO/k/ygdiudD0zgZj/nNP9N5Qkzwb8rC
         aRp4K23LHOUMnqqXTqj/mtpoHIRqyX961R184lb4TnXIHohD/qDGcFqboazfGfSMU2V0
         5oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZsnAEsVBgH1SY91CR++8td8qF2as+jKuxUWas/0RKs=;
        b=WJ/Pl3iTfVZ4wXtYcT1M7FMDG0Cn65NzXgAQSMpk/bkTIUO3brKx9GSN6zNMVRiG6O
         LWrP9yyIu44BJ9YeXtoHJsuqavubWQYUi3IU6mcoMNvgFiX+vicECcDajPJA6Q46wNMF
         F52n3oNLoiPkSFob72TIO53ZLGoYsN1f4sWgyvbj7keyrBwSYmjlJsuNIw45054GTibI
         g58s2A94jq2OkGlYCW4ndK1pb1HLSf2jQLzO+iLMnuXr6y3mdKSAi6K3/+VziQAePJb1
         bWSr6Q6QgEoEDiAvmuTcXkyy5rrlwpPoyHKOCRMBLKbeQhKSXtzNSW1IVw/s0clX1IyU
         6Blg==
X-Gm-Message-State: ACrzQf1tTf7ANYjsPpGLHLQXYZjb6xVobkqu+Mg+PWEP3U+ljH/Nt4DT
        7cCvhKWy71ySHuu2h0o8SC8=
X-Google-Smtp-Source: AMsMyM57ZBavEunI1Nx79QsZ6IO7zB++lejzi5n9DmK/NxRTR5nOd84Pfx7BxO2dLHbr7+SAkaafRA==
X-Received: by 2002:a17:907:1c98:b0:78d:3b08:33ef with SMTP id nb24-20020a1709071c9800b0078d3b0833efmr32455822ejc.175.1666689163187;
        Tue, 25 Oct 2022 02:12:43 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b00780f24b797dsm1061953ejb.108.2022.10.25.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:12:42 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] Revert "staging: r8712u: Tracking kmemleak false positives."
Date:   Tue, 25 Oct 2022 11:12:23 +0200
Message-Id: <26ce206b2c40c7db48c146aa6105789db9dfcc1a.1666688642.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666688642.git.namcaov@gmail.com>
References: <cover.1666688642.git.namcaov@gmail.com>
MIME-Version: 1.0
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

This reverts commit 5d3da4a20a271e3cf5496a50cbb8118aa019374f.

This commit annotated false positive for kmemleak. The reasoning is that
the buffers are freed when the driver is unloaded. However, there is
actually potential memory leak when probe fails.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index de9a568eaffa..4db7eed64a03 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -17,9 +17,7 @@
 #define _RTL871X_RECV_C_
 
 #include <linux/ip.h>
-#include <linux/slab.h>
 #include <linux/if_ether.h>
-#include <linux/kmemleak.h>
 #include <linux/etherdevice.h>
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
@@ -61,7 +59,6 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
 		return;
-	kmemleak_not_leak(precvpriv->pallocated_frame_buf);
 	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
 				    RXFRAME_ALIGN_SZ -
 				    ((addr_t)(precvpriv->pallocated_frame_buf) &
-- 
2.25.1

