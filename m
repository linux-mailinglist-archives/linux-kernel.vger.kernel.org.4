Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AD6104AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiJ0VsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiJ0VsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:48:15 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B5985A83;
        Thu, 27 Oct 2022 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666907271; bh=yLm+PiUX5XIUPovFzVHx3LyxXFzrfVux7pO61g17TzE=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=TAAmoNC8wYFXIWG1qnxNHYFkiOszIFduU5pT6OmHq/Pzqe/4iS4Md4YRya70mS5eB
         F4rnvCUKKlTun2fy19uYhU03gAqQBbCroERP7aVGRCI3ixMuNK5+hon5YwYpG1JB0u
         xzIL1/WG4x8f42Gtrwb+42UqaZRHRmZ0er0SWzoU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu, 27 Oct 2022 23:47:51 +0200 (CEST)
X-EA-Auth: d9SByaZo8cw/fNOd4EIt6ycZB57O4VIIr8QshUjrUPxNGcHHY9c5Pv3ntXVyyyLj670DF+WmranW321ioaRf6dZ3gKl3ronA
Date:   Fri, 28 Oct 2022 03:17:44 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: frequency: ad9834: Use div64_ul instead of
 do_div
Message-ID: <Y1r8gMR8VBG/4A4P@ubunlion>
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
to avoid a possible truncation. Issue identified using the
coccicheck tool.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/iio/frequency/ad9834.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 285df0e489a6..3917a76e7976 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -102,8 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);

-	do_div(freqreg, mclk);
-	return freqreg;
+	return div64_ul(freqreg, mclk);
 }

 static int ad9834_write_frequency(struct ad9834_state *st,
--
2.34.1



