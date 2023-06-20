Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB8736B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjFTLlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFTLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:41:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BC10F8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:40:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5979774e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687261256; x=1689853256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wR3UhI9Px6pcSpLtyKW9Hd7WsxrSJTWg4zx4ad17nMs=;
        b=QRWWnpSCq0KXZlXJwV2+G1Ek0GR0s69ya8kvNoy6iQ3xjs4p3k5ohlA8K+ofWwkGP7
         UpPxtDTYeAI812rYxp/H9dB2RmuyX6NDlC0e7j1aGhQiR/O99SwNLGYrFxpUGWptI/IP
         951fmr88HC1UohE0RBYLWOGL8Rgb17PaaTNCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261256; x=1689853256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wR3UhI9Px6pcSpLtyKW9Hd7WsxrSJTWg4zx4ad17nMs=;
        b=IseyBkSMLWsbTk8Ypbd7BSLT5UKUS/xG4UdJWl+u8bHdiRF9iUJFO7Yz69Kn5LFx4G
         JoI59KxwmPHy+4QQRPDR5KU+5sWJ6se5t/E2cELBkuX0rbv1A+HtTL3ahpzTOGK2D4+r
         xfyYb1OdlkOBrijlMTALT+h7t3yFib0mwmYD4HFmpR/wKv5/INkWYg9m+LQboYIigFoo
         mqvEwGHt5hPNwQPecfCfy0TwVx3zY7yqFgjksEruSlO1052sYb4LUhFUpvYeW1Q4CaXh
         ICaFjcnFla32jL94Lxm+eNVJLBHS81lcLO+tSU2Wz3cWPVPaEGFzKUdDDhWHZuqupYUz
         GRMw==
X-Gm-Message-State: AC+VfDypx4PeH5j06Mun4W/6ZVNoM3bh8bg4UjjST0UvCTuYkJ3nzl69
        65UJHgBEvx39qgYuKTirIgoIzA==
X-Google-Smtp-Source: ACHHUZ6A7kVJNkFsn+BH2hHUMaLcTITzl7R7pmguVWQ+irWwJN0drVojSM1MHj0yPz84vP6Coc6jbw==
X-Received: by 2002:a19:f201:0:b0:4f7:42de:3a8f with SMTP id q1-20020a19f201000000b004f742de3a8fmr6438174lfh.56.1687261253812;
        Tue, 20 Jun 2023 04:40:53 -0700 (PDT)
Received: from localhost.localdomain ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id d12-20020ac2544c000000b004f84162e08bsm329879lfn.185.2023.06.20.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:40:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH net-next 0/3] net: dsa: microchip: fix writes to phy registers >= 0x10
Date:   Tue, 20 Jun 2023 13:38:51 +0200
Message-Id: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is just a simplification, technically unrelated to the other
two patches. But it would be a bit inconsistent to have the new
ksz_prmw32() introduced in patch 2 use ksz_rmw32() while leaving
ksz_prmw8() as-is.

The actual fix is of course patch 3. I can definitely see some weird
behaviour on our ksz9567 when writing to phy registers 0x1e and 0x1f
(with phytool from userspace), though it does not seem that the effect
is always to write zeroes to the buddy register as the errata sheet
says would be the case. In our case, the switch is connected via i2c;
I hope somebody with other switches and/or the SPI variants can test
this.

Rasmus Villemoes (3):
  net: dsa: microchip: simplify ksz_prmw8()
  net: dsa: microchip: add ksz_prmw32() helper
  net: dsa: microchip: fix writes to phy registers >= 0x10

 drivers/net/dsa/microchip/ksz9477.c    | 18 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h | 18 ++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.37.2

