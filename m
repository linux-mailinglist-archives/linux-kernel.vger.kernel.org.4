Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD1660E95E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiJZTo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiJZTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF710DE67;
        Wed, 26 Oct 2022 12:43:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h9so17117671wrt.0;
        Wed, 26 Oct 2022 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORoQDh2bzxbybTBIICtiM6Bx1pQkzrw52vv9hk0I9Po=;
        b=BOPdWFtXsbOjApuxxFp/AXYwOkGyCX8muLb77Xw8wCbL9CHgQLXGLFnO0D2YL+I5cr
         nuHYDS0LxklbZUVjnk6rh9gCErC41oEPZksXW1/r/+1S9HGLRNEoflo2tkmJuMjboezG
         nzwDF1HsLhV88SLMS/+NJtkuUzZWnN0usRjpZ3sHfw1NDTIvXlIfSzkJAjQVdBd6XS1t
         39bG/ZASeAXjGjF5Rz1WctwUYmbbpZfAFz02xin9R1x/lXNaRvMRonVi/271J4oJUzaJ
         QYbNQ8teYyR4G0reiuTl1xL0tJGwfUPW3ZVUsREYnVKh+nj9fhyAE/D7564rcSpj1Zvd
         w5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORoQDh2bzxbybTBIICtiM6Bx1pQkzrw52vv9hk0I9Po=;
        b=CRgyXfl80/W2A+u32Ij3lPoe6JiSagQROBaOw0MfEHCohYtu/40MNWBZYu3gl4+cWO
         vsYldeMxSWIhtQNrBdthXDK/iOOBQZHokaO2OldzZOR9HBI4nWBfAm70mTUH0yYpL5jk
         QRtar7TMPpQ6v8i8gtinMazVUg2SPbjGG0ju86DnsyW1CpSKoat+PwJu09Cnip8p1B7M
         qN19P52qXuoP2xFXRoIe/XEFbLuGhMt5GT3Kz2S1xz9aW86xiS4YQjkYTafEwPMK1t8e
         QS7Q3Rbm7cz4btmp4y4O6gs2v840qWExXK+qCoclonasL14IvUEn8kqW0jWyAd6Lp4O7
         eflA==
X-Gm-Message-State: ACrzQf3QJg91sdh6p5FDHVFousmafpc4AiMuUzz/3K7qRfi2npV4m977
        uqBs8q+gQeNzTLZga/QqNyg=
X-Google-Smtp-Source: AMsMyM74qPQyGVBqHv8D8V4H1TUz0Gg0/3rYN3LVednYEsyCeCLcsp6FNlDQn0ZGTR8UlbyLLyl7kA==
X-Received: by 2002:a5d:6d8e:0:b0:22e:60ae:8875 with SMTP id l14-20020a5d6d8e000000b0022e60ae8875mr30435324wrs.676.1666813431237;
        Wed, 26 Oct 2022 12:43:51 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b002364c77bcacsm6021198wrh.38.2022.10.26.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:50 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add support for X1000 audio clocks
Date:   Wed, 26 Oct 2022 20:43:39 +0100
Message-Id: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
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

The first three patches of this series modify the Ingenic CGU driver to
allow the X1000's I2S divider to be modeled as a PLL clock. This is not
really true -- it's just a fractional divider -- but doing it this way
maximizes code reuse and avoids the need for a custom clock. (Thanks to
Zhou Yanjie & Paul Cercueil for the idea.)

Patches 04-05 actually add the X1000 SoC's audio clocks. The last patch
is just a cosmetic cleanup, feel free to take it or leave it.

Aidan MacDonald (6):
  clk: ingenic: Make PLL clock "od" field optional
  clk: ingenic: Make PLL clock enable_bit and stable_bit optional
  clk: ingenic: Add .set_rate_hook() for PLL clocks
  dt-bindings: ingenic,x1000-cgu: Add audio clocks
  clk: ingenic: Add X1000 audio clocks
  clk: ingenic: Minor cosmetic fixups for X1000

 drivers/clk/ingenic/cgu.c                     |  38 ++++--
 drivers/clk/ingenic/cgu.h                     |  17 ++-
 drivers/clk/ingenic/x1000-cgu.c               | 119 ++++++++++++++----
 include/dt-bindings/clock/ingenic,x1000-cgu.h |   4 +
 4 files changed, 141 insertions(+), 37 deletions(-)

-- 
2.38.1

