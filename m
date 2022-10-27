Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAD610469
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiJ0V3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiJ0V3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:29:32 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B76352;
        Thu, 27 Oct 2022 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666906136; bh=OOdVohmxjyqwES6BVgivansb/UtVz9aFP/lWyrNnjg8=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=pKtWuCzhbBIk1PM0LhtiIxTshU6xE/iTaortghI75CbomsIrhKFsHXQw8TQumY9L5
         k2qAe37H/A9uZuvnnIM1JRkFeMIpLbCz8vO5wju6oIi2Kmp++bZOsRqacSYC80WEIw
         UZdceXgXv6uxSJC/GqSsOwPvuKGDe6+CaF9SGvF4=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu, 27 Oct 2022 23:28:56 +0200 (CEST)
X-EA-Auth: 12GbF3MYEzhNl3lHw/2UILN1hYg3324yD/EbSHxll6FcVpG2POaqfvUrBwf5K3X6yPxM/38dmvXLCKbUsrRha4lx6gNTmkx5
Date:   Fri, 28 Oct 2022 02:58:49 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad5933: Use div64_ul instead of do_div
Message-ID: <Y1r4EaDvEipzhaaf@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation. Issue was identified using the
coccicheck tool.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f177b20f0f2d..730bb31a20d8 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -196,7 +196,7 @@ static int ad5933_set_freq(struct ad5933_state *st,
 	} dat;

 	freqreg = (u64)freq * (u64)(1 << 27);
-	do_div(freqreg, st->mclk_hz / 4);
+	freqreg = div64_ul(freqreg, st->mclk_hz / 4);

 	switch (reg) {
 	case AD5933_REG_FREQ_START:
--
2.34.1



