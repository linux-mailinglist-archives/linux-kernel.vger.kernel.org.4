Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA1634809
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiKVUXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiKVUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:22:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BD10B74
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5so11621431wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCqlZr2lsX82yywXjBQS18B/y1+dk9GDAwKnysLZkuY=;
        b=LKonaoW3uZgZyzbu+m80gqujnFji9Bh902FoIkjTku9LuXRKTLKQ5QQDRZQbF3WOSl
         I9l7CpnvmgpidgOjiCuoQwCYr2IUeQdDI+yStCOiaHzjg/i1Fm2hDNRuzRaSsFHITyyF
         X7nPgv2swo7EgJ7qVxTSNWOq+anJQylWuzJ62tNhsJ2EIWk/605qdD0l5dXl6WHLXuxd
         o26oO/K54eVgl5JTgNjSIRqLvRYaHUdIcp8Qy1PNpaXX7sqbtWvvLMxPJgRlh0tB6Jsy
         mWB2RXV8TjfAUlkws83BX0I0Bon3KlxumfEeSmTZTyE9it51BI120Tn35woo6LS7aMGc
         6Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCqlZr2lsX82yywXjBQS18B/y1+dk9GDAwKnysLZkuY=;
        b=zy6AKUkzy0eU537vIgFL+NstoEl9HVwlljXfF9orGHTkQPsxzvN7mvQorBK16NxZO7
         +kbwNgC1JSVhcQ1TU+dKZtpap95Ib+cRWuosetd9OI1VDMbpOYb8yuQipMLuH6SyuIOH
         nri9UUEQoihFgmtDsJVpUOEE72ytwQsvJp4vemgkANEhqk74Ys01juTL/FyvAbSeMko1
         cOu/iVAEWoMqEOVrXvbCCM72FhuKgpo2OpO81BaY5fgTRLTMkH9+H5Hh81cr2f4MzZvY
         jQLIOWgoL5V35jCwH7ZP4IRV9g29Wb/A4zcCuJ+soSqhdsby5UtHiWrWEDk3sWnq5llS
         xfVg==
X-Gm-Message-State: ANoB5plHZl6ol1ValUvi27rDCGuV/0QuEpjflgj3x95ps4oVHKiL4sgu
        sc92OsfmHgIU7rJ4jUlndbk/xg==
X-Google-Smtp-Source: AA0mqf42Iv+QKTsWCowTCY9AOPRzI2n4jRx5YeN6yzDaWhJGez5LdFgyU/u2ndcOf/08Cl2FPhi0Dw==
X-Received: by 2002:a05:600c:2241:b0:3cf:9ced:dce4 with SMTP id a1-20020a05600c224100b003cf9ceddce4mr17400000wmm.120.1669148573586;
        Tue, 22 Nov 2022 12:22:53 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:53ef:17fc:fb98:916b])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm25718555wmg.46.2022.11.22.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:22:53 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 1/3] arm64: arch_k3: Removed ti mailbox and sci select
Date:   Tue, 22 Nov 2022 21:22:43 +0100
Message-Id: <20221122202245.449198-2-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122202245.449198-1-nfrayer@baylibre.com>
References: <20221122202245.449198-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build ti mailbox and ti sci as modules,
remove their automatic selection by ARCH_K3

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 912529ac58b3..5f16eb498dbf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -126,8 +126,6 @@ config ARCH_K3
 	select PM_GENERIC_DOMAINS if PM
 	select MAILBOX
 	select SOC_TI
-	select TI_MESSAGE_MANAGER
-	select TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
 	help
-- 
2.25.1

