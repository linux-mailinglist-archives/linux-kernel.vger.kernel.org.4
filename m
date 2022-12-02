Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43164062F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiLBLxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiLBLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547F2A961
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:52:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s5so6104952edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbApf1anPXhkyL1eMhU3x4CauZkX++vBii8PykYLja0=;
        b=Zaz1ET+G1SWchZ+VgoJoMcRplKphEziazSa2ThOiA/jFoSYOSbYC/0JWmbk7indYGE
         ZNKMyOgAmUOqNDEv9TUk/yPiJfFZkIKOcnLiuk7lFX+eXBoL6pMBgUrEf3KpCCqeJ/qo
         5exqrQ1zKJlL05VIAa7DhkMb1bOyy9MePplKkiSQQh12oUA/OthYWtBMqG8Y/Fm2BMyi
         WlMKCLlUyCo+9gj9XV4nNWp1GoeRH4V3xkcy4dssda4Ap2EKC4gQoaH6o6deopLDVDPl
         2YjPZ0RBftgHbuCkasZZbFvPihe9aeRTPIU1M+nLd/Ccoj7JLw1YSDnIs/jDREcL/5yG
         siUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbApf1anPXhkyL1eMhU3x4CauZkX++vBii8PykYLja0=;
        b=Yv9q1AxZLP9s3ai8THmy5NhkaLU98+A2u/kjbQ2aCZMb3CfGOU6tJZ7O1FmX+rDGKL
         aJTfs84MrnLpczAMH8bFpiVQQ+ndET4chkNRL0aiw8FudUQzPoogWVKLIOv/p8oSv53W
         4fLoJoW94kBUbJzGy0tg7R0h0qiyH7722sZbXM+bbU4sjRyHWfLcw2B9B5O146EiDBPu
         9Z8Ycz2/mTOCtUbILsnLMP33OzgkAB+mKwTOJd19o0PmU+0rbaBOl1nLmDyLRJNAFhCg
         qLkgHpoJj87sG7FiIAcmteuTKu726VTx0fXwGqPzZLx0HIssf3rWN94C7JRI3mtsom8A
         hTvw==
X-Gm-Message-State: ANoB5pmV2tHasZySYDVg/REuDJf/6kCYlWkbktTLkiEOFmMtj6OHq7ez
        8Vh6F89NB+3DwOGyc39xjm8=
X-Google-Smtp-Source: AA0mqf5u8WJUjMkgmdOQWN0p+3lPuMNPUEsyeQq7hpK3juNAdPo9O2CUMmzQw/QKtlOmoJlwzM+H5w==
X-Received: by 2002:a05:6402:2404:b0:467:67e1:ca61 with SMTP id t4-20020a056402240400b0046767e1ca61mr12816866eda.27.1669981963506;
        Fri, 02 Dec 2022 03:52:43 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:43 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 6/8] drm/etnaviv: Warn when probing on NPUs
Date:   Fri,  2 Dec 2022 12:52:18 +0100
Message-Id: <20221202115223.39051-7-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace is still not making full use of the hardware, so we don't know
yet if changes to the UAPI won't be needed. Warn about it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37018bc55810..3cbc82bbf8d4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -765,6 +765,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 		goto fail;
 	}
 
+	if (gpu->identity.nn_core_count > 0)
+		dev_warn(gpu->dev, "etnaviv has been instantiated on a NPU, "
+                                   "for which the UAPI is still experimental\n");
+
 	/* Exclude VG cores with FE2.0 */
 	if (gpu->identity.features & chipFeatures_PIPE_VG &&
 	    gpu->identity.features & chipFeatures_FE20) {
-- 
2.38.1

