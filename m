Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114FF6CF570
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC2VeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2VeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:34:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E0211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:34:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ja10so16211365plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680125658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOb7eusGoyCsIY8TRKGnriowi5aeN1Nk7y1wihTuN6M=;
        b=k+tjjX1yjhoI93NC1zbWZZC27Y6Vj6wFuNBR5aL1mF+1gaDiHOKcd8hjNlxbCgmq0W
         WjUERZ08sgn5AXWcwYtn5BOTIPwX4MAD6bRLYOMnRL3U0J1Wo4hisDtykXT+z5emRsCA
         zfXRewvbEfjp8Bu2M+64dFH+PH+DCcU2h6raY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680125658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOb7eusGoyCsIY8TRKGnriowi5aeN1Nk7y1wihTuN6M=;
        b=CQvRKbnoAMdtXdXTZ22vc/nubfsBDCGVFaMYiGTa6kpp7OcnF8z0aMTIdx+yHgYY08
         7zFGiMKBDx05X+sq2x7wGUwgB/VDOd+m7i19EaBLtZFaOL4OX8astvIisN0x/yEqJVQ5
         oyHoWGeyXxjWJ1gLCHh53lB1sWhkMPf0Dt/C/p7Kcxb+0q7ZHsOy4Y/e9zZjJdCjLMgQ
         8Fl1vyztXtpKz9U0snbiqYT1j+vYITabtXSjdxF+lTcJb+xQGmW/V157MMGXSbBHXB5k
         EGJAyD2uoKkxPg1Knr3531y/SklVvq8MZJZW6F6mcJn86nh5SQkQ3H986/KnDR6mIfYf
         auTA==
X-Gm-Message-State: AAQBX9eM0uFEKgy9uvd8qiJSRT+VPHxO9VfGSfyg6/dek3RcFJad3QvT
        pDRHyEnDcTEEGLWRYGAlzpoBPQ==
X-Google-Smtp-Source: AKy350ZL7l7KKDQJ7lCdzsU69xcHmDWBrytHsZywWtxsaaj999k/o5IT+qlH8Mn1hv8AwjgqlpyUrw==
X-Received: by 2002:a17:902:f98c:b0:19d:553:745c with SMTP id ky12-20020a170902f98c00b0019d0553745cmr2812582plb.9.1680125657909;
        Wed, 29 Mar 2023 14:34:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f65f:8d37:f3f6:f4d3])
        by smtp.gmail.com with ESMTPSA id bc9-20020a170902930900b001a20b31a23fsm11705966plb.293.2023.03.29.14.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:34:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
Date:   Wed, 29 Mar 2023 14:33:53 -0700
Message-Id: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a codepath locks a rdev using ww_mutex_lock_slow() directly then
that codepath is responsible for incrementing the "ref_cnt" and also
setting the "mutex_owner" to "current".

The regulator core consistently got that right for "ref_cnt" but
didn't always get it right for "mutex_owner". Let's fix this.

It's unlikely that this truly matters because the "mutex_owner" is
only needed if we're going to do subsequent locking of the same
rdev. However, even though it's not truly needed it seems less
surprising if we consistently set "mutex_owner" properly.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- "Consistently set mutex_owner when using ww_mutex_lock_slow()" new for v2.

 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1490eb40c973..9a13240f3084 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -334,6 +334,7 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_lock_recursive(rdev,
@@ -6048,6 +6049,7 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_summary_lock_all(ww_ctx,
-- 
2.40.0.348.gf938b09366-goog

