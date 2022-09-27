Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829165EB761
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiI0CKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiI0CK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:10:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211058323E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:10:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 129so6720315pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RqV1Hbuu6wcO4ooNHmBZaaI6MHnaZ7i2cKw6jALZgyE=;
        b=5TLvVYrNxjEB05HrB7sPM+a6/ItoGDgMafZRzE7yY64ZNdiOLnJd8N/OvVLP3lEXQj
         uI7USCTYbd9NumN78GffTp2U4jBde15Fl1HsxlBlFm4F1eEgb0Mc6D9Xq0Xt88CffsGU
         4+/MMd70MltsuXRU7vpSLjqbEdxE8wCpp2d0DAlSFAVJvCeUl2Io8l99zN/vOnovxuGH
         qbevKibqrYxQ/e3naB2qYwMcNPZeD3rJKtGl49ISGsCjnFQdzwpPjTV6LQvFvgfkesQA
         Fx/8qmL2kMBjuoqP4vXH4ygMBK3nalgRPulFsseC+/brSuIxOVNDyaQUEPd7FcjrOJgL
         6sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RqV1Hbuu6wcO4ooNHmBZaaI6MHnaZ7i2cKw6jALZgyE=;
        b=UJFH3xuSwfiOetQODVUvqN15XOh/XJTVrsPIlcac8/DlY9boT+drDso7+tkNy21EZK
         RDsJGNqQlcZQGiE/POGyhL+OT7BDaaCTh1rdCOUDiUSJCX0xarHxSx0ikQjv8GqYMq2Q
         NahBXfnJROhgsG6Nm57mxC+SJkVzDHkh3W/kYCd9LeJ85EJJBDqAhQXjcWICzAj/WckR
         etBmP4+jO9lrazeACNvpD9f46IGl+WEeIizqfC+dU/0k1YSXZJmSTC0tkYZJQa61BPD+
         Q6f2No1lwDAZCaA/JMvYkqPS55PbfJO1XmgqORlNniKWwppkg13ZIs/GG9WUo0d5Yyh6
         xLDA==
X-Gm-Message-State: ACrzQf0q4Nm29nksRbEUmkFKGSjDMW2p/fAg7HkXZDaXgj10napxKeHh
        9+V6hOZZp18wGgorK1DGZP7d3w==
X-Google-Smtp-Source: AMsMyM4RgktzAMpVRb2H8xPwvR3a84o5pWKh2GpH6QJ/iUQL1gyJM4vwz4eBFquvfgJRhFuF6iGVhA==
X-Received: by 2002:aa7:888f:0:b0:544:7429:b07c with SMTP id z15-20020aa7888f000000b005447429b07cmr26565917pfe.15.1664244626670;
        Mon, 26 Sep 2022 19:10:26 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id 185-20020a6205c2000000b0053e5ebafd5csm196748pff.189.2022.09.26.19.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:10:26 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Fix delays for INX N116BCN-EA1 (HW: C4)
Date:   Tue, 27 Sep 2022 10:10:21 +0800
Message-Id: <20220927021021.488295-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel has the same delay timing as N116BCA-EA1. So, fix the
delay timing from delay_200_500_p2e80 to delay_200_500_e80_d50.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 102ab9f5d40a..3e502d318de3 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1892,7 +1892,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
-	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_p2e80, "N116BCN-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_e80_d50, "N116BCN-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_p2e80, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
-- 
2.25.1

