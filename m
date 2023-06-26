Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872FF73D9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFZI3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:29:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFEDA;
        Mon, 26 Jun 2023 01:29:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa23c3e618so44047605e9.0;
        Mon, 26 Jun 2023 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687768155; x=1690360155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfxAu6sW5+q7WfzXLeH1/VjEmYM6LrxvH/FzoskmAzQ=;
        b=o+Nplp0WDmZyHFlCdALUokQhCZyn4cHkrDBC4N5dkwytAvWfq3hHP7zo7+K89pZPmX
         6fBp26uue0TIf6Dmm7LLzadBd1m6JFy8UBZr42lzbmvC1RRtzYEU4t6Uu7Q3iSV/edMo
         /Z6Zw7X2o16yPqI8r8Zf8BpxBXdrL1kLqKXj1O0dRLGsE7VLXvbRRMeUhlqekBF2hsYr
         82HxRtA1jDtMyTr42dDVtShKfbpbRFepYv2CN15mw49//Ukg6186q2f8VpgwwuMKHX1o
         cNDZ44W+Zb5muGOlfcTvNijTMbo3Nvfu4RfCSJ9db+OX59miZ47j6j7PfSBTFRMJAFIn
         CvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687768155; x=1690360155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfxAu6sW5+q7WfzXLeH1/VjEmYM6LrxvH/FzoskmAzQ=;
        b=a/xqIhLaqy/U9W30ix55b3mpvSC+aADSGlig0sgxMkyKgz6CjwJG2/xKy0NtSIqAd0
         28AtXi02/zl2vBFPBp9ClDqaMskoZNbrX0e+tKUwNu+pps+tn98iAxIpCmBv8T5YvlTs
         M2EZf5yPeyV/oPDp0KhZKW1CmUxDLdK+eFreHG/rZhy7dYFbaOCqk2cWrXAb4FugmY/3
         QCHe3/2MBIsDr8L7fh/T2cso42uKwSUQ2fQ9bD0wKYPpG/9fbU7IUlQ2Ov1u5SlvIaER
         GtTFePYcHM7OfWUSBAw6FiKk4WIyjv63z1ZEpwR/g4cY0qU/TCYFqSZPnkFYVVa3HKYm
         QILg==
X-Gm-Message-State: AC+VfDwcViHLIGHcduiYc0jpGO250PQGa+CFEVCzIpcarniDFYzvw/d4
        EK9rIAk6UmD5l6azvw7NBHQ=
X-Google-Smtp-Source: ACHHUZ7AR1J5W6NerK45Q0I6VwTfH0YXK4Ltix6kj7QS9wNQa4hFWKq1sMSHkujMGbfcV99bS7h4xg==
X-Received: by 2002:a7b:cc8d:0:b0:3fa:9890:8016 with SMTP id p13-20020a7bcc8d000000b003fa98908016mr1053413wma.2.1687768154860;
        Mon, 26 Jun 2023 01:29:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bca4e000000b003fa786b5195sm6896249wml.42.2023.06.26.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:29:14 -0700 (PDT)
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
Date:   Mon, 26 Jun 2023 09:29:13 +0100
Message-Id: <20230626082913.53089-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
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
2.39.2

