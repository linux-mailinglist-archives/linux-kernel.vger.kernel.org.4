Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA47F6FEE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjEKJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEKJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:13:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6AAF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso5537599f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796434; x=1686388434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQCqns3gRcdM2Czi53SSWn2ift7AglrgCzm1ZlfFVtY=;
        b=aEdc8EUhRPCvlJCwMe8Rm7UeIMK8k9ozZyccjikm1PFOnM6LlwNsyO8t/JEJdq8VPh
         wanI8BkBXgxWGXtqhIpu6MV2lJAfTH5rqHQ4BRdEJrMdL1C9HryuwKQDOxQZhIwiyA+M
         FhrseSCZgGglW6De5m7s6Y56Nwr+p4Oa5W8Cxf0Qu8PplFhi06xgDyg/YARHyvh5PMtG
         dci52SbgH/ovIpDbN+TgLB8bOGuf6sjJcYnVRTT8nP8hCUIZSALloKLrwPBKIJhSaFfL
         xaDiU4JEGVAMzay6SEu1eQUY1XK3k+BmU6OdPaEJNOOjBeaAhBddc8kAJrXagWikm5em
         uCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796434; x=1686388434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQCqns3gRcdM2Czi53SSWn2ift7AglrgCzm1ZlfFVtY=;
        b=C95lzlNYZkyFd4N8WUlDxCvNuAr2LlhGCZAxQMh7YMbr9mxSuGd6F2nnyvmcQz84fs
         WwBCoRYiNZbmli71S99ifm0DJUeVx/JdrU0Bag97AhZs6eZuFxvUX42wcS4fIB0HyUgA
         7YQRefEq8eRsVpwidn8hNHF8J/KEMivtT2HIZzGG88Fr9ZceDC5hEo+fdjwERqcTKCUi
         wc5s+5ghIppRH+dJIdJ74wXOHGykhOw+mXolRgtxgeoFlNEFiiTBXz8aLeaHNuoR9iTX
         EBZqswKbSJ2rtMhvVOiS2HCS75K1aAmJcSoZMvh6KCz31KlPy7dLdjjGldvj3OwZjHbe
         t9fA==
X-Gm-Message-State: AC+VfDyu7yRxW+RwxyJJtKrUwOE0qAfNtEDABvHma7DxOm83IcgJivp3
        wQKjO6Moo959MLKVp7QP8YDpcz4HyIc=
X-Google-Smtp-Source: ACHHUZ6Pnuf+WHMYn2295FIHXRJTr+8PAL3MSQwWP+eMag5aq8EwCg22t8TIVkz7ii/p7z9syw5Sow==
X-Received: by 2002:a5d:5143:0:b0:306:3bfb:fe94 with SMTP id u3-20020a5d5143000000b003063bfbfe94mr14236344wrt.53.1683796434370;
        Thu, 11 May 2023 02:13:54 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id b12-20020adfe30c000000b00306423904d6sm19971797wrj.45.2023.05.11.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:13:53 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] regmap-irq: Cleanups and remove unused functionality
Date:   Thu, 11 May 2023 10:13:38 +0100
Message-Id: <20230511091342.26604-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
Rebase patches against for-6.5 branch of broonie/regmap.git.

- 1/4 and 2/4 remove unused, deprecated functionality
- 3/4 makes the behavior of .handle_mask_sync() a bit more consistent
  w.r.t. mask and unmask registers, to aid maintainability.
- 4/4 removes now-unused "inverted mask/unmask" compatibility code.

v1:
This is a straightforward patch series, mostly just removing a bunch
of old features that were only used by a handful of drivers.

Link: https://lore.kernel.org/all/20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com

Aidan MacDonald (4):
  regmap-irq: Remove type registers
  regmap-irq: Remove support for not_fixed_stride
  regmap-irq: Minor adjustments to .handle_mask_sync()
  regmap-irq: Drop backward compatibility for inverted mask/unmask

 drivers/base/regmap/regmap-irq.c | 222 +++++++------------------------
 include/linux/regmap.h           |  16 ---
 2 files changed, 47 insertions(+), 191 deletions(-)

-- 
2.39.2

