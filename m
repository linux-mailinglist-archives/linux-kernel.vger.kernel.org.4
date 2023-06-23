Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4173B476
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjFWKFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjFWKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3720CC6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-311394406d0so443748f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514661; x=1690106661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qjTp+QHdjXZsiJdy1c6W+7WSusbljTMLadetQu+CGU=;
        b=B6Vux4DTtLobjKhHj6oCnNVAbEFhOtLv2CIz60kfoOv3rrspOnjmptB7E+HMXkTef9
         6x6TEzMfr8hLctZVfvXhjGBeOTTrl7jocsfNoBlRXeOWCkiQk8m3zt2c7w6By4kTERXw
         jiNCT8Lu1y0RkHDjuDoynGjYwDks2UiYs6uQcA1SIIcv7S8Wu888LKLj426BRvV0jiQH
         x+wPzd3OcM9wKAvIrFwiYT88ItGISPz+L47qwA6Lk1tr19SzOLFIA2NiLgE2aob3mjwd
         bh8fKTLLwONkWlpV+VhtQl5wquRlsKBZuV0No/Ev5su9n3TgIj30xB+MLCwc/eUFuosK
         DLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514661; x=1690106661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qjTp+QHdjXZsiJdy1c6W+7WSusbljTMLadetQu+CGU=;
        b=HWGh+UCkzJPRvkzQe6gMrICav0lZ1qTu5Ohp6LvTWJzEOH/sGIyb1JFiKAMWIyjEJ/
         CRI5rLv8NOK69lsEPuN3jaUjnvpcjK3mkMoNpHTh2NMnQX9bFztmyl+M8+3sJnlqWHux
         zjMCGLKUwO/OrglD3wngVri2HlsOudlWFYbJ335k11bRjsQrZ+JNNOJ3TiDZyzW9Defv
         ++v/UCV6XkKtb6lRNAYNdqge/Z6NDDf4mwTU948+fAq0Aw11FeqHoSKaatqGRpKWVIPU
         xcnyHuhQdm+r1BHzrbNcg13cjJMayYJW7whS/LoacVEV0j89OUtDkIiLz5mWGhaDTuvD
         YAEQ==
X-Gm-Message-State: AC+VfDxuW1EPGoZhePzPm4i/fTE6lRu97swZfRMJICl7VvcOqzPrUh8S
        mHE2EVUpc0FqJ10scLAzFLUrew==
X-Google-Smtp-Source: ACHHUZ6wSeHhdjH2GIsP0ttor7xJzJ+HpgcGwNpZ1USLEMTkAVBXlUFw+HYK1QZiuLPDn1mzeq8JtA==
X-Received: by 2002:a5d:444b:0:b0:30a:f143:25d2 with SMTP id x11-20020a5d444b000000b0030af14325d2mr14823232wrr.5.1687514661474;
        Fri, 23 Jun 2023 03:04:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:21 -0700 (PDT)
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
Subject: [PATCH net-next v2 00/11] net: stmmac: introduce devres helpers for stmmac platform drivers
Date:   Fri, 23 Jun 2023 12:04:06 +0200
Message-Id: <20230623100417.93592-1-brgl@bgdev.pl>
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

v1 -> v2:
- fix build for !CONFIG_OF

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
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  48 ++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 164 +++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  14 ++
 4 files changed, 185 insertions(+), 55 deletions(-)

-- 
2.39.2

