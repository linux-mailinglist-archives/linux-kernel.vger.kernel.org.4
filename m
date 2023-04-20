Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E666F6E89DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjDTFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjDTFxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:53:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C8C40CA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:53:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 188-20020a250ac5000000b00b9265c9a5e9so1359998ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969990; x=1684561990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmf17OkL5SCBMBWD99k+zYNzeo76qcWOQzqTUdEaNA4=;
        b=wP4LdQuSoesNvn/B4nq+v65j9QBURAtfrTfJclyIGQZl/zwlfdNdJk9rDvE+kJen70
         KrMp944AeYP1jG4zsWJL8KqCjL7ehlImk2NQGbHDJXbKlV6ksBUb5Szyn63HVFN15p9X
         ZdZTIiKtAlOSw04ORDBVFNr9N1YF6VreBh6brM47mSF8r2T7YO9s872kdz6IUsOraA4B
         XZgr783K4qPobQTNyib+UTF9lzfKpDUudWPLkzkgdi8XDkeEqfoRkm4OIRbSCRjYB5cN
         sG+wM4RZqUlfjFPfWoc2QLvy/yXVDJxN9SM2P3SkKfFV6DTfkbKBDuZe8XiaDjpKhDr0
         4u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969990; x=1684561990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmf17OkL5SCBMBWD99k+zYNzeo76qcWOQzqTUdEaNA4=;
        b=QdehQp/+queeEZwM3FT0oPtYK3VnNOsCfXlIpSFbOjO902VPIn2lsydTe/RvrsdO1N
         gYk14MaDfvziK68vKBJbg0drDa09UQhKf46gOjS8wQZ1pYbvmoyl0UCl3YvpztycUpg0
         0lft2TQhsENJhc8/xRzeYVOPRiAQRrCa6vvlPNTGJoZ5a2FMu9GdXUfl21bAIDFckZ1n
         b+FAhyH318Jt+HtrB6SdM1xmNpdSsu0YBysI14tiL3m2UEGGmxRi0Rvq58geqhcNhycS
         GN9rJdR+kW8UgRG+m8fRV3MmKGFSwdF4t8EfAt7zQpaFzgNiGnTRYLiIbpnBDxeQdrpW
         NXJg==
X-Gm-Message-State: AAQBX9efWW39yooRBPPStHQ9IZuALf/WMjea6zbtnVgrhXw5QGefUdl7
        amXetZxynsdOwlFQV0xnKHvUAJ4AfGQNmw==
X-Google-Smtp-Source: AKy350aZp1jhQxfVc44iBqg7o9bq0B/QDYh5+kVoGotSwm59TwPJoS4VXXowbQ0zfZffFl6cBk/hg1YSfupTOQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:3157:0:b0:b8f:3647:d757 with SMTP id
 x84-20020a253157000000b00b8f3647d757mr310587ybx.11.1681969990443; Wed, 19 Apr
 2023 22:53:10 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:31 +0000
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-6-joychakr@google.com>
Subject: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
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
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c3bfb6c84cab..a6486db46c61 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -426,7 +426,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE));
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.40.0.634.g4ca3ef3211-goog

