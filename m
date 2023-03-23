Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC36C735A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCWWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjCWWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:48 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08D2CC78;
        Thu, 23 Mar 2023 15:51:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p17so80013ioj.10;
        Thu, 23 Mar 2023 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwzADQniZ1WNKPleXotCSep6PL7MAO9u3e2Lj6vkwpY=;
        b=WLgLJsY4lIu9scZZcqsQQ6Sz8ntBRk+sXuRTKwSgb3DiniWkIOUieBrTIM57f25oEx
         5nBbUfPHDHIG6L8EQuDrZYcglLKg1UQ+KvFn7uJanaY8QCypPJNMR6CndCXmwWUwZrBi
         AK7j1vZa0u7HPq9t7A8NQ6MUfpyD2mTRUURPuc6I/B3/rWkWQC4EEDDFy+iCcL2Q5tja
         Z/NM41rKoun0LJJaCEQA4O0xhh9x443XRtE0KG5pO92ORfhhGd4+QmGX3XSydkKzjb6v
         6D4zo5SqatR8pHLJuMi5R1RLfOz7G596wQou7aAmU0yVxfvNsQtecpt24JV82uQ5ygMa
         UeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwzADQniZ1WNKPleXotCSep6PL7MAO9u3e2Lj6vkwpY=;
        b=SWXTYffFhQDtGp6o8QUYcRR7wOT+ctifXs43iSQ+NTxlmA+hVIr3B7kw67Mn5mvTRp
         c2Wslep+bCGoPkrxNy+Xm80zRbXxbwdMmoLLUNsoQwqaQOBznHUZNqSxlIwYtFsRD1K0
         lDA+tFsxwh8+kIIwqoQhZNE/RYvvd1M29DnB+xegA/h47z0c/eTPkirXZ0J7HJ7z/BYj
         FJW0NEoY+7Xb9f/c7NpmCfjLIFREZNtoSsbUKKBpWqRvHFtHJ26n4E4o/jUMRg52vYox
         NvJ2BPz1pqLuHMcLEUUL09mT8F3bbubhwoJujBy+fBhlTcMGRup2gcliLKeidj3N9Qse
         CDQw==
X-Gm-Message-State: AO0yUKWZYO1vwuHs4fzCcCLedh+agwxxpHIxu0yxAtSbAtfF2ln+BTZb
        EXlHu19uHlNFlijoUb2iIa7aI5WjLqc=
X-Google-Smtp-Source: AK7set/3x35JehsbnDVlYQVfBzkh/qwX6SheUjt6AoIu4EFxebli+D1Axx7KPL/nwJ1xY1w7umkFTQ==
X-Received: by 2002:a5e:9813:0:b0:750:a574:7c3c with SMTP id s19-20020a5e9813000000b00750a5747c3cmr603659ioj.1.1679611902844;
        Thu, 23 Mar 2023 15:51:42 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id f102-20020a0284ef000000b0040631e8bf89sm6266988jai.38.2023.03.23.15.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:51:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] clk: imx: composite-8m: Add support to determine_rate
Date:   Thu, 23 Mar 2023 17:51:25 -0500
Message-Id: <20230323225128.117061-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323225128.117061-1-aford173@gmail.com>
References: <20230323225128.117061-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to imx/clk-composite-93 and imx/clk-divider-gate, the
imx8m_clk_composite_divider_ops can support determine_rate.
Without this the parent clocks are set to a fixed value, and
if a consumer needs a slower reate, the clock is divided, but
the division is only as good as the parent clock rate.

With this added, the system can attempt to adjust the parent rate
if the proper flags are set which can lead to a more precise clock
value.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  Change name clk_divider_determine_rate to
     imx8m_clk_divider_determine_rate to match naming convention

V2:  No Change

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..3b63e47f088f 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -119,10 +119,17 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
+static int clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	return clk_divider_ops.determine_rate(hw, req);
+}
+
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
 	.round_rate = imx8m_clk_composite_divider_round_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
+	.determine_rate = clk_divider_determine_rate,
 };
 
 static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
-- 
2.34.1

