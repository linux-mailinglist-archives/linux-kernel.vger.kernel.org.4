Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349F6C73D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjCWXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCWXBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:01:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50EB464;
        Thu, 23 Mar 2023 16:01:33 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s7so94715ilv.12;
        Thu, 23 Mar 2023 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679612493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB081nZVc8dV6VyELhQ3vJcnmVLV2KlhEV8rp6VNfxY=;
        b=X6UBU55JTHWlJqMB3S20dS+Wy+yffRoBqr+j3zoDuWC0/Mi4B4FuCuIWN4McJwLwTm
         wNOeVDKR3MMRFr4lDsfweYTODJz32M5fWi7wDAFuOwxF1tS0CuT08O5UdpozWSUmwNK8
         yqt3bISWBB/0zrnvFXUtxhdxruhcLK4nmJoeHsXX6WI0v8447WCou5u9cAAPHtV4hFwp
         IR+5fy8SSv1jVeBPB/1TEtptRXWd7ZOzj7DpCSlNzLeL8uAREwnInAnZExQcMVJ3LmoE
         HrUhlZqqb1KwoXuYRYrgUuHzEKbzMB45JlBDeGjNnA0VVF2Gv46TjKf3K4jk7UjJ444j
         cuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB081nZVc8dV6VyELhQ3vJcnmVLV2KlhEV8rp6VNfxY=;
        b=JPXmFKdWnONSn+r7nQuY9DT2kwlrr2DlGJM5pVRj00XYkc1Bs+oTniAIAug46R5Qu7
         y4PS+clv0BnKp//Cbe5/dfkfz7RQU0FiAX0YMHo3jnQu/WQaBEdSiCHOfxLaBuiZFOH/
         o6vd9MRLlxbqcLCYNxUBNdiwbl4RL36YQkTlNRAfeXQ8vdG450Lakl4Z3ceqXK5DHPbf
         uirlCF0NK3SzZaOHvp1Cz7ORqRz80Oz2vWU2Xwn9tGrEVQBaw70Oqka844oOQ4g03bUk
         +R3M7dcTVMXXkQsTXkDnv679NFvtmxwYntKxzWx5j9TE2xUVuo61q1XTSKrJSxVERZ6j
         hPJw==
X-Gm-Message-State: AAQBX9cRx+eF1fBLjw1Wh7niySxW9WurkpCk4LXbD90OHmuYkgSZnGiu
        rzxfx7yO0lNfTkLfWNv3CRgPiRGJ2Ao=
X-Google-Smtp-Source: AKy350bCXvTy/YRdJXkCgkE98FughAgIeIl5gAg2lVjYZrSOt6dZAG/XykJ6Fo8r/E9EmWO1Cr561g==
X-Received: by 2002:a92:ce06:0:b0:325:cf0c:e578 with SMTP id b6-20020a92ce06000000b00325cf0ce578mr1001324ilo.12.1679612492744;
        Thu, 23 Mar 2023 16:01:32 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id w20-20020a056e0213f400b00314201bcbdfsm5405492ilj.3.2023.03.23.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:01:32 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] clk: imx: Add imx8m_clk_hw_composite_flags macro
Date:   Thu, 23 Mar 2023 18:01:25 -0500
Message-Id: <20230323230127.120883-3-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323230127.120883-1-aford173@gmail.com>
References: <20230323230127.120883-1-aford173@gmail.com>
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

In order to set custom flags to imx8m_clk_hw_composite,
split it off into a separate macro which can accept additional
flags.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3d94722bbf99..621b0e84ef27 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -417,6 +417,10 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
 
+#define imx8m_clk_hw_composite_flags(name, parent_names, reg, flags) \
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT |  flags)
+
 #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			0, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
-- 
2.34.1

