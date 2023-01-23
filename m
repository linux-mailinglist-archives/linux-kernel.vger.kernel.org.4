Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ADD677CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjAWNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjAWNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:38:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80105CDDD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:38:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v30so14580056edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=afOO5O5g9/NTFF1+J/n+I9gdYpUUBo+Q4LKxlRNPfog=;
        b=T60wxJXHaFYNNZgHZKUr93bkRH3Phy9rYun7HdrYP7fdHyDBTx/Q1Mzo5pkx2LCs7H
         hajDV9aFgtb9mwneNZimH6c8n4/i0cckM4uuaYMExc5nYFtIpw5abFDR3Ch44aZ0E12T
         2t1DtWgrpUuNSfv4pQMtWH0u+F5a9WiY9CSVJ3iLeVLqbPwrAX+t9zzEt1PyhVvS9uNE
         k0l3PPSPPQm1Wb2woYc8P0HDkYLiZC8BrbgtIkNsIok1OowHrTvTDnB6rzpwh3MU3OY7
         z8N8g4py8kTLJOGPAAYEoQlNnutivMsFZM7vdRAwYDnD6sNhp/24maOmvHzutyrHJXmB
         FJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afOO5O5g9/NTFF1+J/n+I9gdYpUUBo+Q4LKxlRNPfog=;
        b=h8ExYY2oZWM9bm7Flk4e5rC9TE6mOjQrLtp8MD7TYFUhMhgJZe1Q0exXbYlqtVNqy7
         S2zig8qjceTX9xKkEvxP71muvdI7P+hOxWb4h4hFmekebhzOjAiBFK9bQCf1NYyDuaL6
         o+qmVGo+fQipCupcEAiZhCiYDPW1b+HlF4D6aAbWAfolIVtf2AJAjLak4jLg7D1oI1TV
         CIAzsEjNsxTZCMuhLVjRsNmrLsH1ifKAeP4CAc/bKx2dGD8IP4VrotxVsLOUs4as0V56
         3o8I/Jegw1WWPxt2ahWmK3YwHlsyX9WZ11WCmTmSXnKTYnD1aX6weSn5wT2loyEpW7X2
         lB5A==
X-Gm-Message-State: AFqh2krlPbINsfU5YuW/75lmRxFsFjf/GMyT73h7jBu70luTa9/btLyy
        MehcSS2geBKeIcOi2xrvJ0CzlQ==
X-Google-Smtp-Source: AMrXdXv7D7NgyD6VmwQ5iNmaoi6oKMjHTPr5W95WsdWOXnx9KlCJzNMxV9o33ZGYB7Jq0IXyhg7ZxA==
X-Received: by 2002:a05:6402:3214:b0:496:37c9:b8e6 with SMTP id g20-20020a056402321400b0049637c9b8e6mr29333783eda.8.1674481098100;
        Mon, 23 Jan 2023 05:38:18 -0800 (PST)
Received: from Lat-5310.dev.rtsoft.ru ([87.116.163.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7cb01000000b00463b9d47e1fsm21502050edt.71.2023.01.23.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:38:17 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH 0/2] net: stmmac: add DT parameter to keep RX_CLK running in LPI state
Date:   Mon, 23 Jan 2023 16:37:45 +0300
Message-Id: <20230123133747.18896-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my qcs404 based board the ethernet MAC has issues with handling
Rx LPI exit / Rx LPI entry interrupts.

When in LPI mode the "refresh transmission" is received, the driver may
see both "Rx LPI exit", and "Rx LPI entry" bits set in the single read from
GMAC4_LPI_CTRL_STATUS register (vs "Rx LPI exit" first, and "Rx LPI entry"
then). In this case an interrupt storm happens: the LPI interrupt is
triggered every few microseconds - with all the status bits in the
GMAC4_LPI_CTRL_STATUS register being read as zeros. This interrupt storm
continues until a normal non-zero status is read from GMAC4_LPI_CTRL_STATUS
register (single "Rx LPI exit", or "Tx LPI exit").

The reason seems to be in the hardware not being able to properly clear
the "Rx LPI exit" interrupt if GMAC4_LPI_CTRL_STATUS register is read
after Rx LPI mode is entered again.

The current driver unconditionally sets the "Clock-stop enable" bit
(bit 10 in PHY's PCS Control 1 register) when calling phy_init_eee().
Not setting this bit - so that the PHY continues to provide RX_CLK
to the ethernet controller during Rx LPI state - prevents the LPI
interrupt storm.

This patch set adds a new parameter to the stmmac DT:
snps,rx-clk-runs-in-lpi.
If this parameter is present in the device tree, the driver configures
the PHY not to stop RX_CLK after entering Rx LPI state.

Andrey Konovalov (2):
  dt-bindings: net: snps,dwmac: add snps,rx-clk-runs-in-lpi parameter
  net: stmmac: consider snps,rx-clk-runs-in-lpi DT parameter

 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 +++
 include/linux/stmmac.h                                | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.34.1

