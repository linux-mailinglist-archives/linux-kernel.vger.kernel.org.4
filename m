Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882E060B652
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiJXSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiJXSyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:54:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7289AFC6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:35:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t4so6969848wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=090t3LiJON2kk6iASQiAtMNlpPlevpv/5QY2UHRV3k4=;
        b=TrbydOn6+MlfdB5ueUhejKJ9fTvRqb782d4b92UrYIPUs5JX+T6gXlwETkqdcT04z+
         lQDQGXaktpTuqB82Es9pcd+7aCm2DqpVAL6ev2iO6x2xMe/QP1NeYdcKgSXg4I8d+bJX
         Log9hOn+sQyj0vqF3svhKBigeHo6ttbILwPvozXvYXGaQ9s6v2eJviF1zQKpG3QN/qqH
         PcGagBXHgDSEyxyyq5E3dUGxmPkHU0uEf5vGIPECblwN9cDHWWCt6CEoOfNX8rrN/3Ew
         6FAprfeGHqpUgY3fg+FAL2XmMApIHodyL5Q1RZjlGnndmgeRBs9PCd2aFkOatfxTkgqM
         M7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=090t3LiJON2kk6iASQiAtMNlpPlevpv/5QY2UHRV3k4=;
        b=3kYajTpjSwybjJyiVkDHLwPZMOjJNIfYydB14rbITVuKqmOE+lOMds4Mnbn13C31Pg
         7IhjfNMIhXna78yd5bdiKPsqgCZ86bDJVOBkifrYQoGHA43on506Yolr0NXixpgjAh+K
         iixtGuy/pfeIl8yOTk1zpvaIptEYk0jy9yvTma5an/SgdfH5GSp/TCF4Dr3LKV6rton3
         2qBKWPkr+izIH5adrATIj7wQx7gIGwwZGp8hwlYAZznCm+haskDGVfBmi272N7/zxZ/m
         ajmikpP/7DKfvp8pFvNAyYiN7u/wqRr3efU7flM2OnRIjdvBQpm3cBpi+EOtltFIObzC
         A/cg==
X-Gm-Message-State: ACrzQf3M0rT9YlgKs1b7qGVvGO/QcW8+zfAa5fMtmJSPG/qTgXdf4KoS
        wZnXrZ20POiqNOCGK0JAJScKAMXvEnGdym4Z
X-Google-Smtp-Source: AMsMyM4z23bQnMwaktqgGV/n/irkd+JIobu7O/lGuCRh5Y+TL+jewkig0EBq1SOJq03bdUMnLIE81A==
X-Received: by 2002:a05:600c:34c5:b0:3c7:b52:3ad3 with SMTP id d5-20020a05600c34c500b003c70b523ad3mr16000432wmq.88.1666617368473;
        Mon, 24 Oct 2022 06:16:08 -0700 (PDT)
Received: from fadwachiby.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l24-20020a056000023800b00236627c078esm6322307wrz.110.2022.10.24.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:16:07 -0700 (PDT)
From:   Fadwa CHIBY <fchiby@baylibre.com>
X-Google-Original-From: Fadwa CHIBY
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fadwa CHIBY <fchiby@baylibre.com>, Sen Chu <sen.chu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/3] mediatek: pwrap: Add mt8365 pwrap support
Date:   Mon, 24 Oct 2022 15:15:40 +0200
Message-Id: <20221024131544.31219-1-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fadwa CHIBY <fchiby@baylibre.com>

Hello,

MT8365 requires an extra 2 clocks to be enabled to behave correctly.
This series contains patches adding the support of mt8365 pwrap.

Changes in v2 :
- Rebase on top of linux-next/master
- Link to v1 "https://lore.kernel.org/linux-arm-kernel/20220530135522.762560-1-fparent@baylibre.com/"

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

