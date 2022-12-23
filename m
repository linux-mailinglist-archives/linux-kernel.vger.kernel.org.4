Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB96655230
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiLWPi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiLWPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:38:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA656379C7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w15so4892079wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5OT3dG+TVvhR7aK9FlQndiJCY9sU+0Z1Btwvq5Xrts=;
        b=WRgzCDaaJoXTA9MQT7MCWDZRK26MgzVEuanVXy4Wyokc0DvTB29ulM5/TKktPNzZ/b
         Yak+HtAWd8PoPTuEbNthfEXkUHPa/MnCGRrXumhMzwAXaLPYkcEcWsjqG0+2YvalGDON
         77Hh0BeVQPSsy5F8zlaUV2pTdu1YPSNa1uSCz3InLFwDhiA2OIMXQJXWRRByv1Ks1xvg
         lc78VvKDvLIlrY6jSer3hGlx419dgNCHADeHAnv5B8q2VVyhe8md/8hbbPBZMVWLN+3Y
         +5SjAP1V/wnfQjQsQZSsst7qxPPWaV4xYqQ5/zH46TRkCFPYeqoUUUb6xIZy7KICH9Ji
         kfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5OT3dG+TVvhR7aK9FlQndiJCY9sU+0Z1Btwvq5Xrts=;
        b=qivHMdkgmC5wy4fCdmmkXB9biJT7nBWh8HWGckvSuz9FRvi7YRtGs2KXA+irABZ45u
         eplvfqH2er7V4Ai8SxsWxf1SWL8fl0phqHyQGx+4okRNumIPnp6wavGBphAJuCOoTKuu
         2jQJuGjiWicq3SyKpZ/nEySJQV2G2G64SDMXB2oXKDYID0pVQ8/uZJzAvroRIytk5qk6
         Dg4GNAjlTt2BKYh3Y8q3jsAIHywuBRTTrHQVd7osp8NMlblldhi5wE5ArnC1o8/+BVnw
         rYOWRz2+oXGgmA0D1XBGPJYX53eyeH0QCFEmY/dweuHZm5K75xOXif+VedJLMt4u6Xi8
         fRjQ==
X-Gm-Message-State: AFqh2kpnTxlsM7F6qPtntp7RyjKoFlnpj+lYaCVrLvPxJA+4vvfZqieQ
        GwX5+7jwKy2+Esw+pYa5bS0l8g==
X-Google-Smtp-Source: AMrXdXv1YRDjT5K2nkk8kGQJSQrW+/YnHjJkAIzhCHXfkt26zepoAwL+Ga/KYTApH6VMhYGdjuDH4g==
X-Received: by 2002:adf:f905:0:b0:242:37e3:1747 with SMTP id b5-20020adff905000000b0024237e31747mr6446751wrr.21.1671809903423;
        Fri, 23 Dec 2022 07:38:23 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:23 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v7 00/10] Designware PWM driver updates for OF
Date:   Fri, 23 Dec 2022 15:38:10 +0000
Message-Id: <20221223153820.404565-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An updated set of patches for the Designware PWM driver
split into PCI and OF versions. I think I got all the
review issues in this set.

Sorry for the delay in getting this out, between conferences
and other absences there has been little time to deal with
this set. I will be now out of office until 3rd Jan 2023.

v7:
 - fixup kconfig from previous pcie changes
 - re-order kconfig to make dwc core be selected by PCI driver
 - move clk variable to patch it is used in
v6:
 - fix removal ordering of DWC_PERIOD_NS
v5:
 - fixed kconfig string error
 - merged pwm-nr into main of code
 - split of code from pci code
 - updated pwm-nr capping
 - fix duplicate error reporting in of-code
 - fix return in of-probe
 - remove unecessary remove function as devm_ functions sort this
 - fixed ordering of properties
 - added missing reg item
 - fixed missing split of the two clock sources.
 - get bus clock in of code
v4:
 - split pci and of into new modules
 - fixup review comments
 - fix typos in dt-bindings
v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming
v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency

Ben Dooks (10):
  dt-bindings: pwm: Document Synopsys DesignWare
    snps,pwm-dw-apb-timers-pwm2
  pwm: dwc: allow driver to be built with COMPILE_TEST
  pwm: dwc: change &pci->dev to dev in probe
  pwm: dwc: move memory alloc to own function
  pwm: dwc: use devm_pwmchip_add
  pwm: dwc: split pci out of core driver
  pwm: dwc: make timer clock configurable
  pwm: dwc: add of/platform support
  pwm: dwc: add PWM bit unset in get_state call
  pwm: dwc: use clock rate in hz to avoid rounding issues

 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml |  68 ++++++
 drivers/pwm/Kconfig                           |  26 ++-
 drivers/pwm/Makefile                          |   2 +
 drivers/pwm/pwm-dwc-of.c                      |  76 +++++++
 drivers/pwm/pwm-dwc-pci.c                     | 134 +++++++++++
 drivers/pwm/pwm-dwc.c                         | 210 ++++--------------
 drivers/pwm/pwm-dwc.h                         |  59 +++++
 7 files changed, 404 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
 create mode 100644 drivers/pwm/pwm-dwc-of.c
 create mode 100644 drivers/pwm/pwm-dwc-pci.c
 create mode 100644 drivers/pwm/pwm-dwc.h

-- 
2.35.1

