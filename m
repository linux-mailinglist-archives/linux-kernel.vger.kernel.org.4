Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B446E63EC58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLAJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLAJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088886594
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:22:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id b2so2707012eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbApf1anPXhkyL1eMhU3x4CauZkX++vBii8PykYLja0=;
        b=QZsc+anXmpwu6POr+6D9Nn9OjPEpMot3211JfomV93JEayXGnUjwqnbnYsuH2EqZ8J
         3QXZCMWe/ss5ahcWqWboFLZL3vqDH7B6puPa4VC80uGyOA+XWxAZSpNvpk3nBom9288C
         +MXcRRHO4kjisktIB490p1q2A9l115vmJMhbwvAeG7wihz8OmuT0nllQW/QTj4LEF9jH
         IclppEXhs/6UYUPsFSzxNyc5NapjHKT2wg9uAk0fqwtaicRwaXL6M8pXSWYpWnukA9au
         4O0yxq1pVanNzhwssbcok9cAVk1PkfZXjBxWXXqq+6AoALKAocWg/5c180e2YCREbuO7
         8UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbApf1anPXhkyL1eMhU3x4CauZkX++vBii8PykYLja0=;
        b=s2yHNUyuwdXiD7HVeGHNFyc6+6rkUdyCNuOc+w7lAew4CVwWBxGaROCdqjO+fPpLUP
         ziL8CyOzTGsFbIpCyicy0jjNN8INBbc7sUWs/76b58Vtzr4EHix8dI8EN7yQ9Yk+aa99
         dpg4Z3mKEhxcnZu8ByOo4KvbmAfcMpzxLJXERu5xfTse/KCZdyLK2DqNnq49hlt+LDrx
         NpnAVN2PnSqCvjNKdkQCtv1Y2n0NoFRqLnz36Cu8VjmAPz931jslk5Nm/kKqFomaTXDd
         LSC6CbLpT/w2hywDytFoXB+hWSh4lvzWWM50Myr2zcCoVXwSA/SUVOiqdbm5Tzu9yUs2
         dFtw==
X-Gm-Message-State: ANoB5pndFdzZHeGyz9oVG4PzaAJSJXiIfCjTXc5S8nbg7jKQY7jvV0D7
        qndcXrffIZT6Sy9FaloGiyQ=
X-Google-Smtp-Source: AA0mqf63rBMYzHT+zaT6/ZqAZm1tCS3bBM8sYXQ79N+62wzUyKjm+3MLrgRd+/tgyNUfskRVnPOAVA==
X-Received: by 2002:a17:907:76e2:b0:7bd:f424:b1da with SMTP id kg2-20020a17090776e200b007bdf424b1damr20991045ejc.306.1669886528176;
        Thu, 01 Dec 2022 01:22:08 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:22:07 -0800 (PST)
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
Subject: [PATCH v4 7/7] drm/etnaviv: Warn when probing on NPUs
Date:   Thu,  1 Dec 2022 10:21:28 +0100
Message-Id: <20221201092131.62867-8-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
References: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
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

