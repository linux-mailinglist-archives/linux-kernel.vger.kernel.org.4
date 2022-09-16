Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE755BAD53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiIPMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiIPMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4C3B1B83
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so35807692wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=roKqTDfIrTl9uRri+S8php+Fd9yWmb1Y8cdQ+WhhXiY=;
        b=XXv4s6fz2yp/sVM9BNSs6pAQS67/Ovdc6+oBUAk/GIOfV3f6ZSnldpSkMVh77Kb5r+
         rQ0VeXTVcju9ovRoHRSj9QSPDZdi/fRxfFMyxg4uazjPU5dZACPF5KH0g+x+hL3uA6uG
         qNvseJxrRhzaC2YH3Z0+SgzAncDEV32klVtuTQ7bjxTSZBvQWvnduUd1NkChqINFXDA0
         jKpAatYzt/O6JdC9W+SxNv+atFYDoWlmk576tHBjuBVSz5ZAcMllg20+1wC3ShYgU/b4
         u51PfPuj8i1DP3saRTXWYPEqFPjk4+fvWJNzShsl8XVkYgbx4IuEk/ibb6XDAmfEKmvw
         FFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=roKqTDfIrTl9uRri+S8php+Fd9yWmb1Y8cdQ+WhhXiY=;
        b=AM2aoeCGaVQZGtZbdSf541yBTHfcoqV9k57VJ9vsGP0VF6KOxW56zzFya8Ltg/EIT5
         htKvk347d8UI8vminZof3Lp3uL22+CUgTsgz/BLjhku/P2QQCl+ujqHCWR0pD8CEdra9
         9VPo//fUuQ6MNANgB6R6f8r7xSFatCQopjlpre9sJ6D4tV+dJWzpA60nzUABFmJfZL/7
         Pf6Sh2xqLNDOrdcY5qcG1kZaCqcS6tGOpFo8p0Oc930oJynxpJfjpwtT04YlsGuOOsE1
         XuYveeRv4lw8aLW+nquI01gEWk2xRGWvIHf0zZl6wuMh0d8AbBJNHJrP6afrzLU4Dsz5
         SQ7w==
X-Gm-Message-State: ACrzQf0lZ+a3m8Dx/QX/ETIPYV43iCvCOTwOTjJfyzh0ezJ3HE905QCt
        3O8xWbcWGHz0IO0VnVCwuty9Rw==
X-Google-Smtp-Source: AMsMyM4EQs92CwSmr+cSOC4oeYAgXnOVnoC9TqrK+2emcejHvVllu/KDocuYhA7gQ2UUVXjg1uGJWQ==
X-Received: by 2002:a5d:69cf:0:b0:22a:c2d3:1d4a with SMTP id s15-20020a5d69cf000000b0022ac2d31d4amr2735175wrw.473.1663330872063;
        Fri, 16 Sep 2022 05:21:12 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Kenneth Lee <klee33@uw.edu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/13] nvmem: brcm_nvram: Use kzalloc for allocating only one element
Date:   Fri, 16 Sep 2022 13:20:52 +0100
Message-Id: <20220916122100.170016-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <klee33@uw.edu>

Use kzalloc(...) rather than kcalloc(1, ...) because the number of
elements we are specifying in this case is 1, so kzalloc would
accomplish the same thing and we can simplify.

Signed-off-by: Kenneth Lee <klee33@uw.edu>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 450b927691c3..4441daa20965 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -96,7 +96,7 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
 
 	len = le32_to_cpu(header.len);
 
-	data = kcalloc(1, len, GFP_KERNEL);
+	data = kzalloc(len, GFP_KERNEL);
 	memcpy_fromio(data, priv->base, len);
 	data[len - 1] = '\0';
 
-- 
2.25.1

