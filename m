Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B495E737C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIWFhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIWFhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:37:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84927FF3F1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:37:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso6999769pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FDXVHN6kTmXxUTt2S0ck8BktO3/KI3qikuzjAIbxt+w=;
        b=UElJ5TsMWjrGPps0Q16ahhlFPdH+s9IZ2bfkibo7EfOotDX8gzl8zGcGiR0nGIYIzw
         p7A7fTWJgBv7mm+bVax+nEbzVisIklWa8+iH7XnGyeIZrAADFkUtG3GuF8AmlOyaCDYs
         WDNdGj8fg62dx330FNRm/BaqXQ2xg1yzNCjvM0B5l9SUQeHG4hoagszMk+tP7aKmi5WJ
         A0j5RwMC7clO2bSY2xVr+T9in/JfCDYKsbeG7GJSR4drSiv0VB8ElZhLc0ZlziXikK7M
         TrsLynAB+mrGyaipi9vm4/iQ9NVhpv5eBCG9PlcQR8L2gQ0JPU6v/h9x09ETEOWtH5So
         nCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FDXVHN6kTmXxUTt2S0ck8BktO3/KI3qikuzjAIbxt+w=;
        b=Gr76TxC4cS4k1rDDHQks/78PNKXTjCP/NRICRsYpLPVIPh3XOHuD+QFyiR5DpTpJ26
         h/8yu1+6z2z2HIiIxkvTOWVN3+b4jzcUMvegdFRryEvm442bq9fpUfcT1Vqpq3bXsKpy
         RZPrlffhYCFIcfWKqrNqtHb7Q5WGux/flcwkdXz7a6yEAemtY59gROqmIXblVra9+jN3
         euLOsepq87QAuWFPl3aIrnrBRaWJ8bsWQKWf/Mca9sLjSylNxnN5KvkaYHP/MhlkYD1c
         Wql6rAJjuQ+k3j3N+35TtzPadK6XyHWObXSOZGkNvh8jHOyRrKO0fXVyRIdFfWDOX5UB
         27bw==
X-Gm-Message-State: ACrzQf3HVNc/ByxMQ35CI1A+rCZ9EM9d9lJlor+q5HVG5jgUhe0uKOOU
        wDfKKbpNH3u2+GC3dD+LNWrMdw==
X-Google-Smtp-Source: AMsMyM4EcpDyZXdrGwZ4+tDXeKknxr/WNz0cYXP/OQvK9ZI120PJu8NXAasuJByKZhR03PhQaAvp1Q==
X-Received: by 2002:a17:90b:3b81:b0:202:597a:c71d with SMTP id pc1-20020a17090b3b8100b00202597ac71dmr18970470pjb.105.1663911455069;
        Thu, 22 Sep 2022 22:37:35 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id y129-20020a62ce87000000b005480167b921sm5619760pfg.172.2022.09.22.22.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 22:37:34 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add INX N116BCN-EA1
Date:   Fri, 23 Sep 2022 13:37:29 +0800
Message-Id: <20220923053729.301626-1-sean.hong@quanta.corp-partner.google.com>
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

Add support for the INX - N116BCN-EA1 (HW: C4) panel.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 060f4f98bc04..8db91fb3d39b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1889,6 +1889,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_p2e80, "N116BCN-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
-- 
2.25.1

