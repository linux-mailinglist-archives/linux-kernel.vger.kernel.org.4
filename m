Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73255712C32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjEZSHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbjEZSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:07:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A86189;
        Fri, 26 May 2023 11:07:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so1135543a12.0;
        Fri, 26 May 2023 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685124464; x=1687716464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHJFOn/9WZgbcQQiY2pB91pDyOoBlsFjWDhIaVT8XDI=;
        b=FYmQ+w+h2ysoJlHGZx1SBr3kgLrddcHHSHHjNTPMypvxUBBr+BQle7TrG4IbTS9+aR
         +n34R8CtQq70PebIGw+pK6PS3j7jiQHgq/h0b8ovu2xIjMgXnuyNgw7aOnsedSlMWz66
         tdRtnCcDYQ0M/mFBI/0TNnKUJE8TnNEd4SUsCILR9jj7pzalEIPZxQATqHQaWlT1FakW
         I1rn8nHpTcCbqV5VQJ4xzZNSEf+SUMJoznCex3OZGuyNXpD5zaBLUFfvND0W4JO9XrpA
         Rrule0SrzDaUc4r++kxvLc8+cghD7HNCbhiJOJ+S/dbCeHqSvKLYBhC+J9Iswt5jLMQK
         jtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124464; x=1687716464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHJFOn/9WZgbcQQiY2pB91pDyOoBlsFjWDhIaVT8XDI=;
        b=TR2MA8cMCBsbsXFjHkVw3E0xjJffhEMe018deE7ADcUL5d67VK/wPqBSH5ULTeCcGH
         Dg0KFZV5o0qaGoehuy3c710CLfnA6ndPPTUH3L84ZHXhG/faUK4wjqFz2rsunQbNpWv1
         npgu4U40gK4EEQYR4ZtnqvBRo9HZpCBg60Pr25K/WgpOzoX3L9t6FndM6ZTPzG3rGKbI
         /DowGI2jRnLYV2KPa2FhMht09eA34WEN1iZVQ8MdypGS1ucb09aQcDNN0YElhSEu6zfa
         7+MGDdWKiGEOYnUO4xKJz7K82dYrlHKBXDUSAhRlcKmg3GWa0e/2gQiVPeScZHFmX9O+
         eHvQ==
X-Gm-Message-State: AC+VfDxK3oZ/HLF6kMp0GcmgApqTk5S7CBi0whw/4VFX+FIIN3LC8r/7
        R9QwIBifGd1G5zSVd+QYl+E=
X-Google-Smtp-Source: ACHHUZ7Rg3f8GFmAjQmxJWpt2gt0IFfrSnPXYDat2OUzkhnHaRvMUWggr6u4NUfmTl5CTWc4sgLZ3A==
X-Received: by 2002:a17:907:2d07:b0:973:d8a4:f486 with SMTP id gs7-20020a1709072d0700b00973d8a4f486mr529923ejc.10.1685124464063;
        Fri, 26 May 2023 11:07:44 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906410b00b0096f689848desm2410823ejk.195.2023.05.26.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:07:43 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8996: Add CAMSS power domain and power-domain-names to CAMSS
Date:   Fri, 26 May 2023 21:07:11 +0300
Message-Id: <20230526180712.8481-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526180712.8481-1-y.oudjana@protonmail.com>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add the CAMSS power domain which powers CAMSS and is needed to enable its
clocks, as well as power-domain-names for all CAMSS power domains to make
fetching them easier.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2b35cb3f5292..b2e0cd739d90 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2118,7 +2118,9 @@ camss: camss@a00000 {
 				"vfe0",
 				"vfe1";
 			power-domains = <&mmcc VFE0_GDSC>,
-					<&mmcc VFE1_GDSC>;
+					<&mmcc VFE1_GDSC>,
+					<&mmcc CAMSS_GDSC>;
+			power-domain-names = "vfe0", "vfe1", "camss";
 			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
 				<&mmcc CAMSS_ISPIF_AHB_CLK>,
 				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
-- 
2.40.1

