Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127170482B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjEPIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEPIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:50:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF5AD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:50:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61b71b7803bso65814066d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684227051; x=1686819051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p37xwemRmvnMXu7zqr8qUEOysKIfWHCVcW7gNj+l5QU=;
        b=UKvp3fhWeZx9ULyqR0fJ2b8IIphHErsKHgT3ekfjUzT0dPT/72zzWYnFQ7DbKuGzdZ
         AwQcq/xH+6cQyOV90IVQKIKAGSPlMtbAdE9Q7JhXQ75Ug3qMC1+6Sn2yGQYN8dr2JN38
         EES2HGoo7uwcV4yiFFKhTejy36iH8cDQMTw4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227051; x=1686819051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p37xwemRmvnMXu7zqr8qUEOysKIfWHCVcW7gNj+l5QU=;
        b=dc2B9tIhGr+/nnH7xd0W0fFyZuegtK0p1+Jy4QPtVIDxY8CQVPrfyhFc8J4GMsSw44
         k9nFPgRL3muGQQNKdZpBxaAemX65qii994nFxEK7SKtYywZcdnERnKBOk2fBW4umQfYZ
         23jBPb/ZGYKlpctFK14+wk5XpTRbs2Kj1Bk4PHWVsewcJ8Ct2p7Pgb5codWg/nIgSZhC
         Y1to3j53cWQZT5f8kS+NfVvhyJgWdiH2vuJbI0foJi5LuG8ek2Hrz/pRtAnYmlwj6357
         o1AQFNcYmdZKKGG+VIQOb2eC3lwPhB3xxaflRfCOZgIk8SIKuiFQ/MJps6VlQ5mIj6dh
         qKJw==
X-Gm-Message-State: AC+VfDzI2lpQmweX6plu6dytLUcnR+3A05mUcZ5E20MUpShz9lBuqFLE
        wyZ+LqCgOPbFTBfF8Qnni3MX/0y/Hhd/BmO1LlOSRg==
X-Google-Smtp-Source: ACHHUZ4HrFSbd8Ul5hJPPrcQADlTXsL1z1pUBhxD4DHWR3lIZfNg3Gc5XtR0neHQgTIONuEpRzL/OQ==
X-Received: by 2002:ad4:5bcc:0:b0:623:6b1a:c5f1 with SMTP id t12-20020ad45bcc000000b006236b1ac5f1mr6566466qvt.4.1684227050912;
        Tue, 16 May 2023 01:50:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-62-17.net.vodafone.it. [5.90.62.17])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf48b000000b005fe4a301350sm5497335qvm.48.2023.05.16.01.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:50:50 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H
Date:   Tue, 16 May 2023 10:50:39 +0200
Message-Id: <20230516085039.3797303-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous setting was related to the overall dimension and not to the
active display area.
In the "PHYSICAL SPECIFICATIONS" section, the datasheet shows the
following parameters:

 ----------------------------------------------------------
|       Item        |         Specifications        | unit |
 ----------------------------------------------------------
| Display area      | 98.7 (W) x 57.5 (H)           |  mm  |
 ----------------------------------------------------------
| Overall dimension | 105.5(W) x 67.2(H) x 4.96(D)  |  mm  |
 ----------------------------------------------------------

Fixes: 966fea78adf23 ("drm/panel: simple: Add support for Ampire AM-480272H3TMQW-T01H")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 065f378bba9d..d8efbcee9bc1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -759,8 +759,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
 	.num_modes = 1,
 	.bpc = 8,
 	.size = {
-		.width = 105,
-		.height = 67,
+		.width = 99,
+		.height = 58,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
-- 
2.32.0

