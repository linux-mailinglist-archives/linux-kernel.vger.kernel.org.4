Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5681A7389A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjFUPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjFUPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:37:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A0186
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f9bece8d1bso8545915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361821; x=1689953821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ClAzoGuEp9Q2PcVgXbgejHlPiXITPfjrxWcfTJEqc0=;
        b=AQIraaew2/zXvqE91YbkJxU/ss1rbUIc/5WuQ2mQSwEYNaPiuXgCTioCRnA75I2VFH
         +aCknfvR8zMLhgxgFgf+R4+5qcdatJMkGa8KNvvRfJbcxnUJU0FfInDocxRWkmdMvjXV
         jA6Ng/H7tcLwo0B5fe3RuLLWT368fspgiGisI9e7Y1/7perYFhsqalEbkJsnHZwzepPc
         +84/bY1JMoZu5qIIxGa5K2tC0byJVnDuBDEJxR+EkG17r1y/ENGmCwG/xT7yUoz/itB7
         8j2kOORbFrSvtdFFb4XNZSbKY7GQ0oPbztBfJ+cawzxzNLskGBR3+E7rrS3ryhjOVjTq
         eyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361821; x=1689953821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ClAzoGuEp9Q2PcVgXbgejHlPiXITPfjrxWcfTJEqc0=;
        b=BDGjo/LTP8FMRgXnjA9j8BTm/+gvEhcYIiOq7YRw4ZGfq3QkiY5ufmv+DFkyVOf+1+
         DEaCfNZOubTo/+eMZfqN0xlh3xAT2oBt3fNIp2tZeWB/PZ1j9Lt8Cg0/NHmwB03RQSoF
         HXoOrHoTsbsOaxDoBvmptaPh+1w4BI8K8iVE++LZ+TbcbWHyM+/SXAudRAedMla98Atq
         EsYq4xZCD+FYe+Ar2wZeCsNlFVxd+6Mj1ifOntZCs88sY99p5t9uCl/tUmYHttAcKTxE
         2EWGfLYlVDXKGNIyZmSa5HkpayNa8Z3YRJQygZO3YwTOZepO3giTOAnVY9cpsWDoRNWg
         IEYQ==
X-Gm-Message-State: AC+VfDw2Q76muOVAQFaKWJDIJMoZx2MNtFxIAqAzxhq+zSxLbAPdAANO
        BiQjVBtOOMKajsGjX8RZC47VfdZdPoJQRDmTO1Q=
X-Google-Smtp-Source: ACHHUZ6HAkXFQk8+aVBXjAYvPLGkmxJv5JHJtkveKCNtpBoYsdRohmCW1C61OJtW2Tm6Xb1OgI9RQQ==
X-Received: by 2002:a7b:c38f:0:b0:3f8:ff4e:8ba3 with SMTP id s15-20020a7bc38f000000b003f8ff4e8ba3mr11474166wmj.38.1687361821346;
        Wed, 21 Jun 2023 08:37:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 00/11] net: stmmac: introduce devres helpers for stmmac platform drivers
Date:   Wed, 21 Jun 2023 17:36:39 +0200
Message-Id: <20230621153650.440350-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The goal of this series is two-fold: to make the API for stmmac platforms more
logically correct (by providing functions that acquire resources with release
counterparts that undo only their actions and nothing more) and to provide
devres variants of commonly use registration functions that allows to
significantly simplify the platform drivers.

The current pattern for stmmac platform drivers is to call
stmmac_probe_config_dt(), possibly the platform's init() callback and then
call stmmac_drv_probe(). The resources allocated by these calls will then
be released by calling stmmac_pltfr_remove(). This goes against the commonly
accepted way of providing each function that allocated a resource with a
function that frees it.

First: provide wrappers around platform's init() and exit() callbacks that
allow users to skip checking if the callbacks exist manually.

Second: provide stmmac_pltfr_probe() which calls the platform init() callback
and then calls stmmac_drv_probe() together with a variant of
stmmac_pltfr_remove() that DOES NOT call stmmac_remove_config_dt(). For now
this variant is called stmmac_pltfr_remove_no_dt() but once all users of
the old stmmac_pltfr_remove() are converted to the devres helper, it will be
renamed back to stmmac_pltfr_remove() and the no_dt function removed.

Finally use the devres helpers in dwmac-qco-ethqos to show how much simplier
the driver's probe() becomes.

This series obviously just starts the conversion process and other platform
drivers will need to be converted once the helpers land in net/.

Bartosz Golaszewski (11):
  net: stmmac: platform: provide stmmac_pltfr_init()
  net: stmmac: dwmac-generic: use stmmac_pltfr_init()
  net: stmmac: platform: provide stmmac_pltfr_exit()
  net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
  net: stmmac: platform: provide stmmac_pltfr_probe()
  net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
  net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
  net: stmmac: platform: provide devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
  net: stmmac: platform: provide devm_stmmac_pltfr_probe()
  net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()

 .../ethernet/stmicro/stmmac/dwmac-generic.c   |  14 +-
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  48 ++----
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 158 +++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  14 ++
 4 files changed, 179 insertions(+), 55 deletions(-)

-- 
2.39.2

