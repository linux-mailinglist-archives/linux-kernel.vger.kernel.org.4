Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B466012E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAFNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjAFNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:25:08 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D713D76838
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:25:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r72so694376iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 05:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfTJ3c+9fxJ1NOftUlf5eAcEnHlaOW7AestwesRDhhc=;
        b=TkH3WGHNMZcs1BI37yseipc329HqFYaJ4GVDQB+/wdTKpAEjO7d3EJ+vH8ZwTuYUpx
         SYwrToyQRbvYU/GGm5z0JqgYc8QYc2H1bsGK7zQVnwyuDaBViSP+v5hyjjyNXdzFGRFw
         iG6vCXVuUiJW1TJ2LU5KkDqeFkzyLDGt3LXuM/5ETZpGxy9vb9sdiCPsYvMZwalWujG5
         iSpTNvtTsWXiShbNtwRC7rrchOngvkacnYEUpV0aVT7OlLUqa+QsU5orZuBwnbMYPbuh
         YrseKr8DPVFFl+3YwimIzOTIjmJGBzZDoPRSVKMlELbT75RplPJhth54k59igkERsNz5
         Utmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfTJ3c+9fxJ1NOftUlf5eAcEnHlaOW7AestwesRDhhc=;
        b=tp6yfX9spQxRElBscDvtnghZ7hwqdckPJGbz18coZFDqksv3F5ANec5kL/HJWALMID
         nnlxF0jz46EUJu6SZjzSsBb9wxH1LgmXUCJLLJ6Qmdas5fwkiQqgRTGkQsSzsWUdmOaf
         0tXTzfhY7xeuUgneMLd3NDuLA1IXsfIB0dvgROTN9yu37wGwbu/NV8vlnGyrZyuNKhxS
         5u3EZOYQQrgWWqPsJYpGEkvZ+7ftAq4jE4OcqMQUPrQ7WK2ag+pX7x4uacdMQsFbGLcA
         6ZMUq1iTYA1vFJbiAa+Owpmjz+7T8EWMSDMWY0yoA0LdE8ZQIFCAt5xVm+LdL1uPIii3
         hbtA==
X-Gm-Message-State: AFqh2krvhtSK2cEPInWG4A+8Xa28dNcCqWSQGS9LBZj1m9Tbi6xt5Y6O
        i5ieCkohDJVHWTjUJye3h3KvD/7DGf7NGrex
X-Google-Smtp-Source: AMrXdXtzSjW6xpjttl/b7MIb6PGGuiMfWDaSmoEds9vUt/DtAvdt6YBba8McM3DgiPH/QDYEY+Wr5g==
X-Received: by 2002:a5d:894c:0:b0:6e0:1ae:8d07 with SMTP id b12-20020a5d894c000000b006e001ae8d07mr47726693iot.8.1673011505124;
        Fri, 06 Jan 2023 05:25:05 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id o63-20020a022242000000b0034c12270863sm332911jao.80.2023.01.06.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 05:25:04 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
        caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ipa: correct IPA v4.7 IMEM offset
Date:   Fri,  6 Jan 2023 07:25:01 -0600
Message-Id: <20230106132502.3307220-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b310de784bacd ("net: ipa: add IPA v4.7 support") was merged
despite an unresolved comment made by Konrad Dybcio.  Konrad
observed that the IMEM region specified for IPA v4.7 did not match
that used downstream for the SM7225 SoC.  In "lagoon.dtsi" present
in a Sony Xperia source tree, a ipa_smmu_ap node was defined with a
"qcom,additional-mapping" property that defined the IPA IMEM area
starting at offset 0x146a8000 (not 0x146a9000 that was committed).

The IPA v4.7 target system used for testing uses the SM7225 SoC, so
we'll adhere what the downstream code specifies is the address of
the IMEM region used for IPA.

Link: https://lore.kernel.org/linux-arm-msm/20221208211529.757669-1-elder@linaro.org
Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Based on net/master this time...

 drivers/net/ipa/data/ipa_data-v4.7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index 7552c400961eb..b83390c486158 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -357,7 +357,7 @@ static const struct ipa_mem ipa_mem_local_data[] = {
 static const struct ipa_mem_data ipa_mem_data = {
 	.local_count	= ARRAY_SIZE(ipa_mem_local_data),
 	.local		= ipa_mem_local_data,
-	.imem_addr	= 0x146a9000,
+	.imem_addr	= 0x146a8000,
 	.imem_size	= 0x00002000,
 	.smem_id	= 497,
 	.smem_size	= 0x00009000,
-- 
2.34.1

