Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC863F840
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiLATax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiLATab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:30:31 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48239C82EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:30:16 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c15so2190777qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsmRXs1XrARV8x2b98wPvkGWEv+wWS8i+zTUmm0QBMo=;
        b=kx13LBQYrQj0PDhS8TjXdPpnrGsFG+moF4OhMOT/dDaZR59xpURwUxLcfLYJmejSko
         9bKQZFeWjQ6PGdVwmcjZvlpwrIPOcRTrIMbKmFqxXOwTOFKb8fnIpFv5cjC0oj5ZbwQ7
         3ObDICe7H50Ofjn6thvG7xuAHqulYJ1Tv6JQNNsBUzfxpJjoogrlis6kjsDoW0x6jOz1
         KeRWzqqySBEV9XOeq8URBgZL2WmQItzrfklgsqs/P3IyrB+mKTYJnm6THUoUQN9r6oE1
         4cm0r9kmo7zTaYHI0gDaWZIre5/LHs6Y5l4eZOEDq8GMtmIejaA7DUNv6UG72kGy9a7E
         L2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsmRXs1XrARV8x2b98wPvkGWEv+wWS8i+zTUmm0QBMo=;
        b=G3D3iyAN8qC5F52HIBAgPSN3auZJdT2S9tlRWDoioxf6NcXTw2E82tKgxWGSFjqSHt
         O4Udk66M5D5GVb7Go1qIig4qbVsO+sSTXvU1Pkn3s+lb4vL4Qu1vjYR2t5aq+4fscix8
         m780tOxfznca36llOo1PhmgNt7y63qL3ezNzr8yPCKVJxBTGwlJeZDQm0nSZUFS8Kkj0
         jlJMUJqs0q33VtZtbdDMNC+N5tp+qPh4W4qLOZBDStg/ZVUiKQQ29bwikiRFSgItknQd
         BT4nI+rzBF+po3WZo77irTpixRcUDjDKTB3SR2MIZQtv2T1jUyNmsXD2fE/B8ROD/mlV
         cHAg==
X-Gm-Message-State: ANoB5pkRewT34Wbk73fhl5KznjQj0lIkbMQ248O8sA8TWFTGqCJukP7+
        4T1/PHkih0RTKxY/tLD/lkxgoA==
X-Google-Smtp-Source: AA0mqf7X7qi2w52qIfDQ55qcQ8HNhQma5ohGztXlAbQ4fSTTgCgUZ23tqFB5YNBiXAmQynnKQRYkGA==
X-Received: by 2002:a05:622a:90c:b0:3a5:4086:a46 with SMTP id bx12-20020a05622a090c00b003a540860a46mr61808193qtb.200.1669923016031;
        Thu, 01 Dec 2022 11:30:16 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85153000000b003a6328ee7acsm2977748qtn.87.2022.12.01.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:30:15 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/3] mtd: spi-nor: Extend SFDP to support additional octal modes as per latest JEDEC standard
Date:   Thu,  1 Dec 2022 14:30:03 -0500
Message-Id: <20221201193007.261690-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest JEDEC standard (JESD216F), there are now bitfields in the
4 byte address instruction table for 1S-1S-8S and 1S-8S-8S modes

This patchset adds support for checking the 4BAIT for these modes,
along with additional NO_SFDP_FLAGS to support enabling these new modes

v2: Move page program commands into sfdp.c instead of core.c,
as this appears to conform more closely with spi-nor paradigm.
Page program buswidth appears to be automatically determined, so let's
follow suit and do the same.

Nathan Barrett-Morrison (3):
  mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with
    new octal modes as per JEDEC JESD216F
  mtd: spi-nor: Add additional octal-mode flags to be checked during
    SFDP
  mtd: spi-nor: Add support for IS25LX256 operating in 1S-1S-8S octal
    read mode

 drivers/mtd/spi-nor/core.c |  7 +++++++
 drivers/mtd/spi-nor/core.h |  5 +++--
 drivers/mtd/spi-nor/issi.c |  2 ++
 drivers/mtd/spi-nor/sfdp.c | 13 +++++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.30.2

