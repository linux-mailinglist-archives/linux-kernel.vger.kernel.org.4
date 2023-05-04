Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800126F6E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEDO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjEDO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:58:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E5271F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:58:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8a3f1961so5345797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212280; x=1685804280;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pmr20K/ZpAJp2aUY+nQ3rpqyWCQwf4f5Z55uaqZkVDg=;
        b=d5nOMuVUoPh/72H5jZh/xG5/fBi5V7QuTVqSDZsMrp5GT247BnmNs3NUq3wcupBlgJ
         N4MIqimTMl/+z8Me0peUqI+WsyCBulGuu4WfXTYuTtqiTHzp3AaniQjH0rRh+XgaTeQs
         Jm63crjVuAP8HXzGLiKmHukaFvmZkOHSNd94UjGUNJJy6kZq+vvHlUX+wkRySg97IOD2
         bObXR3pBOq2xbbAvA39eZt94JSPnWXg4NrTb7Liq110611hjdJZD6lmGOVM0ssjhp5fX
         cp4GH0iFqMhHsgIB1e+HdMDAKy/Jc5K1qz5dhHFH3SHS89Aai2t/Px4K7pwdh998c8KK
         +z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212280; x=1685804280;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pmr20K/ZpAJp2aUY+nQ3rpqyWCQwf4f5Z55uaqZkVDg=;
        b=XPdpQN975FSdrnL6EktPWynMTBjyC3mvN93DcdxpObsPZPjRX6OgCLluRVSFW2diug
         3gPPMDahaGqWodkdMRtqr/UyeKDchoIaFF0yKdRLURIhoVRpfhtxW256/SVD1vcWNMSu
         wiysR8z2wSUUQV6MiR72OuLZMEUq4IoxpMOjrRlGDe9Xy6grMSeSV3FIIP8/556GiHL9
         W6VUO4eLx34tbSsgSGUU6pbT0WmtuZQHhqi5KnfcFHHCARBeZ6NPeeeLztk0SiiDEdil
         nOlyREBH+ZoBPTp60bYaXP1/yuYnppBqatMNdzWkX8+8gb+n2C+ZOhU4Yvx5es2HVPeR
         LmAg==
X-Gm-Message-State: AC+VfDzaxw4HOb20dPQvndRk7cEw8xjNdodJ5+yhvFyEXMCwrGVz7Hpo
        VFbkYpcQ7PVYkPrtR1dY4aUyNP8Do6am6w==
X-Google-Smtp-Source: ACHHUZ7+n2xz4HAUYMpPJUGJuuFL7SojLc9tUHMkmTMphLNXlTga2XTemd/zaSUB+bDpChxPyTIVBF67uDh35A==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:c404:0:b0:543:bbdb:8c2b with SMTP id
 j4-20020a81c404000000b00543bbdb8c2bmr1445314ywi.10.1683212280489; Thu, 04 May
 2023 07:58:00 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-1-joychakr@google.com>
Subject: [PATCH 0/7] dmaengine: pl330: Updates and new quirks for peripheral usecases
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes some initial minor and cosmetic changes:
    -Add variables and logic to handle separate source and destination
    AxSize and AxLen.
    -Use __ffs to calculate AxSize for consistency in the driver
    -Use switch-case in prep_slave_sg() for consistency
    -Change args get_burst_len() to remove redundant "len" and add
    burst_size so that it can be used in multiple places.

to majorly enable addition of 2 quirks in the last 2 patches:
    -Addition of a quirk to allow transactions towards memory to use the
    maximum possible bus width (AxSize) during a memory to peripheral
    dma usage or vise-versa.
    -Addition of a quirk which makes PL330 copy left over data after
    executing bursts to the peripheral in singles instead of bursts.
    -Update dt-bindings to represent the quirks
Quirks are explained further in the commit text.
---

Joy Chakraborty (7):
  dmaengine: pl330: Separate SRC and DST burst size and len
  dmaengine: pl330: Use FFS to calculate burst size
  dmaengine: pl330: Change if-else to switch-case for consistency
  dmaengine: pl330: Change unused arg "len" from get_burst_len()
  dmaengine: pl330: Quirk to optimize AxSize for peripheral usecases
  dmaengine: pl330: Quirk to use DMA singles for peripheral _dregs
  dt-bindings: dmaengine: pl330: Add new quirks

 .../devicetree/bindings/dma/arm,pl330.yaml    |   8 +
 drivers/dma/pl330.c                           | 245 +++++++++++++++---
 2 files changed, 213 insertions(+), 40 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

