Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A244B66CE07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjAPRx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjAPRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:52:35 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537C3B3E0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:35:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f20so30689895lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLkKdr7pDQEIzmgkyKtN1Zu++zCyw4Keu9Km6S3sT2o=;
        b=QasTzb8h2vrOzkCrftuDbLS+D57mrkSyDJFNmvhtJg61QCpXBah5MQQ/klFT+Jr44m
         OfExarCYmScCqot8/2QoF2Kn6hockeWUu27BKBHaw+Vw6fz+Jow6YpMOSiHlDgxC7qhP
         EM/wOHX1PS88OTZXj6uG2qMVwZFi3u37IBsUODw2sJtv45GymLllUGbqdIyHat9jZEtp
         5zGyuiyAQFvvbErrOfKVgcXcmSh4wE+9Wf+/et6R0cs1BNYNaTQaqu1mJphmFK7n2v7q
         InbhxENc/mnmZeHgZx7q7HwnK4+wdwGzz+9hvYhYU6h+LbB+kKtF52ZSeZA/SVyzh2hW
         tN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLkKdr7pDQEIzmgkyKtN1Zu++zCyw4Keu9Km6S3sT2o=;
        b=BriZnccPP7vEJzR7cRfphWFxeZR1523arn0a1DVLrYmCCURP8nS38HuxbzTy1bmUkV
         3UnFPec8lKdDpbSWowwnwrQeHkjcEGUvcxBKYuFvSHIq9pqInX6m29P7japvnlYoMpoj
         8wlnGgB9l8PCrHKSM7Ce82JTZnyuqoKnW0L/S8h0qAHB1AvPXqq/HECGPCNvd++KISv5
         6FgeBzy+Lm7a/J+U+LdSVAOivkMF8ABD4/v2s9ZaQ8lOVx6MPdiKhNJtFUTQBbjt3QsS
         QsH6HKGF84tWF+PfzCulxajt11v9fAI6IkDjV/+0jh1a6GBsV+HS/3r8d0ai9Ghb1kVo
         DLyg==
X-Gm-Message-State: AFqh2kqzRNg94bFEbO6lbqaipbKkgxojRY787RpyFgWSakKq8g7aQcif
        P8e5M4dvIpcdz5CCfX/7K86LrsGJ9UuYC3lE
X-Google-Smtp-Source: AMrXdXsY9dU88GrMUZ0keyqwQPbzPga4V1dJtLnUYV90CFWzYZr4I98PrEX0dJGG50/qWJssb6/MCA==
X-Received: by 2002:a2e:994f:0:b0:281:771:e1cd with SMTP id r15-20020a2e994f000000b002810771e1cdmr3381416ljj.33.1673890502691;
        Mon, 16 Jan 2023 09:35:02 -0800 (PST)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id k20-20020a2e8894000000b0028b7f51414fsm707333lji.80.2023.01.16.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:35:02 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        sean.wang@mediatek.com, Landen.Chao@mediatek.com,
        linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, mw@semihalf.com,
        jaz@semihalf.com, tn@semihalf.com, Samer.El-Haj-Mahmoud@arm.com
Subject: [net-next: PATCH v4 4/8] net: mvpp2: initialize port fwnode pointer
Date:   Mon, 16 Jan 2023 18:34:16 +0100
Message-Id: <20230116173420.1278704-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230116173420.1278704-1-mw@semihalf.com>
References: <20230116173420.1278704-1-mw@semihalf.com>
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

As a preparation to switch the DSA subsystem from using
of_find_net_device_by_node() to its more generic fwnode_ equivalent,
and later to allow ACPI description, update the port's device structure
also with its fwnode pointer.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 5f89fcec07b1..a25e90791700 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6884,7 +6884,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->min_mtu = ETH_MIN_MTU;
 	/* 9704 == 9728 - 20 and rounding to 8 */
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
-	dev->dev.of_node = port_node;
+	device_set_node(&dev->dev, port_fwnode);
 
 	port->pcs_gmac.ops = &mvpp2_phylink_gmac_pcs_ops;
 	port->pcs_xlg.ops = &mvpp2_phylink_xlg_pcs_ops;
-- 
2.29.0

