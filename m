Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A266D9B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjDFOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDFOwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:52:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD3A24C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:51:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso40838479pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvxogFZ7tzo2z7dxF0J9Y3jJgkG796IBeY87z8Qv1kQ=;
        b=PxWqmBRUj4WBnZSfVzpRfLqostqKXR8X10+oF706WENnUQNTAeGyug62X2dsa4tpYN
         TmZJqensASXgsRSvYlajRgHSMIgj2iFr/xVKZh8tJZGDsoodlod6SdH5oK9lq7q+7ePl
         eaWtyww8e1C07Wfpb5nER82j3g66y0RauEyorkQixXonVxmvCfIDmD6SHJ6PzTQihsqe
         I2AQUXe4NtRjpaxWSZwm/sykWFD+1zLra0dC+oUYexpzGyYlq9uYv7vXgtDPypULn3GD
         qClosOFu9bbC+DXhM1sMN06zbLRpwPyZr8aDAP28l2d16iq49K4A3UQfJINl2MstFl0K
         VtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvxogFZ7tzo2z7dxF0J9Y3jJgkG796IBeY87z8Qv1kQ=;
        b=jK0nmum7b3fNcZZyYRphIGvBFOX3eFMeN7gnUA8rwCf0JTxfXqEt/+1tDgtuodnz02
         +JK6LS3GENcaL5ubkIgy2BaS908CSToBpVM7qZTFgbaeZPC3AL5MSWNmI8G9UzUX7gUD
         n68S/qmCSZp4eA6MFOZX93QEHYM7A83RDXRjPNbj2JZ9B/m9yzcjOUzLS6JJiO9m00Hp
         j9BfNfHaK8WDM4j+McSjfYyWypfpd5k/ZAeM6uM18/dwAPSUDY/Iy0NcilRjrJK4V+Kz
         qSRKdxHkT9GzycSV1Rt5gTOIcKPRpxD9W9XELBMP5qFE2FhRR2ZmrtJX4/GmA6PGfd+f
         d9Qw==
X-Gm-Message-State: AAQBX9eYmpuTJiKRirPNNnJbNCiDeOMNhsLXR3gsiR61hKwX69lkCuR+
        J+Sc8oN5xdqJg67GB+ebi0anvA==
X-Google-Smtp-Source: AKy350YMOAAXOd9Wtpy7569VRlFO8zc9dgQrOSpbdZ975Faxy8Ltu9r0KG6OuX3tcNR0EjtuUJaFTA==
X-Received: by 2002:a17:903:22cd:b0:1a2:8924:224d with SMTP id y13-20020a17090322cd00b001a28924224dmr12472230plg.59.1680792665876;
        Thu, 06 Apr 2023 07:51:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/3] block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
Date:   Thu,  6 Apr 2023 22:50:48 +0800
Message-Id: <20230406145050.49914-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ_WEIGHT_LEGACY_DFL is the same as CGROUP_WEIGHT_DFL, which means
we don't need cpd_bind_fn() callback to update default weight when
attached to a hierarchy.

This patch remove BFQ_WEIGHT_LEGACY_DFL and cpd_bind_fn().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c  | 4 +---
 block/bfq-iosched.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 89ffb3aa992c..a2ab5dd58068 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -504,8 +504,7 @@ static void bfq_cpd_init(struct blkcg_policy_data *cpd)
 {
 	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
 
-	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
-		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+	d->weight = CGROUP_WEIGHT_DFL;
 }
 
 static void bfq_cpd_free(struct blkcg_policy_data *cpd)
@@ -1302,7 +1301,6 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 	.cpd_alloc_fn		= bfq_cpd_alloc,
 	.cpd_init_fn		= bfq_cpd_init,
-	.cpd_bind_fn	        = bfq_cpd_init,
 	.cpd_free_fn		= bfq_cpd_free,
 
 	.pd_alloc_fn		= bfq_pd_alloc,
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 69aaee52285a..467e8cfc41a2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -20,7 +20,6 @@
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
-#define BFQ_WEIGHT_LEGACY_DFL	100
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-- 
2.39.2

