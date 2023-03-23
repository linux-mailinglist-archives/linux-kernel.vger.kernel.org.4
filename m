Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8076C735B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCWWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCWWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953442CC74;
        Thu, 23 Mar 2023 15:51:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k17so99287iob.1;
        Thu, 23 Mar 2023 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679611904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB081nZVc8dV6VyELhQ3vJcnmVLV2KlhEV8rp6VNfxY=;
        b=DevLSpZI1a3F/+379l0Zvj4w4XbRQvDKbOpvV0cg607xGcW5H8AV0vIqnaJ+2uOLDM
         qYioT5oSWGj/OvxIdVR6D58xOqo8W9QIgJEprnIDSkoCN0A7fqHPU7QcnCIW6uFCYGx/
         WZ9kAIOMJ3+EbrUHZE3KkJ/VtCwElycR5fqU5snaNd5KmNxUvs7P7PrSOdjgHA3aNZwb
         UvFltyjGpeIVKmGLOn62W3mh+rjVDuwVh+rDCmdqKQfIinj8sQ2WA8EZFTcKhPQYF5CS
         Xh6YW/7KTAuQjlzimGJLELBzUwYUU3d5RkQLaOo5cxZgrvRjNYPw8WI847Xj5Ny/kXH9
         Z7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB081nZVc8dV6VyELhQ3vJcnmVLV2KlhEV8rp6VNfxY=;
        b=zSAsxEJPsxV1CSm48llqG7sNBMISbg1vmc1GaNQT3FkkVXq+kAz8y0H7xj+AOlevVo
         XNUkUvjYicCmD6GZI89pCydg+npprnUUiTie5Z0gKceNqSBW4WESoDTemxYwrN/8o8+C
         FDGFRyrMcIKCzV4eMIcKaGW+aDTuPktWKGVto8CR9oKfi54T4CAPqQAl9i2JJuSEsEJy
         y0BlyAb1Cu9QufGfUVTIJJ7e2a8wNxoJ9c4tAX7rDU7fmuc7eT8EvcuP3ZMIMOt81nAg
         ZNaGRb80PF3zG333fOpVWMpkKu+Bzvc9Kupe9Fgi4u2GknhWcYSPKOvQIc28EsSGmViy
         eBOw==
X-Gm-Message-State: AO0yUKXqEbJkzHR1K9JEnWmczhOJJGw8KAdjQEp7qUk3f6uWHWFwSEX0
        scwxSAhijc3TzlWGU8TwJZg4olaREVU=
X-Google-Smtp-Source: AK7set8ak+pGnjfuehu8Nk4l3mhAMokOhWPHXUploByWew8sAVBHMzAFrRekwGB4V7Ldzfcp5YKZag==
X-Received: by 2002:a5e:d606:0:b0:750:6c44:3454 with SMTP id w6-20020a5ed606000000b007506c443454mr563080iom.12.1679611904360;
        Thu, 23 Mar 2023 15:51:44 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id f102-20020a0284ef000000b0040631e8bf89sm6266988jai.38.2023.03.23.15.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:51:44 -0700 (PDT)
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
Subject: [PATCH V3 2/4] clk: imx: Add imx8m_clk_hw_composite_flags macro
Date:   Thu, 23 Mar 2023 17:51:26 -0500
Message-Id: <20230323225128.117061-3-aford173@gmail.com>
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

