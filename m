Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA16449FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiLFRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiLFRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:11:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B978F2FA5B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:11:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so24440579wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmzucAOYeRO1Za2FBpNv+O/C9sORhwUJDwZR4toHbGw=;
        b=MkbkbT4elwmyTpFZMWHeouGW8MXnzkaicMClIaoEPhafVK6G/gOdEqkoCthjepgvjI
         zEqKhpIuaBMlQNFJh2elQbq49ozfBehJl8b7swZPkU8nDYLb2edrIvRhKfoRaWLFoI2I
         CjpxHQ0b/PEP/AKvsDPjtQ21In0cGNlRH6rBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmzucAOYeRO1Za2FBpNv+O/C9sORhwUJDwZR4toHbGw=;
        b=24L9pbc33pt3b4qH5o7BbJoHzvn9FJTfEHYGCBTjrLaBXSYgNTWGWRERq8HV3WPdCp
         NzO67af1e8cYYWk+Kjq1XrMxD2xmt1MGb+pPLVGyjWkzW9utNc2jXR+cHr3hIkUfHZM3
         BCdf6qFoA4IMakTgWXJEj6jQFcIAhorI0YcNqIJ3NKPE1stdX1EfuImgQD5w/5ATekOP
         i3RASmPadP+lBmJ1cuYI+i+zYGvmneyVsLPVTxnM2zdZKZWGCsil5clPkjPCWPJQTkbk
         2AYPd01fWG93UQEmih0drrMhTRsqd8htiuP2/S6OT1yIJenfS3/BY57hKuQT8NVuIRPs
         uHUA==
X-Gm-Message-State: ANoB5plFmJduH4JcYeB16/ckp6InKFyTQVHGB+XzBR5N0qQn38tv/+aM
        vkPnb81ZyiulaAKjAprLnA8XcG6FtJ1VKUow
X-Google-Smtp-Source: AA0mqf4Wm8rkIFD1VSowgEiyUmqd7dnA3qkC4S1F8gLh99B7TegLePQHEbez1bAclFIrsmYtMKkLtA==
X-Received: by 2002:adf:ff90:0:b0:242:46f1:1de0 with SMTP id j16-20020adfff90000000b0024246f11de0mr10925436wrr.640.1670346669143;
        Tue, 06 Dec 2022 09:11:09 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm17298534wrx.55.2022.12.06.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:11:08 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] ARM: imx27: add missing of_node_put()
Date:   Tue,  6 Dec 2022 18:10:46 +0100
Message-Id: <20221206171049.3316611-3-dario.binacchi@amarulasolutions.com>
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

In mx27_read_cpu_rev(), of_find_compatible_node() returns a node pointer
with refcount incremented. Use of_node_put() on it when done.

Fixes: 94b2bec1b0e05 ("ARM: imx27: Retrieve the SYSCTRL base address from devicetree")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/mach-imx/cpu-imx27.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx27.c b/arch/arm/mach-imx/cpu-imx27.c
index bf70e13bbe9e..1d2893908368 100644
--- a/arch/arm/mach-imx/cpu-imx27.c
+++ b/arch/arm/mach-imx/cpu-imx27.c
@@ -28,6 +28,7 @@ static int mx27_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx27-ccm");
 	ccm_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!ccm_base);
 	/*
 	 * now we have access to the IO registers. As we need
-- 
2.32.0

