Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8642361F458
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiKGN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiKGN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:29:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D6E1CB17;
        Mon,  7 Nov 2022 05:29:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id q9so30216325ejd.0;
        Mon, 07 Nov 2022 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDOdLV96aBPIAMlkNzE1ZyzcwED/u+zRiKOTdjgBJUU=;
        b=YgLNaVxs1RztJCcCieI8ERHtdHkFdvRBWXaoGj+AFLeV0EnQ6J9GsBnutFSoPtBsGf
         wqGEIUoUKqYNOPeCTfn1rUDGU9lSJJHHLAMyEkvxmsyoJ9eWysOIIAcot7QrHsOycz5S
         +q4LOxO5qs1upjjEHf4jIk1N12UBXbFxAZwTxHCwRSJIduSE0b0ZzJNltKmKYx1KkoUt
         XJ67MNa49mxB1PeKRLXDPhmykww37tN+1pOnpwTxZmVGCP7PD+HZlxp/DKqcBopnEb1V
         ylZmHLI/HZ8aYw8pU8iCpTAdKu75zLJV/mhhhXEMhmp5q2GkuQ0NwczZFxyfCRvo4mQz
         AOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDOdLV96aBPIAMlkNzE1ZyzcwED/u+zRiKOTdjgBJUU=;
        b=HPDnA8geCSuNImobfdCHM3QjfHemVxFNMA51rvatLbGeqXs7CECMrHkTGjef3qo1Uj
         /RVYurq6X9xcTIgoDB0zgWFANkW1kO4/aPwabmB509O0H2AjujbrlGC8BpM5CEm2fX9V
         TOiVzQAA8JilnNpRkRCFwwk9qt54x9qzaMBmB12QZpgz9vX7XDUWI6O4ggw83iWYj5Yb
         ad3pHHD+9CaeSNjYNhNFZNElK4NqIhuc4EiZobBIa2Fb63jzAGCZyyBOrYKbGgHT2KTG
         ZRzc2CWJSfnhvQ3tFaznCu+wCnPstk0WTSyn9F16FGb2WGXx7Wk/HyjK4HDvF1J8SGwk
         nZ0g==
X-Gm-Message-State: ACrzQf1XyZ3V1GmH0n6DITaINeHWXd5isafndPNkzxXfznc5nGtCcG3x
        INVQdlwU81DQE7ihHX/+wNk=
X-Google-Smtp-Source: AMsMyM6fliBlCshCjtfYk2Qg/pWwCrenj7y+n7lKdApNLB8h60d8aRsQrVG5i6G87s0IUlZDUF0Mgg==
X-Received: by 2002:a17:907:c711:b0:7ae:35c9:f07b with SMTP id ty17-20020a170907c71100b007ae35c9f07bmr16421779ejc.423.1667827746465;
        Mon, 07 Nov 2022 05:29:06 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id ky14-20020a170907778e00b0073c8d4c9f38sm3446037ejc.177.2022.11.07.05.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:29:06 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/3] clk: qcom: ipq8074: add missing networking resets
Date:   Mon,  7 Nov 2022 14:29:01 +0100
Message-Id: <20221107132901.489240-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107132901.489240-1-robimarko@gmail.com>
References: <20221107132901.489240-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream QCA 5.4 kernel defines networking resets which are not present
in the mainline kernel but are required for the networking drivers.

So, port the downstream resets and avoid using magic values for mask,
construct mask for resets which require multiple bits to be set/cleared.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 42d185fe19c8..37d8a9f4105e 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -4826,6 +4826,20 @@ static const struct qcom_reset_map gcc_ipq8074_resets[] = {
 	[GCC_PCIE1_AXI_SLAVE_ARES] = { 0x76040, 4 },
 	[GCC_PCIE1_AHB_ARES] = { 0x76040, 5 },
 	[GCC_PCIE1_AXI_MASTER_STICKY_ARES] = { 0x76040, 6 },
+	[GCC_PPE_FULL_RESET] = { .reg = 0x68014, .bitmask = GENMASK(19, 16) },
+	[GCC_UNIPHY0_SOFT_RESET] = { .reg = 0x56004, .bitmask = GENMASK(13, 4) | BIT(1) },
+	[GCC_UNIPHY0_XPCS_RESET] = { 0x56004, 2 },
+	[GCC_UNIPHY1_SOFT_RESET] = { .reg = 0x56104, .bitmask = GENMASK(5, 4) | BIT(1) },
+	[GCC_UNIPHY1_XPCS_RESET] = { 0x56104, 2 },
+	[GCC_UNIPHY2_SOFT_RESET] = { .reg = 0x56204, .bitmask = GENMASK(5, 4) | BIT(1) },
+	[GCC_UNIPHY2_XPCS_RESET] = { 0x56204, 2 },
+	[GCC_EDMA_HW_RESET] = { .reg = 0x68014, .bitmask = GENMASK(21, 20) },
+	[GCC_NSSPORT1_RESET] = { .reg = 0x68014, .bitmask = BIT(24) | GENMASK(1, 0) },
+	[GCC_NSSPORT2_RESET] = { .reg = 0x68014, .bitmask = BIT(25) | GENMASK(3, 2) },
+	[GCC_NSSPORT3_RESET] = { .reg = 0x68014, .bitmask = BIT(26) | GENMASK(5, 4) },
+	[GCC_NSSPORT4_RESET] = { .reg = 0x68014, .bitmask = BIT(27) | GENMASK(9, 8) },
+	[GCC_NSSPORT5_RESET] = { .reg = 0x68014, .bitmask = BIT(28) | GENMASK(11, 10) },
+	[GCC_NSSPORT6_RESET] = { .reg = 0x68014, .bitmask = BIT(29) | GENMASK(13, 12) },
 };
 
 static struct gdsc *gcc_ipq8074_gdscs[] = {
-- 
2.38.1

