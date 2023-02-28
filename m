Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8726A53A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB1H37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjB1H3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:29:50 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B771116B;
        Mon, 27 Feb 2023 23:29:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s20so11870775lfb.11;
        Mon, 27 Feb 2023 23:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZPr8dGI3aR8aZYgW2ma5FZPEeNI8Ujf4i3nXNHuIyE=;
        b=Ixn3pcRJCxQ8McSfxwt2FqTJuJ6urKnsHOjrPhIOe0i8BrUpBVNhb6ZhgUs5IRLGpE
         2V+ToK5VE1BMV1/CU4+Wgl4wnJrJDw8PvY3mo7zCodUX36RT50UfZ67PjZrXEfoc42Cz
         GL+QH6sxFsZByYfEk/ZbUGgA2dpwrQ9s8LpcwDVcYm0dFJ0CXOnul6SvMvMXTv9KgBFF
         T4ogJDNc4HS6oWvaQ81aEkon1RjbGpartM3Vq9lUp6H3TXvk/3Mfl4Ctb1kpSJGqhtXn
         D5TGrCmQIOd2c3UHCLbFuV5ROhEHdCwa6yIpp7ChltudNZQMw8iK2hG+r8iTkBklIgbH
         Kq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZPr8dGI3aR8aZYgW2ma5FZPEeNI8Ujf4i3nXNHuIyE=;
        b=BAn4iIfSXk9w5AiTJVtkdn3bwBBsVspuepcGlhrFnRinZ4LC4lezAEvGSrp1Gf9qDz
         7sR8a1S9PoTH0yHPMfYteQAE+C5D394AONdaBM9PPrzYwiUNBPfqmHlT0UWkqAJDCN4A
         H7Mu+uV3+piYS4ImgsCOpu7Efwpm/mFM7qNZF9bPHfoZNFUQoa+4K/6paT4AcsmPMv3K
         PfPdCejUHMJk8IXfDLc1i6u/asaXnFdGx6wRJyI4aKC88ikmuId+QJWPQ972JWxCXeKh
         mDgC/Xd2iV3KzDpgfIyDlLGMUfSesw48iWNXlZhD68Nb+E8IzkrmpfsIwT9ZtLWqMmUu
         xDbw==
X-Gm-Message-State: AO0yUKWqHh5HlpiVJHA113OdMU4iEuKjpJOxtvmagLk2ar7U1t+UZRwG
        BcXeZuHv+4EChZUrwgysf+g=
X-Google-Smtp-Source: AK7set+eCp+xMpfhsvaxmUkNUhQJJ+UAblG4lQOyi6vzR9O3QZCLcmGJ9HndFHKpTd2Ec2pJylvPog==
X-Received: by 2002:ac2:48a7:0:b0:4dc:4b70:a723 with SMTP id u7-20020ac248a7000000b004dc4b70a723mr383341lfg.30.1677569384662;
        Mon, 27 Feb 2023 23:29:44 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id l2-20020ac25542000000b004d85a7e8b17sm1229550lfk.269.2023.02.27.23.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:29:44 -0800 (PST)
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
Subject: [PATCH V4 0/2] nvmem: add and use generic MMIO NVMEM
Date:   Tue, 28 Feb 2023 08:29:34 +0100
Message-Id: <20230228072936.1108-1-zajec5@gmail.com>
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

Once we get layouts support NVRAM driver will get migrated into one and
generic MMIO driver will take over its binding.

Rafał Miłecki (2):
  dt-bindings: nvmem: mmio: new binding for MMIO accessible NVMEM
    devices
  nvmem: add generic driver for devices with MMIO access

 .../devicetree/bindings/nvmem/mmio.yaml       |  50 ++++++
 drivers/nvmem/Kconfig                         |  10 ++
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/mmio.c                          | 148 ++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml
 create mode 100644 drivers/nvmem/mmio.c

-- 
2.34.1

