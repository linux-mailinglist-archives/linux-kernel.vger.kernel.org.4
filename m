Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9188D7005F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbjELKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjELKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:48:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F513C07
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:47:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-560def4d06dso56875547b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683888472; x=1686480472;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hTpJTY/rULQPSOZNXcS/148DUgQ2+YfFfUxNW3uGcc=;
        b=NKZ9DJMSbrzKFRruLJXZDhVxtbnaHEbduW36u8MmXgWhDLEoWSdxfbM8/vhFZBPQpU
         RLo9qi7IR5o1WzDfJZzlHc4T+BwdqSJnd7Ue+J6qh1mPx1eSHZjjzCaO+8SqGqgt89qT
         YZd79CSqZyH/7f2gYFkNLQEdTz9dsqPFARBGL8DWIApcA0yY09cf68VS59ozhAIUFOyZ
         sRIBcO0yIvrBLS1KacnxsYnmkXRbOTHr742w/WlSCLQFUGskhP3MBYcm/nc0nnn+9K3T
         3I9m8WoXSDYEXiq8f0j4M76MYxavR8XfB1gmZvtUpCVZXOacOIDeDNPKfDR/T2BZdPWQ
         D/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888472; x=1686480472;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hTpJTY/rULQPSOZNXcS/148DUgQ2+YfFfUxNW3uGcc=;
        b=H4OX+K/ihCcFrCwAJySaHwnZ11pJJfYAVHYgjhaSnbf/f6EZ/fbmbDQDEtDDSys4XW
         uqsEgfXh70sBI4aaGEHf71zYvA975Yo4s+AUbn1HhEdz1mE7M8IQwRwTnvLEeO7DsbtC
         9MfisekQSENLoRPMCcMuI5DDMYrWBysexBDx41EnESkdL/9KOsTLtcOPtURY9YOvsBPl
         sykBLNQkHgp784O8wwQMVmAqt+uaHEInMG7qctnMiI/3guo82JnvjRMQ8258oK8LG6n3
         nkAA3Vi28o+zl9+JE9Xg+2eZQbol4V216+8KbuGlgffDHFphjLpZxjyOOXRs8lFEfb7H
         lCKg==
X-Gm-Message-State: AC+VfDyrqlbPFMJVcNf7II5LW2tK7rtWWycFFK55Yoqmg5VFz2oeNQaA
        WDg0EARU4s41jWuum0TdpCkDMjCiXkz9AQ==
X-Google-Smtp-Source: ACHHUZ7KDuRZ0EiEc4tcmzANzVpo0BfydgpvG+XpD1Q8xiN1zT5M8pMk2mhtN7qHL6fKFwZgD9c0F0bWaBkSLQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:430b:0:b0:55d:9a6d:8ce5 with SMTP id
 q11-20020a81430b000000b0055d9a6d8ce5mr14862719ywa.1.1683888472089; Fri, 12
 May 2023 03:47:52 -0700 (PDT)
Date:   Fri, 12 May 2023 10:47:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512104746.1797865-1-joychakr@google.com>
Subject: [PATCH v11 0/3] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch series adds support for 32 bits per word trasfers using DMA
and some defensive checks around dma controller capabilities.
---
V1 Changes : Add support for AxSize=3D4 bytes to support 32bits/word.
---
V1->V2 Changes : Add dma capability check to make sure address widths
are supported.
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---
V3->V4 Changes : Fix Sparce Warning
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@int=
el.com/
---
V4->V5 Changes : Preserve reverse xmas Tree order, move direction
check before initalisation of further capabilities, remove zero
initialisations, remove error OR'ing.
---
V5->V6 Changes :
        -Remove case of n_bytes=3D3 using 4_bytes buswidth
        -Avoid forward decaration
        -Break capability check patch into 2
        -round n_bytes to power of 2 ( Bug Fix)
        -Add more explanation in commit text.
---
V6->V7 Changes : Remove extra spaces, refer to functions in commit as
func()
---
V7->V8 Changes : Minor commment updates in patch 4/5
---
V8->V9 Changes : Minor formatting changes in patch 5/5
---
V9->V10 Changes : Moving "return 0" at the end of dw_spi_dma_caps_init() fr=
om patch
[4/5] to patch [3/5] to solve :
spi-dw-dma.c: In function =E2=80=98dw_spi_dma_caps_init=E2=80=99:
spi-dw-dma.c:100:1: control reaches end of non-void function [-Werror=3Dret=
urn-type]
---
V10->V11 : Resend patches [3/5] to [5/5] on top of :
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
---

Joy Chakraborty (3):
  spi: dw: Add DMA directional capability check
  spi: dw: Add DMA address widths capability check
  spi: dw: Round of n_bytes to power of 2

 drivers/spi/spi-dw-core.c |  5 +++-
 drivers/spi/spi-dw-dma.c  | 56 ++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 51 insertions(+), 11 deletions(-)

--=20
2.40.1.606.ga4b1b128d6-goog

