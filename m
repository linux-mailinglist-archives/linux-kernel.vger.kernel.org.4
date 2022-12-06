Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FC6449FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiLFRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiLFRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:11:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B42409B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:11:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so24423126wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0eEedGwGTs0kfi7RPmjpdf2WkKmieSTXamBFgfWsLQ=;
        b=dyXoW4R5nzvhrF2ArwJVeg/RNvPFTxGysEkFtaM0+/WmSby6JpBEEzAuzb6dm/IUrO
         loetYRVTWv84boZgega8by8OHA894AB3cBdImVYzS/zG45qSdtvD+P+IrHwFWTQ9kaNQ
         dbXYFqDbgEchx56LERT2IZVmK/P54IfFI/v7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0eEedGwGTs0kfi7RPmjpdf2WkKmieSTXamBFgfWsLQ=;
        b=mq/rpQttbtxUydYgRv2UYWqHNYJg8Vdi1hHpGgiEZLWGaCaQBsIC3s1rVatFh+dAkq
         xC6bi74xMOuCM2CV/Iu3dySH5jwwl4u3j5NzPpnnSf/UHYYuNq6qLPyHveTxxkLpFhU/
         0VK2pjyHl6QAqBMyCxtwcf3wfnn39vBnrQSiTm52x058q0dhjv0Dtq5DzucNXeNt30E7
         NpYFLJLYKqqtNQNNfDTuglpuQ7zkz/ZrloAHZGBOqLZjyk20iO5PbuunnrLNI8xy4yFb
         EPTQIugHHRptVgnKMvQ34UGOSG3xlcUIjC6/immR8sW4lajyAxHenecRYIsYAowrWmoS
         ty7A==
X-Gm-Message-State: ANoB5pkeoXMF3RJz9Nw8TtcnRhCSndahKcC080J/h1qtef7kA4hebpUF
        H/eMdwtzXRAyRRkZVGwMVqy+gCGG6bhj3GzA
X-Google-Smtp-Source: AA0mqf5VYzXR0eKaEheU+DSuzIPtiiZXxadgFHz/ASXvN/BUlPG5unQLLOG06Nxd5Dcsf4wUCuWsVA==
X-Received: by 2002:a05:6000:18c1:b0:236:5d8c:97fd with SMTP id w1-20020a05600018c100b002365d8c97fdmr54257190wrq.473.1670346667896;
        Tue, 06 Dec 2022 09:11:07 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm17298534wrx.55.2022.12.06.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:11:07 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] ARM: imx25: add missing of_node_put()
Date:   Tue,  6 Dec 2022 18:10:45 +0100
Message-Id: <20221206171049.3316611-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
References: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mx25_read_cpu_rev(), of_find_compatible_node() returns a node pointer
with refcount incremented. Use of_node_put() on it when done.

Fixes: 8b88f7ef31dde ("ARM: mx25: Retrieve IIM base from dt")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/mach-imx/cpu-imx25.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx25.c b/arch/arm/mach-imx/cpu-imx25.c
index 3e63445cde06..cc86977d0a34 100644
--- a/arch/arm/mach-imx/cpu-imx25.c
+++ b/arch/arm/mach-imx/cpu-imx25.c
@@ -23,6 +23,7 @@ static int mx25_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx25-iim");
 	iim_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!iim_base);
 	rev = readl(iim_base + MXC_IIMSREV);
 	iounmap(iim_base);
-- 
2.32.0

