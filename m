Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF991747562
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGDPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGDPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:33:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C2E42
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:33:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b89bc52cd1so9336265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688484794; x=1691076794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCJF9OcKxcQRRkN3q/ruFVGi5lpCYguCeajY/bnYrzI=;
        b=Qegsm2xADNZh+vRXK2cGwSSE3B1YCYiMXTRmSn7xMDd2Tlt6nkqF18ivN5gfUmIlw+
         k24HDMJXcV13IoZpJZs9tuQpZ18Tz7yXPHQWhJabyBP75uG8lcYr9B+yv8SlDAqzdFOT
         gUhpZOLojFGm1um+J5VuJUOKZfTuuntNoiZM2lKe7wfQqbymJGwSOIQuVhQJ2sLUtVuY
         uLced89DmOlkOkbrLbiFbW+xDfqFp9v0+fIUq0PT6ElEZ1LujSQJ+yUWyXWMFfjjXSVr
         xrrFyjyFWOTJ0Y7LkdvtoUV8cyan1DiaeBfoWY4qh59KiDDFtL2jOJHPFNsTlsMvA/1e
         E8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688484794; x=1691076794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCJF9OcKxcQRRkN3q/ruFVGi5lpCYguCeajY/bnYrzI=;
        b=edqB95Vnj7IvjPxg3dJaCB4RsjjojZlzgwTiIbiQBnswWCNJcLCnqfcJXY0z1Luz8/
         iyEKBv3ziMPXRJ41TN4Id5949cFa2OZgtcJSMH2A3eHFRlUaGkZZBRy0EatD9S9EMuQ1
         gEdZD1gie/LP2XKZr0opue6PtDHzjEeEZ9GMIyRFRHgFCSLE4lNGKb3GAR7+LMDh5QAt
         H4TKmVM8rJaZ+BJkwXB5GYbXsqyf7Jz1YPxVLwXIqYe9Xr2dYIDhHnsIB6116taBxjTq
         A1Jbk88G0w95T2kjkPoG8+QmUD8WZIaUfxtt1pR0+Bm6xzmrUjngFNnwabDuT65+AJw3
         hq2A==
X-Gm-Message-State: ABy/qLY5fAsxcY7HaB/gNWzHr1LC4Mp3fCzYpS050DJrC3HGv0+f4Fm4
        JzVLWVNkA3c9d5XqQsAgWYx0FKx6PeIqtQ==
X-Google-Smtp-Source: APBJJlGIEOMOr/5lssWZoyi7OaWDUIFclDtyzbu/pokMuqCAwqVTA+MpycSkL2a8oNeVbnXgE2A/SA==
X-Received: by 2002:a17:902:d902:b0:1b8:5b13:5958 with SMTP id c2-20020a170902d90200b001b85b135958mr10492147plz.31.1688484794338;
        Tue, 04 Jul 2023 08:33:14 -0700 (PDT)
Received: from fedora ([45.90.208.186])
        by smtp.gmail.com with ESMTPSA id jw21-20020a170903279500b001b80ed7b66fsm14316071plb.94.2023.07.04.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:33:13 -0700 (PDT)
Date:   Tue, 4 Jul 2023 23:33:09 +0800
From:   Wang Jinchao <wangjinchao600@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     wangjinchao600@gmail.com
Subject: [PATCH] staging: rtl8192u: Fix keyidx assignment within if condition
Message-ID: <ZKQ7tYa9I+PHgef/@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the if condition into nested conditionals to improve clarity.
The condition is currently in the form of (E1 && E2 && E3), where the
variable keyidx is assigned a value in E3.

Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index ca09367005e1..5da8ac401df0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1121,10 +1121,12 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	/* skb: hdr + (possibly fragmented, possibly encrypted) payload */
 
-	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
-	    (keyidx = ieee80211_rx_frame_decrypt(ieee, skb, crypt)) < 0) {
-		netdev_dbg(ieee->dev, "decrypt frame error\n");
-		goto rx_dropped;
+	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP)) {
+		keyidx = ieee80211_rx_frame_decrypt(ieee, skb, crypt);
+		if (keyidx < 0) {
+			netdev_dbg(ieee->dev, "decrypt frame error\n");
+			goto rx_dropped;
+		}
 	}
 
 
-- 
2.40.0

