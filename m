Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA54C717C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEaJ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEaJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:57:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAE6129;
        Wed, 31 May 2023 02:57:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39810ce3e13so3907978b6e.2;
        Wed, 31 May 2023 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685527048; x=1688119048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOc0UBOtHPdYEoOqTP4iajGTGug0Xs6mCkm+zIdi5v4=;
        b=beEXgrl/jUImnnx9RoObOda6LFybucDQby4FKmALz/o9bThirL16WsPMVYZHhUScYE
         SM0QcqROK2TTDqibYc5/86ft3km8fg/x1+UcO1yYZ9d+WW7NocBhHBWv+3pvGWOsc0lH
         DPF+Ud57Xeq/io94Qss7DEgR6Lzxby6VQ0At22V1iwCw77lQI7+wYvAh2cxtXknpDOQ4
         a5S4jpe+mfjBWF0ku1O7sSPXJ/mnXFTTgK4p6CyBKYRdBrIynarSapfLHY/2RKEFD7d/
         R4zC42p+AfiX5jYoSvgSAw574buaOLloZvcS/EExEIurA002MD645s91v73t5VjLrbpp
         t+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685527048; x=1688119048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOc0UBOtHPdYEoOqTP4iajGTGug0Xs6mCkm+zIdi5v4=;
        b=GviZXCXj+7iXXYdVxsVToczFOPPblDYIUpaw7BDfJ08hFkLGFngCa0oW5p3txPbK2a
         sx+wx4o+MQQsD2AQkFB5EK37Cxi7FPktCHL8fvlWyz/Si8LSTBlyCvSXDW76rp1ReeJA
         /ikj4dAbWjyGCxpPIdg6dHpUyoRkTQX+/MlgeEzA4R8rbhrDzpNvu3p98wv/Y/mrT5Du
         yegM9aoxTdUaEJSr4ETrwEmZSBRqLm9biXmkx+7SoV8EzUGJISE0C6T2U0NeqfMz5Bky
         VKX8+CJmR7MsuTVuPYZFwSrpyKyBcnQ8UE5JVpNkHP5vMZKNHmleWys9MI+QVcwy+j2a
         TboA==
X-Gm-Message-State: AC+VfDzwmK1fD8xw/fH+P5OtqJoqIla926hShgJnySoWV2tkC+3aaxoP
        qBcQD5rZFfmubDjckebC/vVl+J0re54=
X-Google-Smtp-Source: ACHHUZ462p4FsYDcdqT9/A3K6vcXjU1zgpXqMlgTwsRHqNwM2JiMu1rxLVQb03ko89CJVja2eRfu/A==
X-Received: by 2002:a05:6808:b15:b0:398:26f0:6799 with SMTP id s21-20020a0568080b1500b0039826f06799mr3491208oij.13.1685527048125;
        Wed, 31 May 2023 02:57:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e454-8dbb-0ba6-8aef-0dad-9e10.emome-ip6.hinet.net. [2001:b400:e454:8dbb:ba6:8aef:dad:9e10])
        by smtp.gmail.com with ESMTPSA id f16-20020a656290000000b00514256c05c2sm852002pgv.7.2023.05.31.02.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:57:27 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 0/3] Add Genesys Logic GL9767 support
Date:   Wed, 31 May 2023 17:57:18 +0800
Message-Id: <20230531095721.392664-1-victorshihgli@gmail.com>
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

Victor Shih (3):
  mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
  mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for
    GL9767
  mmc: sdhci-pci-gli: Add support SD Express card for GL9767

 drivers/mmc/host/sdhci-pci-core.c |   1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 406 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   2 +
 3 files changed, 409 insertions(+)

-- 
2.25.1

