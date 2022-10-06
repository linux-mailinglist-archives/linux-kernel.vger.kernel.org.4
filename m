Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A25F65DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiJFMWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJFMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9B69C2D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=curPJ2N237W59qX/Eld5VxS77RbwV2c9wPIACxuEK8E=;
        b=YJP8Xt/4w9NFu15RQ7bhGSPSAJhsyQdVJT0Xe/hT4Hb3OFC2XH566HJcSfmrw1FXzh118R
        TCnak8ZjjCjCMOjlo8suxLoEQD7uvE4WrYM40gY+xuY8XkfKNu+/esrP6iyS5nNPvnWt6A
        KFzZ39D/f297E0593wRcruAGndIWJ4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-gpY6XO9_MiutGtFSsbvpEw-1; Thu, 06 Oct 2022 08:22:14 -0400
X-MC-Unique: gpY6XO9_MiutGtFSsbvpEw-1
Received: by mail-wr1-f70.google.com with SMTP id d22-20020adfa356000000b0022e224b21c0so466493wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=curPJ2N237W59qX/Eld5VxS77RbwV2c9wPIACxuEK8E=;
        b=7VPx/SFIWIkCYPxCEf4KFRLsMT4tVK+Ska6mCcGbcrYE3OMucWX5Hbr69aPhMjWzc7
         /44QaqxDi7kIc5QWpZb81Yz9egzGN30hmdfPgKUus14z6OFQQRvg8kIeBbbJWjwJAitJ
         fujB9i/oG7P62RpL1aVW2tJUtV03+wxJEjWW3ynHb2wN3KSj4ySOatck5BGMPjL/q0s9
         j6ncNWfq9ptn36JoEopCYpqqQdRPawPy8Tz3mM1/GI04NvV7MUYLCWJ8gAWqGuePxd3q
         3gafGCy3JyO6xn4+myxYIWsNKuPFgWd6qrMgWYL7XTlaaAk3DBc0h/hZ6ygCgf4Rglg+
         dG2Q==
X-Gm-Message-State: ACrzQf2tEzhnorqP8LrASdi0FfZr9c+6NGqxiuf46exaVHqVW8k1asBR
        Ofv4w9VINq2pLCXWavildjq+FropLAhduiv2MlSrLanOmU0K2UE+SToTUgxHX/LIfpG5cGKl7Yl
        ApkkLjSeNGktmnkrLT9FYN8cZ
X-Received: by 2002:a05:6000:982:b0:229:79e5:6a96 with SMTP id by2-20020a056000098200b0022979e56a96mr2935627wrb.469.1665058933635;
        Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cBRqvDWKL6nogwn4jWqQOUP5QiNmUXGk3gstAcZf9U2hKbplHB+q+pomjYcPJEtgFuQ/ajw==
X-Received: by 2002:a05:6000:982:b0:229:79e5:6a96 with SMTP id by2-20020a056000098200b0022979e56a96mr2935618wrb.469.1665058933480;
        Thu, 06 Oct 2022 05:22:13 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:12 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 2/4] lib/cpumask: Fix cpumask_check() warning in cpumask_next_wrap*()
Date:   Thu,  6 Oct 2022 13:21:10 +0100
Message-Id: <20221006122112.663119-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221006122112.663119-1-vschneid@redhat.com>
References: <20221006122112.663119-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoking cpumask_next*() with n==nr_cpu_ids-1 triggers a warning as there
are (obviously) no more valid CPU ids after that. This is however undesired
for the cpumask_next_wrap*() family which needs to wrap around reaching
this condition.

Don't invoke cpumask_next*() when n==nr_cpu_ids, go for the wrapping (if
any) instead.

NOTE: this only fixes the NR_CPUS>1 variants.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 lib/cpumask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 6e576485c84f..f8174fa3d752 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -12,11 +12,11 @@
 	unsigned int next;						\
 									\
 again:									\
-	next = (FETCH_NEXT);						\
+	next = n == nr_cpu_ids - 1 ? nr_cpu_ids : (FETCH_NEXT);		\
 									\
 	if (wrap && n < start && next >= start) {			\
-		next = nr_cpumask_bits;					\
-	} else if (next >= nr_cpumask_bits) {				\
+		next = nr_cpu_ids;					\
+	} else if (next >= nr_cpu_ids) {				\
 		wrap = true;						\
 		n = -1;							\
 		goto again;						\
-- 
2.31.1

