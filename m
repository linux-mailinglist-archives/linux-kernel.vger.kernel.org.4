Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592785E737E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIWFqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIWFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:46:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3F911E0FC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:46:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fs14so11902756pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rz7zDp7u3nZE/L+YT9u0XbpEYeueZmnCFYIryouZKTI=;
        b=qplLucR8pBwSMYPEnF2SKKtbq4cDJapzkW9/CTMdqQNAzgrknTKQAVbH8EJ++5vJA+
         xhv9z574lG3HDuPcrYbsPvCWuSZ4p+1NitcVNR6PWlA8nHemqEbr/xtR4L/IaSGI7AoA
         adTzqdVQm8AnLLyufTl3vL811gFj4ZcVpRkIHLOjuCLbj5oItm1UfCo65kQIdUR5bGho
         8Fo9ff279IcMtR9UI5XELo4s4Or2TH2gRYtIoBdhTiz106d/ZCq+R2qqs3r48P+zGIGl
         3qd1usH6SPU3qOOQ1DqhmkrKDZLu4CcPX3LkjhOTiilxETI4V3330KvcRu1jl0+PZDdK
         xdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rz7zDp7u3nZE/L+YT9u0XbpEYeueZmnCFYIryouZKTI=;
        b=N4e5qJiwGaEGN8Tqst0XfBDPy/hQvtwgSz+WfbhxbAzcUG2MpAdhCU3XtJ9bQEG7xY
         X8P+1g6JD8oIbTdav3SzFEgcIlT52Qk13ACuwqnYus90lVXFGRqC1uYZA6iwJet5ce6e
         rIs7rUxnlqACJuY5c2Ijs7xSLxPH+azcGRX18u7fZgk/WQLE0ZppqSZw6R3InkcOtbTR
         ODO96J6Z3ob82jBiczS/m8Lcl4R5coJF/bBpxoyKF7Tg071aixla6jGYNRCXtre31XYx
         u0RZwaxvioKWu58L2WjF3Q6NO3Tafhw0yPm2m08ZIcy0UMoHPMYRFOUDAsOzhLBexFiE
         8elw==
X-Gm-Message-State: ACrzQf0z+FnvySUKcFvYuPoGW5BfT3JiKMxwS+L3ymYCjRjd0WpgNF4a
        tWql3Z3RNK5Y1R9hmpTvuHHeUw==
X-Google-Smtp-Source: AMsMyM68hbMFb6kwhJm3g05WhgnMCkPkO/6+oLPU5PV7bz1oUK73SSnkwkVTboXgK2jefgE7Mz4Ppg==
X-Received: by 2002:a17:902:d402:b0:178:98e5:7c0c with SMTP id b2-20020a170902d40200b0017898e57c0cmr7081957ple.84.1663911979182;
        Thu, 22 Sep 2022 22:46:19 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0017691eb7e17sm4983579plb.239.2022.09.22.22.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 22:46:18 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add BOE NT116WHM-N21
Date:   Fri, 23 Sep 2022 13:46:14 +0800
Message-Id: <20220923054614.302440-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the BOE - NT116WHM-N21 (HW: V8.2) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 060f4f98bc04..8cf81395ba36 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1886,6 +1886,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x082d, &boe_nv133fhm_n61.delay, "NV133FHM-N62"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
-- 
2.25.1

