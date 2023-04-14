Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424C06E22D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDNMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDNMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:05:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B1A127
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:05:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v67-20020a254846000000b00b8189f73e94so41877216yba.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681473926; x=1684065926;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RUoK0Gonosafzsz3S6wCMP+3KpguwLPaQEXuSVVhCK8=;
        b=s5vdiue/44AmwRsLu2yuXcNJvnET/UTBOPCvvy9Mko84cpdZUkYLA1taJTrrOZ7zLY
         pu2iU/LqNzpoJ0LUjCvkYURhdC7l5qucsSWlCdjtnvEUrsNp5/FsLZm85yUQam2SuQKk
         XccZ1lQprWRonqfHD07IbPkCBgJOctYGFaZWK3TPGO+hImhGUchamhGkucsGrs3ImQnn
         uLU8ZLwEceHkFWAUZ/6ZroNVl80zx8/Z+xsYHgbtXyBRVR4NcMsQGKBBDJsHpb7a08d/
         MG34LChVwC1nSu82ICmAYjg25Iap3Ike7fHPvF9QeDwNLlgMVYoealpsPCMmlJfUcff4
         dA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473926; x=1684065926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUoK0Gonosafzsz3S6wCMP+3KpguwLPaQEXuSVVhCK8=;
        b=VC/L3sjktu55uqmG4GngLyYNyX0k/V387reTziMNi2Rb9XykxLUFEvnfTS6vp2t8JJ
         rfhXFZqc5KTSg3rdS15NqvAswCva4igNwQlcqwf5Li96XUWmAlw6/7oBk2QhJ9Brw192
         6JClW8OlYJi2bCDCMVFA9w8CmOdDoRvzo2naUq23MGtQUn3YY5zi4GMZHQDw9bYYv9YU
         irwQGt+PT629yIdwNwU6w62am19jufNBcyGUX3XCI+bi5cW9KrCBN4gYy6Qkg7QoEoeo
         g3SWPnkVw2eUKyQZAoS652Ny+idCWMDQx732UxQeF2AZ6VVDLUYH4in+ZLCv6/1EwdA0
         bGLQ==
X-Gm-Message-State: AAQBX9fdS+X/o46FuFqnvqchaBSs3PR6itql5lJyt/CZTPjESfpDSlL7
        l0G+qHF/cGjRvXa6vGyG6iy+bQmRknaT/g==
X-Google-Smtp-Source: AKy350YVQy7/f5b1oz9DVK4YjbzEEXbb8jimGc5OSDVMAUtRs8/btfgaQeG9vKqTF6EfqJj2xJAfsSQpsQ0VVg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:a787:0:b0:549:2cc8:6e3e with SMTP id
 e129-20020a81a787000000b005492cc86e3emr3555060ywh.9.1681473926821; Fri, 14
 Apr 2023 05:05:26 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:05:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414120520.360291-1-joychakr@google.com>
Subject: [PATCH v6 0/5] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
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

This Patch series adds support for 32 bits per word trasfers using DMA
and some defensive checks around dma controller capabilities.
---
V1 Changes : Add support for AxSize=4 bytes to support 32bits/word.
---
V1->V2 Changes : Add dma capability check to make sure address widths
are supported.
---
V2->V3 Changes : Split changes , add DMA direction check and other
cosmetic chnages.
---
V3->V4 Changes : Fix Sparce Warning
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/
---
V4->V5 Changes : Preserve reverse xmas Tree order, move direction
check before initalisation of further capabilities, remove zero
initialisations, remove error OR'ing.
---
V5->V6 Changes :
	-Remove case of n_bytes=3 using 4_bytes buswidth
	-Avoid forward decaration
	-Break capability check patch into 2
	-round n_bytes to power of 2 ( Bug Fix)
	-Add more explanation in commit text.
---

Joy Chakraborty (5):
  spi: dw: Add 32 bpw support to SPI DW DMA driver
  spi: dw: Move "dw_spi_can_dma" function
  spi: dw: Add DMA directional capability check
  spi: dw: Add DMA address widths capability check
  spi: dw: Round of n_bytes to power of 2

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spi-dw-dma.c  | 75 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 59 insertions(+), 19 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

