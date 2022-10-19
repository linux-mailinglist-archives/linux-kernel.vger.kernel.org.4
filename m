Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8329460394C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJSFik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJSFii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:38:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874A537F1;
        Tue, 18 Oct 2022 22:38:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 204so16204878pfx.10;
        Tue, 18 Oct 2022 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uagMMX7nbZs02+TkfE1zX/mQYp7hdyYKV8jbBteal5M=;
        b=FBBot3uHkHUr81e//MIjYaPs9o/zoRMyNY41LtbuQO++opJg/bW+OgGKJncVEAoBXf
         RAB0TJGBZaIVtLa60y9T3Sv8pX3rYtIhrDt/q7UxgZ5l4FH9CvfFoI2NdLIzc8oZ22wI
         YEuiYYh3VF/2hLC8Kzi5S+uJRGpe738FIX/hxXvm+jCNs07r14SZS/DDV5HNLCyIeAzd
         42uG716oTFJpwdXNoYDRAPjKTIPTZ22ONoSA4DNeYZWskqZoCMXVypoXAonLntaPOJXP
         R9JB12yKqpO8tzzb3Pg4Z1LKBcRcIAaOV65tKTDqq2ihpA9T3MRJEREcSm2yZ/Qec/IY
         ARVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uagMMX7nbZs02+TkfE1zX/mQYp7hdyYKV8jbBteal5M=;
        b=ay1ubjl6KkK5gNX2ptMW1Tw5S2mLrWWhWQGL9sVLeoqg+AyDNnr80NWU6QhG7kl8et
         dLZDxVh3WHWXMUDAkT3xx0PlWP2K/75pHYXVJZXxcYF+rFfbSCjLnA5mazCFo1rJAzZq
         lFJG9qbKpTjK1s+VKZJZYnLu9d2ZNWiHpBZ23oG078KIU6ElqReJLaIaQhYo9qETycFx
         hwWf235bsOnTCbDxYV6NH1i+l/qQY+YGOHACzr7ecF3wrzph0A4Srm2ITrQDMWPejPPW
         w++s83yfd6ttgY3sQNGQo4SfdjIALZv6ew43N44tI3w3SLay9QSCK2H1d680hoTnE6Vm
         g2Sw==
X-Gm-Message-State: ACrzQf0BlNFzdi2eVvvWohwhubjZrVkbciGhycHCPfJga+PDCpqppWCj
        mSph1c/S2ksZCnkNmbY53tw=
X-Google-Smtp-Source: AMsMyM74hRC/jWVpoP4VZb0Apq40KLd16kllQvM5+RasaEl3DXdwNTLu63s8wz4/wYZ3V3cL6eygxQ==
X-Received: by 2002:a05:6a00:847:b0:563:b593:b685 with SMTP id q7-20020a056a00084700b00563b593b685mr6832243pfk.75.1666157915367;
        Tue, 18 Oct 2022 22:38:35 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b0017b5e1f486asm9860818plf.211.2022.10.18.22.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:38:34 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] staging: iio: Use div64_ul instead of do_div
Date:   Wed, 19 Oct 2022 14:38:29 +0900
Message-Id: <20221019053829.821918-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using div64_ul instead of do_div (64-by-32 division) is more
recommended by coccicheck because this can avoid potential truncation.

So this commit changes do_div to div64_ul and
remove coccicheck warnings.

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c          | 2 +-
 drivers/staging/iio/frequency/ad9834.c          | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6f9eebd6c7ee..cd038480f63c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -122,7 +122,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
-	do_div(freqreg, mclk);
+	freqreg = div64_ul(freqreg, mclk);
 	return freqreg;
 }
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 2b4267a87e65..cfe933ef40d0 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -102,7 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
-	do_div(freqreg, mclk);
+	freqreg = div64_ul(freqreg, mclk);
 	return freqreg;
 }
 
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

