Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11989670E70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjARAKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjARAKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:10:21 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552F29E27;
        Tue, 17 Jan 2023 15:26:22 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id s26so7844620ioa.11;
        Tue, 17 Jan 2023 15:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAVUtctQOsJULJkFQ+EDOKUXUcuZg9HwX/LxnX7RqR8=;
        b=Wxf2BnWMw3J4njBcOKZRazblqTaQMXpmC+ckJceKJP/RHwT/JDQGFegr1QFUv6L1nl
         5TXrc4wG8crKS3WMDOn8HdKrOKLcHiGo0PkxERVe1Q5SDwid5h6+2n0B0cyJCRLO+gyK
         nRd8JxwiYWeMank02w3/Jfpoqx1PsvhQb4OjX5pjenasm7Eromnd3HtnZm0J55QZXSK4
         /M907lwKA/b7C+QydiTd/y9mZARbJDTXW3ou0NeuEQHbp5d3dPgIybph4sQTSpTUo6Om
         sS+fsWE+Wz1L2xLCs7aZrC11OPzD9xm9sDuL51fCQAQ+OuN/pTzZtOXHTi4/7Dlyn5K+
         oQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAVUtctQOsJULJkFQ+EDOKUXUcuZg9HwX/LxnX7RqR8=;
        b=PjJ2ZbU/Sd9ZEKd5TEE850ctL5U8r/BtcHOxfd6XuZHPV2gFGL1fDlB2MUpnIfPF8T
         LgajV71y81NvSSbe+1ISQ5uTteY1HhTnB2bWIs8KKlhvCjm3h6ng+faDE5UzBc04vx1C
         af+ijeNQem3jtBo3/XjFzlnIjoIgpzax4/4QY1U3AK6c/kO0HXr2HyAOwI0XloQA9EtW
         SzCrHHMLi1p+8qVxrHQeOWW1GKxngL++FuzK9OaJw+WSzVvJFQDchyXPQtaPPax1Er/P
         XQLhRoAYN2gD2mWNRUT0u89k8nWXIG9/fin1a59Op0IIZBFzbB01XkJ76fX/5Ni0jpz3
         GPog==
X-Gm-Message-State: AFqh2koyUHUg2O4rCWqjYJimHmaTAyfc9UnN+BMEGBtiHLyi+BZwkCFg
        O47ogNmLu+SmnEBcOu4C7Py/gS4gpJk=
X-Google-Smtp-Source: AMrXdXtTeVWERXfIbzF9gHChmxky0OLBGzy+tebwVMzhsqaOcpP/ILEeQr+wcicSd0k/rQftM9frrQ==
X-Received: by 2002:a05:6602:5cd:b0:704:a65e:2223 with SMTP id w13-20020a05660205cd00b00704a65e2223mr3445463iox.12.1673997981398;
        Tue, 17 Jan 2023 15:26:21 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id f3-20020a5edf03000000b00704878474c7sm206037ioq.53.2023.01.17.15.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:26:20 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: r8a774e1-beacon-rzg2h-kit: Sync aliases with rz/g2m
Date:   Tue, 17 Jan 2023 17:26:09 -0600
Message-Id: <20230117232609.477247-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117232609.477247-1-aford173@gmail.com>
References: <20230117232609.477247-1-aford173@gmail.com>
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

The Beacon Embedded RZ/G2[MNH] boards all have the same baseboard
and all share the same PCB.  To make sure all instances appear
the same, make the aliases for RZ/G2H match the RZ/G2M to
keep them consistent.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts b/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
index bce5e78ca528..146f78cb6f19 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
@@ -14,6 +14,14 @@ / {
 	compatible = "beacon,beacon-rzg2h", "renesas,r8a774e1";
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &iic_pmic;
 		serial0 = &scif2;
 		serial1 = &hscif0;
 		serial2 = &hscif1;
-- 
2.34.1

