Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D26B5FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCKSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCKSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:22:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AABF69211
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:21:43 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d36so10743409lfv.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678558879;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fW/DwA4q8yKtERRs9xU/rZtvMzehwEtMWVT+wwuBm4=;
        b=SLkhYgxvwQ8W37Od1EaHKDv4IPw+xzGOmOIABjII4hNvkqUSqUjoLWOflEi0Up7Fkp
         //lUQMNszSDofGVMxUGCtpG+uAawJeEUN/czLp6jbbIP5+XZE9CwFTlsajhUy1Jvs1T0
         tZWMrjU+/kOExsSSAYjdfvyExk5K5IwMkgNRx7ngF7q08pr/On/VgftALtAkKYq2kTRi
         XWgS69QJG+QzHA43b0UW8ph02NmnQMCRRy8ovbLyUB2zwUk0p6RcEPY1j68Fdhplor1M
         N804f7jSyexF4Abk6HOviUTbAUSxNfGd7kt74gi0zc4+/0F5jJd+ZKYKd0dVwyEa7Xbf
         HIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678558879;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fW/DwA4q8yKtERRs9xU/rZtvMzehwEtMWVT+wwuBm4=;
        b=uH8Y4ltyb/qcm4maylZzj6iAywobtCluc962TW2WmcKFUCq9frSPj+NA0JgYbQ+lvL
         dBD0fSOfCV3+UZoNAPNnrEF76rAxRY77PJnP7dejm3+QB/s8c2aqLHMrQYfG90rf5gAT
         YEcZCqbGr0C2Rwzzu0ghmCCMQ+y65Yt/Otd73y6x+SfJs245AFwYnEPeQv5k/97ZeZeX
         E7QvpZr6FDvXKLrXJh3akkZZrSqCX+YlOYchf29Wu93t61Z/pwdWH6xlkIVpI0bEtbF8
         W4JG0SOhMNRf0bVLvj83v/OEfdsguIauVhZ3pCVCpUzAMWCEaTjbX0rwEDJFThvIndgw
         +uvw==
X-Gm-Message-State: AO0yUKUeJIC4NPNwv/+rkmtb/mITo6dIMzVTH4AGrkTv1kCm7imEcFN9
        UnnVsBvYVv6FBaKsJ6NRmKYTfnoKByGW5syq+XQ=
X-Google-Smtp-Source: AK7set+Xvog9/k+S1AVtKvAZqkOWtOQvKOROYITUaYLogWd5mY33YoMr/OkqcI6qjrpKnz13T+o0pA==
X-Received: by 2002:a19:750a:0:b0:4de:3c94:da15 with SMTP id y10-20020a19750a000000b004de3c94da15mr7498975lfe.4.1678558879282;
        Sat, 11 Mar 2023 10:21:19 -0800 (PST)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id n11-20020ac2490b000000b004dda7435451sm383648lfi.202.2023.03.11.10.21.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:21:19 -0800 (PST)
Message-Id: <1678558770.495747-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 21:15:38 +0300
Subject: [PATCH v2 0/2] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DesignWare MMC cores have a configurable data bus width of either 16, 32,
or 64 bytes. It is possible, and some vendors actually do it, to ship a
DW MMC core configured for 32-bit data bus within a 64-bit SoC. In this
case the kernel will attempt 64-bit (readq) accesses to certain 64-bit MMIO
registers, while the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs
64-bit accesses is the FIFO. The symptom is that the DW MMC core never
receives a read on the second half of the register, does not register the
datum as being read, and thus not advancing its internal FIFO pointer,
breaking further reads. It also seems that this FIFO is only used for small
(less than 16 bytes) transfers, which probably means that only some SDIO
cards are affected.

Sergey Lisov (2):
  dt-bindings: synopsys-dw-mshc-common: add "fifo-access-32bit" property
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO

 .../bindings/mmc/synopsys-dw-mshc-common.yaml |   7 +
 drivers/mmc/host/dw_mmc.c                     | 125 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 3 files changed, 132 insertions(+), 2 deletions(-)

-- 
2.38.3


