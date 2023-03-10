Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724A86B5395
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCJV7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCJV6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:58:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A41EFC5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:55:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u9so26256377edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678485331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcJ/60CiNR3l+Pd6V0GQSncdZhxdS57tle43QWwe+tY=;
        b=YoeHd7YzM9bu/uqWm1SNfo0SjCePAxJQinALi6vgiqitopsZgmpMSj4htwe7pgaiKz
         aBSum7x3Kwz4yxc4WAkSvcuXm8pDHSguYWOg0ZV/1qNQYKrtnFLZ8PrK8XOE/qy3ELN5
         7NsqjAvsD76tbZ2bwPyJJvcOi8X6d+AqVoH/JFdhF9r0DH1JuiSFTIMBdFtjgmS2L2/+
         vtnLdQcw1V++211TjPweX3bo0sIrqs5WeT5lmoGKN6U3tZkBzI6HMGmD96Gxlk0fB6J4
         w8eadwVRIoUpLGFY7tgH8n6hgZKPNyVnAq3sLvrQ2FFmW0s70FUgukl+77tylPM1Ewzl
         OFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcJ/60CiNR3l+Pd6V0GQSncdZhxdS57tle43QWwe+tY=;
        b=AnPoEWvI0WtBB0ZyproE28ABTsqg8vmKHohlEn18cWhSUtb3f8dBaNwQ6QjFkawcn7
         MAAAEsy+mH59zLZO+gCK4QQUDJcbPKfsW3aNNxTEZ2iOizjNDUwCy18Lcp/Qv6XJSl8A
         c7pule9PbfqT7B5oqUKHpdZGOfMoYpryJg5cQrBAHJtd6cpFulPbLalDSlZpUlz3FoFb
         bP6HtqMYjy9WoxAbr9eC+Az00cif2lDK0cg/Qowut7fZI1CKxWI+kzCXCuCOBSQVMPu8
         HqBuH5+zlRSs+s971P65MWU34Xueiv+xIyHqVHrW5p+V4AC+P9QCDPTvKE+yYj6scJWi
         +qMQ==
X-Gm-Message-State: AO0yUKWfTRCGJIJBG1Qa+9T8EtEBMHS+bjzKw1+EU7c9A9U5JtaA0yrT
        OqKlgznIGPmXMJj18hf9Nq9kmBTQqa/eyy9l4Dc=
X-Google-Smtp-Source: AK7set9OWMBah+XLayBu0sHj0HkkG9xbD8r5gmAQE2k0KYWypz08rz5B2gUGv07SfC4WtPbAYwCNgQ==
X-Received: by 2002:a05:6402:654:b0:49e:1f0e:e209 with SMTP id u20-20020a056402065400b0049e1f0ee209mr4078070edx.10.1678484763064;
        Fri, 10 Mar 2023 13:46:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004be11e97ca2sm471873edi.90.2023.03.10.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:46:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/9] regulator: pbias: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:45:50 +0100
Message-Id: <20230310214553.275450-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
References: <20230310214553.275450-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/regulator/pbias-regulator.c:137:34: error: ‘pbias_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/pbias-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index 4eccf12f39de..4ce06072f3b5 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -231,7 +231,7 @@ static struct platform_driver pbias_regulator_driver = {
 	.probe		= pbias_regulator_probe,
 	.driver		= {
 		.name		= "pbias-regulator",
-		.of_match_table = of_match_ptr(pbias_of_match),
+		.of_match_table = pbias_of_match,
 	},
 };
 
-- 
2.34.1

