Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E45E9EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiIZKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiIZKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:08:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F022288
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:08:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w13so5805568plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ehcMWTx3JCiw0KnWDLCX/Z/T6ECZCx/ojhdFf6ysh9U=;
        b=bqv7qi85AS9b8Ieik64VT/vdGDUTL6h125N6FpgUoHN4thC/OwZDiZ7l+sD0HzAA9I
         35rXcdgmVxtL3AqTK1HDCkRkq6ERYXnSFD4SJNEeKZDBjRUXs356sUhge+o2t+djvZvf
         yS4gHDKv3iGeUhCTRi6Lip//NAmqQ3YzsQJboUDFew1abSUEkJLkvpdB+fO30JGV340P
         82bHAU/pzCX+7g506QD4Zilt4+tpAqGwf/jt6c2XTof3xupxRg+wo8DjfVaGxCx7dXuy
         Rp0f7iRjfq/bKPxVB8puSwRJ9Pp0WY5X/K5+HGG/Th/SXeQ3UntQBUvC5M3xhkP48Jvh
         pOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ehcMWTx3JCiw0KnWDLCX/Z/T6ECZCx/ojhdFf6ysh9U=;
        b=NuHRoYJ+MgLo4K/80IioUlL83drHTpYxERThbBdeU8m8VscWfCIC/+T79RFTRZqIlT
         HosVKQPo5J+FMCPKsWujNWZdNkiVfsWfxL4xNue6LY0u51yaWOe84BJP6GezVZIAqIvD
         BcDZeWtsLK1dpossBKcyqs8MlT0YWmJoioMiftunUg/ds21aCc9FU6XTKPd8D95dqPMK
         D+j1fO9oKy541W4i5/HYXw0Od2GdBthF4jEsNSgL5iWdZAEI+FA+og2HjI1xA64g83SK
         v0diAj6C3tIUQvU06Gtw2faQV5Vq7/CERWcalmcdyRXMXy3oY9RhzGpPV16PdydN4c8q
         Lz+w==
X-Gm-Message-State: ACrzQf17Xn0ahFG48Be+RijGZJP0PeU8lfaU7CjrxK8qZhj2nxm+U9EJ
        8tmCvS1cQuJPLSItEv7jTsiJucu3yo6RiQ==
X-Google-Smtp-Source: AMsMyM6d30TDyOxHYeAf121l8qUL1+DdJtCt8j1JfJucbrBQRk6jFIUoRpEffxZDoEnIYfJNKHOOXA==
X-Received: by 2002:a17:902:f550:b0:178:5b6a:3a1c with SMTP id h16-20020a170902f55000b001785b6a3a1cmr20626741plf.36.1664186925843;
        Mon, 26 Sep 2022 03:08:45 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id j29-20020a63551d000000b004390b40b4a1sm10304950pgb.23.2022.09.26.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:08:45 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add INX N116BCA-EA2
Date:   Mon, 26 Sep 2022 18:08:39 +0800
Message-Id: <20220926100839.482804-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the INX - N116BCA-EA2 (HW: C1) panel

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 060f4f98bc04..ba75fae7d376 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1889,6 +1889,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_p2e80, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
-- 
2.25.1

