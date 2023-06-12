Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7472BC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjFLJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjFLJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:29:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9C19AF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso29363165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561880; x=1689153880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6Qql4lmrRc6orjCzbHdO+X/jI0p6UbXCT7w4xaPn70=;
        b=r3C+LN0I7FtVIMevczG2G4gXnrbL8tV0VWh6EO722HqR8GSaE0sIdbfNRfxVxFLZ5B
         KBIgDCk8KbY3A1fU3rbQm5hg/qG9fiu/Qh5osa9r5C1dsQA0Xew8j5mZNyLKuBNimXuJ
         6e0x0WmGekpMepRjwxkoNwMoSWLpFysA/e7TXwQ9HxvqKKEmDAkTMxo6WGY5DU3VlT33
         NHaWsB9EL8reOpnI+0F5kohXV0fYBfz9i83cHE6asArFI1iLJgt+h16f1Yd5ENreccvG
         guXlbNPG/FuHocWDWvE5pg2eRqhyFAu+oxb9QULwsW/TV/ONDHrPilSk3mWzsETb+yPC
         RCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561880; x=1689153880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6Qql4lmrRc6orjCzbHdO+X/jI0p6UbXCT7w4xaPn70=;
        b=AaNMGUun+HMDM91EDcwR24j8LwKocLNbxBsMFXHMHEAowRbiUyKIapDiMcSHZzZMh1
         BFmQy3i8FcLnF/Ju80tKLINlAkLZaGQSzrqgXBVcEm5pHS1XJGk/AIQvEbmdPI8ZfI0w
         QOEyA5e1A2VfsPgfnVYBzHIZAby7zBhXMSJ6/4x/onCiTLPZsWqeI64GrNaM8iCuqAyc
         1s1HJA0b6QG6HZp2/fQN7qTRgxJHUzidbFz1Su9K2ILtDGtoYCaNZnqgznvKciBIY+ga
         BQcby9GfzEOqv7V0yzGqA5CMwC3vQ+5pHsc7jyWt6ejoLTFao2VHYxXHXehyX8hBkKOt
         INfA==
X-Gm-Message-State: AC+VfDympvrDdbz3J6qPE4yBVM+CbqJI4tK5dD7XRUwvfb4i9kbCQiMq
        GOg63Zs8Y82Hiug+CUcJfmmFkQ==
X-Google-Smtp-Source: ACHHUZ4pVmMwHGX7bNbtVfB97Jl65MLcpOZps2ubdvFDgRPuGgLyhLlZQF10mQYnesEmUQW2Dqf8YA==
X-Received: by 2002:a1c:7c19:0:b0:3f5:ff24:27de with SMTP id x25-20020a1c7c19000000b003f5ff2427demr5380405wmc.32.1686561880266;
        Mon, 12 Jun 2023 02:24:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 10/26] net: stmmac: dwmac-qcom-ethqos: add a newline between headers
Date:   Mon, 12 Jun 2023 11:23:39 +0200
Message-Id: <20230612092355.87937-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Typically we use a newline between global and local headers so add it
here as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ecb94e5388c7..5b56abacbf6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/property.h>
+
 #include "stmmac.h"
 #include "stmmac_platform.h"
 
-- 
2.39.2

