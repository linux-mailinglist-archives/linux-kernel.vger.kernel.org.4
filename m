Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352646E7855
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjDSLRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDSLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:17:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3214478;
        Wed, 19 Apr 2023 04:16:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b78b344d5so2210180b3a.1;
        Wed, 19 Apr 2023 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681902933; x=1684494933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJ0quS8PSmcOSKHlL8+ZsUIniTqrOGEBBq6bjBNxf0=;
        b=Z5Q5tE1GLgm4wm3YWrNt4E+8IlHzviPDJAEPbQU/+E8/RAaqgG+gqOBlL9ZGwGHb5G
         ME5NefLIzmK408Lre3SEK75QOOaPcvunXL3eq/b/+kJ252xTopqnqfmbmR01H1bDD3M1
         wRmcFJqIEG/2sIkVL6j5E3G0AzGkxSjAMt1UXw5ZW4knVTMugvgDppz+7vItmdWPCheh
         HMN6mhK2UNk1OjVFul+nf5MxMJjghQsj8nY8/vrKYUGVKKCR63pTvz5jc0sgkQyGYRbC
         2EeR9ajKXTxZK8bInDFHXgDJJQ7Y1KDbDiAeTMz1U2BvXBAA0OqwvbivdTlvtgZfd4/D
         NMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902933; x=1684494933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJ0quS8PSmcOSKHlL8+ZsUIniTqrOGEBBq6bjBNxf0=;
        b=g8Y+BfYmrF7JCTx3XSD8EtluG5ggfZZjZl9pq4bdSaXZELIza5Ffla/Ig/fgL1ahBT
         ASUA7qpaTcVweRjusXwY/3V59l6EUX9dpZoVpdFNsI5yEvQl2YnPsaetMTwL8ldWJr5G
         ugQsC4WTbUsb25N+V0gPPlwK8gJQsqAVMVHfhww73nva1HAinY5RCiSXhcdu71d1nCE5
         D3Thf9TvogL7qIVSnjwOVhztyHGZ5c9tQFS4BElBRtzPe++1pLaJzUHgr/VG6FCYOYYi
         Z9Rp/xpm6AvCWBriox32aK36OnFh+hPGHtosxdz7/aVCaQO6gTcJudbTxRImYfJSSJhF
         gP+w==
X-Gm-Message-State: AAQBX9ehD36t2MLEugzuDs6PZTeepAzYdh+qD3gwpKLpOyt/HT3V6NDM
        iAmlyAL7yyu8N4PCs02ETiho3gzAh64=
X-Google-Smtp-Source: AKy350bG4AYtxLuwGUlX5AcJqEu6yQpwW6OC2sqIZKSpq8IDRXsVeQIJI5UtSm7kkibPb0jck5rJHw==
X-Received: by 2002:a17:902:e84e:b0:1a2:296:9355 with SMTP id t14-20020a170902e84e00b001a202969355mr5518861plg.16.1681902932888;
        Wed, 19 Apr 2023 04:15:32 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b001a6566045ccsm11194914pls.192.2023.04.19.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:15:32 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [STYLE v1 1/3] cxl/mbox: remove redundant debug msg
Date:   Wed, 19 Apr 2023 11:14:41 +0000
Message-Id: <20230419111443.231151-2-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419111443.231151-1-raghuhack78@gmail.com>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A return of errno should be good enough if the memory allocation fails,
the debug message here is redundatant as per the coding style, removing it.

Signed-off-by: Raghu H <raghuhack78@gmail.com>
---
 drivers/cxl/core/mbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..11ea145b4b1f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	struct cxl_dev_state *cxlds;
 
 	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
-	if (!cxlds) {
-		dev_err(dev, "No memory available\n");
+	if (!cxlds)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	mutex_init(&cxlds->mbox_mutex);
 	mutex_init(&cxlds->event.log_lock);
-- 
2.39.2

