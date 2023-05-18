Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2017F707C47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjERIky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjERIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:40:48 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E9173F;
        Thu, 18 May 2023 01:40:47 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-25367154308so220423a91.1;
        Thu, 18 May 2023 01:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399247; x=1686991247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vw6xt/y7AkFMPkBEKOtYpyNZ0+8RMoG8PhpY+gjYbQY=;
        b=dlXpIdPn6Xoo+PhNh+4FNQo2SisOp+4ua6JE9Er3VE5xxRFjx2IEG3xPdfGpBtJz3E
         xARWlf3ceSzUn1Wvn9V9CbKJpplc5ynn6vJwLg+QmJ9ZGqwBx0J+HfgvcSQejbRDpTVF
         PuE7sN1dKV+TYZ17nYLjZyHS8qCQvITA71veDxQIscKdHPyCls160zU6UsS3lRH/TP0y
         iapO4Glupa9GXNZ+RqT17wKwTbk0n84pzNUzkViiabf2vIZAzcr8PcrDK+ayy8IAKi8w
         LHjOZaS8BrD34ue29FV05hQ6dEcdA4AYexgqFwJScT/fAG5rouQP0ASjUuKGaOXod4l2
         03vA==
X-Gm-Message-State: AC+VfDwahlTrvyc+NMs1VULVGKAzuMxE/47hzxu0VIt2a0ptZPa1a/zo
        VxYRY6q81k85jZ1PQx27On7ejm9Tcbd0bUQB
X-Google-Smtp-Source: ACHHUZ6vsmiXjXFwyKM5gSEb2mIhlorpplmKrEeHCicuDLzKL9PpRqXmtu4/cLEmy8KkytUqs1myJw==
X-Received: by 2002:a17:90a:1481:b0:24e:102e:edbf with SMTP id k1-20020a17090a148100b0024e102eedbfmr1660044pja.13.1684399246734;
        Thu, 18 May 2023 01:40:46 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090ad50600b0024dee5cbe29sm889946pju.27.2023.05.18.01.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 01:40:46 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH5b51a54ae2fa1cc8459b68a28b3c8ca7b7203994] PM / devfreq: mtk-cci: Fix variable deferencing before NULL check
Date:   Thu, 18 May 2023 01:40:33 -0700
Message-Id: <20230518084033.508711-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warning:
drivers/devfreq/mtk-cci-devfreq.c:135 mtk_ccifreq_target()
warn: variable dereferenced before check 'drv' (see line 130)

This is based on static analysis only. Compilation tested.

Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
 drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index e5458ada5197..6354622eda65 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -127,7 +127,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 			      u32 flags)
 {
 	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
-	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
+	struct clk *cci_pll;
 	struct dev_pm_opp *opp;
 	unsigned long opp_rate;
 	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
@@ -139,6 +139,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 		return 0;
 
 	inter_voltage = drv->inter_voltage;
+	cci_pll = clk_get_parent(drv->cci_clk);
 
 	opp_rate = *freq;
 	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
-- 
2.34.1

