Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150446BAAD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCOIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjCOIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:34:02 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C43584B7;
        Wed, 15 Mar 2023 01:33:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17aaa51a911so4807023fac.5;
        Wed, 15 Mar 2023 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678869234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjMnP/a9aE6vyFsbxsfjUFQh+LON6M/20fpKlSvWjvs=;
        b=AAjWq+87+CG048djRPbLX77rjes8Zbq1a+RYd1kDlwqFW4av+0b+qQa4U/FlQshlPR
         NZRi9A/+Irw42gk4glZZ+oMbYDy+JwRJM3rLrTZUdrCXFVBGuhWdmiS+d7vJOoNNWLT2
         M+xHGXvDonJFaqRQEfWW/9V9o8aci3bIj8L/2xGXkxDRmrtxV5dfM2y7C/BnDyACPvKw
         /Deqm3OEl+bqJXELHYbFyA0/I2VNQtIBtYKvUv9ZfKAqdHkqH9tXdBMlo80q5zR8JXBP
         WiXdRZcTmCnO22eKTqBIc0vSZtIcoqU9ydX7xRRzA1A/Pi17VBexPzpEJWms6168JnBe
         5aeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678869234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjMnP/a9aE6vyFsbxsfjUFQh+LON6M/20fpKlSvWjvs=;
        b=J5R5j2wJAnsx1T4wnGNuhAEeRGqzRePxyHjmSaxvXlvmvz18CRM7C1r4rpwnK8+Jl+
         VHP+K77LpMWoIy0WtOr4aN/gdj9C7cWA5F7+PN/nFF/8qmMV6uiOHix2OkQ+3bGFBfjW
         FIS99EHiFwqGt1KXYDz2HLuPTRVW49EUIVMDSZVxv26l4AP33VB5XjETdJ7eni/h1whk
         /Q9a6T0x9RzzPTMEX4t3vAW1farvmYBTJ7PCCuE3qymn4SytFPOHKCKHdm51ASr+j7Lw
         7pvX8kkPTMeFXeEok96URIWC8EUHS9x3V0eJlw0MI+zlVuhm9i/Ol5/DhQ70lNqeQPVO
         WHMA==
X-Gm-Message-State: AO0yUKWKeLLRfT1zLmqHcCFl6tQzHQR2KaVDqhhh9cmTE0rkqSJaZr9O
        OiwBvt0LkQw4vymw+NncnR0=
X-Google-Smtp-Source: AK7set/MEDzKoeKy/lXZwpedETkiZQL6yRV797Lp1tGpucxWm4SaDf9LnNNJ1wK34tpbxsZEnGSVXg==
X-Received: by 2002:a05:6870:6025:b0:17a:6788:e8b8 with SMTP id t37-20020a056870602500b0017a6788e8b8mr3904321oaa.51.1678869234187;
        Wed, 15 Mar 2023 01:33:54 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870e28500b00176209a6d6asm2006912oad.10.2023.03.15.01.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:33:53 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     mbroemme@libmpq.org
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] fbdev: intelfb: Fix potential divide by zero
Date:   Wed, 15 Mar 2023 08:33:47 +0000
Message-Id: <20230315083347.3852851-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable var->pixclock is controlled by user and can be assigned
to zero. Without proper check, divide by zero would occur in
intelfbhw_validate_mode and intelfbhw_mode_to_hw.

Error out if var->pixclock is zero.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index 0a9e5067b201..a81095b2b1ea 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -1222,6 +1222,9 @@ static int intelfb_check_var(struct fb_var_screeninfo *var,
 
 	dinfo = GET_DINFO(info);
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* update the pitch */
 	if (intelfbhw_validate_mode(dinfo, var) != 0)
 		return -EINVAL;
-- 
2.25.1

