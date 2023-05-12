Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39E7005FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbjELKs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbjELKso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:48:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C512EB4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:48:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c58ec19so11706023276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683888486; x=1686480486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y049PmC5C0PnSAgiyWvWPHzKRIJST3guVG5ES+MeGns=;
        b=vzvkdCR8kM136SsZBU8U6eQlSFq1oB+ZzglgeMJUx1D0MI+o/WQSVOCyw//1P3LZVw
         npUlZM10hPgXVQ2Cbmr3lZeebUN8Dq/7w4re/xNNrVEEkLgVTQanyAPt3J/qxl47Phag
         wuurc+OhIsCI3v0IoO8V0okHUzfS0FGRIzDdTTWooGPJwGl8oIsmiPAtSaFkLnDb42V9
         b8DR3HLqasuktNv8yBUjuMR4SLdhfbr+/9pa2ApIj/0mcwTdK1LP7S1arT74S1rq/Nxs
         IQFoe2LN/ptkKD5ZFlVg1wDRkKW4VPHyVVaVC05WFrmDOaBiRbdwfPUroOXRCZ4Wl2Jy
         J3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888486; x=1686480486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y049PmC5C0PnSAgiyWvWPHzKRIJST3guVG5ES+MeGns=;
        b=KBj4gKlpwXVhLkHIsZX+StmhTeYHPHzVW+fM0l3a9yKDnie4VwGfsKtgJn7CS/2Dk0
         zFpK1eOqn3rfguZsoDqN7x/TIKrNaO3WijDn0DFDTuvUew3L0/OCixCKr3AjgpQl74Gb
         ra/Jg1j8iFETKrW7Eiht4A+fl2neAx7zocMf4SED26Y7I8C8FbwNWYChap0xeCxYPjID
         G4qjbZ/Q6nGXVivLhnroVzK/T3ikhPOxEqioOS5ULuDtxa4OmSLcFf4Ny0vh5l1DKCxY
         Asmn7WEZpyEAwTYbgZ2wh7WxNJIv44Ru6efWV3mSqxWap2w1EKxV6muRG0GjhmOBMTbm
         OU+Q==
X-Gm-Message-State: AC+VfDwQUZkws6+KAJuMcbz+bpg3luCp1AMJfyk5wcMn+/vdtwO3t6/t
        CvWW6mYp5uqf2ArKP9Syxg1Nlz1FHmYg4A==
X-Google-Smtp-Source: ACHHUZ79BFgMVJJIcvfFqvQAo8l+zEZEgcjfLxAouTj2iS04W2IVqnCTc6w1YLTXDa6JDILsajqrPA3xjrT+Jw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1890:b0:b96:7676:db4a with SMTP
 id cj16-20020a056902189000b00b967676db4amr15756188ybb.0.1683888485998; Fri,
 12 May 2023 03:48:05 -0700 (PDT)
Date:   Fri, 12 May 2023 10:47:45 +0000
In-Reply-To: <20230512104746.1797865-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512104746.1797865-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512104746.1797865-4-joychakr@google.com>
Subject: [PATCH v11 3/3] spi: dw: Round of n_bytes to power of 2
From:   Joy Chakraborty <joychakr@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Joy Chakraborty <joychakr@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>
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

n_bytes variable in the driver represents the number of bytes per word
that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
bits from the client but in memory they are a power of 2, same is mentioned
in spi.h header:
"
 * @bits_per_word: Data transfers involve one or more words; word sizes
 *      like eight or 12 bits are common.  In-memory wordsizes are
 *      powers of two bytes (e.g. 20 bit samples use 32 bits).
 *      This may be changed by the device's driver, or left at the
 *      default (0) indicating protocol words are eight bit bytes.
 *      The spi_transfer.bits_per_word can override this for each transfer.
"

Hence, round of n_bytes to a power of 2 to avoid values like 3 which
would generate unalligned/odd accesses to memory/fifo.

Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
---
 drivers/spi/spi-dw-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index ae3108c70f50..7778b19bcb6c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -426,7 +426,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes =
+		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
+						BITS_PER_BYTE));
+
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.40.1.606.ga4b1b128d6-goog

