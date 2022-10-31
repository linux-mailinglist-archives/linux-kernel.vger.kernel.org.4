Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFE613B55
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiJaQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiJaQcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:32:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211312761
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:32:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l5so13304818oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt/WR1Gmjk2D9GnfY1ZcaSEw9Q+GFqctU1oYIXCvdkk=;
        b=QUWIYopeB0UZaW/Dv5KZ2rxinkrGWUERLDC9wEH1krFqq/rXZu+Kj+MAQPmS/sHcq9
         WDgyMC7MgQBzSlm10f8WQ3MtxpthmTHe0DwIlueWPM1HQbPCtuz+mou7XsDwyL2P0Mnz
         D0jx9ZgP/J+OjSijEVyG6du7VE4eI6Gr97Pu8eIKUxw0p+aPhfMLAaAhV+NTXPsHEG9W
         SDYp2Hi7K+Oa6TVJyTP+vWDJ0nNH91JSgUWSNBhwrUrdGc4P/0oNEKeEZGvBFrxuL9YH
         lpzxS7wT/StIJImvUJZ2rfylv0C/yrd7X2ir7umu1HtCMtgWP2Q0fLevcAqTfg6J81va
         di+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt/WR1Gmjk2D9GnfY1ZcaSEw9Q+GFqctU1oYIXCvdkk=;
        b=X1xF3fR6s0IxCeW1Jz8Xldpd+FQitRCnjDtkVZle5vHcMTyGjQpP4Q/8SdRY77QEm/
         f7jt3YgrPUQE0v6qR3oPL4ZtPOYGRDCSblCQoYvNuAkXmsuco9Pb9yHkywNMpNWPACLy
         EXkNtvfnduiFx2re4JxPKxBEtbeJEbzTmPJQrm2EDxSgIcx8aTf//7OqxabdUpyyPKwl
         pD1wdDMM3ibA5cVZFHE94+nnMwAo9dyvpU+6FfF2ktYCPefe4FIFhROhBb2RsliNMh2o
         Y6mdboGZdMbm//jvPrFSe/5Pkk5ZpRgK2NrvjOA8B2lmsYnA7LjYGY68ieNFHdoCZ0j3
         afyg==
X-Gm-Message-State: ACrzQf0Ip9neEZiQjbMaJudq33gMTzzmVOZSu8vnlU23lvKMg4vcfpSB
        QoAfRtRjzQSSa1MGMjm9pPofNqhebEAvLDX9
X-Google-Smtp-Source: AMsMyM6vONEEf7VjwL5TUau766cjtN/1V1RvxWagUODwX7I/kWb2Ovz4ymQB4e25WrRPTws8zBMCpg==
X-Received: by 2002:a05:6808:171b:b0:34d:444a:fc1e with SMTP id bc27-20020a056808171b00b0034d444afc1emr15366187oib.85.1667233944276;
        Mon, 31 Oct 2022 09:32:24 -0700 (PDT)
Received: from antonio-Lenovo-Legion-5-15IMH05H.multilaserwifi.com.br ([45.163.246.1])
        by smtp.googlemail.com with ESMTPSA id x6-20020a05680801c600b00359ad661d3csm2477558oic.30.2022.10.31.09.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:32:23 -0700 (PDT)
From:   antoniospg <antoniospg100@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bagasdotme@gmail.com, sam@ravnborg.org,
        antoniospg <antoniospg100@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: Add support to control backlight using bl_power for nva3.
Date:   Mon, 31 Oct 2022 13:32:11 -0300
Message-Id: <20221031163211.13228-1-antoniospg100@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029184851.25340-1-antoniospg100@gmail.com>
References: <20221029184851.25340-1-antoniospg100@gmail.com>
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

Summary:

* Add support to turn on/off backlight when changing values in bl_power
  file. This is achieved by using function backlight_get_brightness()
  in nva3_set_intensity to get current brightness.

Test plan:

* Turn off:
echo 1 > /sys/class/backlight/nv_backlight/bl_power

* Turn on:
echo 0 > /sys/class/backlight/nv_backlight/bl_power

Signed-off-by: antoniospg <antoniospg100@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index a2141d3d9b1d..5c82f5189b79 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -263,7 +263,11 @@ nva3_set_intensity(struct backlight_device *bd)
 	u32 div, val;
 
 	div = nvif_rd32(device, NV50_PDISP_SOR_PWM_DIV(or));
-	val = (bd->props.brightness * div) / 100;
+
+	val = backlight_get_brightness(bd);
+	if (val)
+		val = (val * div) / 100;
+
 	if (div) {
 		nvif_wr32(device, NV50_PDISP_SOR_PWM_CTL(or),
 			  val |
-- 
2.25.1

