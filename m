Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDED69BA31
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 14:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBRNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBRNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 08:20:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4518AA9;
        Sat, 18 Feb 2023 05:20:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id j1so282110pfu.5;
        Sat, 18 Feb 2023 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNMRgH3NmhW4em9tRT4KeD9GEuYej7dmXs7hwuKnpeQ=;
        b=gpl97i2XWkDu/oiU+nMsVB8xOckNetjRCCk1kIih1uGK4CJ9dAQ4Ngr8WlMGC8EGHY
         uxkoGxQLhD30r3xK12g1egnxfht3eZwAClTcyuqhDxpwnLy7aMSGud2KonjHXgKzl23k
         wcMY6wBFdNeSHZv0jG5JGC1z72k4bCEVd7oa3kVgGZuoV69BPiztxx32IYEWYp9IXrmA
         ey7e9BeYcl41n6+8I3+XaQt8p6oP9fRHm+Yvvx8J7CvYS95qBzClkEG/FnBjAa6oqWIK
         7RYzEE1K3XRciQYQWep/eOw8MWr7fr1qzP9od0sJYdlP5x2zO7UGZ0uGzpg+Qyxb4fvU
         GyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNMRgH3NmhW4em9tRT4KeD9GEuYej7dmXs7hwuKnpeQ=;
        b=G0vR3dcAgHnV4lBge+U9ppHUJEcFtMHQN8ouAVnGazX+PGzdQLC/YH2YYwxiBJAMcP
         wErdioK5e3tLi4uUIpP9tUREGg34qbN1va+ilzTdFrRnX/zj3ZT6L+juk2eP1V2udKho
         xEOmSknVnGY8ErxNjQQyOnQYLllHX26rIQTQ3SfKJKIcrnq1CUxg7QpY/hlBCXgP/3f6
         l4I/XYuQPuUucSZ3FXHQdYQ8bWX6xwvl6AwgKdLrepPmWPQaJJK8HVjCmf1Y2Gij0qPf
         MfgdsKTo1Jh1PDISFpjztPKZXYf3oRDxuPWXwLO73sbu0V55hZeBkMZdIn8Oi1Be+iET
         q4qQ==
X-Gm-Message-State: AO0yUKWi4eGJYfnP6lm787JSwWiBWweIlxVrLxZyfR+UYt317Q5NZd5/
        bXQsabhvPVP0spfRDgC04wQ=
X-Google-Smtp-Source: AK7set+dZDl6noBNz/ZY6LMvFwirLRo2JsGKWqlOCQE/DMGWw1ZRaxjIFAqxPsmFQr+nlaAhgQiqIQ==
X-Received: by 2002:aa7:96c9:0:b0:5a9:b4eb:d262 with SMTP id h9-20020aa796c9000000b005a9b4ebd262mr7651302pfq.1.1676726446099;
        Sat, 18 Feb 2023 05:20:46 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b0058e24050648sm4769448pff.12.2023.02.18.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 05:20:45 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v3 1/5] apple-gmux: use first bit to check switch state
Date:   Sun, 19 Feb 2023 00:20:03 +1100
Message-Id: <20230218132007.3350-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218132007.3350-1-orlandoch.dev@gmail.com>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
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

On T2 Macs with MMIO gmux, when GMUX_PORT_SWITCH_DISPLAY is read, it can
have values of 2, 3, 4, and 5. Odd values correspond to the discrete gpu,
and even values correspond to the integrated gpu. The current logic is
that only 2 corresponds to IGD, but this doesn't work for T2 Macs.
Instead, check the first bit to determine the connected gpu.

As T2 Macs with gmux only can switch the internal display, it is
untested if this change (or a similar change) would be applicable
to GMUX_PORT_SWITCH_DDC and GMUX_PORT_SWITCH_EXTERNAL.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9333f82cfa8a..ec99e05e532c 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -346,10 +346,10 @@ static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
 	else
 		gmux_data->switch_state_ddc = VGA_SWITCHEROO_DIS;
 
-	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) == 2)
-		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
-	else
+	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_DISPLAY) & 1)
 		gmux_data->switch_state_display = VGA_SWITCHEROO_DIS;
+	else
+		gmux_data->switch_state_display = VGA_SWITCHEROO_IGD;
 
 	if (gmux_read8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL) == 2)
 		gmux_data->switch_state_external = VGA_SWITCHEROO_IGD;
-- 
2.39.1

