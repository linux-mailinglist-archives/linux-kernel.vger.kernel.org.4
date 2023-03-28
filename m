Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A786CB3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjC1CVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC1CUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:20:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B765A3A80;
        Mon, 27 Mar 2023 19:20:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id le6so10257065plb.12;
        Mon, 27 Mar 2023 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7dJ/bjg1F9FQ9capUh4BLZhZjrrXicn0p5OerG2+tM=;
        b=NgMeXDWdQBj8d7ErGEkcrsqAL8i8QIJqB85y8OmhazOco61f/AsEf6bcIotiSSv5gr
         nhsCeIjFkFb/J3G/cqJtsReZ5jYUjMcZprCjDI1HrB4WY/W8zSZuT2vOPy/0+bBXvIRv
         lRnMUwuBOAidzIevUGiYBwT+hJ1E8c/77UoSk/xbLeNKXmbNots4SHULuyRQm7P+5dBb
         KPHvTG4vuF/YCTgW1NRrudlA3IovaoWCWf7F7E9xVjD3M3q6lyz4wiJuLxpPulXTrC0+
         R4RnkSvzODP6F66MZQ3u9Qm1UgMfzJygYcacWrhO5LOLHrxx7SAwORAkeOgo/BXZ+V0f
         bIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7dJ/bjg1F9FQ9capUh4BLZhZjrrXicn0p5OerG2+tM=;
        b=wYRRJhG2FWxu+ezmHlcnhLTocfdL8R3uKHumpebnF/Kr5+/NiRbtzk+qIoRbGn72hR
         eojn3WGNCbjwVIxA9ZaH/5g8dFb0mB62tRx64YC50ZnzoWt74bj+6TbN25+qXYyoIfen
         m3Wbv7XMPgrEWiIDszj3ydZkP8DEuDFRVn/OTNxTA+dgY8DM+y6QKht2TqTmtNZlv/aM
         ilLegc/emQ6Nal9Al7fmmWl9kQiHiSIDNNDiDP38HWUk/0cbupkVbD5hYH8SqiYucTWu
         d5sWBhq0md90+wBGgy6KMvNQaRq990Plo0RoJGfAKc6jqq45sAhy/flFGijgREapZHFL
         lHGw==
X-Gm-Message-State: AAQBX9f15nt0e5IXmQjqNZhH+y1Y9ek1wc8KhCi5Jt0/DuwvbwcV2ThF
        bt6gtiJJjolaIvxUc7dODFo=
X-Google-Smtp-Source: AKy350a09Q0z1OAREfN69d8V24aTLlOXOre3ocv7OCVWbE4J+go0Qi105oq10UXv6Bv8FBPGBEjPwA==
X-Received: by 2002:a17:90a:7062:b0:240:6623:733a with SMTP id f89-20020a17090a706200b002406623733amr7923003pjk.8.1679969994103;
        Mon, 27 Mar 2023 19:19:54 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:53 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 12/12] MAINTAINERS: Add entry for NUVOTON MA35
Date:   Tue, 28 Mar 2023 02:19:12 +0000
Message-Id: <20230328021912.177301-13-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
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

From: Jacky Huang <ychuang3@nuvoton.com>

Add entry for Nuvton ma35d1 maintainer and files.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc8bd26b6cf..a3912717f1da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2501,6 +2501,15 @@ F:	drivers/rtc/rtc-ab8500.c
 F:	drivers/rtc/rtc-pl031.c
 F:	drivers/soc/ux500/
 
+ARM/NUVOTON MA35 ARCHITECTURE
+M:	Jacky Huang <ychuang3@nuvoton.com>
+M:	Shan-Chun Hung <schung@nuvoton.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/*nuvoton*
+F:	arch/arm64/boot/dts/nuvoton/*ma35*
+K:	ma35d1
+
 ARM/NUVOTON NPCM ARCHITECTURE
 M:	Avi Fishman <avifishman70@gmail.com>
 M:	Tomer Maimon <tmaimon77@gmail.com>
-- 
2.34.1

