Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC6A610E92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJ1Kek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJ1Keg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:34:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9925CB;
        Fri, 28 Oct 2022 03:34:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z14so6027002wrn.7;
        Fri, 28 Oct 2022 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NzwqSpckoNP17it2+mRAD4Pbxq1xir6QmYGwW3Pwv8=;
        b=TBXDBLlQfNn38PkI94DTl4TOhBkjDateSFX08TuNwp5WHEFIN3YhBS+CJiShn3Ir30
         sa/ND6BR8DwYh6gA4lKJ+R/FOSpO7FS/vcfK3X5gk3Wvehz714/KwqrJ2I+UlfKJueqK
         mmgc5AABHvuRzpuku00latfv7Nn7HQKxRSXZ5/s3PN+yYJlK1OiB/W1/KzGemluzNNhP
         jz30k4M6myvuCThPD7OyXvIMS4dxVHdsDGPCyLcTFPyiK7e7G3fHEfVm0YeX8EIElkIb
         NCHqUjdsSX6tCQnwdR8tMbCeh0Jux2dBoqb/um4YnR5UuwovJDRjuqHPD72ttyPHFZGl
         3e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NzwqSpckoNP17it2+mRAD4Pbxq1xir6QmYGwW3Pwv8=;
        b=Z2WbxfhzghCJwxfhHGI1V3qP2nk9c0amzOMg45TabGVdSONX81+9mPk6dlfoARpfnG
         or8DEa3WCtQadYwy74PbfYcKhDLC92CWU2cDBDVYQn41P518NR47UjiphsSqB9aZzfs8
         FSAO9MXNDgL7mdyHzV1nsRR7e3iKXbg77H1LigoVDuaeVfr/DdxUCrFOkGp1wC4il4Qd
         D6Wvlh6zHwykBGm90Jl6IcCrr+B6UbgdWW5Qg79+RhBMglxcGJLpU29f5J1f0LPVSwA1
         LYrMX2ygyPF03Stz7TTGrvFrMCker1yEA1xPZlNhu75LR99jgKoOFbgb8arLvj5np+1/
         4j3w==
X-Gm-Message-State: ACrzQf0qHVpJQ9zBd1Tqa+nLoifrUk+cBaCAc5XhGbuM/ncwYn/DBzCA
        Mg+BmxjVKd8TBwhntRa6KtRbgLOBX71hS9bU
X-Google-Smtp-Source: AMsMyM5XHpNkQ+aqqZC8OjhAUpjzirc3Qe7lT1TlMRE+R0iEbBLi8U3FiHekJFB70tvRg+XqMKDMOA==
X-Received: by 2002:adf:e64e:0:b0:236:76a9:446 with SMTP id b14-20020adfe64e000000b0023676a90446mr15760555wrn.696.1666953265347;
        Fri, 28 Oct 2022 03:34:25 -0700 (PDT)
Received: from localhost (94.197.40.204.threembb.co.uk. [94.197.40.204])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003c6bd12ac27sm3841551wmj.37.2022.10.28.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:34:24 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tsbogend@alpha.franken.de, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] ASoC: jz4740-i2s: Remove .set_sysclk() & friends
Date:   Fri, 28 Oct 2022 11:34:15 +0100
Message-Id: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
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

A quick series to get rid of .set_sysclk() from jz4740-i2s.
It wasn't used in practice so this shouldn't be troublesome for anyone,
and fortunately there aren't any backward compatibility concerns.

The actual rationale for removing it, as opposed to fixing the
issues of the current DT bindings and implementation, is provided
in the dt-bindings patch.

Note the last patch only applies cleanly on top of my earlier
jz4740-i2s cleanup series, but doesn't strictly depend on it.

Link: https://lore.kernel.org/alsa-devel/20221023143328.160866-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (3):
  dt-bindings: ingenic,aic: Remove unnecessary clocks from schema
  mips: dts: ingenic: Remove unnecessary AIC clocks
  ASoC: jz4740-i2s: Remove .set_sysclk()

 .../bindings/sound/ingenic,aic.yaml           | 10 ++----
 arch/mips/boot/dts/ingenic/jz4725b.dtsi       |  7 ++--
 arch/mips/boot/dts/ingenic/jz4740.dtsi        |  7 ++--
 arch/mips/boot/dts/ingenic/jz4770.dtsi        |  5 ++-
 sound/soc/jz4740/jz4740-i2s.c                 | 32 -------------------
 sound/soc/jz4740/jz4740-i2s.h                 | 10 ------
 6 files changed, 8 insertions(+), 63 deletions(-)
 delete mode 100644 sound/soc/jz4740/jz4740-i2s.h

-- 
2.38.1

