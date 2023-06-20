Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA571737594
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFTUDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC61712
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-988c495f35fso305226166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291414; x=1689883414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZmsUFxfSaZd2TRggUEzbG3wsKi/JJu6iTKnfH0U/a8=;
        b=PL2aYv1XJTAb6SseiJmq0ugcTYxl5XsFYKBAptEfz4pni3OV9/VirDCoGuItpfae5S
         UN6RnvIKIZVu5ObsB1SDlUcMta0rykf+STCDgIkDgS6ANMNVflDAmKD9dZhEz0yoCYZc
         WMjrOGzhNROXyIJlLjMRmnOZO+VtEeffjVHgNQYRlNUK9EzND/e8XyZPhyuvyKDbYGKq
         FMOZd8VkLy0JQW/u6skoiclFJOobAtzPZ56PHAi71fB0QWV+DQh3LOxY5CF09IzMTzKa
         gkFnD9qSSsX/OIx99noI3P5iR+hUKYYk8LpNSCfQpB8tTZ/rw07OveSRU5PMO8Z4TCJ6
         ZMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291414; x=1689883414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZmsUFxfSaZd2TRggUEzbG3wsKi/JJu6iTKnfH0U/a8=;
        b=QHY/UdApj/YxRN07LGjol9usbrAar5txzxzbXvO0adfns1Mntagpf5+C4Uzp764eVl
         U5TGJCJMKabDkXdY/Lgedi92C+NiNQSryekc+EKCoVzIhsmaamxsyE9/C1xz5BUA/uwz
         HZVqzK4+GBTdQyfo4V7mP6dtUYaThpFU4VIIxqvgs+ndM450Y8E3O0n2hoM/CJS9o1gh
         BQiKduECMlATA6qgmCE7mPuZvyUAuhzXcfwSg4+ItmMKxFUScpxOG6uSf3+MQ4hEymi3
         ni3/jiP17ISwXOhhyhgXfHO779dUDHfrmZgRbPyUe+Kzf17a71zLwVIBczZs/MyowNUB
         DuXQ==
X-Gm-Message-State: AC+VfDwGd/wWOmeULx3tMUQ3mpnw1snIa586+8tHee+oP86sDRL5xM6w
        SFoRAC+fzao3DWW7StHrwoM=
X-Google-Smtp-Source: ACHHUZ7aTIHGXPpWhLNVtsAjn6ed8yL6xIJFjalQn1soPkXbxGdxGfG1zuotGKg1J9ll8r7ltiLn9Q==
X-Received: by 2002:a17:907:2689:b0:965:9602:1f07 with SMTP id bn9-20020a170907268900b0096596021f07mr12473108ejc.39.1687291413720;
        Tue, 20 Jun 2023 13:03:33 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:33 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:02:54 +0200
Subject: [PATCH RFC v4 01/13] regulator: da9063: fix null pointer deref
 with partial DT config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-1-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Skip checking the XVP constraints if the regulator has no DT node.
This fixes a null pointer dereference.

Fixes: b8717a80e6ee ("regulator: da9063: implement setter for voltage monitoring")
Reported-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Closes: https://lore.kernel.org/all/20230616143736.2946173-1-martin.fuzzey@flowbird.group/
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index c5dd77be558b..308ad63fcf78 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1028,9 +1028,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			config.of_node = da9063_reg_matches[id].of_node;
 		config.regmap = da9063->regmap;
 
-		ret = da9063_check_xvp_constraints(&config);
-		if (ret)
-			return ret;
+		/* Only check constraints if DT node is available. */
+		if (config.init_data) {
+			ret = da9063_check_xvp_constraints(&config);
+			if (ret)
+				return ret;
+		}
 
 		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
 						     &config);

-- 
2.34.1

