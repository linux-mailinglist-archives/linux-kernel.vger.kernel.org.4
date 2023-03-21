Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2706C283E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUCcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCUCcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:32:11 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4539296;
        Mon, 20 Mar 2023 19:31:51 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h11so7481081ild.11;
        Mon, 20 Mar 2023 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679365910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBy7Uhw8n9XJJSSN0OA/4i8xS/Flp3zKZhGIeWwusVM=;
        b=iQatrVrSpMzWM30D/QDBzwK1QzX3H9/6UAnHFb1yBrZ6JUUw82BPT4EPusvdKi6pjl
         VuNXhHXYsPY0VGRKIy+IFLw9Rd2Zrad/wTtin7ziRywR5F3PfHy6TzJbdW0QD9TtFRPs
         FUSrOocS0aBhsv4wedUXG3LohtmMEzWfFfwLAHBDAA8Fi4ZmCz4sbxjcNlqrT49HgIkv
         mKIOPPmNS/VYSkKTIRvR+9qZ/cTa3lKow3n2Uh04LLP31Yt+y+r+Y6pYvshtyyGcWEQ7
         xAzRfovnLhDkFlLpPMaXkyG0Te9DdSXthpmauHL38b82JH0BbNKSBYf33V+sLcDaPwiT
         lPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBy7Uhw8n9XJJSSN0OA/4i8xS/Flp3zKZhGIeWwusVM=;
        b=yA3snMwm6qpI1yZXWRNF8V1q7xk+5Tp+hmEswu+C03a2Yo5PRx+j7R8vCCTBzGM6Fp
         TyNZFYE8nGzHzxU/NNUeZtTVVYde6WacxegIQDcetdB75HWQlaSdDeYUhpE/H03U/gwY
         YVaEddzDulOYpyLx59G0yy4jdHEDjpZ9ZjNknj2T2rOj1MCHWmTwLqqzghYiie4qGxh8
         Nt+6T0++VXrdYMQmFZyRD37L5T2TxdiLvOw6FsQHi8yntFNPxh1H7AY9aZ3USRCBnx1P
         voUb8o+4s1y9+fsBL6q9keKJoKoQztHiHvL0reWyUB5YDlsjfGMzqSK9q5TuwLQR1ILp
         LncA==
X-Gm-Message-State: AO0yUKULXSZ0XSbLUsOx+7PcNcmWwY+/f5Hh7h/O049Qs7PVHSf2umCc
        uhxMA8BPimPoxtMbroQEHRac/1uiNqI=
X-Google-Smtp-Source: AK7set9vcTeQrv+uY9TyXI19wR3n5BkdxkTtvMfVMUNnyt8RgvFbS0D7h3ZFNj2n45e0XVTDmmeRyQ==
X-Received: by 2002:a92:d312:0:b0:318:aac7:d7aa with SMTP id x18-20020a92d312000000b00318aac7d7aamr517200ila.29.1679365910474;
        Mon, 20 Mar 2023 19:31:50 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:1387:3268:b209:f4ec])
        by smtp.gmail.com with ESMTPSA id a28-20020a027a1c000000b004065ad317fdsm2241200jac.151.2023.03.20.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:31:50 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] clk: imx: Add imx8m_clk_hw_composite_flags macro
Date:   Mon, 20 Mar 2023 21:31:34 -0500
Message-Id: <20230321023136.57986-3-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321023136.57986-1-aford173@gmail.com>
References: <20230321023136.57986-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
V2:  Split into its own patch and re-order to fix build error

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

