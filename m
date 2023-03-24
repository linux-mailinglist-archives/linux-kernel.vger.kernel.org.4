Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792266C78E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:34:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B96640C0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:34:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so4285256pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCuUQNVkkfD2ZPnOF587mW3XsARVZtximMlGLvwHOxo=;
        b=oVpq6RhJr2s0S9DQD3buIKYI1LGRwDwGLmm55a4+Dc6subYya2Oywblx+ebe3Wj/Bs
         nSHIQ39bpdx9GsJvW6iq9hTjHO/rHdV8ZlQpAhJ3eKl2yHT583D/1skJVMDKYwHF27Gx
         rzA60odIMXvYC/efcBdh5eUdDm5h3B7C+kzP5AMQx6hBmVkYLw+vPR5X0WPFjop1Md3p
         cvRPWxZgjF0GKVWX4UQ2Os4vAoZga7Ri9LhqEM+QCfXnXNZV/F9OQcMbISWy3W+rlQGK
         rT1HJGQCzfWxFsYcUlz8uTpQmAOxW/OH1cdWoYIBCWv9O0NVQp36Q6lZV2otYTCejxMd
         nieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCuUQNVkkfD2ZPnOF587mW3XsARVZtximMlGLvwHOxo=;
        b=v7jYjEqA5G+k1iJi8CVWNZf4Cj730BEjmPEbxbZ1pK5LJTB+HnWL2pMOUkYfACapxN
         B8gnLermZ6Oe3OrvXv235UVuWNt+mp+6gzjTAQg/fOP2l6E6jcR8cPAq6GD+0/Ym87dL
         xh18diEmdTQmYzC2M5w+rmFXJ4wv2N9t7A+YRW9mYZDkUw04IUu+Nv0e4Ydqc4/PLc6/
         SDQeQfTdC1r1gL6qF81FtlDU/J7OF1Yw7pDzZTeN+7g/EplKOb9evT/fV0ggJ7FcglQh
         hJG1rN32HIkzEexqXfCpecW/SkhSz6YVmgpOe2ML4ldnSTu+7p1orWX458vxtoVCopAz
         z86Q==
X-Gm-Message-State: AAQBX9eXoHp4EE/pyJUn/K/C/COyFn2GHNUScdvW1+vociyM7o6+r3ar
        6PTO2kqJ+q2zMuZBlyqB5k8=
X-Google-Smtp-Source: AKy350Y/HHioS9DnMn2ppRJJ2qm9D8YHrwBl/5qZydmOURfSPB4rXN6nY4wARgBZ8PsqDCngFlx4gA==
X-Received: by 2002:a17:903:124d:b0:19f:3aff:dcfd with SMTP id u13-20020a170903124d00b0019f3affdcfdmr8704345plh.6.1679643260081;
        Fri, 24 Mar 2023 00:34:20 -0700 (PDT)
Received: from ubuntu.localdomain ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019a75ea08e5sm13511604plp.33.2023.03.24.00.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:34:19 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2 3/3] Staging: greybus: Use inline function for pwm_chip_to_gb_pwm_chip
Date:   Fri, 24 Mar 2023 00:30:03 -0700
Message-Id: <a7d0f315478af0596d1b6b97b8722a753dd39666.1679642024.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679642024.git.sumitraartsy@gmail.com>
References: <cover.1679642024.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
v2: Change patch subject, noted by Alison Schofield 
<alison.schofield@intel.com>

 drivers/staging/greybus/pwm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 3fda172239d2..88da1d796f13 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -21,9 +21,11 @@ struct gb_pwm_chip {
 	struct pwm_chip		chip;
 	struct pwm_chip		*pwm;
 };
-#define pwm_chip_to_gb_pwm_chip(chip) \
-	container_of(chip, struct gb_pwm_chip, chip)
 
+static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct gb_pwm_chip, chip);
+}
 
 static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
 {
-- 
2.25.1

