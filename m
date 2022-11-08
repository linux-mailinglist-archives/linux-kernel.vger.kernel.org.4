Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C26620893
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiKHE5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiKHE5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:57:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D847312;
        Mon,  7 Nov 2022 20:53:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i21so20716058edj.10;
        Mon, 07 Nov 2022 20:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg8ScU3pDth5YYtNSba+y23tAKdqXF6at6ma5iPQR6A=;
        b=pGvdsmvMKFLMKcPCJ/8gIwtPi3zr+g4v+hyqpNSP1SZ6ryQSKid/FM5BGy4rrZNU72
         n63/4aKYpRf8Yx5ig/3MTBoyRD6xLQfS4ZLpUNXMepLGkSyOFw4qq63fA36whOjwwvX6
         Zs0iVwIqYwC7cZXF71DFuAKWms7xNV2HVPFu2JirGIYHk51DxN1PpgC9XCS7/cGC2cj+
         udl1KzVAGytG3QK43KyAHCBkOf2OC12zTX6khFD9jeGY2yEk6hLltLCEdRXrYO9462DN
         u/wSz0330JH+QYLkymEmAT65BpxqA9ObL8VOBZaBxTr+IKwk1paW0MaDYlS1oLlacmKx
         f/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg8ScU3pDth5YYtNSba+y23tAKdqXF6at6ma5iPQR6A=;
        b=zn8GZ7JpDZBFk38QlgJXHXhgExFo1fL0D9x1wec/w4AlrTyMDP6Bo2jy379Ovs5CJf
         +eppK01FDoBPMi22Je0u2JHdu1jVcKZq5FLv9zTPXhpfOyXP8k5LByMZWKnmZ3zGVGky
         2dSfteq+JWZJ2hM/GLpz0G/H4Vdu4noLmG4aePLR+ekGgXRIlYziQyD2mFR0LgoIIMBv
         u6EgWBbxVnQ0EuRcxNkYPfcP14FmZuJWT6gnaeKCK4bXqT++lbL2H9iMqNdXuUOfIizb
         QIsGpIKIUM7/G6+f5Jar8uS/8E59Tp66ioTgDOgpHpy8F3a+fuh1OczAViJRfATzVkp3
         CUvg==
X-Gm-Message-State: ACrzQf2b1EgSX3ljfAtbK7gjib59nriX/ExWGjMazyM4OGGMHAchw96W
        kfeDzxCIBgQatJp4PQqaTmU=
X-Google-Smtp-Source: AMsMyM6mGObMOMcT/OgXEfSZ/+y0XBnkWG4w7scRQPt88ebiOnXXWel3+lC+Td5lko/J2dEDfjF17A==
X-Received: by 2002:aa7:cb09:0:b0:461:e6b6:4bad with SMTP id s9-20020aa7cb09000000b00461e6b64badmr30898511edt.27.1667883233519;
        Mon, 07 Nov 2022 20:53:53 -0800 (PST)
Received: from hp-power-15.localdomain (mm-58-12-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.12.58])
        by smtp.gmail.com with ESMTPSA id p11-20020a05640210cb00b004637489cf08sm4994444edu.88.2022.11.07.20.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 20:53:53 -0800 (PST)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 0/2] mmc: jz4740: Don't change parent clock rate for some SoCs
Date:   Tue,  8 Nov 2022 07:52:58 +0300
Message-Id: <20221108045300.2084671-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have one clock divider for all MMC units, thus changing one
affects others as well. This leads to random hangs and memory
corruptions, observed on the JZ4755 based device with two MMC slots
used at the same time.

List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b.

The MMC core has its own clock divisor and it goes to the first plan in
that case.

Siarhei Volkau (2):
  mmc: jz4740: Don't change parent clock rate for some SoCs
  MIPS: ingenic: rs90: set MMC_MUX clock

 arch/mips/boot/dts/ingenic/rs90.dts |  5 +++--
 drivers/mmc/host/jz4740_mmc.c       | 10 +++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.36.1

