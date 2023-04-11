Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7893B6DE57C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDKUHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDKUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B45B55BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681243519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zenMfB5Zn+UbigAKsZIPpQknObixx5MnqQjCcDXL53w=;
        b=i8GKMLp5zwpWGfPRsfVbPHkoeGtYZH5IL7dJl5uzfdoCzWTYRmJkfAUEe3kSVYi5ThPHJ2
        q58LeOyrUIFpfBjkUfgVbWjL//cl9ve3H0P1tMey4Vr/PckoNJth+REBBzLwFrl50qvf89
        ucTdJUIDV5niRkDS4ahphakrGSzUfts=
Received: from mail-ot1-f71.google.com (209.85.210.71 [209.85.210.71]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-wHkKzHV9NeaNLV6ka8cDqg-1; Tue,
 11 Apr 2023 16:05:01 -0400
X-MC-Unique: wHkKzHV9NeaNLV6ka8cDqg-1
Received: by mail-ot1-f71.google.com with SMTP id k18-20020a056830151200b006a11baeb49bso2091075otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zenMfB5Zn+UbigAKsZIPpQknObixx5MnqQjCcDXL53w=;
        b=nKvBJwAR2nTLURnBn4i27xZjLZPtJYxS70vpMXExl1Iv5HxaSv3chlZ9Ww3wxqDeoB
         kSBoJRdhPMJz/A7n3UDVVYTffI56W53NYi+LTDue3ssIIn8HxKSWr7/aFxefoNU2gDWn
         FXUSB8i2sLL/Un9+AH2KzBCGDcOoXxsqh0kPAu1txBqoEltE+a1v6gdrWrNiVQlOxpOv
         KbtH32/Jvk3qmWqm35xoyGkkEqpHuGHHXuCuZAJB7GsltwBNKkttF0+CU00fQJPcyFw9
         h9r5lth5aKBFtdva/Yxsj3MA1gvgzUg0XgxHUDWEelNaxRs7vDFSkCNFKiIEEChoqPTf
         hO2Q==
X-Gm-Message-State: AAQBX9dfWZJcDB65um/IBQmRoHG7bl09IQ6JsFPlEvPGVlKJLWO9vNnP
        k9cR9xs5SyVd4wnO8A6AiuMTR+2W4bUbNiKvVdLLKeCCUF/+zxWqfy8PO3iwk4f2jglRme44nDD
        S2RQ2B4BlH5tEGlHlqWDvwQFSbZA1U2lMwNWBFIhqFP8BE8bC5XuZffxqX5xR06tQCa0Axmlwwr
        D+ER8hMr0aGN0=
X-Received: by 2002:aca:1a09:0:b0:387:29c3:f0a2 with SMTP id a9-20020aca1a09000000b0038729c3f0a2mr4713898oia.9.1681243494931;
        Tue, 11 Apr 2023 13:04:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z2XdmlUFC0MeVBWwPYue4CzrV/HIPiMXHL6V/DCyUF8qsQRSj5c1pDR57qf/aw++mecVdqjw==
X-Received: by 2002:aca:1a09:0:b0:387:29c3:f0a2 with SMTP id a9-20020aca1a09000000b0038729c3f0a2mr4713854oia.9.1681243494605;
        Tue, 11 Apr 2023 13:04:54 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id e20-20020a056808149400b00387764759a3sm5868545oiw.24.2023.04.11.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:04:54 -0700 (PDT)
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
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v4 05/12] net: stmmac: Remove unnecessary if statement brackets
Date:   Tue, 11 Apr 2023 15:04:02 -0500
Message-Id: <20230411200409.455355-6-ahalaney@redhat.com>
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

The brackets are unnecessary, remove them to match the coding style
used in the kernel.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v2/v3:
    * None

Changes since v1:
    * This patch is split from the next patch since it is a logically
      different change (Andrew Lunn)

 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 21aaa2730ac8..6807c4c1a0a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -281,9 +281,8 @@ static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->has_gmac4)
 		value |= MII_GMAC4_READ;
-	}
 
 	data = stmmac_mdio_read(priv, data, value);
 
-- 
2.39.2

