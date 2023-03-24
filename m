Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBADA6C82A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCXQwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjCXQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:52:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381CC20A04
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso2189477pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679676763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hAMVuew/XpfZidvZRKjun+NiVbRnaAGsA3f7GMnLNc=;
        b=gXTFgVCfp4dfhrjwiSjmzdJFjjbDr0XWRtyMeoXcEkHUnJLXWtzw7+90s/RtmAF7Lo
         k6NwP0A6A4weLIztatm+DDagdmP9IFQYg8Mx+4C6o+5iFvDBviV5TEQfPeBY6hTg2rzc
         nB9Q7+9bTkLO7gE8QlBu1ufQPCDGk67gyP6nz9JQMvu3u4yyL7ua/QML97fvk6y4hlso
         QOWmJRW4S6Zjhzk01o2kMDAPHQUd6swFkg7mVcr0CM9TY06FbiX2m2lvFHfN6pTKXE2c
         IJDsEuohFIshLmSAPblKmw0VThZ9NqxYr5MYyTgLjzDP1TLwGdlDDFcl8D0L2pnbGTTk
         SO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hAMVuew/XpfZidvZRKjun+NiVbRnaAGsA3f7GMnLNc=;
        b=e6tR+Ot52l8/AZd7JMC3Vyc6leHPa0wp00Nmhbh59yrubRrTi9rBaZhaZAcn7VLt0u
         4Z1vafDXxpXy3+UJVaFNHTbJoEVSgWwkhTwfJMfqRt9V5Q0i8latnpbYhEqiY/Uvm4qc
         BFIxHHdzYYKV7nKOY5EcdQ7/59PasFQDKBnhfZB4kP/GbcyeTpv/CLxEnGy8DTf2vVUb
         i07h3T/bCxa7fG24NodR4N9SzxyPHxyZW2+GtsifoaLZmuT8/r+SlsIzOYuYFVZn7Qbm
         NXU4NMjvDJYPVQ69mHvMH7L5uf0+VpvULZgO3EqKjVDR0B6c1ttfgTA3TOxtDRxULyG4
         svyw==
X-Gm-Message-State: AO0yUKWqkGRs9veJ/JdGM/zf1XM0INyXct/PiylsUni+yIPracFWZ7pg
        NNhGQLekbe3Mf/7eeRbo1OSeTLuDtZ0=
X-Google-Smtp-Source: AK7set+kSMmDMRXmTWJZtXu26zU7zy5hiq7SZCQudu5LW5A80adRBp8KrgUw8ykU8g2H8/aLlEDNmg==
X-Received: by 2002:a05:6a20:c320:b0:dd:d1f2:f1a7 with SMTP id dk32-20020a056a20c32000b000ddd1f2f1a7mr3297441pzb.27.1679676763272;
        Fri, 24 Mar 2023 09:52:43 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b0062b5a55835dsm1420289pfn.213.2023.03.24.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:52:42 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 2/3] Documentation: sysfs: brcmstb-memc: Document new attributes
Date:   Fri, 24 Mar 2023 09:52:30 -0700
Message-Id: <20230324165231.3468069-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324165231.3468069-1-f.fainelli@gmail.com>
References: <20230324165231.3468069-1-f.fainelli@gmail.com>
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

Document the DDR rank, size, total size, width and type attributes.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ABI/testing/sysfs-platform-brcmstb-memc   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
index 2f2b750ac2fd..bc969c02b85f 100644
--- a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
+++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
@@ -1,3 +1,42 @@
+What:		/sys/bus/platform/devices/*/ddr_rank
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		Displays whether the device is single or dual rank.
+
+What:		/sys/bus/platform/devices/*/ddr_size
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		This field specifies the size of each DRAM device in the first
+		(or only) rank
+
+What:		/sys/bus/platform/devices/*/ddr_total_width
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		This field specifies the total data width of all DRAM devices
+		(in each rank)
+
+What:		/sys/bus/platform/devices/*/ddr_type
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		This field specifies DRAM technology type. Possible values:
+		DDR2, DDR3, DDR4, GDDR5, GDDR5M, LPDDR4.
+
+What:		/sys/bus/platform/devices/*/ddr_width
+Date:		March 2023
+KernelVersion:	6.3
+Contact:	Florian Fainelli <f.fainelli@gmail.com>
+Description:
+		This field specifies the data width of each DRAM device.
+		Possible values are: x8, x16, x32
+
 What:		/sys/bus/platform/devices/*/srpd
 Date:		July 2022
 KernelVersion:	5.21
-- 
2.34.1

