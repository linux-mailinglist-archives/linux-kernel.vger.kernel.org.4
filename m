Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E924719032
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFABv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFABvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:51:25 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F44B121;
        Wed, 31 May 2023 18:51:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-394c7ba4cb5so133230b6e.1;
        Wed, 31 May 2023 18:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685584283; x=1688176283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQoSuTtBJera/qhqdd1CLT9tpMgseaYL+q7uiB1AsuM=;
        b=LpZNjTPWWTW9bKG6YL5+Dip/n97HBUvZDnnqz85s2nXvj+FqLQET0foMLYYmzV9moY
         y5AkTd93XzYUyp7je0hwV7cZIh9Yk0m4871CqMVKrpI+HfeWAfWp5oRcJP/1C2XDQj1k
         N0dQHkLGaY+aL9JoOGGy8JgY1MDNfYvcjkQ5QiXNnXilNmk1hti4nbdvvn6GSq1iazm5
         Rwz1y8rvQr8r6MsupjxdZrkeEscDYgfAsWpRmq0vsH72ducleha9dPnYQvphKwyiIGPy
         S31YEMRE0j3IBbCRrODsBarAvxrsCMd/zA2ymnMlDswpYq9CXkRP6RegdOspXiL72xIf
         uUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685584283; x=1688176283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQoSuTtBJera/qhqdd1CLT9tpMgseaYL+q7uiB1AsuM=;
        b=ORkIgHIT6efujL70tOaV30972JJk0wzoTw8a9Qtc8c0xxSZADoPq48K1YcSHObl5Gv
         eCZUyDrIIqWG+Q+tRqLH/kNtnnxn5pxvNPdn2DAaxJ8vcpSWP3D5e3piN6mXmk5sARfm
         wxMowuhRzi+VvKmWq7j3MnligZZ+QHdQfVfum1ovJj42QYRcj87MF+am8OGJB/24XskI
         EuGIVLzwZOStPN2Ay41lcSum2crkq1Kriun/iaPB02hR/0lL7GIV0lSNIjbV06mwLoRv
         4BAeTzJjoAfsfMatsu0OEb2LvMNBBqtbjvWC6mL15doipXvJlDkcafmupHQiHZmE39yb
         grcQ==
X-Gm-Message-State: AC+VfDwLUujTp4U8T9u/Lfz3+v7jsvGnGJvvGQNoG7j1lmSjDGEnBYRB
        LJpdpVp7101iq3S3NA5/jTc=
X-Google-Smtp-Source: ACHHUZ5ZgLC41CwI/4BKIbwlfeFodkzu3PXg2QnQHsMI6fJvUb7sy1dJ/adxc1ZskHYHQOylyd/bzQ==
X-Received: by 2002:a05:6808:1890:b0:396:9fe5:1a65 with SMTP id bi16-20020a056808189000b003969fe51a65mr6693453oib.16.1685584283284;
        Wed, 31 May 2023 18:51:23 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e454-8dbb-0377-d3ab-ebce-7b9b.emome-ip6.hinet.net. [2001:b400:e454:8dbb:377:d3ab:ebce:7b9b])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a7c4200b00253239144c5sm165795pjl.42.2023.05.31.18.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 18:51:22 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V5 0/4] Add Genesys Logic GL9767 support
Date:   Thu,  1 Jun 2023 09:51:11 +0800
Message-Id: <20230601015115.406002-1-victorshihgli@gmail.com>
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

