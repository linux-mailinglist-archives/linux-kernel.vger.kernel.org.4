Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D8727C54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjFHKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjFHKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:07:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC6D273E;
        Thu,  8 Jun 2023 03:07:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30ae4ec1ac7so278766f8f.2;
        Thu, 08 Jun 2023 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686218844; x=1688810844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9pgMIbtNGvt+dZacrjStBRF6ycRamKEcgmVWNACzbk=;
        b=B6VsdJXuVBxjoRidl/rWXx6lyaYIQFvp6tWrCs2klKJkfmNI5IfqRB3FYJE9QNs7XZ
         VQPgYaeyFzIYXB5Qpd/UPFXCdx1Tt4cK2F0Yg+wx1WstWHbLwafT2d40KyEmd2oKkwYA
         3bxFngz+IU0+Thmfq3uXmK/BY/AWKCJVbkrTotOodhq24zTiVThPtuYwc9t6S6rKfFp2
         pF+8vUbFK+BP92TFQDj+8Rjr/GiO0xtV0yygankwhNC7hAIMpLN9emUgK+APb6Lc1MuH
         CLfmfwi9lWlB/u3pQfxTOqJCt4IWpB/1eObhNw/6SceyHfK9l0c0S+97IU3Yahb7pTwG
         gfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218844; x=1688810844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9pgMIbtNGvt+dZacrjStBRF6ycRamKEcgmVWNACzbk=;
        b=Jj04nFgGDCBviBxFU9W35zkXYJ666m08kEBLB+yf5303ylULmZiOhBoW38OFn/uVRq
         s66VvICW/xiWE+vna69GQAVOF7Msade06AxS88HtRZsVD9AFBhCuFnIQmUPpyaCFIDXZ
         eafahGnynPho95D4MkmjzfD2NpuiBwlxhNDHNiRxw9F64SxWKgdFwGWsXdrpmNvIaTvo
         HcSX0gVqB/aStrtpfmndOquD2Uu32FCzvoRNtoEKCEapjHSTrmXZy6scXD6QOSndcMWz
         c7da6EIvTH60H4YxOKdm3E05uCugQdcxvRw5hANcpT4aeOdeP6EIHfptd5hKsOovWIXb
         p7uA==
X-Gm-Message-State: AC+VfDwBH2X9JbzWjWzDz6R60y7yMzBOW7NbCVxAie6kOxy8xjU8QrGa
        MhE8cQod1SXjtizZhPHuj/7K3BuKpR6dww==
X-Google-Smtp-Source: ACHHUZ5UbkzYfeP23mP06MNOclTBsL8+JGEjJfF81Bk0/Obd6/6ehp942TML9tFOWhsksM+sPC42jA==
X-Received: by 2002:adf:ee8e:0:b0:30e:3da5:46e5 with SMTP id b14-20020adfee8e000000b0030e3da546e5mr7274154wro.59.1686218843798;
        Thu, 08 Jun 2023 03:07:23 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002ca864b807csm1141756wro.0.2023.06.08.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:07:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/mtl: Fix spelling mistake "initate" -> "initiate"
Date:   Thu,  8 Jun 2023 11:07:22 +0100
Message-Id: <20230608100722.1148771-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a drm_dbg_kms message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_pmdemand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_pmdemand.c b/drivers/gpu/drm/i915/display/intel_pmdemand.c
index f7608d363634..f59e1e962e3d 100644
--- a/drivers/gpu/drm/i915/display/intel_pmdemand.c
+++ b/drivers/gpu/drm/i915/display/intel_pmdemand.c
@@ -555,7 +555,7 @@ intel_pmdemand_program_params(struct drm_i915_private *i915,
 		goto unlock;
 
 	drm_dbg_kms(&i915->drm,
-		    "initate pmdemand request values: (0x%x 0x%x)\n",
+		    "initiate pmdemand request values: (0x%x 0x%x)\n",
 		    mod_reg1, mod_reg2);
 
 	intel_de_rmw(i915, XELPDP_INITIATE_PMDEMAND_REQUEST(1), 0,
-- 
2.30.2

