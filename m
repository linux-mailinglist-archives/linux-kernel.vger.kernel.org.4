Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA39D69B157
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBQQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:49:40 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64D47432
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:39 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id c10so1701369qvp.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBYJ6k0k+VwIOBHwk5gBDh6Agwe69W8vixfj+NTwllQ=;
        b=cbgLFejJCkpFAA1rG+0UhVL12J9Kobhzxs0sUeSCZnsDNZuzpFAfmYkqndjEtV5DI6
         kW2GzbI/EGgOyvKiAUPizIKx9rIHbtAD6uh0yQJmEwX2G3wd19DeZjt5IBx7lhC7dWKV
         Q7X5UAmCemucN9qoxsVo0IBoSCKebEk61Nhszx8Sl8Usu2DJ+Aqpz5aj7l6503HM9tzA
         NnvgIlOBe0c+qyb2NAIM+aoTLTpFeWxjV0E/ucnvZc8gelIXfot1NkS/BQe9RcKsIxzk
         L78sDo5LO9hkFyA0yyaQlf8yev3PON+TGZi9nncsFpbw3iq4OqrbksgUXl7V4eOYzT+K
         QwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBYJ6k0k+VwIOBHwk5gBDh6Agwe69W8vixfj+NTwllQ=;
        b=IdW36U1LDv0KqU/BWcn36Ir2HE6ckibT6DLbHC7UG85YgFctiMrMpym9jLVsEjBt/U
         ebqV/Ep71EJOww9S1GNoGkeV79Cbk+cUS/0TVAqd1EyelZ4p9/MDyLRmzD5JZjCnd1g1
         EOxDicNpMMsw2dZ7qcXpD4IxLKJjBi66R5Pe0GThOon7h4EHv+INnvRRHJBvG5djPA9u
         Awcgr82NX4fl/IvSU2ZXH+oEwevEWl2EMdstgJZff9pehJmtw0hotefSSOmlAIxzHE3R
         D0NlnmWXtyjAmeVjP1lBgoeZsmrTHZlNlxbTk3dAvQZFzsjbuslowmoY5VB9geWAH0IA
         VGzA==
X-Gm-Message-State: AO0yUKXeZQ8muQYw4eUg4/JfdJVnV3XMQ9KfIMGqqizTkzSPxHAm2YRn
        /cqf/NB4dja8vl6f15Dwn+guEA==
X-Google-Smtp-Source: AK7set9tVasjBlEnZHW2dQ+jbQys+MEkEojuhwaDAbV3NzS4mykkijQTQKiIyqYuqqIuadRnPy2pHQ==
X-Received: by 2002:a05:6214:1942:b0:56e:aa11:daa3 with SMTP id q2-20020a056214194200b0056eaa11daa3mr2767351qvk.14.1676652579014;
        Fri, 17 Feb 2023 08:49:39 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b68-20020a37b247000000b0073980414888sm3569161qkf.42.2023.02.17.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:49:38 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/6] Migrate IDIO-16 GPIO drivers to regmap API
Date:   Wed,  8 Feb 2023 12:18:15 -0500
Message-Id: <cover.1675876659.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-idio-16 and pci-idio-16 modules depend
on the IDIO-16 library and are thus updated accordingly.

The 104-IDIO-16 lacks a status register (as does the 104-DIO-48E), so a
no_status flag is introduced to the regmap-irq API to properly handle
such cases and avoid hacks. The 104-dio-48e module is updated in a
subsequent patch to take advantage of this new no_status flag.

By leveraging the regmap API, the idio-16 library is reduced to simply a
devm_idio_16_regmap_register() function and a configuration structure
struct idio_16_regmap_config.

William Breathitt Gray (6):
  regmap-irq: Add no_status support
  gpio: 104-dio-48e: Utilize no_status regmap-irq flag
  gpio: idio-16: Migrate to the regmap API
  gpio: 104-idio-16: Migrate to the regmap API
  gpio: pci-idio-16: Migrate to the regmap API
  gpio: idio-16: Remove unused legacy interface

 drivers/base/regmap/regmap-irq.c |  23 ++-
 drivers/gpio/Kconfig             |   7 +-
 drivers/gpio/gpio-104-dio-48e.c  |   6 +-
 drivers/gpio/gpio-104-idio-16.c  | 294 ++++++++----------------------
 drivers/gpio/gpio-idio-16.c      | 255 ++++++++++++++------------
 drivers/gpio/gpio-idio-16.h      |  80 +++------
 drivers/gpio/gpio-pci-idio-16.c  | 295 +++++++------------------------
 include/linux/regmap.h           |   2 +
 8 files changed, 326 insertions(+), 636 deletions(-)


base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.39.1

