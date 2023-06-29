Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B132742D68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjF2TVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjF2TU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD9468C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688066268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CB4F2eDO1VL92Q0HqzTksbw7n9fujtKb1FZPPsN/d0c=;
        b=BqpD4ZwMzYZmpIJ45DfkxUtfb6EFY/wUovblgtb4/RWR9jwNEyvj2jNzIpKyYnEZETM4sQ
        6Y1Zn0/78sSfVelNKxLcfN24j4Pbo1Bvo8oXo1fbYvpJy8nm0mxVf+YpQ6k54PNHJvwA7G
        kMonJ0IdMCIJic14np/lWmUqJ+sIpQk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-nTksXX5HPguh-8DvuPeldA-1; Thu, 29 Jun 2023 15:17:47 -0400
X-MC-Unique: nTksXX5HPguh-8DvuPeldA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-57704a25be9so15581197b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688066266; x=1690658266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CB4F2eDO1VL92Q0HqzTksbw7n9fujtKb1FZPPsN/d0c=;
        b=EVLphCcdbCznSz6F6q339m0jnZADRZCmjz+glmkJNxutxWic0TzscBuuN3cOq5OujG
         rXMnlBj5c0G1vK3QGaK9oqKBE1Ga6xT/w0NRKMi1uhWIELhTwM+3cRitsnMpk/Kevqmk
         q8gmmkw8/95YQYao6BUiFnmVfFuaKnf36//I5GTnoC2rCN9VUSMHmHHD/t7czWiLjYYr
         iKdUYaye43ujap7vZbDALkFCkk9sleQkryBRRf5InsUPB57q1rNoo1oRjdWljo2lBvsp
         mLQrqLsFV04k6gQEvzb4GPxTfDgKcXJKLXMyh84e7e/LTN/8qGgD6ZY7G/5J8mF2JeNn
         bhGQ==
X-Gm-Message-State: ABy/qLaPTYKBVkHKMSYjUgdjzwBh0k4bxsdn3s1D8JaEEwTJEe0IMrFL
        GHw1GY8S6RZiAKwJDnqBKhvdaAzGIO9PXZlwEPQL6GTLhhCwjcY41j8kBIlB/0HKS7da8DyCqGd
        fI4VLH4kBhJOmgmXO5QCxv5b3NCKPYe66pdw27cQo4PoMbZ9muRmDCF8Np/Bn3aK/xPrT9uVvS2
        H7mJeZRPO6
X-Received: by 2002:a81:a04a:0:b0:56c:e260:e2d5 with SMTP id x71-20020a81a04a000000b0056ce260e2d5mr6808628ywg.7.1688066266357;
        Thu, 29 Jun 2023 12:17:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOfhrwZ9iRh4ReGxdsfikEqHuYNT4UdGjpezi+NU1/qUuJa+z/QJduR3WvMUh9O98fjlkVHg==
X-Received: by 2002:a81:a04a:0:b0:56c:e260:e2d5 with SMTP id x71-20020a81a04a000000b0056ce260e2d5mr6808604ywg.7.1688066266038;
        Thu, 29 Jun 2023 12:17:46 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id w127-20020a0ded85000000b0057085b18cddsm3052478ywe.54.2023.06.29.12.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:17:45 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        bartosz.golaszewski@linaro.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 1/3] net: stmmac: dwmac-qcom-ethqos: Return device_get_phy_mode() errors properly
Date:   Thu, 29 Jun 2023 14:14:16 -0500
Message-ID: <20230629191725.1434142-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than -ENODEV, other errors resulted in -EINVAL being returned
instead of the actual error.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index e62940414e54..3bf025e8e2bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -721,6 +721,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ethqos->phy_mode = device_get_phy_mode(dev);
+	if (ethqos->phy_mode < 0)
+		return dev_err_probe(dev, ethqos->phy_mode,
+				     "Failed to get phy mode\n");
 	switch (ethqos->phy_mode) {
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -731,8 +734,6 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_SGMII:
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
-	case -ENODEV:
-		return -ENODEV;
 	default:
 		return -EINVAL;
 	}
-- 
2.41.0

