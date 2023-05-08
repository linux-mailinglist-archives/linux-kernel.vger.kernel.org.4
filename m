Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70316FA232
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjEHI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjEHIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:25:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA3218FF6;
        Mon,  8 May 2023 01:25:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaec9ad820so39706345ad.0;
        Mon, 08 May 2023 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683534355; x=1686126355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcTz0vWUD4Q0wv75dePvEIDbxsiYaBnCtIX/PSDWBAs=;
        b=r6MPeVExhXh05iZtlMvE4rgm0Ad8K7f5BunXzKEuLU+FcNaAduD6cMY50jhLsy2VUY
         wu9UoinodbcypMPurh3B3PSG7l//jUybqYtiXVFLz+9vYgIcmfsXZVua2FrzjX3rCRWc
         4Va+eb+hTAZAupZYnIZuHxByb2fFz5OihsD9NcLAGgolh/GlvRu+j3N1tkEDlKOPWLD0
         t3ESbhWgF3c/aDcK5zlmJjn0VwfRMmtMV8D844uTkMSCMIHOrMXnTV3Xe0sDkIMHhTGS
         11suvbtrTW7X/FLen0APzsVOfip9ZeLb7rqDtFadt31al70FmkXidDVoQq57jlvnPd+5
         Rnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534355; x=1686126355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcTz0vWUD4Q0wv75dePvEIDbxsiYaBnCtIX/PSDWBAs=;
        b=b4D0BZOitxZ61OQPUasEo1SznJ1ypzEZApBLMBjKA8S8aoTdgoLoKoTbJWB/abV9l0
         hPtbYnTVDtHGKrHHxAdVr+ooxupCcU/w+L1lcL8MLSNir9gtuQt0ol/Ac+UoD9p3DdOC
         JfbZUgBubjXDnBBFC01R5dIjmsdg7Dd6PqW5x7dYtXE9ekfY9mxkLnXuIlYHgnnvQEwu
         egwF9bzBpbt80dWSunMIz8BoPdisEVG5IkqSIK66lEQnTxIuPmh6Gn4Lk4ZhfKNqwh0E
         wxlWWq9frKDWlYHiB2gsotQGA/o6yaf6M67wYjjzii+vGdfuWc8OBU5yIIejLfCNGVlL
         pfTA==
X-Gm-Message-State: AC+VfDx7k4t2dU453RY1a/EJ3qt1YyfbCelJ+nod9M5kIbPRed3QOztR
        VbFGZK/Y9zFmvA13GOziSo0fN0mp/WU=
X-Google-Smtp-Source: ACHHUZ5TjXl8DPZQOIORR123Rdr0ZajzwYUGGrQwGm9wd8gmGk3ZIwhqojYwrxhNjr/o8PHyKTacAQ==
X-Received: by 2002:a17:903:41d0:b0:1ac:4412:bd9 with SMTP id u16-20020a17090341d000b001ac44120bd9mr12241137ple.3.1683534355487;
        Mon, 08 May 2023 01:25:55 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b0019c13d032d8sm6497933plb.253.2023.05.08.01.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:25:55 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/mbox: Remove redundant dev_err() after failed mem alloc
Date:   Mon,  8 May 2023 08:25:30 +0000
Message-Id: <20230508082531.136281-2-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508082531.136281-1-raghuhack78@gmail.com>
References: <20230508082531.136281-1-raghuhack78@gmail.com>
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

Issue found with checkpatch

A return of errno should be good enough if the memory allocation fails,
the error message here is redundant as per the coding style, removing it.

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
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

