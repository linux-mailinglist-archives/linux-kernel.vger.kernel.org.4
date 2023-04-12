Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F86DE9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDLC6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDLC6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:58:00 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18610FD;
        Tue, 11 Apr 2023 19:57:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id cd20so436881oib.0;
        Tue, 11 Apr 2023 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681268278; x=1683860278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBFq4BHhH/cjgo3hbq/bqAErrb/K3fGnq66n2iIKmYk=;
        b=e1Q2jiqOH7wW3KWNsflgd8NjY+K4Ulk1rGHEeGeuGBrOrOGAcznh+FtudInqmiSSou
         NHJCXgCDAS4d1ofWyqVuWF2ZK3ECZ9wtojyTP+O0NkpT42TpwtDj/iuvrKnIFsF0NttJ
         9vfOYl3kHxQltIAM6WGQhlxVNEbjuYzwv0qfr9LXztTECT9t8moq+6BLSIJOWh4sNlrP
         XwZPe5AU0Ht8PAMfK62fc5ConQ+orAm84obW762drf//P8TAYlQufS1pEF3Old8CCPah
         koI+urtWwk7LAcxnOpkwetpOfjpkJ0fy08PCJvvexFENjYAWz1QI5Tt7JJMpcPCNHfEp
         eeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681268278; x=1683860278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBFq4BHhH/cjgo3hbq/bqAErrb/K3fGnq66n2iIKmYk=;
        b=0DDURABNFMjFosA5EngiVoUyTfPgTsudjys3A7dxJDRmCf5QT3gYvqOZex95MMwhD6
         HkuAIH5VxqBOKEU0Z/UwEDKVUlIOnaCsHEZ/fn6WoKqDA+AMJNSPY05tDWCDuGwYEKDj
         wYcSXbsDRMj/1q+VgpXTmdEjhOME15ZHcPvvBK118cZVg7eT2yH4clfdXDaPRJswQeDm
         sKV4dbvh8kpMsjgV/aLtkzFsa8bl5OHS39govMW3hcNMGMaZIpeNRE3e+/zl8ZpIjff4
         8h6A8ZJt5YFsfMDU9/hWXONWB3jVnWG/dZg+3kWR/RmJEHYEIHscsAMhX6vUr4ah/8y5
         ncEw==
X-Gm-Message-State: AAQBX9e8DbheZ5tHSCIEAH58ZSnATnTQMtHI49+3kvh6X0cPHSb9+wwu
        9z3FPUcceSxHh1FLRtdhXpQ=
X-Google-Smtp-Source: AKy350ZL3k2HQ1msLFr3129WnolMPaBLSMdDj4Bc6jcq5S8BBlX+vDi4HsuaMTQpgJQUOhsM+goNjQ==
X-Received: by 2002:a05:6808:8e:b0:387:2075:59c with SMTP id s14-20020a056808008e00b003872075059cmr249676oic.37.1681268278334;
        Tue, 11 Apr 2023 19:57:58 -0700 (PDT)
Received: from localhost.localdomain (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
        by smtp.gmail.com with ESMTPSA id b124-20020aca3482000000b0038bc0cb5d52sm3013293oia.9.2023.04.11.19.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 19:57:57 -0700 (PDT)
From:   Tony Dinh <mibodhi@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Dinh <mibodhi@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v2 0/2] Add support for Thecus N2350 board
Date:   Tue, 11 Apr 2023 19:57:34 -0700
Message-Id: <20230412025737.20280-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thecus N2350 is a NAS based on Marvell Armada 385 SoC.

Board Specification:

	- Marvel MV88F6820 Dual Core at 1GHz
	- 1 GiB DDR4 RAM
	- 4MB Macronix mx25l3205d SPI flash
	- 512MB Hynix H27U4G8F2DTR-BC NAND flash
	- I2C
	- 2x USB 3.0
	- 1x GBE LAN port (PHY: Marvell 88E1510)
	- 2x SATA (hot swap slots)
	- 3x buttons
	- 10x LEDS
	- serial console

Changes in v2:
- Add marvell,38x.yaml. For now, add this binding to the Marvell
directory to keep it consistent with other Marvell yaml files.
At a later date and a separate patch, consolidate the Marvell
yaml files into  marvell.yaml.
- Fix various DT bindings conformance (too numerous to list)
- Vendor prefix is not necessary, so remove it.

Tony Dinh (2):
  ARM: dts: mvebu: Add device tree binding for Marvell Armada 38x
  ARM: dts: mvebu: add Thecus N2350 board DTS

 .../bindings/arm/marvell/armada-38x.yaml      |  27 ++
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/armada-385-thecus-n2350.dts | 432 ++++++++++++++++++
 3 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
 create mode 100644 arch/arm/boot/dts/armada-385-thecus-n2350.dts

-- 
2.30.2

