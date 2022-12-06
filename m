Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401CF6449FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiLFRL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiLFRLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:11:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C61F2D76D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:11:13 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h10so14889574wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTKzSC4xiELtOhvYcPg625CE+pmvLexXVke2DqyU21Q=;
        b=jBQD+O7XNs5SbP+46Ou8Fyj8CECu5cE2sdTpHJmBujn+wNPZOhaoLoKc0GCA9Gwq+G
         1W76vEZ8MT1Ki6hKHJmSamfFN23/9WUPMg3FLo5RE+CBZw8/MKoEOrQcCBc6raTMcr6m
         awNNnOPDL1KREISMcuOhPUhoWkJRWzRXpKnqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTKzSC4xiELtOhvYcPg625CE+pmvLexXVke2DqyU21Q=;
        b=3Q9N77Shutp1fcaosCr9SGmYFtFvPUeCmHFvDxVZ5XXfHyl9SaZZaIB2hD2JA5/lKC
         zfEHT6ogpU/12TlSoKussdEcsKkJG9CN48duhKMPGxMAHwNvWha3T/Fzg/lZK2a3zqC+
         oh81uYgUcA1vxoxm5KU4sVNLBjBL7bEs+ujKwvIdLWLOi9Rsl5wPnQlGcsEFwy4OmqzV
         bLN+Nra53HEvSPnJ+UCPQeo7Qt6g9rnGZD/FydNYq2S+xJYhxmddVCo3dvIY+nbGkjPD
         1IkVdbmYHNO8Cs9zkncb5YkG5kACPO6RqXBcWWpx0AKdVbvXsWlcLTmoj1wjo7BuAf+6
         GUAA==
X-Gm-Message-State: ANoB5pm/f1PLurEQkM4SaInWqu1ip8Mt070TwLIt+bxwZpf1FsU4jxeb
        l63NfpRFmJdYSdth5PKVrbzfCySQDmybOd2T
X-Google-Smtp-Source: AA0mqf46qOghPsTK5SHdLa1G/B2hktQOKTAgXMfUJJ8bJ8Lem5+VEr3rDWh1zK2Rir3AyuSd6Vrewg==
X-Received: by 2002:adf:f54e:0:b0:242:1534:7b57 with SMTP id j14-20020adff54e000000b0024215347b57mr26622429wrp.404.1670346671934;
        Tue, 06 Dec 2022 09:11:11 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm17298534wrx.55.2022.12.06.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:11:11 -0800 (PST)
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
Subject: [PATCH 4/5] ARM: imx35: add missing of_node_put()
Date:   Tue,  6 Dec 2022 18:10:48 +0100
Message-Id: <20221206171049.3316611-5-dario.binacchi@amarulasolutions.com>
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

In mx35_read_cpu_rev(), of_find_compatible_node() returns a node pointer
with refcount incremented. Use of_node_put() on it when done.

Fixes: f68ea682d1da7 ("ARM: imx35: Retrieve the IIM base address from devicetree")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/mach-imx/cpu-imx35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
index 80e7d8ab9f1b..1fe75b39c2d9 100644
--- a/arch/arm/mach-imx/cpu-imx35.c
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -21,6 +21,7 @@ static int mx35_read_cpu_rev(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-iim");
 	iim_base = of_iomap(np, 0);
+	of_node_put(np);
 	BUG_ON(!iim_base);
 
 	rev = imx_readl(iim_base + MXC_IIMSREV);
-- 
2.32.0

