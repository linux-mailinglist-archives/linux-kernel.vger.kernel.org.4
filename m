Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221C6449FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiLFRLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiLFRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:11:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F92497F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:11:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y16so24445505wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq7fPIZG3aDEtfD0wwU/8U9whhqjXtEDAaDzJYWZYHs=;
        b=I5BQl0skgp4y5pxYi0OJILcDpjI7+inScV5XXGbcoq+jO5RPU/B2SNeVTbfFbN5wNy
         M2xaBux3+3OFnCqEwaI1HrmkZE+btXFiUfuiHp8VPZH9fqVGyun1WoKBVOihWzh3JDzv
         Q/Q24KyFionSw2jddc7tKzAHP1zHOe/sYxkyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sq7fPIZG3aDEtfD0wwU/8U9whhqjXtEDAaDzJYWZYHs=;
        b=dK0LW1DpFBpcKP6kwzUdwkIH7ymU9a+2u2hqAV/zzviIXvn1TGB1od51uT4gaCtbm0
         2WmQK6WmXzpo44JGx58Z3YY1ZnnBHvvin8Dy+1TJ4EzvPmxUL3K3r4V51Gekf2TFIv1D
         2E8xAIqTVPUCOzqJw+zgYv89qjr7l8aSIdkq+FKDdOAOzqqSDpOpbYClDfP/WwhzmGXR
         e6VcTEq1F4iYObeLmFtnGD52crIOMecxeizM06wgg7qkXHf5a6oG1FBGOx/ua8yCjCpw
         l8SXLbdg2giEHpmAxKXlTFWiexWzHmeDNFCBnVjq3mgfKwAAL/FT8PQLyNhEXJj4QE+B
         Lkfw==
X-Gm-Message-State: ANoB5pnfQHWpS6yWj2Oqgwpn4gbCl/pekYg5rBjXhytU0XxRs8ipOSHC
        Su6A5F8Q4k55nl1heGX0ySnLwec49ujSd8XR
X-Google-Smtp-Source: AA0mqf441ksXSYFc5sMMTbcHMvI86FrsJSqJCKpNxvqwTxWzUbvdSexZJAzQXz4YBh69/Eko/8VC+g==
X-Received: by 2002:adf:d210:0:b0:242:989:d9cb with SMTP id j16-20020adfd210000000b002420989d9cbmr4758668wrh.716.1670346666507;
        Tue, 06 Dec 2022 09:11:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm17298534wrx.55.2022.12.06.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:11:06 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] ARM: imx: add missing of_node_put()
Date:   Tue,  6 Dec 2022 18:10:44 +0100
Message-Id: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5 patches in the series fix the same problem on different platforms.
In doing so it is possible to add to each of them the tag "Fixes" which
identifies the commit they fix.


Dario Binacchi (5):
  ARM: imx25: add missing of_node_put()
  ARM: imx27: add missing of_node_put()
  ARM: imx31: add missing of_node_put()
  ARM: imx35: add missing of_node_put()
  ARM: imx5: add missing of_node_put()

 arch/arm/mach-imx/cpu-imx25.c | 1 +
 arch/arm/mach-imx/cpu-imx27.c | 1 +
 arch/arm/mach-imx/cpu-imx31.c | 1 +
 arch/arm/mach-imx/cpu-imx35.c | 1 +
 arch/arm/mach-imx/cpu-imx5.c  | 1 +
 5 files changed, 5 insertions(+)

-- 
2.32.0

