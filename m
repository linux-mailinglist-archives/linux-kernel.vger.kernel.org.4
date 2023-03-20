Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348636C1568
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjCTOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCTOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:46:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C980B763;
        Mon, 20 Mar 2023 07:45:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so16746144pjt.2;
        Mon, 20 Mar 2023 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfAHpBWoMxTHMa2AnmzhjkXruv6iv5Hi+uoFH6JuoB0=;
        b=dvZaXVTGYKr1InrytzOA1sJ4NQK/BXq3NKHKzdudDkqaq0XSBSXf9z3k/Luykto2iP
         c+ZneJL4VSdLkTAQNEKxqGKTXzz+oLy7ySCL//+bGiDqqS8Kos40r9xWpaOKAqeVAX1I
         8ud9G7quF6etshvv3cC+Cfw4AzbUl/5lJl5hQSMV5zMZN1hbdM58wMEWfU4eTlKS0D+h
         8Km10S+bHJjWVXYJC7OKKLW+B6GYh+XLF9XGIOetq1OYyvj5k7FAok2JG+bMRN1OYN8H
         qUwQuvMHK6z5XutxhtjFHU09oWcsffFuyKjkKHs5HxjpqzlLs1cvryGa/JrKx16Z+bb/
         eArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfAHpBWoMxTHMa2AnmzhjkXruv6iv5Hi+uoFH6JuoB0=;
        b=XnmPL5XTe1//zrDlUU4S2MPP1SDN/vVFqhA4pu4MyQi9HWggeyEN60cUNZW/wWwQp7
         WcDs6p2KNRFpbnnm1LeQBj1bLmVa3/4fYhxcYdXqPbQ2SEnrftK3pYQMouWPHOz1/Dp5
         19txSRBXPI1v5PgpeXNkthgkJLdTIDuacSG6Oput7ybzfPBDDGGM6KiTEth8CtYaiFh8
         5YZWSE2HLqA4JRdR3x+gmKKA/LFCmWY67ubM7ymJtwULpq7VzRLeeqgWz7geiKOcKcFa
         CZAHeKZ/k/9w7/9/NotHqk6pCjiYDqwOgl2oMMc40GtXDQN9onRfJmCNDlNFnn3xa69j
         WGTA==
X-Gm-Message-State: AO0yUKW5V0N4AdMn32iNAjPhiiFqXKNhXC26dJBCbrHKqaGkocLMxexw
        1EP8G+qev7mqLiGlAR8E5fI=
X-Google-Smtp-Source: AK7set/kgpnfgYQ39cq6tSqCbmQJlYOTfrb5Xz1qqT6kTEByPM9h/PbOYeIY23ga+5pEL0JwAhoBsw==
X-Received: by 2002:a17:902:f9cf:b0:19c:dedd:2ace with SMTP id kz15-20020a170902f9cf00b0019cdedd2acemr15267590plb.18.1679323512781;
        Mon, 20 Mar 2023 07:45:12 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id jc7-20020a17090325c700b001a0667822c8sm6818324plb.94.2023.03.20.07.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:45:12 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 20/23] soc: qcom: smd-rpm: Use GFP_ATOMIC in write path
Date:   Mon, 20 Mar 2023 07:43:42 -0700
Message-Id: <20230320144356.803762-21-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320144356.803762-1-robdclark@gmail.com>
References: <20230320144356.803762-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Preparing for better lockdep annotations for things that happen in runpm
suspend/resume path vs shrinker/reclaim in the following patches, we
need to avoid allocations that can trigger reclaim in the icc_set_bw()
path.  In the RPMh case, rpmh_write_batch() already uses GFP_ATOMIC, so
it should be reasonable to use in the smd-rpm case as well.

Alternatively, 256bytes is small enough for a function that isn't called
recursively to allocate on-stack.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/soc/qcom/smd-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 7e3b6a7ea34c..478da981d9fb 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -113,7 +113,7 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 	if (WARN_ON(size >= 256))
 		return -EINVAL;
 
-	pkt = kmalloc(size, GFP_KERNEL);
+	pkt = kmalloc(size, GFP_ATOMIC);
 	if (!pkt)
 		return -ENOMEM;
 
-- 
2.39.2

