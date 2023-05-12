Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB41A700A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbjELOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbjELOPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:15:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EACDA268
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55ffc3d2b63so98243567b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900911; x=1686492911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kJtzV8QKLK33nINo9QDGOG+IeWyuMdmVEqS+yux294=;
        b=73+KE2jJZgkKQVWCaUtcFRpHwxmCoknACAnlzWzTTYdIeY0sf1xAPMDgtao4FVuH4k
         cIXrqnoPUk9E9aw5oY+NH0+jpuVYn11HOwCNYKqqhyAGlgtS8CuLEkii2U8zX7IDZGG3
         tlE3p6UYcl+Dl7nnZLCUsFMsZHAaumD1Hky/+FyLVDvK5mKqHYq7x4LBEhc2fAIii/2H
         yPQQh3WUAMDhsWLQPzOgM2V6SxOObNDmTh0RskA9oAhKJX3QfNpu7Df6AIEjOpTY2N4T
         xslSmLB6C898lbkzltwNSx1CNN9tRFjI/b5qSyKnAI4MQmIHDWG5CVYIHlhWqrVQXrDd
         gaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900911; x=1686492911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kJtzV8QKLK33nINo9QDGOG+IeWyuMdmVEqS+yux294=;
        b=PBDw+ZIpMCa8FVM83v1gq3i5GGShrMnId7eNbEZW5s0/0bj7GBWqZOnj1FiKhdWNg8
         ZMm76+fAg3a8TWxH1Kokie05ZIDHygHWL/vAeU7WHm8Uwc4KTXdemTXu7SV3bETorBXt
         f+lLj2CxxDA+9eij2cV8893khmYPUcHqA9Qi+c8+RLC1s9nUSvYv2+R4Y0gCjuHM66ZS
         uwA57WSkUcIxSM2+YBvb2NzGT2UnTWFXoRK10oFAfcr4ljSACCIwqZYkQHIOyWI/c2Ov
         aJBEQh1HA6koIzbfyfFabr3lg/bH16DdRcHgvzXpOXuglA/o/g7B59lDjTjDJc8N+zcq
         XAHA==
X-Gm-Message-State: AC+VfDxLzPeKQNx4GUCtj0YR2kj5J6j38ZM9ttmHdei/BGyqbKfgu/No
        QaJXg2ZFRS9hHMmxXwUEFgOK2mh6saDbRA==
X-Google-Smtp-Source: ACHHUZ5FF1KDxHSmDdCADl9UuEtrVgD3r0eClUYyRAGVWtfRWyouNuYTfOYNJtJsrlXdAXmgpxOCHVAtwCX34Q==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:430b:0:b0:55d:9a6d:8ce5 with SMTP id
 q11-20020a81430b000000b0055d9a6d8ce5mr15219383ywa.1.1683900911005; Fri, 12
 May 2023 07:15:11 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:41 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-3-joychakr@google.com>
Subject: [PATCH v2 2/6] dmaengine: pl330: Use FFS to calculate burst size
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
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

Use __ffs to calculate burst size in pl330_prep_dma_memcpy() for
consistency across the driver as other functions already use __ffs for
the same functionality.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index c006e481b4c5..39a66ff29e27 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2804,10 +2804,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 	while ((src | dst | len) & (burst - 1))
 		burst /= 2;
 
-	desc->rqcfg.src_brst_size = 0;
-	while (burst != (1 << desc->rqcfg.src_brst_size))
-		desc->rqcfg.src_brst_size++;
-
+	desc->rqcfg.src_brst_size = __ffs(burst);
 	desc->rqcfg.src_brst_len = get_burst_len(desc, len);
 	/*
 	 * If burst size is smaller than bus width then make sure we only
-- 
2.40.1.606.ga4b1b128d6-goog

