Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD66A660857
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjAFUel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAFUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:34:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19555AC40;
        Fri,  6 Jan 2023 12:34:12 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p24so2829769plw.11;
        Fri, 06 Jan 2023 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DT+/huwtQo/Hb3OM+ZFYw7lz+P7V1u4iH9OMjxXR9I=;
        b=TyYWgfhTM3HUIjd7gJ5EtNhIsQmtclO/JJBnQw05cqqM1htMS9Iz4jj3hqvCi5jHsd
         Z7ErPjOy50rpGgRl4d+ka6KQKzbEhjB2GCPvY/WkURtIVtk7LK0O/woLERu5lz+56kIZ
         kGiFsrYvyNSPgl0dCRopGB5pAhsjOTXAKf+1fkGHNnamy5aSmgKkOkXzouZzR/yerIKU
         rzotxk8KfwqpTi3NgVJr6VljHEznnM53vevaUGvmpKnVHt3Lu23pC6gr5Hyd7oXbdEw4
         7BlRkXXtLuLN3PSJZFIArc/DDmQlpvk2e02Wce5tLtCFI39xGB91YFWFBBO8CTqLDkeL
         jweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DT+/huwtQo/Hb3OM+ZFYw7lz+P7V1u4iH9OMjxXR9I=;
        b=lLgqaCBILuRAf0U2L95yL/RvweHsxsgUZv1XJBFbQT1ZvCvd+J4pAZmoWbpLVNjEvd
         IkKvu+XhlxUd0gDANoGdf9wk4UCuCqOyFG76zOC9pJWjuBrQ8bm92T+LzK9cO3CPKP0e
         /uu3meHUSdjalw+loDCe/vHRl1m4Lf0XFL1rHErGkEcQO/ODzjHxBOvtZeU49d/FpKaX
         MoMXyX2frh3I3GhbId8LvMRhN7SO5S18D+IFhl/5i7pLaugvt0T4In1dAnRRojGLT9fh
         g82xhfJRngwAdeTr+OJ1JfjF0Ct/1czdoGIQpu8DVo13dS3p1CCpM9XtD20Oh8wACzdO
         0s+g==
X-Gm-Message-State: AFqh2koGBYwweZAU68lUmghyhG0ET7iMK1FY7xTrxS8Svdeh1dZssu4n
        XReUQAUmZG7xQsamNNou4gc=
X-Google-Smtp-Source: AMrXdXu3ANdUQS5ELLp6Ej4q37pOTz53uQtmaHIHheb8C65lnfc0UhC5Mwve6aC06Y3kdcmsXgBpug==
X-Received: by 2002:a05:6a20:bb10:b0:ad:2c7c:9510 with SMTP id fc16-20020a056a20bb1000b000ad2c7c9510mr62398353pzb.19.1673037252423;
        Fri, 06 Jan 2023 12:34:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b0019276616e9fsm1310530plk.183.2023.01.06.12.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:34:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 10:34:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep() from
 blk_put_queue()
Message-ID: <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
References: <Y7g3L6fntnTtOm63@kili>
 <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan reports the following smatch detected the following:

  block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context

caused by blkcg_schedule_throttle() calling blk_put_queue() in an
non-sleepable context.

blk_put_queue() acquired might_sleep() in 63f93fd6fa57 ("block: mark
blk_put_queue as potentially blocking") which transferred the might_sleep()
from blk_free_queue().

blk_free_queue() acquired might_sleep() in e8c7d14ac6c3 ("block: revert back
to synchronous request_queue removal") while turning request_queue removal
synchronous. However, this isn't necessary as nothing in the free path
actually requires sleeping.

It's pretty unusual to require a sleeping context in a put operation and
it's not needed in the first place. Let's drop it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lkml.kernel.org/r/Y7g3L6fntnTtOm63@kili
Cc: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Fixes: e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal") # v5.9+
--
 block/blk-core.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..b5098355d8b2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -283,12 +283,9 @@ static void blk_free_queue(struct request_queue *q)
  *
  * Decrements the refcount of the request_queue and free it when the refcount
  * reaches 0.
- *
- * Context: Can sleep.
  */
 void blk_put_queue(struct request_queue *q)
 {
-	might_sleep();
 	if (refcount_dec_and_test(&q->refs))
 		blk_free_queue(q);
 }
