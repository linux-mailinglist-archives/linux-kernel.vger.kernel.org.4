Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009B0742D67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF2TVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjF2TUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286364699
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688066281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdunTKBXq26vcyYb/EdIVE7YvQRq/YPpQ2jK2C3l7sY=;
        b=VDKZKcCOjBHpSiu9M3ndPRoUf5k29rXGq/BfARQ3Kk4OKNMGKt6J37KoiLJmUPO8iLsNVm
        ckdnwwfPZG2rdpcxS48stHIBtDITT1qTPPXhThKknvBxu6UT/PsDBdNJ/FPx6V+VUJs/zj
        geler9EUkkpgieB6tBcjuLqXS+x2dA8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Pb9xJYt-N4WowBIJOhIpXQ-1; Thu, 29 Jun 2023 15:17:59 -0400
X-MC-Unique: Pb9xJYt-N4WowBIJOhIpXQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5704e551e8bso8704337b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688066278; x=1690658278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdunTKBXq26vcyYb/EdIVE7YvQRq/YPpQ2jK2C3l7sY=;
        b=OfrV56eDa+Y18mgCy3i2ywPs/vaD3kEjkPXDzvgt0JmehyWAarFrQEVhKJSkzivPBG
         yINpCogDCD26Kb9kwiiz1Gx7B3OS2ZlEKIMQLxLnfpCfBTry9fbXvmRo7ZVHQsppZMqV
         2OMyewrBua/WzdATV5G8lHt3E3PPgO0DIEBOBdxg7a0whSf4BpU7ip2XsaSUxTpccqly
         /IuOBu6uXrvKu/LQT5FFQcJuj8A9HipP/7gZR+3AEOJm6TVu8qhT0WjMneMnasv5Evbd
         OAosqCbarKfxUW7wfSV6JUTVTBSCUtjfAG6+V2EOMuRtOZTNFwlbwF5ScIjLjlfNIryB
         pI1A==
X-Gm-Message-State: ABy/qLYZes+rzYAJaHV7GTjzhz0OKmI3sHD/Ydj2KYJvl0XMKVigX+8o
        Flw/cpOhehEnjnx3C4PpXE3nDdL3lKTvlpH9alM2G7fTW1MMS4/e7aEOqAprmvJi6lkDccIFsYr
        v8Jf5/jY4qaZn0dUdgOyt7jjDlMHJPIrEtzUzsyGqH3LCq4kBfgCB7d8rJ/pO99aEhy0sfeG9/1
        Tdb4l7CE3w
X-Received: by 2002:a0d:f2c4:0:b0:570:6fbd:2daf with SMTP id b187-20020a0df2c4000000b005706fbd2dafmr303082ywf.37.1688066278500;
        Thu, 29 Jun 2023 12:17:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWPYjej9cDTBj9PaobIHZOXCIJHkmLixBjf5KfzXTvWmIZX19PFv5oYzbDnjlXG204DfghIQ==
X-Received: by 2002:a0d:f2c4:0:b0:570:6fbd:2daf with SMTP id b187-20020a0df2c4000000b005706fbd2dafmr303048ywf.37.1688066278207;
        Thu, 29 Jun 2023 12:17:58 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id w127-20020a0ded85000000b0057085b18cddsm3052478ywe.54.2023.06.29.12.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:17:57 -0700 (PDT)
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
Subject: [PATCH 2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
Date:   Thu, 29 Jun 2023 14:14:17 -0500
Message-ID: <20230629191725.1434142-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629191725.1434142-1-ahalaney@redhat.com>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
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

Using dev_err_probe() logs to devices_deferred which is helpful
when debugging.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 3bf025e8e2bd..a40869b2dd64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -710,8 +710,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat)) {
-		dev_err(dev, "dt configuration failed\n");
-		return PTR_ERR(plat_dat);
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "dt configuration failed\n");
 	}
 
 	plat_dat->clks_config = ethqos_clks_config;
-- 
2.41.0

