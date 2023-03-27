Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353186C9A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjC0Eeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjC0Eef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:34:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F84C30
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:34:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e23-20020a25e717000000b00b66ab374ba1so7629530ybh.22
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679891673;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLP0iDbOKmp5dR6zyew5bYI8A6UpTe5M67jJip6qNr8=;
        b=g54fLmoT+eCwIo9hM5uYaRt1FxlYmcHJiirjrrMOIdIU1qL5XHkojOnUfop8aJYQJe
         tywuLZnNbXmydIntqTGTKl9zvhc2O4Y90ulmf7KAeqdDz9V+ECv6k98tSdWOZnRHqDx9
         i1X+KMj4v6BURWtkCviLLwTK6xxZpu7kudu/MchQwy+dBBcCRudopBXhU4/4lN73LfMg
         0L2yqrC/xWPzo9eWRUDObnn2WxjcMb2wxVkpUEsnJPlK6E1/5ypgWGL6ZQejJ0odf25X
         /w0HAt3SjV8yLXthSc7S6ldDlC+G/7w20yL0vj2nSBzqWS2S6Zio8JSsKV6iptRf3B4/
         pNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679891673;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLP0iDbOKmp5dR6zyew5bYI8A6UpTe5M67jJip6qNr8=;
        b=yZEa5Pbpkaj8L9urrFQe91lCHO6KNpv9o/um9OioLM8IXRE5rUMvMmmRBCjwepfC7U
         gUYOb/coWpxnJtlNhuQBCPIlzN1/K5mh1qIvKMFX2ZdtBP2vVt5PzHmz6ckqmCOkzwGg
         YIOvyh03KImkFXd2KUsk4GUyyP8YMd3MPQmJzUy/rMcPKA9u09HTlG+TR2HAYSSFQ0et
         qPLNUdC0/5aaLWrFA6VVG7F6TjuM7atj0Kd/d7PtdyqiSjwrIDTOVnJOypOSxbR9B931
         +GBW7smQE7ysMwY+M5NpuJH6+NPGMGEIDxfQ4GB/iVSU+Xuj+l526Jph3xnpdzvh4FjP
         T2NA==
X-Gm-Message-State: AAQBX9cuIZ1WYIjfSaYjgMcMNLVuEOBHrBRdSIjR21qN1V7nqEb6vQz4
        D2AzUHfJoDH6mqUkQzk0D8WzNvMYMg5FOg==
X-Google-Smtp-Source: AKy350ZUQ0qK0zEXhjwjUG2z+xViu8bIT3LYZfUmL6Xxd+qcGfk2WmGtgR78o7qqVFc1XV7uraTYEQiMmXNfrg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:a707:0:b0:545:6225:4536 with SMTP id
 e7-20020a81a707000000b0054562254536mr4462251ywh.9.1679891673439; Sun, 26 Mar
 2023 21:34:33 -0700 (PDT)
Date:   Mon, 27 Mar 2023 04:34:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327043405.881645-1-joychakr@google.com>
Subject: [PATCH v4 0/2] spi: dw: DW SPI DMA Driver updates
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

Joy Chakraborty (2):
  spi: dw: Add 32 bpw support to DW DMA Controller
  spi: dw: Add dma controller capability checks

 drivers/spi/spi-dw-dma.c | 67 +++++++++++++++++++++++++++++++---------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

