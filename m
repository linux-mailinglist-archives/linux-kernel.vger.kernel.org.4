Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287516B5D57
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCKP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCKP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:27:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4FBE774D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:27:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id y14so8383549ljq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678548420;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=SH56Nddmw1ZrZbG4A/Duy0q3YhB55llLKrtwopN271oMvsD9R/2fmWYVk/0ayAcoYg
         v3vgS6Ppamh2MJNfL0w1zckzujbnnS8ls2bJyWOCVvaSQzwAXqzMyiFrAzCWFyy3M18o
         WXs/CoJFiy5dMxd7EJJCV4GZ9J3+L7B/cQ4ISfSOcAzyYF+eCRHPypI2oPoC01c8Nt6o
         qOcY9BFOp8Xsj/L+MfHGAyUui5fGVPJbs7ESLv0jmsNI3eyyTD7P0pDMwbHjEWGSOyka
         syWy5e3GWiWGDENfiu2BNds8aNja6hreO8qrCXAdzl6af6xbGpih60P/fOgBGqwFCrIR
         zCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548420;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=uIVDT0QkPRgBDfYjmyD3G09xFS4eIzo91rqlXDBQaoaUHLM/m9udRIbAZLsHvMzkIF
         eVFXwDG7nQshiu3QFNiBEhTzbC3fn2JrZXmlEMVTb/Kjl6h4/aAFKtVP5pQSDwP+9xR+
         0dVaR5ZJ80SVEBvDOYIdrSt5pODK+/2d3jj8eAfy58wJsJPB5XAscaXlO1dng6ov17FD
         VZV0XeT84xqoGL/cu376E5C3LbL9NRVmx8t5kaf0vNk2SMMOrzoedZOWVMzf0GP2PBJN
         3Vlgye50GYBsMs005MIZqHrnjADZOLo2Wplmc28/3ICVSjLBwwvBzr8Njx3EfLY7BGTS
         wFfg==
X-Gm-Message-State: AO0yUKWaVXdSqp07NyAK6+eeBEut7P5oVbBbo7njnpeAmgttBiTQ4lld
        Vq1grcAQcHmx09f+kUma8G+P2qDnEFGIYiwcyKY=
X-Google-Smtp-Source: AK7set9YMFNgjZUesji1hZIZ75A9vvszpvKaSjcW3zi7kKwLZ8Vn99xfsnlPvyKZWx2FQN8mJwiqgQ==
X-Received: by 2002:a2e:7013:0:b0:295:733a:3463 with SMTP id l19-20020a2e7013000000b00295733a3463mr8592865ljc.29.1678548420005;
        Sat, 11 Mar 2023 07:27:00 -0800 (PST)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id m2-20020a195202000000b004d3d43c7569sm347981lfb.3.2023.03.11.07.26.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 07:26:59 -0800 (PST)
Message-Id: <1678548256.0817535-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 18:23:00 +0300
Subject: [PATCH 0/2] dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems
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

DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs 64-bit
accesses is the FIFO. The symptom is that the DW MMC core never receives a read
on the second half of the register, does not register the datum as being read,
and thus not advancing its internal FIFO pointer, breaking further reads. It
also seems that this FIFO is only used for small (less than 16 bytes)
transfers, which probably means that only some SDIO cards are affected.

Sergey Lisov (2):
  devicetree: synopsys-dw-mshc-common: add "fifo-access-32bit" property
  dw_mmc: add an option to force 32-bit accesses to 64-bit device
    registers

 .../bindings/mmc/synopsys-dw-mshc-common.yaml |   6 +
 drivers/mmc/host/dw_mmc.c                     | 125 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 3 files changed, 131 insertions(+), 2 deletions(-)

-- 
2.38.3


