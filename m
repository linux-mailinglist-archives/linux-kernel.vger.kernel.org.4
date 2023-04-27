Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FEC6F05DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbjD0MeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbjD0Mdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:33:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76D5244
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a805e82a9so870279276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682598824; x=1685190824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ypFgisKdugG378RCE4wuNj0FpBiItt6cq8MGNIIYGA=;
        b=Otk4yIq6Sbhtb4TihxX60Psghxw0hddCiysw1B0c+w6rnLG6DP8tPh7lvgZ5M1w7Ye
         /KMpNEQS+6aA+ZZqtzogfKKjwXsEHaMZabvreo32p165z5+9THvfuz6i2eVem5FxByk5
         NSkh1R4Dju3S2xWB3oOJfa8/VG+1AndSfU92fsztFbXNf2MW0nTgXYJmr5kbIEXH/KXe
         dJ0BL3lS/iY691UuIba82p7XuGmUI8tkKLjGMH9g/IvXuY1UdU9I/n3fQD07YYh+eS0J
         zYKWa0puQ3ZWy3qAXei/C3PLQsVTFyHGJdVqvOyMJIjn1Pv8ILZH8IMXqikGBxumAPgU
         fLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598824; x=1685190824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ypFgisKdugG378RCE4wuNj0FpBiItt6cq8MGNIIYGA=;
        b=BnkoSiqMubYr8AJEcE7CRm1JzrWElTiO1gMr/SyODBKVQk5v8a0y4VOrvabcQut2sP
         WnZ30fwTRAkiJ18Ylv/+knSn03UZ36XKlvxXQIaIPnfRLhdKT3vqwFUrsjUbxYjiOdo2
         yN6Xt2hQV6Wp54IMBYEDnM4nCNr0b25i5a+KQLQnHnvndS2EJUEu+/Hy4ByfnrSE5vMM
         MQ5r52QeWbLHJqOC9G1RQFbxQSxdgB0M0DdT/+gmk8Pb0SUNES3kqJY5BW9QW4qEHXOX
         PSAjxrtXitO1xuraLY2UlK+9T+EHaucnOOqo2PWrs/5niyxEPu47eiVCLiC/WOtFzSvT
         ZvgQ==
X-Gm-Message-State: AC+VfDwzBz292OZzOkUFihAczHcnfdbSCwacLHdUSKTHn1v9+ojrrK/F
        VtaUUX5znZVBL5oB3p9SPpvxd5gbrweMpw==
X-Google-Smtp-Source: ACHHUZ7HFF9cztNmd7ivBvM2Tt5Ka4hMiw6tetPGvOkizaiT3+YmYw1mFqCq61cGJ0i8nIVRQdvUFhcK28i9rA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:188d:b0:b96:a18:1b4c with SMTP
 id cj13-20020a056902188d00b00b960a181b4cmr497926ybb.13.1682598824170; Thu, 27
 Apr 2023 05:33:44 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:33:14 +0000
In-Reply-To: <20230427123314.1997152-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230427123314.1997152-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427123314.1997152-6-joychakr@google.com>
Subject: [PATCH v9 5/5] spi: dw: Round of n_bytes to power of 2
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

n_bytes variable in the driver represents the number of bytes per word
that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
bits from the client but in memory they are a power of 2, same is mentioned
in spi.h header:
"
 * @bits_per_word: Data transfers involve one or more words; word sizes
 *	like eight or 12 bits are common.  In-memory wordsizes are
 *	powers of two bytes (e.g. 20 bit samples use 32 bits).
 *	This may be changed by the device's driver, or left at the
 *	default (0) indicating protocol words are eight bit bytes.
 *	The spi_transfer.bits_per_word can override this for each transfer.
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
index c3bfb6c84cab..4976e3b8923e 100644
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
2.40.1.495.gc816e09b53d-goog

