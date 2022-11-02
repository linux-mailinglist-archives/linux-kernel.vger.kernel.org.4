Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9A6162D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKBMkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKBMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:40:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F2F2A437;
        Wed,  2 Nov 2022 05:40:20 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g129so16139365pgc.7;
        Wed, 02 Nov 2022 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmz9MTfv7lI1QNkjbbI4jecKBOC8rkshqDZ/E0vCsJc=;
        b=VeibVBTCfMdN+FVmc77EkVwhtydUW+tXJU6+/gq5kBBejmiwThQHVdVTHpEsALCI7H
         x733cOcn18jFNKXQ2kcNwtBDW4wiJYmq9z3iG+f5UPvQuVAS0YIPhYvv0GnTZ/eaIMce
         udgQPUa3L45A+YexMe3OiWyegkzQfGfjmprH8MtlCTR1OlpWcaZElaqq2/5LSgkcBC6M
         EPtCQlLpdRYVBCO+JzosERkPqEsXHZ91mggqfeFeJUcHgPjiMT3UKhkauTtzk3FjNlLr
         m39zbW/A+mWGMM/qRwJuKhQKpMxMEC2ZSTYiQzyRMH1QXwLcY5QhnsJrR0ixU2zk5BBV
         VgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmz9MTfv7lI1QNkjbbI4jecKBOC8rkshqDZ/E0vCsJc=;
        b=QOdilwzbCB6AKnCZHnViq65f/JeR42LM0sLNy1kBbTvhXVJ1jI2rdphj3AGWfy88sC
         hyiycZGBIRVEIXTzVSfs1qUx1SUJMJw5ufLiU2+WtUQOXRMS4fPVD15l0y2Cr/6Fm+Q9
         Fl9zam5Z0u+kZH8P2GEZFrfH5xmqXFNvX5Dy4LLboAJU6Z/i5kfsWI9jDUjfNEfBivQf
         TmMaJQEGlEJdOEgdQiJz3Yx7snkTLJLOHCjH2agDydXvw6sAPr058R7VHF/g57zj7jy2
         OVqOKE6G+asKwY2QHm6RpHuXIIolmp8Mc/RzYCl7GYiageTKOO31eSMiGRc86H2Q8PcY
         VSNw==
X-Gm-Message-State: ACrzQf0q20sNafLW7PT4PxQNOpalI2r/+DMF2fUZHSD1mXJOZc0s50CP
        D2+FhgFt3HiDh8ztmf5Ghe+OgU5xfCG7tPne
X-Google-Smtp-Source: AMsMyM4lAYlAp8vytn6N/m4wsYjsRHrDho15t7weJvyNoCvd4E9lT4ezoA4hfCFoE3jtpymg3qOpYA==
X-Received: by 2002:a63:187:0:b0:43b:cf3c:c64d with SMTP id 129-20020a630187000000b0043bcf3cc64dmr21227922pgb.359.1667392819177;
        Wed, 02 Nov 2022 05:40:19 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id f19-20020aa79693000000b0056c003f9169sm8339360pfk.196.2022.11.02.05.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:40:18 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [PATCH 3/5] block, bfq: don't convert pid type in bfq_log_bfqq()
Date:   Wed,  2 Nov 2022 20:39:54 +0800
Message-Id: <20221102123956.230-4-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
References: <20221102123956.230-1-Yuwei.Guan@zeekrlife.com>
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

Don't convert pid type in bfq_log_bfqq()

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e00c67a01b09..9c626fba41c8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3109,8 +3109,7 @@ static void
 bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 {
-	bfq_log_bfqq(bfqd, bfqq, "merging with queue %lu",
-		(unsigned long)new_bfqq->pid);
+	bfq_log_bfqq(bfqd, bfqq, "merging with queue %d", new_bfqq->pid);
 	/* Save weight raising and idle window of the merged queues */
 	bfq_bfqq_save_state(bfqq);
 	bfq_bfqq_save_state(new_bfqq);
-- 
2.34.1

