Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37E74DF12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjGJUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjGJUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FA3197
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689020260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfBCs08BCyvb4rUBf/lFUidTAq5uH0UA99R+iDtQ+Ug=;
        b=Vte6DMJequp4VaHVSbynVId14j94TYH8zqSPUMuTVZ5MHtzjTgtVm1AJ4PkD1AhhAzfKKH
        STqMUNgKDuygO59j23fYJdvf0Uuf7iKOWEfh/8hZw3bJvc7nvAflwYAHg3T6+QYKsJgU7b
        YTHCqeqUzAwuWm2JAppvrpWv9RLQW4s=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-PQxISe_LNZujYq9y264CVg-1; Mon, 10 Jul 2023 16:17:39 -0400
X-MC-Unique: PQxISe_LNZujYq9y264CVg-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1b02ecda1a3so3953557fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020258; x=1691612258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfBCs08BCyvb4rUBf/lFUidTAq5uH0UA99R+iDtQ+Ug=;
        b=h135sXGnGHmJz2H6dRIBr+EdnHpivQTjfgY1A4S9Q1MapAobRsFG/TvPeY6urOOeHX
         hYQTMLIr5QGhwyqk3CmpGC1rcuC6Jb0ARq94ZRQNPxMJk1j8wXjFIn83w64xJJ2hPhKp
         Ybe6/1tjOKoMDhDRsKf4u1BvDZ6MNchoyBaltMoHCYY0rg4pV4e/4Jg4xcv4OEf8WqRX
         A4DsPF+KbTmxF4eGhMxKfeNJaC47t5ow1AIOUplk/Nu/RvFCypQwN7cZ1Yc6QvSq2P7O
         7Ox9Ds7GnXle96N+Ys3BvK5PL3xQeBODazl38OAKIlhFZpczYGdU7+1cIkD4LFeRD8SK
         mUOg==
X-Gm-Message-State: ABy/qLZBTSRLekihcO6VN+hzmeA3REeBR3/fP5saiy8eihPACx5XetdH
        +OoPtVxQbUUWrYCTmYwR7h4Wq9CyFgr2wc/K3Mj785NA/R1jnS6W/zIX/RmgG71agJ/snle0Zyu
        x3EPOORYB8rmildq9SA9jlHBp/wbtopZvl/MrwXbuuoV333kwtpSyeEKKaNIUkPsDOltJ4jZp6j
        oHxtaNHFfy
X-Received: by 2002:a05:6870:440b:b0:19f:9353:d9b0 with SMTP id u11-20020a056870440b00b0019f9353d9b0mr13312431oah.24.1689020258072;
        Mon, 10 Jul 2023 13:17:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/yzsbrle2mK4hDSP+ymIcBBFgugjNQj9A986L5d0AncrnW2gjIY3q9PjS07ExUBl/iRYYsw==
X-Received: by 2002:a05:6870:440b:b0:19f:9353:d9b0 with SMTP id u11-20020a056870440b00b0019f9353d9b0mr13312403oah.24.1689020257748;
        Mon, 10 Jul 2023 13:17:37 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm155097ywg.103.2023.07.10.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:37 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, andrew@lunn.ch,
        simon.horman@corigine.com, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
Date:   Mon, 10 Jul 2023 15:06:38 -0500
Message-ID: <20230710201636.200412-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710201636.200412-1-ahalaney@redhat.com>
References: <20230710201636.200412-1-ahalaney@redhat.com>
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

Using dev_err_probe() logs to devices_deferred which is helpful
when debugging.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1:
    * Collect tags (Andrew Lunn)

 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ebafdadb28d5..1e103fd356b7 100644
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

