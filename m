Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551A76CFBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC3GfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjC3Ge6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:34:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6314EFE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:34:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541a39df9f4so180298017b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680158097;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vck4iSDUKZf+JCdPQEvQ4evRUmQTT/pnCnaPcb2eePY=;
        b=K2ZxZT3WU7jTwiesqYy89B7hO2hIOzo/cyknJYK7ErdVGCnBDUUfG4QRbuA6Ew/UBq
         66p3lUcFg9MUziJJhOzBEdwtoHWizDcBeH/DTYEaxot1TqPBH5+aL0CdsjBnbmvOUzPs
         7Y8zHNNN2f4dVVw0lxHFF+QK50cvtKezv9EorSute8ILZpzulv6WjGh1c5lJ4XChhQIP
         XpKniGWjZ9qlHSZBhlbnVPLbb7v6UfT683D2MMxQ2SIwaSNM2mdwMsfZqi01vQJ+DeI5
         tlDdF0MA1Eu4Gjy5GikaRF1fBRHIZo5RvwSskPxUyy9peykfjmREizZyY1Yf8Jm50wAl
         ORVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680158097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vck4iSDUKZf+JCdPQEvQ4evRUmQTT/pnCnaPcb2eePY=;
        b=GzPDmtQ3geoKQavZNQtUVdkMPSl4Boc89gWQiWgfCWf4BNtClgPCah3WOgBXwEAwYA
         nGbRY5xBcl4bH5FMIWBoDaov7u0zXFWtFoYEGbkCKRhAwts31Qy530zPcXpNDCgp4g3a
         zVFvkHEsOq3klnceDn+Vggj8FF3FQm07JXXivWUswu21Qryvhr/tDVlp+CrxS0o/9ck7
         Z+MQ6ITaU0PJST/TkhpIpGBbThGFQ9/FaqcxV7QMIYKDr24hfPqL+xr0QWN3HXq9RQdN
         4Li5PcIGdZQOVL/FW6l1i1UfgqbSDclKzm3ZVPMvDmMGjUXsV6qEfxukj5EErINcGbZR
         5xaA==
X-Gm-Message-State: AAQBX9frv7aDI/3ec4xo1NN8MiN5O6a/6TFuTz6Zfik1/4cuz1+tRpDv
        xERb9/nuZ9YVDTxfgTRNs2o/J7Hglit/mw==
X-Google-Smtp-Source: AKy350Z0cQ23dfmrxicebK+KYirmR35YSZ+pTIA6iDuQB6Y3G/mNGad7wXSF0g8L67pFNpH8xcHoelQKSwTskg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:ae23:0:b0:541:7237:6e6b with SMTP id
 m35-20020a81ae23000000b0054172376e6bmr10436707ywh.0.1680158097247; Wed, 29
 Mar 2023 23:34:57 -0700 (PDT)
Date:   Thu, 30 Mar 2023 06:34:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
Message-ID: <20230330063450.2289058-1-joychakr@google.com>
Subject: [PATCH v5 0/2] spi: dw: DW SPI DMA Driver updates
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Joy Chakraborty (2):
  spi: dw: Add 32 bpw support to DW DMA Controller
  spi: dw: Add dma controller capability checks

 drivers/spi/spi-dw-dma.c | 70 ++++++++++++++++++++++++++++++++--------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 57 insertions(+), 14 deletions(-)

-- 
2.40.0.423.gd6c402a77b-goog

