Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143576E4F83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDQRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:44:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD936B47B;
        Mon, 17 Apr 2023 10:44:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f0a0c4e1ebso17646445e9.3;
        Mon, 17 Apr 2023 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753466; x=1684345466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wl07vQ1AO+kNIizqaeliSseA8G5rkqNQsDitaTpZIc=;
        b=EEPaJN4zXOu38z1Cjv04aHBn/69AnpIvlOb/yelRxwWeryHfC6PWx3JXAqEADozrB9
         K44VBCPrdgpKlRm+gX8PBY5A89GXbc7VHcsyidPHE7NxGLDBTb74Ww+k/VsU8A/3xrxI
         Az8Yv/aQVfCWGByh6LWhTWeqmzWqZXOHNgU/eWFaJ3b4vraVMkmDIQmf+6PjkvM0mCdU
         Ce/407+2oE4KsCEUWG7xf1ep3U+i4hzRpNkvr3oInXFtvrGh+ocdzni0WtxIUu9hxhxc
         RMeaxxcCoqlRQrPjYv1r4vCsmDYwJVMjcrKW2tXHqOZzAPM5ksv3Kp3ekj/sfYGRWWs2
         dVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753466; x=1684345466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wl07vQ1AO+kNIizqaeliSseA8G5rkqNQsDitaTpZIc=;
        b=KaU/RJYwkB4YMEEmNv/9h9N90LiExgKtLFLCBiJmy0v149NFQECRItOWBA5mKnGzRg
         QbtVyipKb4YhwXx9Zawh8PG7RmlR3tP87NvV8HGe/dqxM86+E07eFXpbwza8Asml9Ssj
         aEtXKfSa2MlI4mpbbZQ7Gc5PVIVIPuJk8ppnEby34ccAgVUfZCJo9TbqQNlhvUN68Iy/
         YFNQW1vMFVmJCQHVumMyB1zdXzIgzjGDxdPTHNCE3cMc8bJtlhXqQWZg8eplLyuW5p5o
         9HV9ekg1zoIbj3yl06XUvJn2Tx6PBDOpviYhgG0TKKS0CVg6ZZ0tU2g97uDD5sD4r1kq
         wICw==
X-Gm-Message-State: AAQBX9eKqjCbqjE84bN4gx7j0O9SbbhwicAPpNkEFlO18KFdxRovPm1o
        KtqkIjrAbENnBFJzPaMov/s=
X-Google-Smtp-Source: AKy350axYaI3RgrUewJe+zqYDBluieZHARACOP6EU768NYQ7be2hn1b8turA8sReyvN3WU2DIgIW/A==
X-Received: by 2002:adf:f1ce:0:b0:2f5:a412:dabe with SMTP id z14-20020adff1ce000000b002f5a412dabemr6818264wro.3.1681753466280;
        Mon, 17 Apr 2023 10:44:26 -0700 (PDT)
Received: from localhost.localdomain (host-87-7-13-196.retail.telecomitalia.it. [87.7.13.196])
        by smtp.googlemail.com with ESMTPSA id f24-20020a7bcd18000000b003f09a9151c1sm12516155wmj.30.2023.04.17.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:44:25 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] clk: qcom: gcc-sdm660: drop redundant F define
Date:   Mon, 17 Apr 2023 19:44:08 +0200
Message-Id: <20230417174408.23722-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417174408.23722-1-ansuelsmth@gmail.com>
References: <20230417174408.23722-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.39.2

