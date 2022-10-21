Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA93606E15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJUC6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJUC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:58:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834F1BC179
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:58:07 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h185so1324251pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHilljWsWRx1PWhY+hLvNRoEhjRSaugmuLh1rPSUKY0=;
        b=w07XQlruQ9Efxxdw/R9T6Gpz9e0SNGX+p751DPbHJUS2x/ClWvuXwL7G1XlJ5T10FN
         sjXN+dIDcWjTcaqOL1f9uKocw0NaymGwMrt+3GWVlihy/FVbPCUQMjtpD6NRxthg80S/
         eLi8vQeDiWar+V44wT60WV4JexRSK/ym6eAvmNoto7tIswVs8nD/AnKf/IuTtc/D4SND
         T2GKKR9NNVaGD20nYPeZ6TMYK2Qvf1sMsjNZqf4qPJsRVfQhwRPnB8hXH0bCOwEsRLZy
         v/yW74T0BhIO5DTE2Ge9nzC4cQzlqDA6P8rwnmWeMjxz8/WRgML1tPecoLtZ+CN9ixtb
         8k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHilljWsWRx1PWhY+hLvNRoEhjRSaugmuLh1rPSUKY0=;
        b=w7KArkR7E3Wh6kFqN1l3r4+P5jhwS6HS0k2olT9uEZQX3hlkrMjC4+uASIrg43F+JA
         HkR69OTvzarLKkN+cWNKJO0D47pQWAo5bRX2Jrol6ym5HNTYWb8Ss+l2rjT86SfSWWOe
         2DDfSKpTb4J79JEP38npzq9cNxHh34cVK6AO314Yfhf2M0yU7On6eG+MciL8ywd0/VMZ
         2CNLpzMlDc4HKCHdvD+teMWWtZVoBEqUZUbdGu9GXsFzTMZZf5KZV+NBtefsCrYHG/YO
         BrDw5faJwTiOmA154OTUE+wol01oDSjxYQ5FY7Rkj5GOLIoONVy/YAsx2vswNiCx85yC
         3m1A==
X-Gm-Message-State: ACrzQf0MONhkLSvyS9toLYV06sAkh6ko9FgTrZheio6IHBacODF1eX60
        kHE9jPyGzpZA6Cott8g7UtlQ3w==
X-Google-Smtp-Source: AMsMyM52H2RHBB/4+tA06rxTThZHTboHHp2FHsYn0xOVv7ZPD54oocgDFweSipS1HWKyPrl3EB5Z3g==
X-Received: by 2002:a65:42c7:0:b0:462:7158:c863 with SMTP id l7-20020a6542c7000000b004627158c863mr14691575pgp.590.1666321087284;
        Thu, 20 Oct 2022 19:58:07 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id f26-20020aa7969a000000b00561879b0f3asm13731695pfk.203.2022.10.20.19.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:58:06 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add INX N116BGE-EA2 (HW: C2)
Date:   Fri, 21 Oct 2022 10:58:01 +0800
Message-Id: <20221021025801.2898500-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the INX - N116BGE-EA2 (HW: C2) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 4b39d1dd9140..724b27a53299 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1883,6 +1883,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
 
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1139, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_e80_d50, "N116BCN-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),
-- 
2.25.1

