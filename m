Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297B3610504
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiJ0WAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiJ0WAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:00:05 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AC1E73F;
        Thu, 27 Oct 2022 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666907978; bh=K6jkaIWLjM8amIf1/3sGKi76LC/AewW04KWQY65UKW4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=EhiA4AHsTTAS+Eve+c+tPPzPBk4XEFkyguh14hRkAHRwMxzOpas4XNSLmKADx553e
         V+VlYpHUhA6fWSZ/Fr4XnDjrbbpIKpWNXpgr/so07YXy4YIdA6TI+fsCEpAh51pXTW
         ebmS/OTl3eEmGDu4/n4N3QIX6oXueJi1rfywKEKg=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Thu, 27 Oct 2022 23:59:38 +0200 (CEST)
X-EA-Auth: gPds8du2GN4EigpVxAh6zYgunt9VQITGmwhvWpkx/yxVDikGFU9mBoo7as8yKS+di+ACDryNiOD5yTMHezgeh8p9CD8AOADG
Date:   Fri, 28 Oct 2022 03:29:32 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: frequency: ad9834: Use div64_ul instead of
 do_div
Message-ID: <Y1r/RAk83Csk2L3E@ubunlion>
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

Changes in v2:
   1. No functional change.
      Include outreachy mailing list on the to list

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



