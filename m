Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF426C24A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCTWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCTWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CC3645E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679350627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uADkhSDU3kNDzAhx/ALq71/R+qHbMHup0NfIf4oXRRk=;
        b=bAOQ/wnAPB2pqQp9ZW/9j3a0vAI1BaIGY68qGiGTGrBezsfYSS2r5j+YDSXlKwy8yyYRXD
        hPX7pnezb8OQl9ttmSgXydBO0msx/AYy4xyuY/raGUx4WZG98BBRREp8sjcKgnkyJAWbEy
        Z7+i+lbMF0i+taVBeKXQdbk0mNh9A9I=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-99PdeIDPPOyiO6Vaws30xQ-1; Mon, 20 Mar 2023 18:17:06 -0400
X-MC-Unique: 99PdeIDPPOyiO6Vaws30xQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-176347f3b28so7705438fac.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uADkhSDU3kNDzAhx/ALq71/R+qHbMHup0NfIf4oXRRk=;
        b=n9ZfggDwNATB70PlU8gKs+gx4VyZyMfuEbqqGaBfbKHAtgosfrfb/SeBiuqg0OG+I7
         42Lu5LVp3ozgAY3Azqf0FFGC6bOnb8DbzK4Hs5Pqu70qvJ09pARzdI5x0FYIFNGSmXPA
         FWx/dAvBsa8oa68sqq+wQzxFgThFsekYQeVdUrzjzdRrfKX2Kt7cOe5yjueF6SxMaJ86
         w7yubshgh/l89r3ROBoTlrvNAh2q3iPHDLmE6VTxhSPYb0SdAwXxIwcxrBnJ1LksmZSt
         /kxfDgbF2tGAsyrgq+9p89X+N6KhJgFN49pB2ClRvKjblT1u9OyOjdFanohgRVOwcsdQ
         yAuQ==
X-Gm-Message-State: AO0yUKWwTaKI8DDf+sCuu6iRKe8HcUicIIpajmo0f+C9jAQIAzPiuJLB
        L2cqVo6UouAbi+E1VFUa895KBax1LyXbysP604Hd0Uw8ERGCeJjXVHHoK5gq0OTVxT2tXbXK6AU
        5Phi4MPncDetuynnd+mqdNS13xEv3kRCwB2fZ7fFZQcNQ4qLZSgD5M5UxeySoVzS9zkcZb4Hkkj
        /j8XDwCbUWsbU=
X-Received: by 2002:a4a:d38e:0:b0:53b:1086:7a09 with SMTP id i14-20020a4ad38e000000b0053b10867a09mr949172oos.3.1679350625216;
        Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set8HeXukDtyerKLEQLIGqNPkUK2wofZTtG54Dcrc14ovssGSEI09uY51mICdr2wdiRw2g7QDRw==
X-Received: by 2002:a4a:d38e:0:b0:53b:1086:7a09 with SMTP id i14-20020a4ad38e000000b0053b10867a09mr949133oos.3.1679350624966;
        Mon, 20 Mar 2023 15:17:04 -0700 (PDT)
Received: from halaney-x13s.redhat.com (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm4092465ooq.8.2023.03.20.15.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:17:04 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 08/12] net: stmmac: Remove unnecessary if statement brackets
Date:   Mon, 20 Mar 2023 17:16:13 -0500
Message-Id: <20230320221617.236323-9-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320221617.236323-1-ahalaney@redhat.com>
References: <20230320221617.236323-1-ahalaney@redhat.com>
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

