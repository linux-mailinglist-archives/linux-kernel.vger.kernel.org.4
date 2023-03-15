Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7A6BA92C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCOHap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjCOHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0BA6C19D;
        Wed, 15 Mar 2023 00:29:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v21so8986333ple.9;
        Wed, 15 Mar 2023 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skDrdHHxY4/PRNsG0BtA3PR+oADTeYv6w75S5aIGD+k=;
        b=ncX2cNjBBArloPVBvUzdqBSEYyE6q/RBxhKEBvLcOGoyzywiNysSunaU/OKu8S+zVG
         WJHnZNjf/npJfFzyniqVTE0/a1I5oVzxyTbHfzPBbihQrPqpmj6BkzoEmfQnFp1DIb4L
         ECR6fWzulpN+k1wQRBcvsx9Zh9RlS7q0vzi7jE3P5rOStskcjh/b1hSpeMRJUu/aQFi6
         Kn+2HGlQglBJzN9Znoi0SI208RUeNBkZ3zTo/e2DH93ow7HirepCuW01sebh/NXx1cVq
         miTThLyV969evfDME579tdtogEZhgMpAgSD6wyWhfREWjf9YSgCw2GQ+aDk8ndRcST3D
         lTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skDrdHHxY4/PRNsG0BtA3PR+oADTeYv6w75S5aIGD+k=;
        b=agyfEPVS8wvmjES0I5jjGsUSIv+JPrOKd5xQ9qvKQ5zaL8yLYb0plr3jVlqzfsHJfQ
         42BBLbobwH+UOF3z3rHPlP8cPPl7/UOyn3sPZlJ9gVLiWLeq8Xe22zJcsPv28iYOIkA7
         IenaGJXnhIYeyLW0M7QwQ+AMXiHlyHvOJy9rPFJlx5sPVCFMYBp08wexV4HhQMVu9cM1
         9fNGZlSRz/bJs0rUr4duAGa2fLuIcHlPOjcT1nVY7UvJeuV64TaI79glE9Q2GUD1o4wB
         OK3QZt4In4rNoGmmfm6CWYayh/VKHl4eoGKsM1nZPtDYCn8No+z/VwnS8zPS6pEYtDuI
         8YEw==
X-Gm-Message-State: AO0yUKXib2l+8Tp+RSIDXiawp6kioxK+3Uzvv5VeQYxZ+anO/NiSrmmb
        nDSeBRbrfx9lDf5rOt5BiVg=
X-Google-Smtp-Source: AK7set9hHttrvRDC5H+g6AdgKuIgXIrQQYDTQpVx8MLNrRRywrLCA11rZ7KFHpOen4NeVzub6jLetw==
X-Received: by 2002:a17:903:2846:b0:19c:e05a:ea6 with SMTP id kq6-20020a170903284600b0019ce05a0ea6mr1270462plb.56.1678865353712;
        Wed, 15 Mar 2023 00:29:13 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:13 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 02/15] arm64: defconfig: Add Nuvoton MA35 family support
Date:   Wed, 15 Mar 2023 07:28:49 +0000
Message-Id: <20230315072902.9298-3-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
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

From: Jacky Huang <ychuang3@nuvoton.com>

Enable basic drivers for ma35d1 booting up support: architecture,
device tree, clock, reset, and uart.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..c96189acb02c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_MXC=y
 CONFIG_ARCH_S32=y
 CONFIG_ARCH_NPCM=y
+CONFIG_ARCH_NUVOTON=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
2.34.1

