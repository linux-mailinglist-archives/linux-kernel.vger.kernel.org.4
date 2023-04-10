Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274056DC615
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDJLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDJLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:09:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C12D64;
        Mon, 10 Apr 2023 04:08:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso2399376pjb.3;
        Mon, 10 Apr 2023 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm55R+I6Fh9QyLAsUWe4zvnL0s5hklOWhWWeIyefJts=;
        b=QZZwomqAKqgPrLmHpiNCTDhpASuGXyGlV2gMesa5ET0pUu7XtMR5IFyi8Ptdy56juA
         SqRglU0cn053f6hO8ZXkPP/Hs2+UWSDS0Hdvnog+giVh2/5iEY0iOb7QXuCwLsHHvUGI
         vVFNguvZ7Bhy3h1pV0ndpMbcZYyCBumAblU3dYu46VVvcUcE8RdP8exx5ui9GjL949LL
         OtjDAfnSUkyc4xzhn4uescN8wW1ZWW7AV6SFWf2bAFjkPJejDji7OvseElBlvrgEgF/j
         QhhIt985WglWCVwmznMdplJYfNbTw8jgviyJj8SDkiBtdP3d7DltCKRg9gz2JsBz699X
         GL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm55R+I6Fh9QyLAsUWe4zvnL0s5hklOWhWWeIyefJts=;
        b=JwN36lSvwTZkoF+ffZv3Lg2VNIHFTvossZaD5s7AjTxRMka4l78MfopDJeB/6talTg
         sYsq5RlF3QrJf1UfhJLewwlYrYiwUxVAR60LX7IR6OO+QRw0AZsQ+O9WmMdt0AzC+tbs
         wwD4gG1vpd4ULHOP2muz5zgZ7UTT2bwzXgGkFESSYTnHKEAIJsRMVwiMH9S7VkH4GiCl
         F8xXlIBt708CirnJ+SzXdLLeoqRQGY87n9OtxOWPp8CpckYduv1db9ytZc8u4lQe4DOE
         XyC0zcJdy6HBfatcrxCGuK1LPdX/fHO09ODjraV+uNIqU1xBGFnJEDI1SG2Pss2owrcb
         4YuA==
X-Gm-Message-State: AAQBX9dY4YjasTk4p4Ul37QbCfykKUJBw09hnlrqa1HFoygvOcW66xz3
        qpzRSIqfrF7zDA2EXCl4cxYy942oXZKzLyWH/2k=
X-Google-Smtp-Source: AKy350Yj0sDA/B73/NarcMPEbhw+8UVcZDAmPrYrvHh8ykHdZP4VkaCn5vw/tJgNAm2Y7BMFVLbkHQ==
X-Received: by 2002:a17:90b:4ac5:b0:246:9374:febb with SMTP id mh5-20020a17090b4ac500b002469374febbmr5819566pjb.19.1681124929054;
        Mon, 10 Apr 2023 04:08:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:08:48 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/14] clk: hisilicon: Remove hisi_crg_funcs
Date:   Mon, 10 Apr 2023 19:07:17 +0800
Message-Id: <20230410110733.192151-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410110733.192151-1-mmyangfl@gmail.com>
References: <20230410110733.192151-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After refactor, no one use hisi_crg_funcs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index d9544f1f2625..49142759d63b 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -11,15 +11,9 @@
 struct hisi_clock_data;
 struct hisi_reset_controller;
 
-struct hisi_crg_funcs {
-	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
-	void (*unregister_clks)(struct platform_device *pdev);
-};
-
 struct hisi_crg_dev {
 	struct hisi_clock_data *clk_data;
 	struct hisi_reset_controller *rstc;
-	const struct hisi_crg_funcs *funcs;
 };
 
 /* helper functions for platform driver */
-- 
2.39.2

