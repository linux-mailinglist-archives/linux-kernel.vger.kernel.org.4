Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBC6E3946
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDPOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:32:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC310FB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:32:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fw30so4888531ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681655572; x=1684247572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxPwmhTn7R8qcbvvXrEOzUT6iY4Cfl6bwCwS+WC5Va8=;
        b=jRcjXg6jNI5pjujR/dVJj+LQpcy/81Qohbx/vk0NeKE/+JJSu4YD+o826383+s0OTJ
         G+srA2g+4s8lELCqwy4n466Ip06tbeoBQDAgd1Fg2chSEnwPThZz0KDuGcyLQEj/xzsM
         VxvIQfA/RZpK90xvfRkeJid59BhrRkzSCfJCG9cOAazSrwDz2osvpMJdQt8li1pb2jSB
         y9/8RZp/30ZZGsEpp9u/Qn1ZkpvFKxpKm6Dvg+PQ/A6sl4EcUi+0+fruNo2eQR4gc1l9
         VGH5fq3Baf8Cwep1ZSX3tILq2EbswDTIqt6xGjT5SL8n7Mk4VOpLVrQtCmzqbLOBboiU
         mWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681655572; x=1684247572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxPwmhTn7R8qcbvvXrEOzUT6iY4Cfl6bwCwS+WC5Va8=;
        b=U/MfPiu/btbROzoLqEJVIURVjYkqvdZMHBo+r1PyvZrpOn6l4YaVyQYUGYQYaepH8l
         QcrQe2gIFDxruzWVMbENw7ntdAtHJisQSkGrOwthNadovhlx5W9QohxxtMqUyynIFql5
         YvPqoOAuBUDJMh6wxUN7MA7Pwg0dhxP+QTo3gxyuxyMxuhWanAMw899q8BcW9mEW8Wld
         JRlqdQMDrFxBSqwqjkvKoxVA1aWtSh4D9vZ/iXgLWTVyAuD8fTiVKnWT419IJX4NeYhx
         IpfEGEMb/ukXNaawDI773FwYXTZQvuSpJLKTffTpRp/yMvf2XSfqRzqWVNbaMYe3CLLT
         E4wQ==
X-Gm-Message-State: AAQBX9cCkxX0ttxzNg+gubB26AiwXSH3BLu9ff9zJf7AGm1rvOXJe1oR
        +8u4adlpEozhy1+R3NoTSo4OFORgirc3SncixoA=
X-Google-Smtp-Source: AKy350bxYnhx5lTuz3nhlAXOfqrgCFlsA9aSriC++51hMHa6zCQKlPTLANk80um0Va61/aHij0j7qw==
X-Received: by 2002:a17:906:17c1:b0:932:ac6c:7ef9 with SMTP id u1-20020a17090617c100b00932ac6c7ef9mr4599921eje.22.1681655571849;
        Sun, 16 Apr 2023 07:32:51 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id g25-20020a17090613d900b0094edfbd475csm3663271ejc.127.2023.04.16.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:32:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers: late pull for v6.4, part two
Date:   Sun, 16 Apr 2023 16:32:48 +0200
Message-Id: <20230416143248.308942-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 69d170c4c28ba0490bd42630cc09d7e1834bbb3d:

  dt-bindings: memory-controller: Drop unneeded quotes (2023-03-31 21:53:15 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.4-2

for you to fetch changes up to 3ec0e1ea4770e40575bfb2bb4e9ebbbaa3c80d3f:

  memory: mtk-smi: mt8365: Add SMI Support (2023-04-10 18:57:15 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.4, part two

1. Tegra210 EMC: correct reading of MR18 register.
2. MediaTek SMI: add support for MT8365.

----------------------------------------------------------------
Alexandre Mergnat (3):
      dt-bindings: memory-controllers: mediatek,smi-common: add mt8365
      dt-bindings: memory-controllers: mediatek,smi-larb: add mt8365
      memory: mtk-smi: mt8365: Add SMI Support

Diogo Ivo (1):
      memory: tegra: read values from correct device

 .../devicetree/bindings/memory-controllers/mediatek,smi-common.yaml | 2 ++
 .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml   | 4 ++++
 drivers/memory/mtk-smi.c                                            | 6 ++++++
 drivers/memory/tegra/tegra210-emc-cc-r21021.c                       | 2 +-
 4 files changed, 13 insertions(+), 1 deletion(-)
