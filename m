Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5449732F18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbjFPKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjFPKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:51:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9A5B86
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:43:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31122c346f4so270166f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686912174; x=1689504174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7UUUCEiDOQDFLQBmgYOU/VRB87rfpeTkrh78SXewlQ=;
        b=d/HoqkPNJhmfrZK92gGm3XCSxr3gRxMKmYS1pBA3mH4DonHRJxzkoCjrNHzbFM3Xkh
         4r+gd1AQ4E4rtecdZB56qSPEKlSoUAAbD4Zpv0SAQM7DLOp/AuulZmQJjWW3mFqBIL+M
         8AD0YD/y4kzGuuT2UG6nWYMn3CFlHQKkW/nw/qMoritzMdZK9LxLM3ON7OSP5s0sCtTJ
         QOYWzIfYFk3xavNfKs5z3NoWeep1RoeML6N6+PLwGZjg1X9yFBv22Y2LeBeegHvYpMT8
         ltQv1plpsh5ZqungEDhdA1vRxgdPQWGAtUv+ZlprMp1jIHGRVMbiG06t4Y6MEQuwbLU6
         JIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686912174; x=1689504174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7UUUCEiDOQDFLQBmgYOU/VRB87rfpeTkrh78SXewlQ=;
        b=bHOMWgLESvvkM4JjbGmlkFMXu6bpLaKBuNHyISXVlxD3uQ64scFOq5wpcJ/sctCIZC
         VuzYwYVIWUDS6Oq5qFf7mpr/Ib9a3MI8xcNer0CEs81U2A0HKtSkrr2pMjf8EOSBJdwz
         xGCE5bGENH1Ns5C8A5p4EqLqhL9JhAUo5bMzO+vTvIpaO6tvBdpDxqufPCQQF2rVExiB
         Zff/7nlulXZtdKRfakGanqNl/R78E3EbcKgijrBf9Pievvt57HED+BTddCTlg8VaJ6bF
         ylQPo7inlN33UVmq2VbdJ/GovzlhgWCf0MMtnL7ReAprakgOouVY1zQj1TLldEWo4oOl
         d22w==
X-Gm-Message-State: AC+VfDxby7TLv2Lehn0nKeOyoRQQzNQWnOB/PTtOvCC7aBYTwodbSIc7
        shQWhmPta5xJNm8PiVktApbl+FfqyTiwMwzFh8M=
X-Google-Smtp-Source: ACHHUZ79+WHZQfcfy/frvys94Lo80cA+tl2FV9KD8MCaSKzol/5ipwbVMZ3T04P7GsrXRUhcD5vRDw==
X-Received: by 2002:a17:906:da8a:b0:96f:e45f:92e9 with SMTP id xh10-20020a170906da8a00b0096fe45f92e9mr1493906ejb.16.1686911495167;
        Fri, 16 Jun 2023 03:31:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906961400b009829d2e892csm2251098ejx.15.2023.06.16.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 03:31:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 1/2] stmmac: dwmac-loongson: drop useless check for compatible fallback
Date:   Fri, 16 Jun 2023 12:31:26 +0200
Message-Id: <20230616103127.285608-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device binds to proper PCI ID (LOONGSON, 0x7a03), already listed in DTS,
so checking for some other compatible does not make sense.  It cannot be
bound to unsupported platform.

Drop useless, incorrect (space in between) and undocumented compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index a25c187d3185..900972521b59 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -59,11 +59,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		return -ENODEV;
 	}
 
-	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
-		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
-		return -ENODEV;
-	}
-
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
 		return -ENOMEM;
-- 
2.34.1

