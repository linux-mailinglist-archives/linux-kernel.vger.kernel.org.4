Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C85EB774
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiI0CSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiI0CSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:18:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803CA9255
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:18:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso8710126pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dZD2Q3sJnT7LtqyYnQOsH2aHhEx3TviV9Oc+ahsq2us=;
        b=GhCkuBE/fHzYH5gF0AE6yQROWfKQZpwIzbVd/3JlWvKeILaZfA2vAIE5mSMY2eo+Vy
         0quWl57+5MjcqRup+fn6FNfOEuqEOFiHMh1vB+WdKzi5azE7u/pkPXpeDiroIoFLBcYD
         qpBeOOkemLQH7vQcL1k3s6yS3sScqQpTlIpS4cF870MbbXflIufLnjKhDi9s2Y9qqlpy
         UE+cRTLvCM6X3zenCUOq12fsjgouNtFF/FglVwRVN5J3utjGJ5rSzViBohLTfK/02Tkr
         XRvrxWzuu4EnR3aDJiwhz5jXI4OE/9YOGZWMDKTZ2T3wtfEGexg2LsvmrF0xeehOKpGk
         kCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dZD2Q3sJnT7LtqyYnQOsH2aHhEx3TviV9Oc+ahsq2us=;
        b=L5L5r3C6tFP1bpPi5txnuSrUcel9S/KDFZiGy6WKK9O7BvK1lqz3SJ11wLFoGFQN7m
         j/AWGPIdXAnFsuhLoBa1fWNSz9KGNeN10xIfEdb1a6W0OWOuw4UmPftq3S44fL8nsSHd
         TUHJcnlp1JicfXWB28NkhndTSPGIVIyVJ8iBHKVX0qi148EJ1YLXv4PNAa6Okqd40aFu
         dk2MHOdjMBr+q3FkT2wo2H1QD4sUwsAngz0tbRggpNt/U7QQ6DzStdd8g6rS+rwNSyj/
         mkBDEJMrm9kLeRJwBOLhBF0qLvKMcOef2jCJiVFSL32yMHq+3fC5bl3Di1Sar8zRBiKp
         O7MQ==
X-Gm-Message-State: ACrzQf11FRDBJoYvOtSOttKOmnn0TGbRQFInDfag0e34ZRT6IK9+efcz
        6okOw3qF2yoy1lbeUzLdz8r/DQ==
X-Google-Smtp-Source: AMsMyM593Juk1zH98oEDl8t13zXBDlUN69CYGKGRf6UzGixRbC0Zp3bCpxxMatnnfxJ6+L2oxJ8ALQ==
X-Received: by 2002:a17:90b:38c3:b0:205:d6b5:582d with SMTP id nn3-20020a17090b38c300b00205d6b5582dmr1275417pjb.229.1664245120262;
        Mon, 26 Sep 2022 19:18:40 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b00172a670607asm101844ple.300.2022.09.26.19.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:18:39 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     dianders@chromium.org, thierry.reding@gmail.com, sam@ravnborg.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Fix delays for INX N116BCA-EA2 (HW: C1)
Date:   Tue, 27 Sep 2022 10:18:35 +0800
Message-Id: <20220927021835.488803-1-sean.hong@quanta.corp-partner.google.com>
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
index 102ab9f5d40a..e25851de7954 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1893,7 +1893,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_p2e80, "N116BCN-EA1"),
-	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_p2e80, "N116BCA-EA2"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
-- 
2.25.1

