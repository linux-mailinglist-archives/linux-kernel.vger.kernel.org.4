Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF36E30C7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDOKod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDOKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C693CC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50670cc3abfso1882344a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555406; x=1684147406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU+5r6JwnlkZV5udDpSU3TN1NmnqBEFaQ3l0VUaFTms=;
        b=u511iv3WysXlmqIRNEbk0a12CsPPRkaNq6plomGGvHIsvGFq/gHRz5u4Apv3X5I9s0
         LnhTO02jB3h5e+5tG8C4HTPKnnbraGhyQGJnY3vx0dUIPGe8kjAN01ztD3P3rsle9bXd
         RJ+Us5PbPLRGW5x26AnX/lnCpPJFKFMGKp906BrPG5cUYil/21+5n1u1kJJX3/2u2USy
         wB9ouYXLn9DEbc1kgwSpzfE+LwUkVbRa/cwSbk3YXnoMvVljlaqH82dMgNv4MpJyfJuS
         1wi7X36BOoqU3el55JPTw3aPFth82d3dDJS2TODyYhEViZqO500J3JhRFDbDCVr1HiLd
         WZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555406; x=1684147406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU+5r6JwnlkZV5udDpSU3TN1NmnqBEFaQ3l0VUaFTms=;
        b=QLkh8UaXcmbIZroul1fOL3WXpqXH3mkeHYasQQ17nkyB8DpUm9CSIalvwXQV0YUXrE
         o6rBizlBlJRwYddjyGX1eiE3adHd8IeylIXxmBZ5iSp7TbdoaTpBsss52Meyq3N239Jl
         Hjin/HD9UVxE5CiCvE0eBsTT1ccsKZ9gR7i0/y41mZYQPdLLtsWxO3dUOkscrkIuizpP
         SBdVrb9eOAYA0jAbFZ3ZTlhAwBsrzOId+glTOPJAHv7cTZOH+iHBzvf7PVlyaLxUwlOU
         UF4qTCB3snTyowh+zVLPJJecvpnHpUrWe7xmG/Frz3ce0QHsmsIMkG5Zqshc5dadSom5
         vQ1Q==
X-Gm-Message-State: AAQBX9eCRlsg30kKktqvlnaMf5yXEs6eljNKlxUbJZCRgYTGzCJ2/tdX
        Js456ALrLRHvbfz0s3JL2GfKNQ==
X-Google-Smtp-Source: AKy350YyOTMpW+nN80cP1bbacqd+TASdoxSP7lVeVgOVVD1mXbr+acvFjhul8bei+0eLKe9bJgdTLA==
X-Received: by 2002:a05:6402:5168:b0:506:75e6:6321 with SMTP id d8-20020a056402516800b0050675e66321mr7198815ede.30.1681555406465;
        Sat, 15 Apr 2023 03:43:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/15] w1: matrox: switch from asm to linux header
Date:   Sat, 15 Apr 2023 12:42:58 +0200
Message-Id: <20230415104304.104134-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/io.h is preferred over asm/io.h:

  WARNING: Use #include <linux/io.h> instead of <asm/io.h>

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/matrox_w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index 94a1f3fa2dc3..662108b1d806 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -7,7 +7,7 @@
 
 #include <asm/types.h>
 #include <linux/atomic.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
-- 
2.34.1

