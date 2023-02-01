Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E05685FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBAGw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBAGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:52:27 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46944A253;
        Tue, 31 Jan 2023 22:52:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id me3so48470911ejb.7;
        Tue, 31 Jan 2023 22:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMU0WzlJkgoGbKPFmkcXrdPY8PaQeZ4fjfOamOl8qjc=;
        b=a2YsEAmx/kUClgAZDcv2fVH8oN+RKJimOLk1eglv7EyoSakA3WJQparUKoKi4OaZX7
         Qv3YJaJdcnuYLCSEF/tc0tERnaxKQo4ywe8UDRX0okFJ42+PkmK3fQtrWNKGJLUb8WnX
         D/ZJ3wfngZm0jeJUDmquRxPvqTZPKeHlgp511CJS7TsZt9db8IqdfHFsVdqTSZZw+dJF
         Y8EeVS4PYV4F5rb4AFh7bS1l3lNOD2Rzmy54kZZX+MjArXb9qUW2tNcF7asKIKySQRgo
         yUJgHDpF6CQ9FeCNSUvbbcKlDdPcbmfa5t65k80DDefOSax5MSAC04zEuHfp5ttq9CmQ
         nt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMU0WzlJkgoGbKPFmkcXrdPY8PaQeZ4fjfOamOl8qjc=;
        b=RZXvDaGLtggBEnCJL+4xeTcIdTV2kw9C46UZDFSr5es3WiKqs8MoIoUVPFewFOcT4i
         tErKylklr8FaQgDk940NbrCFboMa62adCzYfRy0uz5AUST8oYlegmsEMRnb9KR/SkBT6
         v6TIJRgNg6MkQvNtbRBTinmBg5hZCnau9viRznBJ7vY/+4+dwdBD2udKE3S1pph4IAjG
         HruT9Hhd3Cv3jpqgbpgDQ67ks4OevX3vE0SKH3OGa1Q/rDNjTwK/u1wymO0XpEPCJBk0
         J9/z363xzdg+MTfRcsCP+uAAUOJdSOI1Ue7y0E89PRdPxR73a3w5rY5lMLZ1pwjQsw0E
         /fnA==
X-Gm-Message-State: AO0yUKVbtZAg6YcoTC3xtipnDICiIOywSFDK4VpHQqiHm5SfQcJTQGEG
        RCl+xws1UKZtzOxII7eWJAE=
X-Google-Smtp-Source: AK7set8jh7awTsTD0Mny29s1rpwDIwGC9gf44rtfGI0Nkha6ybhzwArAt8Ck7RlIIEly0DB/mNRoSg==
X-Received: by 2002:a17:907:6d15:b0:878:7cf2:3617 with SMTP id sa21-20020a1709076d1500b008787cf23617mr1683067ejc.3.1675234344639;
        Tue, 31 Jan 2023 22:52:24 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b008720c458bd4sm9509608eju.3.2023.01.31.22.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 22:52:24 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/4] nvmem: add and use generic MMIO NVMEM
Date:   Wed,  1 Feb 2023 07:47:13 +0100
Message-Id: <20230201064717.18410-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

MMIO accessible NVMEM devices should be simple enough to allow using a
single binding & driver for them.

I already replaced two existing drivers. With NVMEM layouts introduced I
can also replace Broadcom's NVRAM driver but that work depends on my
pending U-Boot patchset (it provides required helpers).

Rafał Miłecki (4):
  dt-bindings: nvmem: mmio: new binding for MMIO accessible NVMEM
    devices
  nvmem: add generic driver for devices with MMIO access
  nvmem: mtk-efuse: replace driver with a generic MMIO one
  nvmem: uniphier-efuse: replace driver with a generic MMIO one

 .../devicetree/bindings/nvmem/mmio.yaml       | 46 +++++++++
 drivers/nvmem/Kconfig                         | 24 +++--
 drivers/nvmem/Makefile                        |  6 +-
 drivers/nvmem/mmio.c                          | 84 ++++++++++++++++
 drivers/nvmem/mtk-efuse.c                     | 97 -------------------
 drivers/nvmem/uniphier-efuse.c                | 78 ---------------
 6 files changed, 148 insertions(+), 187 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml
 create mode 100644 drivers/nvmem/mmio.c
 delete mode 100644 drivers/nvmem/mtk-efuse.c
 delete mode 100644 drivers/nvmem/uniphier-efuse.c

-- 
2.34.1

