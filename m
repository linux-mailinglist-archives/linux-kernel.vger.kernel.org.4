Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB760399E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJSGM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJSGM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:12:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88C05924B;
        Tue, 18 Oct 2022 23:12:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id by36so20838621ljb.4;
        Tue, 18 Oct 2022 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCx4Kgc/xr5kokwSca80qjeKiN60Myi1wfhlMAWWRds=;
        b=XBzvyPdVVbjKJoRDRCGPEMwBlp09+Cv5Gy4Eg/NPVfXWZBKNWGt59b5yG+PCXyUNAt
         JM3Ur9BOSt/oVm7OFl2nBMNQQllY60VSew8iCIjuowljBA3Udn3p4pu7Y14Ejvvf6nse
         OovMdkcDnZMTPnDDyKrLRcF4KEg9HB2aDALxOgOAVSrOJ1Uwl9AOoYOTjXMLboRyGasp
         rY+OphPkUXKTnUiSGh/DPauqZwDwZlN9PgabGCgxcuh0WNGu+ap+D4/opH4l9Jl6R1LO
         WjwHO+uWDzMIlvytOPaQ69Y6hEu/jyoAHDPVPHI24WoX2h9lGH25ZUGbhV6t7/61ToYr
         bAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCx4Kgc/xr5kokwSca80qjeKiN60Myi1wfhlMAWWRds=;
        b=hw3ph+PiFcVlTRw/NOWTpdg5SU3BYKMYD3SIx8Ed+XxI3MdnYAt5T1y7p/GCRbRnvE
         5aQPMk2G3Cq4ukhKzHkc1Kl73sO2ulVlnuzCf+S7GrkMQ7r8mqvhCJN6nfOVfp5IVF9K
         CCCNGYhbZM/rv/71gm+b6dl3TJNyfIAo2P9rpI1mdY3RvObOoj2X/oN1dujzZEsyyVwg
         BwKZJUp3gJQo8M7FxpkGLdoOZEOnJM7XUztmkanypRv+tAOLACt6i208OWgbDm6+EfXq
         me/7wmBGEjHRVvlMD40btyGXo3H+bjNZu69WyG9oe7flQkDoPYdzEVWnzxDH/8DY+uqE
         HaGA==
X-Gm-Message-State: ACrzQf2twrGyqT6LTjHc+MngJ082HyDEyhrUHcrADEm/24/juHy4o4nc
        VG4b33/sXrohLTTHmq23q8/t+sL3BJ+jXg==
X-Google-Smtp-Source: AMsMyM64sqqStdh8jJpoBDDopV3gSTthIS+uFLtH1dhw47aT+gzJXWsGp7VdvvZmHmI8ctROYFhcFA==
X-Received: by 2002:a05:651c:1784:b0:26f:ed03:a1f7 with SMTP id bn4-20020a05651c178400b0026fed03a1f7mr2376004ljb.30.1666159944026;
        Tue, 18 Oct 2022 23:12:24 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id o21-20020a2e9b55000000b0026c46788fa3sm2221759ljj.104.2022.10.18.23.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 23:12:22 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] gpio: tegra: Convert to immutable irq chip
Date:   Wed, 19 Oct 2022 09:12:00 +0300
Message-Id: <20221019061201.5194-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Update the driver to use an immutable IRQ chip like tegra186

Svyatoslav Ryhel (1):
  gpio: tegra: Convert to immutable irq chip

 drivers/gpio/gpio-tegra.c | 60 ++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 16 deletions(-)

-- 
2.34.1

