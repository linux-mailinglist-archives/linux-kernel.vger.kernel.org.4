Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C174769D259
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjBTRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjBTRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:49:45 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB9CC3E;
        Mon, 20 Feb 2023 09:49:40 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b18so2019422ljr.4;
        Mon, 20 Feb 2023 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FGe9Nk23MtKGd2Di6KmMIvhk+QEojQFWCNwRtr+vnU=;
        b=mvk+TThKU7ubB56YYV+lW4V2BDunzS2i086o9i9QeBoNCeTQQxjbnWeoZ9e/QNqsVK
         Sg5yh34HjWTRZ1fxni4rA6nGR2yiWjplrI+VHSuEHZXoQYA1t8b0s/kJ2q2GmbNrUBts
         uwxMqd2eJEHwtoMKppfRIGQVAYlRUv+sE4mZopglLLjKsSszsTEvawYS2vhQgEingQRE
         yIHkL/EKoYPT1wv3OLG+G4xInbh+zQIBGdUNNJx3DXPD21mBDl/zc5DEY1Bt/ofa0R59
         RM/aBfj6GrXg6SeLGeB1nfiUni5JTNJTrgEe0ThFUO8U2YXMDEB2DZ3mvDOTxD8xkdrZ
         hrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FGe9Nk23MtKGd2Di6KmMIvhk+QEojQFWCNwRtr+vnU=;
        b=tHZBV3sM7lP/SDqwLrDwToIaJZeQfoz+pM3eP5gMEXy1JcdNSdO2/6vZwuktkcVsEo
         Loi6EJnxt7dzsWgHhSh9pS/LVlo/0DC964wg3QizkMUxy39T0NjU1WavuPnbPk/9Vonf
         p2qIUXONrWR4r7UDH4n/OgCz91u5khwbrpQHu5mjYlQSHeuDs81vUoR9gLiHxzV47Fov
         9HFBRaeJ86UPw21TQqz3DfZ1fvOntENA0c5kve/hcmibOerz0MtD66W6+nP3TAi2XbKf
         nAaDauhzSwY6VTW+wqmMekpApegWa8BnS5f6trnQ0o+7fLdBZvpInHn/Ewk1xulvJAVO
         NBRA==
X-Gm-Message-State: AO0yUKWCPjfAt+IuV1D+CGq0MNZGcC/uIIbb8nne5Y6RrsOKpwytouU8
        B1tElb2DMBm2VUs+4OwKvp0=
X-Google-Smtp-Source: AK7set9xxybpVCvBucs1tVZ78OmOAio0JOq4btRXAwdqDX8LKNUvBFuwFLH6Bpkxpupku4UmK1wBSg==
X-Received: by 2002:a2e:9092:0:b0:290:603d:4337 with SMTP id l18-20020a2e9092000000b00290603d4337mr641579ljg.51.1676915378771;
        Mon, 20 Feb 2023 09:49:38 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e9f16000000b0029353491df6sm294695ljk.48.2023.02.20.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:49:38 -0800 (PST)
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
Subject: [PATCH V3 0/2] nvmem: add and use generic MMIO NVMEM
Date:   Mon, 20 Feb 2023 18:49:28 +0100
Message-Id: <20230220174930.7440-1-zajec5@gmail.com>
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

In V3 I didn't decide to modify existing Mediatek & UniPhier drivers as
there are some concerns about adding writing support to them. If needed
that can be done later.

I decided to support Broadcom's NVRAM with generic driver though. That
is my main goal right now. To let generic code handle NVRAM access and
let NVRAM specific driver handle its content. That way it can be reused
for other NVMEM devices later (once we get layouts support).

Rafał Miłecki (2):
  dt-bindings: nvmem: mmio: new binding for MMIO accessible NVMEM
    devices
  nvmem: add generic driver for devices with MMIO access

 .../devicetree/bindings/nvmem/mmio.yaml       |  50 +++++++
 drivers/nvmem/Kconfig                         |  10 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/mmio.c                          | 125 ++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml
 create mode 100644 drivers/nvmem/mmio.c

-- 
2.34.1

