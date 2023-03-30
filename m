Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665E6D0109
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjC3KUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjC3KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:20:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69D9013;
        Thu, 30 Mar 2023 03:20:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id le6so17594266plb.12;
        Thu, 30 Mar 2023 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZmxJBGnppRjnLwPig2HvBYgGtUmPNqmKtzVUEwg304=;
        b=ajA6egIMBMRYHU4F6oW+0mCqPJYkZOF1V9ors/gemKbzM3PUlUh2PW8eRCUSOqfQly
         AtBXQ0XlgososQNI9Qihk+mf4drHiQ5cxJGm70+lMoAoU5z2aauQ3QA2ikB10YjQ7srM
         8nqv7jMldn5KwwAywPcAFhTZqEFQ2wvATFSxKATNHgG5vfsJFHyv52Cn/WN6Ey5CR9CR
         zKrFX2ILORgYwWO4GTRsZKjgbm60/5089tzqIqf57hodpIQaZ1/nHrsotjl9l0K68qOL
         r/Yi+lpAzfpEm7c0e6BOlTKoicAcODwQGxkf5Q/UVxkMXU8opRpYLtVkneDzO5IVzec9
         2hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZmxJBGnppRjnLwPig2HvBYgGtUmPNqmKtzVUEwg304=;
        b=lyos+Znu9lt3nHSUBbiD53hc+ywDC9M5SMKbsTVadSlTd31+QRelDw5vvFI19hKkT/
         ++A+3min1tBYOcudnNlXx4jIOZGeus6L148WZMNviKMwLiePCcIIWB5ZMaQFd+Bd+IGg
         CH4KhZhDedymHqRaCjlRzk76nIVE6XQUDhJYmWNKSUtPo+tP/lysMlM7LBvO23uoPvQc
         TZsWs6ce8Tb9ljsKAygC0/Ya4nqZ84a6eg+9E5ITxFGcfhZjVF1bC5fLd/YLS6ibP5y9
         dwvOEo2jtC7uOed3UfkmBLejBnUY03JNbbHMac5f2JTe4aqOHeLwdsAMS9g8zu7CBGUb
         FJTA==
X-Gm-Message-State: AAQBX9fXCHoZiJeEuB2VHNH8sjTyXXxDfF9998UWXH1NlAlYncK67gSu
        r+9feLMaJsipaF3HizArcNzExTYz82ydNw==
X-Google-Smtp-Source: AKy350bugyO5EJ0XwTZ6sNuLfw+/sTGAdhEbUpcjRdjcem0xQ2OP09F7lSHI+17KXayK83nihUx29Q==
X-Received: by 2002:a17:90b:4c4a:b0:23b:bf03:397e with SMTP id np10-20020a17090b4c4a00b0023bbf03397emr25526744pjb.24.1680171631122;
        Thu, 30 Mar 2023 03:20:31 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090abb8800b002376d85844dsm2860416pjr.51.2023.03.30.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:20:30 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 2/2] watchdog: loongson1_wdt: Implement restart handler
Date:   Thu, 30 Mar 2023 18:20:13 +0800
Message-Id: <20230330102013.545588-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330102013.545588-1-keguang.zhang@gmail.com>
References: <20230330102013.545588-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement restart handler for the Loongson-1 watchdog driver and
define the watchdog registers instead of including the legacy header.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/watchdog/loongson1_wdt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index bb3d075c0633..a0b6fe62e516 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -7,7 +7,11 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
-#include <loongson1.h>
+
+/* Loongson 1 Watchdog Register Definitions */
+#define WDT_EN			0x0
+#define WDT_TIMER		0x4
+#define WDT_SET			0x8
 
 #define DEFAULT_HEARTBEAT	30
 
@@ -66,6 +70,18 @@ static int ls1x_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int ls1x_wdt_restart(struct watchdog_device *wdt_dev,
+			    unsigned long action, void *data)
+{
+	struct ls1x_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
+
+	writel(0x1, drvdata->base + WDT_EN);
+	writel(0x1, drvdata->base + WDT_TIMER);
+	writel(0x1, drvdata->base + WDT_SET);
+
+	return 0;
+}
+
 static const struct watchdog_info ls1x_wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity = "Loongson1 Watchdog",
@@ -77,6 +93,7 @@ static const struct watchdog_ops ls1x_wdt_ops = {
 	.stop = ls1x_wdt_stop,
 	.ping = ls1x_wdt_ping,
 	.set_timeout = ls1x_wdt_set_timeout,
+	.restart = ls1x_wdt_restart,
 };
 
 static void ls1x_clk_disable_unprepare(void *data)
-- 
2.34.1

