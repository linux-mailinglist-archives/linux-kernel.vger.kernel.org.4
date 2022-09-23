Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49BD5E7382
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIWFvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:51:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92311ED5C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:51:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so4660746pja.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jLkty/bBGe2PBxsiiWA4/CqKAsHGTrzTrzwycR1vG3c=;
        b=PRSd5EA2QV4KM5pY+1E0N6c1EXnQ8LeQtK0HM0X4cBDy6NqNwiGsuU89rUsVGQx8P0
         Hx6OB+fyeK2u5Ww7Ky6qKVKq5qs7n3FGAYt0B9wBY+22o/mkRgIVmujDR5o4ZWkFGcAK
         6hv+Hz6X7XS0WnomYpX86aMYst93qvp+pa7NaJJH01Xsen3HWs16912oJHWjByjJvCOy
         vUCf7p3KUP1P5z74zYPKhgXGIVVbyFuPkAoH9FnI9W6lhmWFlQQY4xxQFjy8Ywzcne2H
         z8whlnlZl1k5cL99btSWvMq9CMzUxdOGkf02gkxhuK/f0fO1eTQyQzYt1991wMppFzLB
         3wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jLkty/bBGe2PBxsiiWA4/CqKAsHGTrzTrzwycR1vG3c=;
        b=YJ1m+gBtm3YQurePfArByT5/1HlHUwBeWUXi4urqchRaFhsv3KotlAvxwgHC8P4Q6F
         7ElB2VlDTimm3EWUIXeyEetsFhaAwrAlV5JyRdbS9veHRhRIB0BcGNNTVSSb9+rN/OH4
         6VxhdMXNFSuX91AzQmcuNfzQ0pPSK2bPwGyAD+kf5bA/8/ZMprQiI72CdgnP6U3FKdqt
         6nFm5hnZkK4RsCQ/z0S/UaoYApxkmai1NnoYt23I0WXoUEe7xFwSRyGUZYehiyUO4oZS
         k/tPLcIwZtmJnuoEhmPLYKlvJC3JbGLhjFvka+dAQhRFmsYjimgPlojXUDr05w7tYKtQ
         d5vQ==
X-Gm-Message-State: ACrzQf3d5NuT0j6WQoNmjuFVdoWFO1LJ9coIJKDdEEAI756zZtnDxJTQ
        Djw9TiuUv450ejN20Szn0lZQdQ==
X-Google-Smtp-Source: AMsMyM4insN+oo7qq3Dd+6GtbqAWoNwyzn01N95Pcn+8JIxbmexXLXVeVuJQstL9XcvvaC/z/cM/Sg==
X-Received: by 2002:a17:90b:1e45:b0:202:fbc9:3df1 with SMTP id pi5-20020a17090b1e4500b00202fbc93df1mr19824389pjb.72.1663912298361;
        Thu, 22 Sep 2022 22:51:38 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id 7-20020a620407000000b0053640880313sm5399908pfe.46.2022.09.22.22.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 22:51:37 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add AUO B116XAK01.6
Date:   Fri, 23 Sep 2022 13:51:33 +0800
Message-Id: <20220923055133.302740-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the AUO - B116XAK01.6 (HW: 1A) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 060f4f98bc04..aaa7a24bce6d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1878,6 +1878,7 @@ static const struct panel_delay delay_200_500_e200 = {
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.25.1

