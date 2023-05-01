Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2786F38BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjEAT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEAT4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:56:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FFE30DB;
        Mon,  1 May 2023 12:55:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94a34a14a54so589651866b.1;
        Mon, 01 May 2023 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970947; x=1685562947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVl+1ldEbgG0bY/nnbA49+7exJ4XMFuwhoQlwV/juHE=;
        b=m/BskhkoAc99W7NhroNRS7UdT5dY/EE+WENCsL3WAWHaSFrWoKbKUmi+F8+FlxcGo9
         keLARdtcbUPcdF0MYORoWNIbIMJ/fJ5AJnzU52Y60zydKrykYJBxlZyRp7iIAj/Ni8To
         5r4EO4/XPi+g6BD1hQRfwzbWwS8zHVDCiaVZ3rXFFCfPae3YI1tYFWw9TdjOqGNa6dcG
         NX2hlHVCDAzap072Xh5DzwMO0RbeKi+E4SKP5cu/pCcocudL65n4F9q9MMj3hr2l+dUr
         a6iy6HG4zRDqLqIN/hoX6eeSacwKjIL7/f2yOvCymRG+2w4Nu/hH7da9WD/ejyglAQVy
         tzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970947; x=1685562947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVl+1ldEbgG0bY/nnbA49+7exJ4XMFuwhoQlwV/juHE=;
        b=ZqYbPTSwryZUlRvjAjHPSpq2vT0uHkEwoIWy/O0QzQi3h6eSFJeu8fyKh6ytAj49r7
         NGIwwDtMCQ9R5BAG+YxK0WlxJ7o4ia1Gfk9Xuvj+Du5wpOzwcXHyAvi4EU9ATCyrZHVM
         8PGFVU8gBJfBjpxA3ZjfL0qfL+t2qqCT4ouuPhYRILFV+7EP96rqqmDduxJdV00NwRTA
         Ta10N+hHvXV1k06QPSW4POoR3mUpWcOGgfeI0gGL41ghorHEDzm0yxQlrXfQPrq3BCJs
         UW+nSiQbaE9xvZdCb2NNEQnkzCizYbSKwD0uPS+QJvWg+i2wus6ow7w3sUBSaY2ybRTC
         0Fqw==
X-Gm-Message-State: AC+VfDzaWF+0O25VN7558Kqi/dPOIa8Y2Gz0h7hfoEX3SCWDVyYiYk9M
        EJf6wac4GkpKfuUb1k98UYg=
X-Google-Smtp-Source: ACHHUZ7jrkT0xfHVPcIzTIZhHTNk3x/WPV+vnt2Yz0ptrGIMq9z5ndA7ZxekxkLXc/Qxc166p+NkbA==
X-Received: by 2002:a17:906:6a15:b0:94f:a309:67b7 with SMTP id qw21-20020a1709066a1500b0094fa30967b7mr12450638ejc.56.1682970947470;
        Mon, 01 May 2023 12:55:47 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:47 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 08/13] Revert "phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB"
Date:   Mon,  1 May 2023 21:55:20 +0200
Message-Id: <20230501195525.6268-9-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501195525.6268-1-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the Exynos4212 SoC was originally dropped as there were
no boards using it. We will be adding a device that uses it, so add
it back.

This reverts commit fee7e1d50c6e6da1d99035181ba5a5c88f5bb526.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/phy/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 3ccaabf2850a..f10afa3d7ff5 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -59,7 +59,7 @@ config PHY_EXYNOS4210_USB2
 config PHY_EXYNOS4X12_USB2
 	bool
 	depends on PHY_SAMSUNG_USB2
-	default SOC_EXYNOS3250 || SOC_EXYNOS4412
+	default SOC_EXYNOS3250 || SOC_EXYNOS4212 || SOC_EXYNOS4412
 
 config PHY_EXYNOS5250_USB2
 	bool
-- 
2.40.1

