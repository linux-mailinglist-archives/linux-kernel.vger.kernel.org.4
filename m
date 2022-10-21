Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1279A606E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJUDKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJUDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:10:36 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A6FC1EC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:10:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y1so1374660pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqy88kgcdqgVJZiFTICz5DdP4bxwc+5bmeTWZHzDx0Y=;
        b=Vm54pQmKTiZYDhJDqnLWts3Q4KaijkpvkPRKZ9iQIKybieWKuKKPyBdS4kLqddffpX
         oBPvk9kzrb3bqPp2Igg7kQSlAjJv6bMQnSawt11kJvEk6NI6LbbD5QxeMRcm1GDvorvG
         2hUYsWjpDTbw4GQckWvdL4ZmqqcfZVLnUxcbgSUWOIwCIE0O8AKD9S+2QHb5xNIwpif8
         AZJRj0ySLjZ4rkBkhNP5Mxkx9dE0hlH+DHGwB2FWCaR436+aQAOl39ttvPpSZ7wbYzLY
         UcvWT5YjUvwi092vPjeOuu4vtDfd21Ltmgc/374RLBhDBMyY0vaRwGPcBInr6D/u0x6x
         RAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lqy88kgcdqgVJZiFTICz5DdP4bxwc+5bmeTWZHzDx0Y=;
        b=o59sTJOsuxW9XrXMjiQzZDiIoPq2skRHjeVJUkrCvOOZFvVj8zL6iYWdY7PqXdbkQ8
         KssGZdlXygWSlSGpJFy4oRsMNU1KyR+N/Pn+x11pIDH4fb6v5lV0LCkFzkmaAe9f2lt7
         bN1a+ptn4r2xMFINEy7fNdKobyxR/LqLPH8wgALqUKT7VOEChmmO6U4Qs9cPiXfRVqID
         V6NOhLziJrR3+lQA/L62ZJTR37T1wBweNy7M6HOOesF+GqczKnu9TvtbCVgv4l2KDzvr
         VlwL14Z2gxlghkdWCDXptq9FlBeYOCPyFRma0se9owmG7U0t8C2nlSZtGRhQ4ercZJZa
         uenQ==
X-Gm-Message-State: ACrzQf1HLwDD8ECArR0nAVuN1n0Qr6thwvDeRerPKMcCOpttHQiP6KMM
        FUNOjQJ7VUHumucoOfdT75uZNA==
X-Google-Smtp-Source: AMsMyM6N78wjujSI1lfFxzM6CMjAXO093s8B96q91MqDf39PAYKlSzniPHslFTatE4kIY2Lf8F+WSQ==
X-Received: by 2002:a63:485f:0:b0:458:764a:2224 with SMTP id x31-20020a63485f000000b00458764a2224mr14235293pgk.620.1666321829224;
        Thu, 20 Oct 2022 20:10:29 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id i34-20020a632222000000b0045913a96837sm12459499pgi.24.2022.10.20.20.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:10:28 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add INX N116BGE-EA2 (HW: C4)
Date:   Fri, 21 Oct 2022 11:10:24 +0800
Message-Id: <20221021031024.2899082-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the INX - N116BGE-EA2 (HW: C4) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 4b39d1dd9140..82c81622a169 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1885,6 +1885,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_e80_d50, "N116BCN-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1153, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
-- 
2.25.1

