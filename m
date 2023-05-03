Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E956F5175
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjECH2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjECH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:27:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925DF468B;
        Wed,  3 May 2023 00:27:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-95678d891d6so971247566b.1;
        Wed, 03 May 2023 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683098860; x=1685690860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJwlvnk2QOdQ9AieHi7YHl4/Jlfed/PX+1LmVtBDjCk=;
        b=qpNz7E1+VFzfePkVMnoVHtoW/8IE7Quy0IjJVHeRuJEgGBJ2wZV6mKpbfWtxhRhnTB
         Pkt9Ja9tb4KNAEaZdsQuvv4RITeunowlxbR453JsaqzgkDX/+JvQeHI42uGslw9W2JdG
         NqNgrgtI81T9c25P1N9B7AD7vxUdlmp97Jc98Vn6lSeU0B9pCuY68hy/r6V96YlVyXvW
         07CLLoHkIYFO/xPmHX7jL5yKpyehTt5gDseiuvprl825NpcaOxPzgMitiH0G41Ejxwy7
         KByAC5zcQvxgGNOp5RaVsBD9PBhy83TJ1AtM7Sh7APR3F+isGHVqPvl+vc3LvMG5EQBh
         ZWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098860; x=1685690860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJwlvnk2QOdQ9AieHi7YHl4/Jlfed/PX+1LmVtBDjCk=;
        b=KVrzL+mHd7jPIK5/gHmt2dmixcTyKSmJsdVzPsZVsx7175SRzmssvKTg1WNgVvPspi
         fG9G/Gg5hMreqz1oUXayx+B/7CJ30Ny5sLakMH7/kK0rsLXG4J9lydlx3i+XeHMAED1g
         MRfJXQ+3bO5+BO99l9JtxtXsvaafegTJD2ojnvthQnJeECODoCB37NlOPV1TYs8Eq9kC
         hBimxdLv8zL7jEXVC3/0mH5Gk+cEyVoALVBh7m1qel4+M32ih8bTIeOIpvtG39W1/GDQ
         pr91iSbdcg6NL+ALDJ28RojwiQ7zp3KU6bt4eKlhmI7SV/1f5KAUTx7zCIGiB7Ufb40p
         y/ZA==
X-Gm-Message-State: AC+VfDzvyyx/8l8aLEG3hvF75nGNnYNCSrWTNasgGGCqQ+VwFrKKUL/S
        IdMEsOBsG6Pd4HyJuKg0Zfs=
X-Google-Smtp-Source: ACHHUZ4IAn1aq7b3Q3aab34HGPYRA0chyG0SMTfVUuMvdOIL9hRKBA9f3MSYZjTWldPVUSnpXA1Iiw==
X-Received: by 2002:a17:907:5c2:b0:961:b0:3dfd with SMTP id wg2-20020a17090705c200b0096100b03dfdmr2301653ejb.7.1683098859957;
        Wed, 03 May 2023 00:27:39 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709064f1a00b0094f34fe27c6sm17072009eju.170.2023.05.03.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:27:39 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: camss: Link CAMSS power domain
Date:   Wed,  3 May 2023 10:25:43 +0300
Message-Id: <20230503072543.4837-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503072543.4837-1-y.oudjana@protonmail.com>
References: <20230503072543.4837-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The CAMSS power domain was previously enabled implicitly when the VFE power domains
were enabled. Commit 46cc03175498 (media: camss: Split power domain management, 2022-07-04)
delayed enabling VFE power domains which in turn delayed enabling the CAMSS power domain.
This made CSIPHY fail to enable camss_top_ahb_clk which requires the CAMSS power domain to
be on:

[  199.097810] ------------[ cut here ]------------
[  199.097893] camss_top_ahb_clk status stuck at 'off'
[  199.097913] WARNING: CPU: 3 PID: 728 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x140/0x160
...
[  199.100064]  clk_branch_wait+0x140/0x160
[  199.100112]  clk_branch2_enable+0x30/0x40
[  199.100159]  clk_core_enable+0x6c/0xb0
[  199.100211]  clk_enable+0x2c/0x50
[  199.100257]  camss_enable_clocks+0x94/0xe0 [qcom_camss]
[  199.100342]  csiphy_set_power+0x154/0x2a0 [qcom_camss]
...
[  199.101594] ---[ end trace 0000000000000000 ]---

Link the CAMSS power domain in camss_configure_pd to make sure it gets enabled before
CSIPHY tries to enable clocks.

Fixes: 02afa816dbbf (media: camss: Add basic runtime PM support, 2018-07-25)
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/media/platform/qcom/camss/camss.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 1ef26aea3eae..9aea8220d923 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1453,6 +1453,7 @@ static const struct media_device_ops camss_media_ops = {
 static int camss_configure_pd(struct camss *camss)
 {
 	struct device *dev = camss->dev;
+	int camss_pd_index;
 	int i;
 	int ret;
 
@@ -1496,7 +1497,13 @@ static int camss_configure_pd(struct camss *camss)
 		}
 	}
 
-	if (i > camss->vfe_num) {
+	/* Link CAMSS power domain if available */
+	camss_pd_index = device_property_match_string(camss->dev, "power-domain-names", "camss");
+	if (camss_pd_index >= 0)
+		device_link_add(camss->dev, camss->genpd[camss_pd_index], DL_FLAG_STATELESS |
+				DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+
+	if (i > camss->vfe_num && i != camss_pd_index) {
 		camss->genpd_link[i - 1] = device_link_add(camss->dev, camss->genpd[i - 1],
 							   DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
 							   DL_FLAG_RPM_ACTIVE);
-- 
2.40.0

