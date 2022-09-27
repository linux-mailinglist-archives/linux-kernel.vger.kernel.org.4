Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7D5EBAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiI0Gfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiI0Gfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:35:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB861B13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:35:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d24so8246643pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SRYYQ3707grqaxVxUN3p9E6nOdleDAi4s45cvWAivxY=;
        b=L+4fX/BsaccZku8y8TMKmgsuB9wZmC428zVKBfeQ1cDazTSPIP+B4KLav9sC1OGJgx
         AoYkVU08Ihc9nSCfien0w6YM7IeevVdXJJg3DeiwH/r/E5vJym8myAi9kdt4tycChYMO
         FXf8W7roVySBaps9xfOcRzX30mLVe6r+tl5xGOspQ0C453SmIFbnDN5RAlpZ+asqnUx3
         yEntW7z6zHBLfuSC5Aq6kyJsSX5pj7a/p7LgpOOL2cH2nxkFB36N26qCpz+I5pjpClnz
         Mud1RWPZmTnTW9KTIeRZlXiXVfgTt1w7uh+B5zM9oND+nuhn2R5gRg1ZMf5m3jTaMjGQ
         BOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SRYYQ3707grqaxVxUN3p9E6nOdleDAi4s45cvWAivxY=;
        b=yJwFil78iBQY4ZgD/jSZwwe1s0wvbLtAPGuCtXxR8TAd6q6Q+/H9tLjkoiuNbuDJj1
         bGklUvjl463kJrvQ1ad/rYzXfS1RegFecFJ4WrXTScooUl3Dk6V6xTj2HVOTIOdGaIRS
         GhmlOk7lnypP3VV7RzvVXkUXnsCCp1FLsk/VkWw6S9MP0Zd7/Za5aTORNZwGUQ3hO72E
         wydX435n5If5Xe7GcMVQm57OGIup93Cd3BqlDGofFAH78jymmCCIAEf1v5S6QZX74RgO
         LTHd0tQKQJHq8F3rJuJUrfAdyPFZjgqLRTbqUF+XnLiTMwSWkpNDycgmi39CNUtGgmni
         YMCQ==
X-Gm-Message-State: ACrzQf2O87lvkMn2JsFe3e/6a0HqiNHRBl/879NwRP4vjlm6FASVArpj
        lmsU6ohA2dzbv7vBKyNpQHoSbUjY9se5ow==
X-Google-Smtp-Source: AMsMyM7blyFe7Mx+4ipAFYRiiAEK9NkBdRNW5a8w7wiqjFY/2liM7kAMcwnAsqMB7ulDEC5GfGb5vQ==
X-Received: by 2002:a17:90b:4acf:b0:202:65e3:da5a with SMTP id mh15-20020a17090b4acf00b0020265e3da5amr2824997pjb.174.1664260530240;
        Mon, 26 Sep 2022 23:35:30 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id a8-20020a63e408000000b0042f62120c1bsm634714pgi.17.2022.09.26.23.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 23:35:29 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add BOE NT116WHM-N4C (HW: V8.1)
Date:   Tue, 27 Sep 2022 14:35:24 +0800
Message-Id: <20220927063524.493591-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the BOE - NT116WHM-N4C (HW: V8.1) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 102ab9f5d40a..03a4a49e4ecb 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1890,6 +1890,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_p2e80, "N116BCN-EA1"),
-- 
2.25.1

