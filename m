Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A57176ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjEaGfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjEaGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:35:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3449125
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:35:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af713338ccso2267211a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685514940; x=1688106940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEwCfTaICvYvCwQRPGK1g4zyztT+iiOIX15/8C0y2cc=;
        b=PuIbwlKaUGt9MSo2eWXDmtINbwnWoPk+SXdAsF5fKni3qVC7byx8t036vE/O7cKTOo
         Rys+j9bafeFY3XdNeAnNbXXOICeOd7OOBoCryHJzpL5RcJSd1i4MJ8aY4e22e3eA2r1v
         UjJZXafKix/LQs2iuVCFBB5xIjflONwWQorT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685514940; x=1688106940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEwCfTaICvYvCwQRPGK1g4zyztT+iiOIX15/8C0y2cc=;
        b=Hp5QU0ZKEq7GsehChmi0x8XN/GHTUKwQClehI/EU4UnT19W5NEbjBHzt1eQQGmTOpI
         zUOq1pDjNL+xmjR4/L5TReZXVs9OEdmvPJLg3e1NNuMVJSIOiuKAFsO2IoH7iYhD1nYg
         8QiYNrvVVOUiWNZ4D0fE8bb3XPVzgL2riSxr0O5MrsXvlnoyvQdWd/5I9NJZ8AzQHTbP
         476UOvv48c+dt9hOgHiyCesnIR2PIMQjoLxjxNjkejAxAdMVkln41Dw3CMFLnBmtKKvH
         xpcPZ4xikH2NA61d1NpM+P4kg/5l8uCSz3lSthbw+msqxWEJc6iAP4XtnNg/ea40R85b
         EVoA==
X-Gm-Message-State: AC+VfDwtwXhe/kgCD1DPVbXnZfQ5tagHTxh4G4GFtvUPQUw3jNLzwEfB
        5hd5nCLv3ThxHI3zQnxhVGaQC1uodWLKhZTAjrQ=
X-Google-Smtp-Source: ACHHUZ4quZpuYe7FI5h99AuDIMN0SwFckVXd0u92B8fxRkbiGlGOHNgDRF5LdN1wZA7gprk0Iz5naw==
X-Received: by 2002:a9d:7546:0:b0:6af:9738:3483 with SMTP id b6-20020a9d7546000000b006af97383483mr1195796otl.29.1685514940024;
        Tue, 30 May 2023 23:35:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3052:fa:c737:8f43])
        by smtp.gmail.com with ESMTPSA id j12-20020a62b60c000000b0064cb0845c77sm2581010pff.122.2023.05.30.23.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 23:35:39 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: mediatek: SVS: Fix MT8192 GPU node name
Date:   Wed, 31 May 2023 14:35:30 +0800
Message-ID: <20230531063532.2240038-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree node names should be generic. The planned device node name
for the GPU, according to the bindings and posted DT changes, is "gpu",
not "mali".

Fix the GPU node name in the SVS driver to follow.

Fixes: 0bbb09b2af9d ("soc: mediatek: SVS: add mt8192 SVS GPU driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-svs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 81585733c8a9..3a2f97cd5272 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2061,9 +2061,9 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 		svsb = &svsp->banks[idx];
 
 		if (svsb->type == SVSB_HIGH)
-			svsb->opp_dev = svs_add_device_link(svsp, "mali");
+			svsb->opp_dev = svs_add_device_link(svsp, "gpu");
 		else if (svsb->type == SVSB_LOW)
-			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
+			svsb->opp_dev = svs_get_subsys_device(svsp, "gpu");
 
 		if (IS_ERR(svsb->opp_dev))
 			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
-- 
2.41.0.rc0.172.g3f132b7071-goog

