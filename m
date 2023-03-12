Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24416B66AF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjCLN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCLN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:27:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8523753724
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:27:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so8393077edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfPqeOLW7or+4SmUILObRzf1lvCA61sFi8BYiPE3oKo=;
        b=d7viElX6WjL8e/pjhES9zSFEvsV15OtVpWHceSNoKWMrgrfclhNLOKCzC9+ElaKXWa
         NhkbfsSZ9MTbt67dUApI6czkTtSZ6P38S5z/qglSgzZYGt+tVyByStmw3/DkbakD0BTe
         /Qk1sMw/wb8O9yV65W9AB3SLMiWzRAZxUjvO/pg9hVq+QTt+X+QlXWR2laQm/Yl9CiNx
         MAoro3hWhMOeGNyoMrgJ18i/Mc9mk/dtTDvJVL6HwAmBLkaEYF3Wk6tXVf+daVvBZSNO
         p1o0mg/aV1dH7O0C+dgWNptLBdlD7SuQoNyK+lWNl1oTUOUTlwHB6rfokIZT3ryr68/8
         YT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfPqeOLW7or+4SmUILObRzf1lvCA61sFi8BYiPE3oKo=;
        b=4MqsvIgeHaygZKBNzyU5l1dO0ZN19gF/Sfxi8b7qiteYQsdfoZl5WcL/xoR13G6Vnt
         wGAqLeVzZeiHbgnjz8XhMTq9SuHCO/0m0qd6HpQu6Wq3hWUZlM/bWfYJsqcY1H3sQeO7
         X/OrxMmc7HQxmMRw+5Uv42JFSzKxMDZDV1pAPMFadUJAllCBftmibb1BzIh4HxKoanle
         AmW0ifyZzTVv37C8thyRYSH1232Umc9zHB5GUy66dR94igU8o8qwhfDfQ9QRkyh3fFGX
         AVMxDu0yUd1++OSn7ldwZqF2fK+JTlW3AQX0PHvAz2Y846ITuyrvAUfNzAPljSkEtPrP
         DZvg==
X-Gm-Message-State: AO0yUKWFcoswmcfKg2+K/Y40y8fJm0DyT+0JnkqD395IZd/7gRcKuplv
        /jqD1iDtI6LEtkJx7qyfV6lwAA==
X-Google-Smtp-Source: AK7set+aK4FVNfCezrbJEaLy/bClCmwbZ6D7lRIUdkDV05aFMUu1jCGuYbHorMQVRispbzKvBcvk8w==
X-Received: by 2002:a50:ee18:0:b0:4ac:b6b2:1233 with SMTP id g24-20020a50ee18000000b004acb6b21233mr27886248eds.30.1678627623692;
        Sun, 12 Mar 2023 06:27:03 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id d6-20020a50f686000000b004bef1187754sm586773edn.95.2023.03.12.06.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:27:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pinctrl: sx150x: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:27:02 +0100
Message-Id: <20230312132702.352832-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).
This also fixes !CONFIG_OF error:

  drivers/pinctrl/pinctrl-sx150x.c:833:34: error: ‘sx150x_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/pinctrl-sx150x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 0b5ff99641e1..87fcbfbf49b7 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -1250,7 +1250,7 @@ static int sx150x_probe(struct i2c_client *client)
 static struct i2c_driver sx150x_driver = {
 	.driver = {
 		.name = "sx150x-pinctrl",
-		.of_match_table = of_match_ptr(sx150x_of_match),
+		.of_match_table = sx150x_of_match,
 	},
 	.probe_new = sx150x_probe,
 	.id_table = sx150x_id,
-- 
2.34.1

