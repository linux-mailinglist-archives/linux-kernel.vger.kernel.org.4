Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3336DE2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDKRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjDKRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:44:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D06596;
        Tue, 11 Apr 2023 10:44:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 21so404460plg.12;
        Tue, 11 Apr 2023 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm55R+I6Fh9QyLAsUWe4zvnL0s5hklOWhWWeIyefJts=;
        b=nd4d5HnurrA2+UmxIOciW7ei9VwiKyC6ni9K/L0auxtF1H/Pyp1P2YQEgKYh3eneHY
         iP3Qi8GCu4I5l0gNCCfPQnNrPTvtUyVl/9u9MUSmKoPJAZd2Eh9PC+cbiHJVidRbr2LU
         uSL78YdYnstDOXOHIdtPcgOkVzXMGlNM/f43TFnq1GgCFKTNF+/X9N7CsTdT/vd/nj2j
         U+Oc1gOCqTFpy42oSG2PIP8WT+GOuKmT/SN8OlRunZcGzN+0IGVt2VlSR5SZGdJxqPxM
         2UXJh7DTMJhjdgb03687WSvpZd+ESImDuKObFXQ953itsIE2F5MC8/EWqnBprmBOmnL1
         uLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm55R+I6Fh9QyLAsUWe4zvnL0s5hklOWhWWeIyefJts=;
        b=z/wLbeWi41Ex6/q+kGnSMs0J3/cz6VRsWD3o6dWoNSdCYvKwSzeLI8PaDWVorB/+1P
         VMRRaXaEiQl4Hqr0Q23Zm5ymbICtSbHOe5QMqG5ZOVFYb53J27flAc4s6GVrFrGT8p/J
         pXk2klxuv5a/UYv7ivaGRqo3y/6cTwofRdpRVeqxbTrnweHzJbCuk4WEWOiKrjtgd5zX
         YREu+W8skJZaFuHRr9yhJI6XsfKMaEzz6YrFEj8sD8NkSZplj7pyhQLBS1jaJJf+z6IU
         oIwqdd865b2hBSyKM6LXUbZHXwRQgXlR+wfSitMSDAJTz9Y2GXfovE9F685N9zr6Py75
         lfRQ==
X-Gm-Message-State: AAQBX9dbwRfuaU3MnU3w4DKhmbILsdvB0ZwYrFZXtTJfd0ySNKuZc63i
        HRya/e7UWH5j9mLiI1sUshGOr7CCjFnfELzXGQg=
X-Google-Smtp-Source: AKy350bCzvlZN7fN3RBeegbaYNxReBFdYL7XSdkcaTFSi7ERbqbV43BlBBQf7uUERrzUXd3Df9q6Iw==
X-Received: by 2002:a17:903:124a:b0:1a1:dd00:b4d9 with SMTP id u10-20020a170903124a00b001a1dd00b4d9mr21213220plh.46.1681235074860;
        Tue, 11 Apr 2023 10:44:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:44:34 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/13] clk: hisilicon: Remove hisi_crg_funcs
Date:   Wed, 12 Apr 2023 01:43:13 +0800
Message-Id: <20230411174329.424763-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411174329.424763-1-mmyangfl@gmail.com>
References: <20230411174329.424763-1-mmyangfl@gmail.com>
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

