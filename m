Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298E6E89C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjDTFwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjDTFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:52:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA13C2F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:52:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-555e3d8696dso14488717b3.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969967; x=1684561967;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iXfqf/s6wp49MzEwFPmcAfC7YjXY3gto73Qxf5qzVro=;
        b=cqve1P3Ahn/GSvJK6t9IllTKZkwqUuyZJls+LqYhkOnlYr9snTo/+ut+nNUOZXEEYd
         ZlWNhu3oRoZrLYNdn3320ZRB+Uo3XXiudmgt4AzyRippiVsy5tv1XHx4G9H0gX8wkIyw
         9LCT24e/0uzH+dU4wlMCxcrQwX6c+szqS2qqt6eE8UOflUC/zfbriabDWt7YsxhNgRLV
         h9QaWNtE09dPTVkyi6O6ecWHxRJgTN/wXmoCOwmg2LpDbXqk8cMKO2Xy28NCUX+B/tyn
         TFJW5kdpdtmU8G/zlR0zbuDIQiCyN4zCIhaCP3vcZWWhjDVBzHBY5VrkiAPbmhNvcN5m
         ykUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969967; x=1684561967;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXfqf/s6wp49MzEwFPmcAfC7YjXY3gto73Qxf5qzVro=;
        b=LCfW7+TAoZSvn532+LMJ/poxESyfBGUPkViAqMC9GozPz0gevNzdztmZWJpZihzmy3
         GroKn/2FJyKAg1PgeZw35qX5dHstkozK3ZuFCMkXsGnZYqze44Ko7Mk7DAFIZU3JC23q
         w0OUxy6da2W/XyKm94dBRKp+qmwqCshdybBB/LRa15RR0PpQPVRVuUCBNjnhmVyKp1VH
         UnRii2B4HeTbtM2L9Alpm6Hin4GaqWybhRCOj+7Sn6a09UNLRvWoQXWaQ0AwPODM5pzB
         VB4+7lAbFQ99srY5jdfSoIiphRyI0C4QiAFXiRPTWFGaFztyePg3otMZN9fVqsbIbhOp
         Vevg==
X-Gm-Message-State: AAQBX9dI8J1rQAukIamYuwvraTkvvBBdI7ZHTmhBvL4jKV5HplHACSFu
        KBr5kZxA5TWNjCgmWf3w4D0oLrFZ5Sy9jw==
X-Google-Smtp-Source: AKy350YSSdGSkaHwcN43xWtFjsCfaBRJd8JJo8idndsiueTbZPrVVKyO8JUrjzapZuJZdBeTJNwcwFq3Kv/gLw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:d653:0:b0:b95:ecc5:5796 with SMTP id
 n80-20020a25d653000000b00b95ecc55796mr208873ybg.12.1681969967117; Wed, 19 Apr
 2023 22:52:47 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-1-joychakr@google.com>
Subject: [PATCH v8 0/5] spi: dw: DW SPI DMA Driver updates
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
V6->V7 Changes : Remove extra spaces, refer to functions in commit as
func()
---

Joy Chakraborty (5):
  spi: dw: Add 32 bpw support to SPI DW DMA driver
  spi: dw: Move dw_spi_can_dma()
  spi: dw: Add DMA directional capability check
  spi: dw: Add DMA address widths capability check
  spi: dw: Round of n_bytes to power of 2

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spi-dw-dma.c  | 76 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

