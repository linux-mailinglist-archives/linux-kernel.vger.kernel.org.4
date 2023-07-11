Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3A74F97B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGKU7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGKU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA110DD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689109092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGh+uAGSNBabNs8otONzVd5nXL6Ue86FrE6lpV0zFTs=;
        b=OArO2mzRUq2d1CFg0i4WIQ5U3YuByW8RaWLGIKFJBVbRbjNs/7AsVnActh1bcApFbZlyTf
        iA4+ZnOQTbaXwzgiRhoMitrukylur3olLYwrHELMy9V3DXovDKOT+DpP4hUVgLqSXrGBqS
        skcqBbbMcaoKNztgJtlJyucvkZdnHWc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-ucAPLURSP52NkkL9W8Wf1w-1; Tue, 11 Jul 2023 16:58:11 -0400
X-MC-Unique: ucAPLURSP52NkkL9W8Wf1w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5766e49b802so62819097b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109091; x=1691701091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGh+uAGSNBabNs8otONzVd5nXL6Ue86FrE6lpV0zFTs=;
        b=d7DqWwmqSJPbWTP2koUsSzJRMQv7YgeUnf88agzrDPXMenHIjYTASwoWbDniv+nDf1
         Un8cPr6IoLPsIyvIemU20X4JvSbwWt4KArTCuRQ2xMLUnlYlMuPv5UryyNmUbMHUiNAI
         TaJjjsJaV+bRRu6jNAbLJhKma4ZsCq4IyD8jQisoq74IUbvSb7qp9w5Qg2Pejbe3LBZo
         uj/0E/bXNBMpI5KHd7msbBbUxomabcLlhDKGWTbzSGj4/306CJDg8XhRQ5S+2xnkN7kf
         XxQBJzmMagZ4Wg4CqzXwHMWOuK2IDJ6hFZgq3X+MKLCz8IRlVQZxSqXxlXbXVAFm22rp
         25hw==
X-Gm-Message-State: ABy/qLbaCxP1hjJ49Sklwql3U2+pVmuXS3RCGL4CGbyIKqL4TNH0fge6
        9zQlhtZBHJEXovfYaYlOMwt5/MDZQqRnJGMkIHgF+mNI90etqTzhnrkdiWfSFM5UWYd1KMb++Mo
        XeYUuBS8gLD3G7iXANFwqM6/gNSlNrYnfqpAKAFG3YKZStd/kzTVgtpL8je4NGiRxiVAcZZ997+
        x65ocr5YtC
X-Received: by 2002:a0d:d851:0:b0:56d:5272:d540 with SMTP id a78-20020a0dd851000000b0056d5272d540mr15383351ywe.46.1689109090949;
        Tue, 11 Jul 2023 13:58:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBKIgazDrRhr2+67U2dBV7TYIWtfQ85b0QfXe8t9Je+goLDwuNWjUTwlmm9dlLHEZL6Qvc5A==
X-Received: by 2002:a0d:d851:0:b0:56d:5272:d540 with SMTP id a78-20020a0dd851000000b0056d5272d540mr15383327ywe.46.1689109090644;
        Tue, 11 Jul 2023 13:58:10 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j136-20020a81928e000000b00545a08184cesm785353ywg.94.2023.07.11.13.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:58:10 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RFC/RFT net-next 1/3] net: stmmac: Make ptp_clk_freq_config variable type explicit
Date:   Tue, 11 Jul 2023 15:35:30 -0500
Message-ID: <20230711205732.364954-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711205732.364954-1-ahalaney@redhat.com>
References: <20230711205732.364954-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priv variable is _always_ of type (struct stmmac_priv *), so let's
stop using (void *) since it isn't abstracting anything.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 +--
 include/linux/stmmac.h                            | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ab9f876b6df7..718bae6872da 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -257,9 +257,8 @@ static void intel_speed_mode_2500(struct net_device *ndev, void *intel_data)
 /* Program PTP Clock Frequency for different variant of
  * Intel mGBE that has slightly different GPO mapping
  */
-static void intel_mgbe_ptp_clk_freq_config(void *npriv)
+static void intel_mgbe_ptp_clk_freq_config(struct stmmac_priv *priv)
 {
-	struct stmmac_priv *priv = (struct stmmac_priv *)npriv;
 	struct intel_priv_data *intel_priv;
 	u32 gpio_value;
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 06090538fe2d..c0cbcef1a2f0 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -76,6 +76,8 @@
 			| DMA_AXI_BLEN_32 | DMA_AXI_BLEN_64 \
 			| DMA_AXI_BLEN_128 | DMA_AXI_BLEN_256)
 
+struct stmmac_priv;
+
 /* Platfrom data for platform device structure's platform_data field */
 
 struct stmmac_mdio_bus_data {
@@ -245,7 +247,7 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
-	void (*ptp_clk_freq_config)(void *priv);
+	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
 	struct mac_device_info *(*setup)(void *priv);
-- 
2.41.0

