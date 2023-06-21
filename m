Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC07381FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjFUJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFUJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:31:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED26198D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311153ec442so4550953f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339868; x=1689931868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnoYzlqcpbqIFDX/QCzP0DM0XYhA9I/O0wRSd0b2d80=;
        b=OKCgz0VaMI1Fv6yd2XldHp/3Alw1/cS1VYDm4ECvg32UV+E10/b7GlASd5Luv4QTDe
         gl7+Y2+pMX7ebU1ik0S+/Bfjt+amyNuaVDzBp9q1dQm8nFS470hJzdR7tZXyr6Q4x5fN
         yy4l8FtsayAy/qYIK/O4ngS4Z8pBog+1eRV8Um2eyVNWrMK0IbXKS858U0IWVV4eTRw9
         sr7aBZXPzwDkEI7pzvxZQqaGXD45sobVdOJ+U7xJMGNTAwX13i+wjEefT/9ctkCN8KjB
         7ZStrac+Cl8yc2N9adH9Rcz9ni7eoCebFDY12q/U9V52Id688qhVzmdepEW+oLWS+tbE
         n0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339868; x=1689931868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnoYzlqcpbqIFDX/QCzP0DM0XYhA9I/O0wRSd0b2d80=;
        b=XJXINnCXgw5o/up9zYtSIpAxdMCfwvynFUIi92dbN+MA5j9ahSiinpwqym8L6prIw/
         VUZ90nEUt+jHn9SAzGXavK/oGH8L99APK02Kd7/30LP3MT/8vKG4GiV3Cw2W5wKASFwH
         ZIk47OMcvNVls4Cy391nS2DQjrgwVTyPXY1n8p5XbZKmr9tmZ49AMw9X0XvBEIXLOFp+
         IzFlow+gCLU7fe+0gQTT/fenptcbHS8fQAxV/tJsyLYb3NJ3uBCRXx37n26u9ycRehbF
         z0OtxcfzFf7loQoDXJPuwNkKTRSgrR6uDrInb13WzBrHjwTMMVjbOaZL84AuhCutWJF5
         0A5g==
X-Gm-Message-State: AC+VfDzJvGCdlLnp9jB8iG7NVULt3uOQ3alv+9CZAfAysQh9jRVZegWv
        Ujq0qVfdhJvojwJTLqTeVU0DAQ==
X-Google-Smtp-Source: ACHHUZ6wNggPJlaWNtBCFb85tB2zyBb3w5c/2/L22CBkW3973Qtp0kgzE6fLsZu8EOuufjAe/NANWQ==
X-Received: by 2002:a5d:4203:0:b0:311:1107:9aba with SMTP id n3-20020a5d4203000000b0031111079abamr13408111wrq.19.1687339868152;
        Wed, 21 Jun 2023 02:31:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:07 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/6] can: tcan4x5x: Introduce tcan4552/4553
Date:   Wed, 21 Jun 2023 11:30:57 +0200
Message-Id: <20230621093103.3134655-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series introduces two new chips tcan-4552 and tcan-4553. The
generic driver works in general but needs a few small changes. These are
caused by the removal of wake and state pins.

In v2 I updated the bindings to use tcan4x5x always as a fallback. The
driver now uses the first more specific binding if available. If the
given binding does not match the chip that is present, a warning is
printed and the correct driver data is loaded instead.

Based on v6.4-rc1.

Best,
Markus

Changes in v2:
- Update the binding documentation to specify tcan4552 and tcan4553 with
  the tcan4x5x as fallback
- Update the driver to use auto detection as well. If compatible differs
  from the ID2 register, use the ID2 register and print a warning.
- Small style changes

Previous versions:
v1 - https://lore.kernel.org/lkml/20230314151201.2317134-1-msp@baylibre.com

Markus Schneider-Pargmann (6):
  dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
  can: tcan4x5x: Remove reserved register 0x814 from writable table
  can: tcan4x5x: Check size of mram configuration
  can: tcan4x5x: Rename ID registers to match datasheet
  can: tcan4x5x: Add support for tcan4552/4553
  can: tcan4x5x: Add error messages in probe

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  11 +-
 drivers/net/can/m_can/m_can.c                 |  16 ++
 drivers/net/can/m_can/m_can.h                 |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c         | 161 ++++++++++++++----
 drivers/net/can/m_can/tcan4x5x-regmap.c       |   1 -
 5 files changed, 155 insertions(+), 35 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1

