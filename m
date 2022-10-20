Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689D606101
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJTNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJTNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:08:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547315F93F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:07:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so1156986wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNOCO5Wzuq4FvlmMhHTUbdlTAohmkL46icpaXsf0/1Y=;
        b=xz3RuACawiv28InMGXQPOnsDtPTsJajZ0co1tB4EqlAXmOjn74Of+tTCASMWW5T1vq
         g0K6EWs4M0gRQSj7ajehfvBsOB+V5ytuNGnObh++TrchvAkfbVeFIJlZNYIre2HZhTQt
         lUciWYqgJzm+cS+QpEzqS9UWNM4lNYVMdBpXbmOOoEZfDpD52VExK2bOl9KDinXzH2op
         uByKpsLRksD226P2QQLsInJCtNiyobkHcoDPKtROZNPWLuz7iMIyA/F9f+y0U/6BKeN0
         Rod6OPc+h3qETyrFsRXPrMMMDd7gNpyVvyir5bCWxNfmiEqVOmxXm/TwNzN6sHSir431
         5Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNOCO5Wzuq4FvlmMhHTUbdlTAohmkL46icpaXsf0/1Y=;
        b=2PKXLI5Xq/O9G3mYoN1lFjZ5FX2upP4m8LtQCnuDAvu+X2bkPUR3KHOurcovJJ2gJW
         dB+0YJMwK6C1Nz/4bPl0K5t8V4Nngmv66A79D6SYvE/pfULdtMVwY+54Z6Kb0e4+6DQl
         U9TI5fSd2PFfzxos9bmDj20S0Py/RLfCuBGuMGIqKiOXwkSvhVy7xAjYjCq/x417hb16
         v4BrPZidEatjW5bQ5GsERTBMMaJMK98feBqgfCep2MSwdoA9rKJDvyDwZgocJHHI3eo9
         VZkosNhNA4xxMl0vkP+nXtdgePneqObbKtC29FBV7jAdHQNFZmPqqhjBn1VYwxgyacHI
         7eIA==
X-Gm-Message-State: ACrzQf1xR4gzgSWtiV9KV8hRa/WfTzTt3NTgZ+uqLVmMNIou8uQG0c3q
        Vo0rw6rVC47I6UZx5H8idUsuaA==
X-Google-Smtp-Source: AMsMyM6q4GCeHgKPIprFFHv956iClBofRUw8CV7juZGTrSWFBsXMfcTeTjT1bqPf0FaB0/TIDAyNMg==
X-Received: by 2002:a5d:64eb:0:b0:22e:48df:f1bb with SMTP id g11-20020a5d64eb000000b0022e48dff1bbmr8385160wri.262.1666271262400;
        Thu, 20 Oct 2022 06:07:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a82:90b0:2979:1615:9a68:f204])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b003c6b70a4d69sm2676080wmc.42.2022.10.20.06.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:07:41 -0700 (PDT)
From:   fchiby@baylibre.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
Cc:     Fadwa CHIBY <fchiby@baylibre.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] mediatek: pwrap: Add mt8365 pwrap support
Date:   Thu, 20 Oct 2022 15:07:16 +0200
Message-Id: <20221020130721.24866-1-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fadwa CHIBY <fchiby@baylibre.com>

Hello,

This series contains patches related to the support of mt8365 pwrap.

Regards,
Fadwa CHIBY

Fabien Parent (3):
  dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
  soc: mediatek: pwrap: add support for sys & tmr clocks
  soc: mediatek: pwrap: add mt8365 SoC support

 .../bindings/soc/mediatek/pwrap.txt           |   3 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 114 +++++++++++++++++-
 2 files changed, 113 insertions(+), 4 deletions(-)

-- 
2.25.1

