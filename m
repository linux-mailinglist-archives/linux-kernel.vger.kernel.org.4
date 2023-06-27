Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4026973FC89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjF0NK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjF0NKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:10:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D54273F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so4038775e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687871444; x=1690463444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBuLo0b6IxVX9cXB2ei5gmONECQso6leYmJZ9ORNlhg=;
        b=SPdHVzDtj10utplwPccXd3PwCKXAvbof5DY6uypVigad+MbSspIV4rrelrtToaG8HF
         f03cJzy4nX4flmYtJ4q8hvulmwdRgHexG9cXEFjKKp22eCJHPyiDC65bq8vO5Z9xUaqm
         jzTtQdahRaeqGXDtN/W/2VNIaZ8NiF416SYqGUV9vN1KgD0v3JqYhSsP48m5tlh5ljlh
         Jai6Z3y5pAzAMMTLtLQQtMbIKoax5ClX6FSI3R3a0gEXcQ93hVDfJFdRont0ip2iMJJD
         yaoUdRzpk4NduTc80+/eMvOmrwHFdch0aBxQWRmwaHkSZhjUBfFvSHDYGyHKM0gkIRmO
         RhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871444; x=1690463444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBuLo0b6IxVX9cXB2ei5gmONECQso6leYmJZ9ORNlhg=;
        b=gHwyiSMpGfQz6hiZlZbIHm8P0mn3ClirBIMMLCaMi1gHpwKQUShgyAGAOGSa/Qpf2v
         ELcJ0cIyFV+l9BxS0MvOzTspe9wU7CUcnQDD6cpG6TiHa3alpiSSX+m37AWYeQIjFVaW
         XsUkNAqPZsyjUMB0HTKMnv9BQ5+vEWZZ5A+0/8v8y9nZMZCefEpzXkfq07u9+BqJR1gY
         YE6FYbbF3sKargAmbWDOA+XwRNSEU7khPe+D/MTSF/EuT9nR9ZcWzkpFbVRwMK9p+3vK
         ImVGeWW1iq3sM4y5uAyDBhm/zuYj5G3MSFX8yGKai67DOokjjHClhivtp3a7yW9FWBJ4
         rhGw==
X-Gm-Message-State: AC+VfDx66x6n9AtRBwHavq44xTkq5Et/xXOZBncQWZEYF9EScxxFvUDL
        nHdJNL2I7YpG0Umv5XqpwWcbHA==
X-Google-Smtp-Source: ACHHUZ50JKean1DAHPXWBxcFyTzxCE/EXC9Xbx9DILD4S3N7MM6uSMBrhmJzZhxaevVJ/oWJ1112/A==
X-Received: by 2002:a19:9141:0:b0:4f8:770f:1b01 with SMTP id y1-20020a199141000000b004f8770f1b01mr12263567lfj.19.1687871444260;
        Tue, 27 Jun 2023 06:10:44 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003f91e32b1ebsm1403196wmf.17.2023.06.27.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:10:43 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 0/8] soc: mediatek: MT8365 power support
Date:   Tue, 27 Jun 2023 15:10:32 +0200
Message-Id: <20230627131040.3418538-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Angelo for the feedback, this version should fix all issues you
reported as well as the kernel test robot issues.

Thanks for any feedback!

Best,
Markus

Based on v6.4-rc1

Changes in v6:
- Change flags field to be u8 instead of u32
- Use macro concatenation to simplify BUS_PROT macros:
  BUS_PROT_WR(_hwip, ...) etc.
- Use the final bit values for scpsys_bus_prot_flags from the beginning
  of the series.
- Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
  MTK_SCPD_STRICT_BUS_PROTECTION.

Changes in v5:
- Create defines for all registers and bits in mt8365 power domain patch
- Redesign scpsys_bus_prot_data to use flags to store reg_update,
  clr_ack as well as the difference between SMI and INFRACFG. The code
  uses the appropriate regmap depending on the flags.
- The WAY_EN patch now uses two flags, one for inverted operations
  'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
  'BUS_PROT_STA_COMPONENT_INFRA_NAO'.

Changes in v4:
- Redesigned WAY_EN patch and split it up in smaller patches.
- Added two documentation patches.
- Added mediatek,infracfg-nao field to the binding.

Changes in v3:
- Mainly redesigned WAY_EN patch to be easier to understand
- Rebased onto v6.0-rc1
- Several other stuff that is described in the individual patches

Changes in v2:
- Updated error handling path for scpsys_power_on()
- Minor updates described in each patch

Previous versions:
v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/

Alexandre Bailon (2):
  soc: mediatek: Add support for WAY_EN operations
  soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap

Fabien Parent (2):
  dt-bindings: power: Add MT8365 power domains
  soc: mediatek: pm-domains: Add support for MT8365

Markus Schneider-Pargmann (4):
  soc: mediatek: pm-domains: Move bools to a flags field
  soc: mediatek: pm-domains: Split bus_prot_mask
  soc: mediatek: pm-domains: Create bus protection operation functions
  soc: mediatek: pm-domains: Unify configuration for infracfg and smi

 .../power/mediatek,power-controller.yaml      |   6 +
 drivers/soc/mediatek/mt6795-pm-domains.h      |  16 +-
 drivers/soc/mediatek/mt8167-pm-domains.h      |  20 +-
 drivers/soc/mediatek/mt8173-pm-domains.h      |  16 +-
 drivers/soc/mediatek/mt8183-pm-domains.h      | 125 ++++++----
 drivers/soc/mediatek/mt8186-pm-domains.h      | 236 ++++++++++--------
 drivers/soc/mediatek/mt8188-pm-domains.h      | 223 +++++++++++------
 drivers/soc/mediatek/mt8192-pm-domains.h      | 112 ++++++---
 drivers/soc/mediatek/mt8195-pm-domains.h      | 199 +++++++++------
 drivers/soc/mediatek/mt8365-pm-domains.h      | 197 +++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         | 157 ++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h         |  51 ++--
 .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
 include/linux/soc/mediatek/infracfg.h         |  41 +++
 14 files changed, 972 insertions(+), 446 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h

-- 
2.40.1

