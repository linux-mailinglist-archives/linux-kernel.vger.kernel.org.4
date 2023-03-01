Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A26A67CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCAGzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCAGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:55:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39B30EBC;
        Tue, 28 Feb 2023 22:55:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7661492wmb.0;
        Tue, 28 Feb 2023 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677653713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7TQlLP33d/hsxTkfWm0RTdIoRZwSrsSyc6CDAnRU9w=;
        b=VT+XCeOXzFAVdn3CVlD1Wt1dgyeHRKbNrJyb1aPMxVh6xj8SIcHJ4WODGcJ0hEVPjZ
         VWVl9W8uFFfN0nPvOyuFAc9DGXat+LvLUWqeEorKYvTYGSgOuVviB+cefDPyAARJZVXq
         1MW9zKTHCrKKJ9Kf1VPaqA8yB4mQA7TjyIPIzreC73IIsha+aWuv70PdCDH8ZR5hyZ01
         hBFDj80sueK1yCUPUi+hK0U3UnuVXr2fBvwg0Soo4re68eQbr7qgqsQglzfQ3o/SKDl+
         3rkUMk61WKSUfJTKlnwc5lhSg2Awpn4nKl6ANw7dO1QvG9ZoTAC0sHLQkizoGSybp49N
         O7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677653713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7TQlLP33d/hsxTkfWm0RTdIoRZwSrsSyc6CDAnRU9w=;
        b=6UnH/+lttkvATE6ZdYXdRg6BRBrgIX0/vuvKbU1zgTW+ofBDuKMzGY3ron3HnA09hV
         Bh3aMKAnw1y5TBW4q+FGdMfyvC58iWGJmZejN9of6z55lf/gTzMbhPlBYQ2yMEcqvqil
         LLETOnvF0GOd8hbcb8NW7MpfA4Tp2RbrB2y0hl+RToY9I0B9muZEP06Tj2p6RzA5xy4P
         Xob1jUPyPtbHhxZ3O+dgLVuQcOTB77/jg2iLE/M7nHC5IHZGiCPLBn5Sj3/RK/MANJaa
         QQyZf14JFqW0HpnzxRt3fRwbzPCVUd5t+IhrJuowO/BPi44Lq9G729QUNnzCNYmCNzNy
         J0aw==
X-Gm-Message-State: AO0yUKVRpsbmJSGEh5uxG0CS53eWnmMLJu7ryzi5iSNZKmKS4QenKLq1
        MAId51Gk+e8cfHemcHl4lgz5w/C2XTI=
X-Google-Smtp-Source: AK7set/4wvnupagkweswyKRIVBnfKUbDE/9mHXNLwBHcB6DFO3YdEDoK2PsgCXEAJqj/nAdIE2AIig==
X-Received: by 2002:a05:600c:18a3:b0:3eb:2da4:efe7 with SMTP id x35-20020a05600c18a300b003eb2da4efe7mr4001134wmp.11.1677653713404;
        Tue, 28 Feb 2023 22:55:13 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003e7f1086660sm18279998wme.15.2023.02.28.22.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 22:55:12 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog: rt2880-wdt: prefer unsigned int over unsigned
Date:   Wed,  1 Mar 2023 07:55:10 +0100
Message-Id: <20230301065510.2818425-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301065510.2818425-1-sergio.paracuellos@gmail.com>
References: <20230301065510.2818425-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of declare 'reg' variable in read and write operations as a bare
'unsigned' type prefer to declate it as 'unsigned int'.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/watchdog/rt2880_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index e54737bcf939..4499ba0eb5ea 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -54,12 +54,12 @@ MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static inline void rt_wdt_w32(void __iomem *base, unsigned reg, u32 val)
+static inline void rt_wdt_w32(void __iomem *base, unsigned int reg, u32 val)
 {
 	iowrite32(val, base + reg);
 }
 
-static inline u32 rt_wdt_r32(void __iomem *base, unsigned reg)
+static inline u32 rt_wdt_r32(void __iomem *base, unsigned int reg)
 {
 	return ioread32(base + reg);
 }
-- 
2.25.1

