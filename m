Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA15B7E81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiINBkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiINBkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:40:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491766D9EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:40:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso12995361pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KCj2JZhUIlc2QtoOnWJCVSUQllFdWStECUChjU/ENkM=;
        b=QoFzBSfh8I5qKUc3oiR5VDOzyaxYVfSz8gA+UwQWkYigZZSyqT4xezLzsZHdr0nLNN
         s6prqoijgK5ssjlGtYChnABIcRZclmJXrxuDRTUjJEjD3hAhacnzOHOgNmbYF7XUAuHS
         Y0g3mk+sx8ecGVhRH2tD1p6O1Fa7M+rSpF2gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KCj2JZhUIlc2QtoOnWJCVSUQllFdWStECUChjU/ENkM=;
        b=fVOgTeRxFip8ANyGfk9hXcFQSiZSKHzH2vdVYXBUzMQl8DiFSJl8G9oQ7SAui2SRiM
         BjIW4dnZCugorIyK3R5xl3fUBjp31G+Wv09LCCF7zZUIaTp3q7AdOUXohqX+ZyMruPDI
         IG0uCGxieKxghZoHrDb/NqPfPvcycuAKWuEH6pCLKz7h/zk7+mHpaUXaYfM/g+aZXtVD
         8+RnoSFRBjeBFM6eBH9rmhlPwmXZw8cE9ia1FIbGS8BtCCxTsYPs0vYLc5ISA080qyxC
         +cJpzFCNdncXyFcYDAMkDFduK3hlL9xi4xfIVzNZQ5s+KI+ribEUG+uG3vhXY3pp18XR
         zKvQ==
X-Gm-Message-State: ACrzQf3a3pp5TRepuNrkPLZ8fQaj3UabbFoWxokJoOM7T3zHX21aya+3
        9iy57eiBm9Kh6MRTcu5My3IjrQp/wNW8gnYy
X-Google-Smtp-Source: AMsMyM6xb9Xs+R2n31o4v660yqssLLBb7p9bFfIProsVZH9e3LzA6espTlaQIqHoyrrr1pQEj3zGXQ==
X-Received: by 2002:a17:90a:4402:b0:1fd:c07d:a815 with SMTP id s2-20020a17090a440200b001fdc07da815mr2104374pjg.188.1663119617833;
        Tue, 13 Sep 2022 18:40:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c6e2:a019:5c54:fb4c])
        by smtp.gmail.com with UTF8SMTPSA id n18-20020a170903111200b00174d4fabe76sm9137227plh.214.2022.09.13.18.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:40:17 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>,
        Chris Ball <cjb@laptop.org>,
        Philip Rakity <prakity@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] mmd: core: Terminate infinite loop in SD-UHS voltage switch
Date:   Tue, 13 Sep 2022 18:40:10 -0700
Message-Id: <20220914014010.2076169-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This loop intends to retry a max of 10 times, with some implicit
termination based on the SD_{R,}OCR_S18A bit. Unfortunately, the
termination condition depends on the value reported by the SD card
(*rocr), which may or may not correctly reflect what we asked it to do.

Needless to say, it's not wise to rely on the card doing what we expect;
we should at least terminate the loop regardless. So, check both the
input and output values, so we ensure we will terminate regardless of
the SD card behavior.

Note that SDIO learned a similar retry loop in commit 0797e5f1453b
("mmc: core: Fixup signal voltage switch"), but that used the 'ocr'
result, and so the current pre-terminating condition looks like:

    rocr & ocr & R4_18V_PRESENT

(i.e., it doesn't have the same bug.)

This addresses a number of crash reports seen on ChromeOS that look
like the following:

    ... // lots of repeated: ...
    <4>[13142.846061] mmc1: Skipping voltage switch
    <4>[13143.406087] mmc1: Skipping voltage switch
    <4>[13143.964724] mmc1: Skipping voltage switch
    <4>[13144.526089] mmc1: Skipping voltage switch
    <4>[13145.086088] mmc1: Skipping voltage switch
    <4>[13145.645941] mmc1: Skipping voltage switch
    <3>[13146.153969] INFO: task halt:30352 blocked for more than 122 seconds.
    ...

Fixes: f2119df6b764 mmc: sd: add support for signal voltage switch procedure
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/core/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 06aa62ce0ed1..3662bf5320ce 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -870,7 +870,8 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 * the CCS bit is set as well. We deliberately deviate from the spec in
 	 * regards to this, which allows UHS-I to be supported for SDSC cards.
 	 */
-	if (!mmc_host_is_spi(host) && rocr && (*rocr & SD_ROCR_S18A)) {
+	if (!mmc_host_is_spi(host) && (ocr & SD_OCR_S18R) &&
+	    rocr && (*rocr & SD_ROCR_S18A)) {
 		err = mmc_set_uhs_voltage(host, pocr);
 		if (err == -EAGAIN) {
 			retries--;
-- 
2.37.2.789.g6183377224-goog

