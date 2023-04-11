Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4684E6DE555
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDKUGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDKUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA334690
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681243474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeRMoDwNgHrXxiMag5H3EfyVB1iYobNV8jx2yu9ZLd4=;
        b=JhjeuT3Ed6kwDS7xy2kcEobDlVikdgCuLcIvy5rJ/3E1NQeg9mRsv0UQsb+XL1+DyAUjet
        Aou+a01NxSxCJo6Jy1c14oXIT+rjBtp2IGyyk0lfQ6OKMMy91fWRGNXsnp54NTVatAYXB0
        x5M+gyNkbtSiTU0rgJNYu851k0GIf1M=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-jELQfEH8PJeIOhjArhCD3g-1; Tue, 11 Apr 2023 16:04:33 -0400
X-MC-Unique: jELQfEH8PJeIOhjArhCD3g-1
Received: by mail-oi1-f200.google.com with SMTP id db1-20020a056808408100b003873410ce73so2803448oib.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeRMoDwNgHrXxiMag5H3EfyVB1iYobNV8jx2yu9ZLd4=;
        b=tRbIo3Ef4pDwCruhvYDAMfiS8me1NLnOyJMVgSwS4WG7ADa2pTcKOwLOXQM82Dg7qV
         6gQYDYQ+AxlwBnlE1m/ZG9FBBxFDEv5q6xG7NAMtwTwU6cxPwtihKBQtrGIiY/DGxAKy
         /PvW9hAHk+g8leUlBpfB//vpVLAaqyZ25rfZ80/+sVois1TPOAUrg6QR5gdtfdEUqkAw
         ZMos0KpCF2Eneo48GjoGvzM/g+8b83HmDrDl9ZjmMqjjUcUG/6Ki0e7Hf33T0dApm4g5
         vq+aUqv3Tqur3N0u4HdFJCSTU04ogayfht14EGCUFblrZs2XmxqPU5BUd711YlfDS3zS
         1NYQ==
X-Gm-Message-State: AAQBX9eaC6p1/AgCxlZFWIVWTx419LVG3zX+AQIM9wDYa5uEQZvdqyxu
        XelVshp+DsjWAUQk6EntFN92QjJZeu/skQlgioxJM43D/vgAn6Hrhmia8S9XT6uec5c9NJu481/
        UDNDJNOfM6DGaW7GrgvT2Kzif1GvImip8s62HCpFGbLZhumnDtsLzAACcbi0czTJw86O7V9qMCm
        NMzsDx9egWmcg=
X-Received: by 2002:aca:be88:0:b0:387:11d6:d48d with SMTP id o130-20020acabe88000000b0038711d6d48dmr6270004oif.37.1681243471890;
        Tue, 11 Apr 2023 13:04:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ayqSH+7Hj8HEiFSaaeuV9ioyjXPt4cbYwGEzo7vQ16BMv3GHZIKe3My4U0lgrvHGPyDqwn4A==
X-Received: by 2002:aca:be88:0:b0:387:11d6:d48d with SMTP id o130-20020acabe88000000b0038711d6d48dmr6269958oif.37.1681243471614;
        Tue, 11 Apr 2023 13:04:31 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id e20-20020a056808149400b00387764759a3sm5868545oiw.24.2023.04.11.13.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:04:31 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, mturquette@baylibre.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v4 01/12] dt-bindings: net: snps,dwmac: Update interrupt-names
Date:   Tue, 11 Apr 2023 15:03:58 -0500
Message-Id: <20230411200409.455355-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411200409.455355-1-ahalaney@redhat.com>
References: <20230411200409.455355-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhupesh Sharma <bhupesh.sharma@linaro.org>

As commit fc191af1bb0d ("net: stmmac: platform: Fix misleading
interrupt error msg") noted, not every stmmac based platform
makes use of the 'eth_wake_irq' or 'eth_lpi' interrupts.

So, update the 'interrupt-names' inside 'snps,dwmac' YAML
bindings to reflect the same.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v3:
    * None

Changes since v2:
    * Add Krzysztof's Reviewed-by tag

Changes since v1:
    * Dropped Krzysztof's Acked-by since changes requested
    * Changed interrupt-names items per Krzysztof

 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 74f2ddc12018..5a4737e969a3 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -105,7 +105,7 @@ properties:
     minItems: 1
     items:
       - const: macirq
-      - const: eth_wake_irq
+      - enum: [eth_wake_irq, eth_lpi]
       - const: eth_lpi
 
   clocks:
-- 
2.39.2

