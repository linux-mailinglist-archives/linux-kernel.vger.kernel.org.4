Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D29600052
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJPPDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJPPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:03:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A3419B9;
        Sun, 16 Oct 2022 08:03:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d26so19844344eje.10;
        Sun, 16 Oct 2022 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FJ7/YP2hXS1vCrLDjBwuedubr0y59mrPeF+JZZ90fI=;
        b=Oew1i3NVCMoZZdQLuEGDPYbnBZgkBemMYRY0r7R1w5Z/ERIcFek+s7X/04rra1pJDX
         7LdhJxuTzW7INr9stEfrMMExZmWIre6R2pVnfciRy+uPNKIpsfBrFfQjDN5YWXyEVKWS
         XJXGN0deN0tfUH8WV1QCo8qbidvFnvnjjWYqctNJ/iXAvcn1rmPjG6MIMLTxSaHEr6Gs
         GdHh7pBhCvOrk3BQFlH4ZWvoKhkGrbuQnk2XxS6qD4wCEq3fEccchXOLsxnR8y541N+u
         0up5oEEoBMUFW1mmJv5rhMsxEfPRJh2IwKvQaBXsPlPlG5HIjDxdqkupY/GMbkDXEpNw
         sa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FJ7/YP2hXS1vCrLDjBwuedubr0y59mrPeF+JZZ90fI=;
        b=NaUTHKGtlGBrn+qJyBDAWdynLP3eKbvGYi4o++KX3yZgeKhuRW9/xzXdbYTnhrEXAG
         5NnmUQ3eDlneUjm2F28c+J/yB67C67lZaVQoMYrcvFFkcwSdZDpvGd59i8Kv6/P+4oNR
         44c0RIM8iGTdYICpjY26ZsvSXYCp71VbMCBVJeMLUsgiZFYz4OAXDjPtV8qssDmUPIxX
         Cg5Mjl6phJpOV76ujApAz0lliCEOxp8DYjcQPYETtlSlP/cSp6xxjKXeuT52rm2pYGhP
         iwReQptW8OCyPf8iMSEOo9od/u8yt00oO4K2NCz2hjPfIzW8Qf1H1fe+xIWQSb5jREGE
         gJXg==
X-Gm-Message-State: ACrzQf3tf1C/eKa1rw/j/SGJ6sBGST0rL93eyeOCsPbflBH4yRovaYcG
        +iky9q05lN0qeyV/AGPlIbw=
X-Google-Smtp-Source: AMsMyM4sA5Z6mE6yrCb0Y2Mfw0pJdyAkAD+acsbSybrO901BKkvarjRt9ycDR25jrs4FSidj7mR9nw==
X-Received: by 2002:a17:907:a054:b0:78d:7822:3108 with SMTP id gz20-20020a170907a05400b0078d78223108mr5322987ejc.764.1665932589479;
        Sun, 16 Oct 2022 08:03:09 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-39-7-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.7.39])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090657c800b0078c1e174e11sm4645699ejr.136.2022.10.16.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:03:09 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 1/4] MIPS: ingenic: add new machine type MACH_JZ4755
Date:   Sun, 16 Oct 2022 18:01:06 +0300
Message-Id: <20221016150110.3020451-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221016150110.3020451-1-lis8215@gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

which is close to jz4725b because it is actually a low price
successor of the jz4755.
It has the same MIPS32r1 core with Xburst(R) extension
MXU version 1 release 2.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/ingenic/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ingenic/Kconfig b/arch/mips/ingenic/Kconfig
index f595b339a..edd84cf13 100644
--- a/arch/mips/ingenic/Kconfig
+++ b/arch/mips/ingenic/Kconfig
@@ -4,6 +4,7 @@ config MACH_INGENIC_GENERIC
 	bool
 	select MACH_INGENIC
 	select MACH_JZ4740
+	select MACH_JZ4755
 	select MACH_JZ4725B
 	select MACH_JZ4770
 	select MACH_JZ4780
@@ -53,6 +54,10 @@ config MACH_JZ4740
 	bool
 	select SYS_HAS_CPU_MIPS32_R1
 
+config MACH_JZ4755
+	bool
+	select SYS_HAS_CPU_MIPS32_R1
+
 config MACH_JZ4770
 	bool
 	select MIPS_CPU_SCACHE
-- 
2.36.1

