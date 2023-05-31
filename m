Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACA717DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjEaLR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEaLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:17:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227ED9;
        Wed, 31 May 2023 04:17:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b0201d9a9eso6453665ad.0;
        Wed, 31 May 2023 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685531845; x=1688123845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nYsWVGJOGz8ttjTDAPLgXM+w4JK5u+IFaSs38V5gSg=;
        b=QFimioP/PjagTNgtw+kQnPBGCIag/xjs2oR2efYX0UBghA+S0a0LZ/2+Q2ppP8NRoE
         C7b6OqYJtimVxqIcd8l4ICNBanylPomKEmsJQ2V+od1nXBwvTE5fkb/rk10oZl45hUrm
         pzbxtBfSKlG2maEwaRNUdrpwxqJqxSjfxnrxc7crT9DcIZCRlU7R6oHDiE1MoqMrJEkV
         HyJomgJW5Xo3qorDVfcIDrO/kyb+VfVMZwxe/aSezGx7y6HOleXMSyUpkXK8pCwPREUk
         WlNDI5EyXlI6fLP4dSePQcsw0OxO7NaLLOrqzxWkYcE/EiJt1ngNaA9/fEHM5MQNF0x/
         LVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531845; x=1688123845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nYsWVGJOGz8ttjTDAPLgXM+w4JK5u+IFaSs38V5gSg=;
        b=fyBdVUXG46zmFifrO0V6Cznq1o/7ecf4jBOMvGVxvKRM6pvnB4asHZ/wuOPapBhYIp
         4szWstXxVoDBu9bksr/bCV+lCX6rpVUQgvg+zKz6B42/BdCpKNBYscfZDaEDLkwsYhFN
         0bVWunA2Su9TvWE9K8NrwZ4dTpwfC3FDkqao8YDRBhKWWJfIPEM5oU9iaKOzdHiJ7N4c
         PWbj4SV6vhODa9gch6HyMj9dM8TNuIpg/FjDPRb/nobpKzT6MaVHKnqq9n9b+NpE5hZU
         JG3aBgHgxkNc24IMWlgUkIxdqzC8qg7r+W5kFztkjZkqxGujTYf8AfhRr/WMc2nqDzOK
         GGXQ==
X-Gm-Message-State: AC+VfDxY5Qoh/LzGEgc6vnqy4act+awGwgGQba0hTV0ImXbDd7IznmJh
        BvkSXI8gVeRFTI4nZClbcKk=
X-Google-Smtp-Source: ACHHUZ4vKyT5Chq2wmrzAx0+95JpEpBO7WO0W+rhn8OTNvyBtA9IhnLkgqiJI4UPp6uzb7iAvNMCKg==
X-Received: by 2002:a17:903:41c3:b0:1af:f253:24b1 with SMTP id u3-20020a17090341c300b001aff25324b1mr16712771ple.9.1685531844655;
        Wed, 31 May 2023 04:17:24 -0700 (PDT)
Received: from localhost.localdomain (111-82-252-250.emome-ip.hinet.net. [111.82.252.250])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001b0aec3ed59sm1076588plh.256.2023.05.31.04.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:17:24 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V4 0/4] Add Genesys Logic GL9767 support
Date:   Wed, 31 May 2023 19:15:14 +0800
Message-Id: <20230531111518.396868-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v4 (May. 31, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* add VDD2 definition for power control-register.
* Patch#4: use SDHCI_VDD2_POWER_ON to instead SDHCI_POWER_ON in
           gl9767_init_sd_express() function.
           use SDHCI_VDD2_POWER_180 to instead SDHCI_POWER_180 in
           gl9767_init_sd_express() function.

----------------- original cover letter from v3 -----------------
These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v3 (May. 31, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* Patch#2: use msleep() to instead mdelay().
* Patch#3: modify the if-else condition and content in
           gl9767_init_sd_express() function.
           adjust the order of definitions.

----------------- original cover letter from v2 -----------------
These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v2 (May. 30, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* Add set SDR104's clock to 205MHz and enable SSC for GL9767.
* drop export sdhci_check_ro() function.
* Patch#1: add gl9767_vhs_read() and gl9767_vhs_write().
* Patch#3: use mmc->ops->get_ro() to instead sdhci_check_ro().
           use msleep() to instead mdelay().
           modify the wait time for Power valid to CLKREQ.
           drop unused definitions.

----------------- original cover letter from v1 -----------------
These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v1 (May. 12, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* enable MSI interrupt for the GL9767.
* add support SDR mode for the GL9767.
* export sdhci_check_ro() function.
* add support SD Express mode for the GL9767.

Victor Shih (4):
  mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
  mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for
    GL9767
  mmc: sdhci: Add VDD2 definition for power control register
  mmc: sdhci-pci-gli: Add support SD Express card for GL9767

 drivers/mmc/host/sdhci-pci-core.c |   1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 406 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   2 +
 drivers/mmc/host/sdhci.h          |   8 +
 4 files changed, 417 insertions(+)

-- 
2.25.1

