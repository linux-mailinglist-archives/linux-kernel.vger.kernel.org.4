Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5C6BA8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCOHTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCOHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:18:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B537D1166A;
        Wed, 15 Mar 2023 00:18:44 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso1217035fac.12;
        Wed, 15 Mar 2023 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678864724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uta/U05GAafaktR9fApAMeVEtX67Kdj3raMR2qMOvbI=;
        b=PJ2X+ScApxHTebPxeX1bpYuOF7q01B1YjghfwtSX9BrJezCARL3fcJzeYPbRNAqq8Q
         7Wm4cm8ceHVNag03pezg+jR1KBV+BtMvS4ujHJcqIhkb3yXOBqhjkYKDv1QXEmyB51li
         VVPGWnAGUhnxQ+uCEao0OIqcJCr/17LOOKoNWgWYw3zLPcwhp+BC9bE97WvFQK2QbH/G
         amtOOyJWhny5O1eaoXOfGnJicjORYiZOyDBdytgJobMhSDWhy3pMIAZ0F5UBEWpJYYpT
         1XDJZO8xRd0BXGzrMO5waJ8D3Zfc7fL2/VzWD13i8TUXK/I8qwjy74Fi+T+z+J8KCScB
         etIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678864724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uta/U05GAafaktR9fApAMeVEtX67Kdj3raMR2qMOvbI=;
        b=MFUMnEmI4X9NxEXlFfMYfX9BiXLWLJ5Uu/AbgL65DR1b2XJHiHRqv9P4VotW6eMvbR
         70zP3v3J2Q5I2te34ylPg0w7BlU+N8Ogibfmlj/PkTc1VrLjbd4CT8GVgAbheXOVdpua
         hB4G42LhyNGrSN4z56i4QZLu9HXUMDBc2YFA3vNqr/or8UqkGBucUZX0CxUBn5vVt1gs
         JIDeZUCCiPL+LFrhXjgDwjqFT8GpQtN7Q6wDl4XGISn1vjA5TqFDLqHOpS8c+SP49Hfu
         /frcTayMm3bwwE3dYRac+7dGV90XQmY4lbBy44uduMvBZEg7PUYalIE8tWqg4YUQniwa
         PDZQ==
X-Gm-Message-State: AO0yUKVTmdsuT4ttKPD2aykr8PgC3LH1GinTOrewuP+H4ZYBKWdJcjng
        Vzy3EVl2QmBiuTBPcl8RjnBntfwy6PSzqA==
X-Google-Smtp-Source: AK7set+tVtF3UU14jhEuO63/9HB2svaK+oHMY8mRNgtuyokLjZEUYhsRpjZC9RJHiAdfnnYAgpuYCA==
X-Received: by 2002:a05:6870:c084:b0:17a:bbbc:71f6 with SMTP id c4-20020a056870c08400b0017abbbc71f6mr1862775oad.55.1678864723793;
        Wed, 15 Mar 2023 00:18:43 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id f59-20020a9d2c41000000b0068bb6043362sm2047437otb.11.2023.03.15.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:18:43 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     adaplas@gmail.com
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] fbdev: nvidia: Fix potential divide by zero
Date:   Wed, 15 Mar 2023 07:18:31 +0000
Message-Id: <20230315071831.3833948-1-harperchen1110@gmail.com>
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

variable var->pixclock can be set by user. In case it
equals to zero, divide by zero would occur in nvidiafb_set_par.

Similar crashes have happened in other fbdev drivers. There
is no check and modification on var->pixclock along the call
chain to nvidia_check_var and nvidiafb_set_par. We believe it
could also be triggered in driver nvidia from user site.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index e60a276b4855..ea4ba3dfb96b 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -764,6 +764,8 @@ static int nvidiafb_check_var(struct fb_var_screeninfo *var,
 	int pitch, err = 0;
 
 	NVTRACE_ENTER();
+	if (!var->pixclock)
+		return -EINVAL;
 
 	var->transp.offset = 0;
 	var->transp.length = 0;
-- 
2.25.1

