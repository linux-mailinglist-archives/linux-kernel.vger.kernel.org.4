Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D66E30C1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDOKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDOKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA08691
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94ed301bba0so125717566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555401; x=1684147401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/p4NRTjs3BLjzJ+cn6r3EmwmpCVSEOW5kd0Ht7+9co=;
        b=TS0mVAwVSMB3TZMk93moob2qJ+9hbVdN2NNKYdROxrSv8Z2oA+4aGmxXKYDuzVcEm3
         9WAO3TLgfk3G9ML7RIXjY0+uQuOmbaL6k8vqqwULuHlX4X2D/JxVN7h09cN4x7F2pn0t
         rpPYUBFDVlWZN7Caw5m+gaDUA9OmWj7wWdOGkRClJNU/AssvaD6n7MjIAQ8qkTQ5mZbU
         /SnSYhRWfTfkZGxD448UcXPUHEWCtgGCvKWl7FytOSgOWlkxLBnyhhZ4EzKf9SK/f1Ds
         eRUlsFjGuXFUyLEKgfNLUmosguoAt5m5GlPTyye+qpAhUv8pWtxlwd2Q4Arp7Rz6dAk4
         dIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555401; x=1684147401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/p4NRTjs3BLjzJ+cn6r3EmwmpCVSEOW5kd0Ht7+9co=;
        b=iE6kx4tsnhyWny3PzblzKOHcD2Qh9a9KjTRhn2Owaj6J4DdCthozprMtEp6J5YGghE
         0UgaAjSce+olU0YPECjjsiyMXLhDd00xIV6vzerALYYgu55f/gby312X0zfiUDhHt299
         QYCozo1LkcY/sfgA5ptmZ3NyMkBSXIaFWQcjnwa7Vc3PPAtAkvvfWI19G3UvX2gXvsn2
         eJevp6ZxJph+jS3uKoaAceIu8QMKipAsmPiYCkhfZiktu28u7dVYXQESXcA6PHKH+oq4
         h5NxKwxv+QxRtlZbiXaEXOSWejahdl+2rpcK6NPwoHu71uatr0zM0EDwqRZc2wLJH1TK
         dDOw==
X-Gm-Message-State: AAQBX9dB8y5eIczViUL36IVd8yq35z3x1xB1wTIomhD7KNln+nLtb7Ho
        SpMzj6sAhVqBUzbQJYfryEJB0Q==
X-Google-Smtp-Source: AKy350Y/jEVtp7V14c4ipCG9viPadpCpFPQ5g4EBv4b8edo0N6mm6U8UNf34WSAn2Z2nfW+5TbCmYg==
X-Received: by 2002:a05:6402:1257:b0:506:8e91:3b35 with SMTP id l23-20020a056402125700b005068e913b35mr1944679edw.13.1681555401131;
        Sat, 15 Apr 2023 03:43:21 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] w1: omap-hdq: allow compile testing
Date:   Sat, 15 Apr 2023 12:42:53 +0200
Message-Id: <20230415104304.104134-5-krzysztof.kozlowski@linaro.org>
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

omap-hdq does not depend on anything from ARCH_OMAP for building.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 692cac3ff0ee..ad316573288a 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -53,7 +53,7 @@ config W1_MASTER_GPIO
 
 config HDQ_MASTER_OMAP
 	tristate "OMAP HDQ driver"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || COMPILE_TEST
 	help
 	  Say Y here if you want support for the 1-wire or HDQ Interface
 	  on an OMAP processor.
-- 
2.34.1

