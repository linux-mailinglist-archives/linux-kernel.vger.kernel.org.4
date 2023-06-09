Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884837290A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbjFIHOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjFIHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:14:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F39273A;
        Fri,  9 Jun 2023 00:14:47 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b162127472so408868a34.0;
        Fri, 09 Jun 2023 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686294887; x=1688886887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj+I/Z078bQFH9XJY9DtKo6v8eFiX2booMeshYQ82pY=;
        b=LrrM5LABjmgulWhc+P2jC16Pz1Hvb5PDpEhoa/Vhr2qcu1wEdMsipsNCHaktK0ulKb
         MNyGZgH5U6hCvZ5pdvBIZ3pqPJPgbFifjEd72ss72elZJ/33JDq3o4p2FKO2KsJLx6/D
         2LdJWl6KeqmI3hVhogPaue2NNbf1uPB26arntK46+l8xdQM13pqj93ouneMnfAjcbCYs
         qBF3GFO6ZMMbCvGeIAbEhK72YK4U3jCuJxqFNf9w5y6VsCQ92e6xqonpF7bkcGo5ZCDd
         aGmYwD7mt6vSKSlnrbbtpTJwtUEwQCCN/xhYJAw2nYbyY3VUENCL8AzK0AC187NmP7sH
         jcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294887; x=1688886887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj+I/Z078bQFH9XJY9DtKo6v8eFiX2booMeshYQ82pY=;
        b=gqEh75Svj5lWwffmGOtycC8JioF95aeO3SeWVajtQKaIV9h8lTochK5cclluTCtGe8
         FEmeXtOoFYTz6TIBdOVtBPssPDbrCszhwY6JMSuOyJPUah5PWsF8KYJ0KwG0X37wmBkM
         O1bQh43s55vJY60+xc9Jmb2OtGqOGTuk25iW2dKWlMpBkiPSyTF4hW3IlsnhD7xR7Gz9
         gF8onNeReLbmUAxIAzCymfOqXdDwq/HechfsnZ/tMKt6ljdKqbEyOoH0Sy6UPiiXbfB7
         xGuWorxa3zesBCUTnuvgbgHvT9F0mLgxyw76JCJT3HIUpQYZihqlRSjwTF+Zt1qiSL+D
         Npsg==
X-Gm-Message-State: AC+VfDywUZJegfTrn2xkgKhc8Fg4wFABuJGpjHy6/OebFHXJ6WOl6eF9
        1k+GO+5+g8rxcXWO2s7AAsU=
X-Google-Smtp-Source: ACHHUZ5iTxPB2V2Uervt0cQoqR/babM8rB56SsgMpRcNL22NDg3rd4x5Tue8UHARwrQjw7wQ5FgAtw==
X-Received: by 2002:a05:6359:a02:b0:127:f5d3:b6f9 with SMTP id el2-20020a0563590a0200b00127f5d3b6f9mr619332rwb.18.1686294886835;
        Fri, 09 Jun 2023 00:14:46 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-07a7-2523-0b40-49e4-7cbb.emome-ip6.hinet.net. [2001:b400:e282:7a7:2523:b40:49e4:7cbb])
        by smtp.gmail.com with ESMTPSA id f3-20020a656283000000b005308b255502sm2085196pgv.68.2023.06.09.00.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:14:46 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V6 0/4] Add Genesys Logic GL9767 support
Date:   Fri,  9 Jun 2023 15:14:37 +0800
Message-Id: <20230609071441.451464-1-victorshihgli@gmail.com>
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

Changes in v6 (June. 9, 2023)
* rebased to the linux-kernel-v6.4.0-rc5 in Ulf Hansson next branch.
* Patch#2: use usleep_range() to instead msleep() in
           gl9767_set_pll() function.
* Patch#4: use usleep_range() to instead msleep() in
           gl9767_init_sd_express() function.

----------------- original cover letter from v5 -----------------
These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v5 (June. 1, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* Patch#3: adjust the alignment of definitions.

----------------- original cover letter from v4 -----------------
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
 drivers/mmc/host/sdhci.h          |   7 +
 4 files changed, 416 insertions(+)

-- 
2.25.1

