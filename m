Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9038B66DFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjAQNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjAQNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05E7ABC;
        Tue, 17 Jan 2023 05:55:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so21035249wma.1;
        Tue, 17 Jan 2023 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdWr3l6Lx7GA+PzAYzrOffiqrgjBeqJI1wVp2EC7E7E=;
        b=qVjukzf3AL4RFTbzl4nNjsVAhOPp2mmpE7QQizyXC+6PqDzg7A19WIaQ5k4BwSipla
         +CQRQu6nk6M2Nb8ZZn2u4x6/AExBF5u3vd4l6f1nItY/V65bX4dtgE3rKbSQlLzkYt1U
         ZQDY2cOS0BDP1Hd3PZUj17UoBKLV+pdCwT5bw7c4eznuC2n/WT7wdJHlg2SVulJ3WBU2
         Mx8zHKPVqa1EVkW3lDAaplPoXoCKLKl49llsuXPpJIf5R1yjKlDZYOw/UocMBeWAN8hS
         7prfP/6QPYpJGMhyV8sPj+X07H0rffS83rxQ5CeUX2UhcqjFpnXl5AaS6QG9ZnAuX6Ls
         e6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdWr3l6Lx7GA+PzAYzrOffiqrgjBeqJI1wVp2EC7E7E=;
        b=htQBPc60auRNwqqFBykyPoujtrRhD6eG7lft4j9/mdAJB2lQB93iyXZ9qIQzIo+lF6
         TxCnqfsvNAlAwXO5LvoFWaVg5YQTnKpFmWeBRSgNNslVNeMwZ0e80gZayQ/6IMl3+SKk
         XGmpTJ3kKYpDueZTCRYFumMtI69292PkJ0y/lgHerSAhMGvqmqR3yD8hRxrx8j/3Bk+V
         3mwK2zQww6LeMPZQwcKyw1+XKZyihSAvNm3D0l6PjAyqW3IUwW+INKJZnS6zyedEavUI
         Lv54tklklAElKvyh9a2dhUwZ5WJEb/NZQbhxYoh3IHRq0cyxKsZHcYjll5yAyAlTQVXh
         umdg==
X-Gm-Message-State: AFqh2koadQic3+/1u+GDeU6p3sWSHrMH+bA51pch6Z43Pw+1JAAEhG8d
        Hvupnkd1yLeM+7s2W4epL84rdGPSx48=
X-Google-Smtp-Source: AMrXdXu86Cu7Vhu8dR/ivQOr61yHw+oFpXa918y7P41GWKSUv4yM27EkJXJk2swk6TRHF+qRVHh3sw==
X-Received: by 2002:a05:600c:3acf:b0:3d9:fb89:4e3b with SMTP id d15-20020a05600c3acf00b003d9fb894e3bmr3108945wms.23.1673963722295;
        Tue, 17 Jan 2023 05:55:22 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:21 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 2/6] clk: qcom: gcc-sdm660: drop redundant F define
Date:   Tue, 17 Jan 2023 14:54:55 +0100
Message-Id: <20230117135459.16868-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117135459.16868-1-ansuelsmth@gmail.com>
References: <20230117135459.16868-1-ansuelsmth@gmail.com>
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

The same exact F frequency table entry is defined in clk-rcg.h
Drop the redundant define to cleanup code.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-sdm660.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index db918c92a522..6afce8e42ede 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -25,8 +25,6 @@
 #include "reset.h"
 #include "gdsc.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_SLEEP_CLK,
-- 
2.38.1

