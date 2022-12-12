Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821DE649EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiLLMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiLLMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:35:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8AC12609
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:34:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so12041925pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apPGFedAv3uAmQAp6xD4tNC7N1DZdKzki801rLgGfFs=;
        b=rvpNc8D4tUlWJjtdcx6r2kqPUvDpcCZXEVp8rHRZOdG2ZylbdXSlA8X1WBvN3Dcze+
         AqowEJ/9OFPO3NuyEVu89W2Orgo1iLJY3jmbYAXE6QvpdTh4I4ctkJMUq90CF/BX7lfL
         wad84Nmgs7J6W8BRaaSM5GcgN8dmrcwRN9QPNACcBPyZOqhO7pziTJPcx+ht4ft6YBwc
         i/BcTPWVq4YlLIw/zLf4Ilk/vQEByu5A9DwIWXQ8PkZpSs4Yqg7HOBoJl9OGUjgEvTPj
         Bcxhyv2FEGNfVvupN4jXpr/eQVVFIgLWmSC16XdVCZQXba6uXFWN1upJfaCW4yOhXL4Q
         v8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apPGFedAv3uAmQAp6xD4tNC7N1DZdKzki801rLgGfFs=;
        b=aKbByw7sW9CgGK4NAkIVmz1Q+1noOxfnMk6JMKjfb1NVXOCYOrFCWk+k9v5JWHLY0i
         QWBRNdahRUAX1MyXk/4KNU8sUgzySIxnPdJrulWsVb2AEK1ZTespnTpa4/7lH7Fubgqk
         QnbG99q8aApJpq3J6pN3F8RngB49zEZhc74Y1f95lPs5AuFQs+cisMYEjbsfH9tbPJQJ
         cD8h/fpEwbQNNC4PeAIaVGYFcHuippZ47d2YL5EnclMqZly6TTgww5i+GvLRft1yJt0u
         9y/HcRUVwjRvsS0RxhnhXHgR8Y+P1xE02sJuAponWlzCHLHV6mMkPgzd5C7Z8CO6Ibl2
         +VJw==
X-Gm-Message-State: ANoB5plGNnPvnvFCPLW8mziJ88NCSHTZE7BGgTLtFfIULuGpAEvJYOLA
        PkOXy+odxbJplBBBUmxb7ZyS
X-Google-Smtp-Source: AA0mqf6+LShJsPN+/zqNTsvXdXBN/B4lMNcCK1WC0YzDvfRhwPh9u2OTOAPd9dPQ9F4U87PLHnaagw==
X-Received: by 2002:a17:902:a70b:b0:187:ede:e014 with SMTP id w11-20020a170902a70b00b001870edee014mr15848859plq.44.1670848456668;
        Mon, 12 Dec 2022 04:34:16 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00189c93ce5easm6252557plx.166.2022.12.12.04.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:34:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 09/13] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Mon, 12 Dec 2022 18:03:07 +0530
Message-Id: <20221212123311.146261-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
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

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Also, let's get rid of reg-names property as it is not needed anymore.
The driver is expected to parse the reg field based on index to get the
addresses of each LLCC banks.

Cc: <stable@vger.kernel.org> # 5.17
Fixes: 9ac8999e8d6c ("arm64: dts: qcom: sm8350: Add LLCC node")
Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 245dce24ec59..7f76778e1bc8 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2513,8 +2513,9 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
 		};
 
 		usb_1: usb@a6f8800 {
-- 
2.25.1

