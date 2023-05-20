Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FDF70A5B1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjETFbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjETFbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46951BC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684560618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maQ1H/KHFCmtzJvbtPQ78ynksUc2EpyBApXxB8/KGoU=;
        b=UQOK52KDv97wXLURIQU7f3R+Q0+8Kzgf33C3i1xU50yv3NeGzso2smq4mxJCXTrTf98oSK
        5GUs4vzcl/Mwa7eSaMaF2RplhVl+cY2V0G93yXcwyRYBz91hv7/fI0llUz9Eez/2PI/ZIY
        HSFUrUN7JXhgeoYmw+IX1+pIVmk8mlA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-r4HwTTInOUSSzB-IMNzRJA-1; Sat, 20 May 2023 01:30:17 -0400
X-MC-Unique: r4HwTTInOUSSzB-IMNzRJA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-54f5cbdfbf5so2445822eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684560617; x=1687152617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maQ1H/KHFCmtzJvbtPQ78ynksUc2EpyBApXxB8/KGoU=;
        b=Ps7czpWAC8K/djhL+2bGjJKquCnRcxu+Rz8TUDK+hbFq4lKs/Er6JCAMilKm9TsKnA
         8orrhLqDIV59gv6nAhn2l6B4aUGVv9FG5icmzS/zPNYDbAe6Q2IanuquM5vYElT5+ssy
         Dumsps40TtcmZip9VHGhkgV8L+7yC2h2puTz3dQ4nAEEzD2fg7nHCIRzbY0i/j3N4dRV
         kaj5wQi6w38XYOfhed+Uqv0Xoa17Ed5a5a5QbFTYrvBV2q81hSDp9FF00OoZUp6Fb7rP
         cboJVEaG6tSpbpU9dDii7ujFJX5mK1RJworf1DlZn4re7Qe4fgFTyere+x7F4BPmJR2E
         U3+w==
X-Gm-Message-State: AC+VfDyrurJ08YCfLi+paIlfR4rNWtkAJuefEo51ZWDPUBaIKroOG0Ag
        jUEOaPIvL8f9He8MDkqaCwkyhAoMvxGhZ1Y8k/ge78Kci0ywHoaxcUH4JnIhMDO89KW16u0BL2Y
        4PSx4d2Mbll06ORqG374i8Zfa
X-Received: by 2002:a4a:3c1b:0:b0:54c:49d:3b37 with SMTP id d27-20020a4a3c1b000000b0054c049d3b37mr2416505ooa.1.1684560616872;
        Fri, 19 May 2023 22:30:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6h4l2Ghsh00+OOUGIhOUeHxbExMk18l4zb1GAHKo2+Ge6KGX+J7ML7dWZZoT5ZnowMXnhDvA==
X-Received: by 2002:a4a:3c1b:0:b0:54c:49d:3b37 with SMTP id d27-20020a4a3c1b000000b0054c049d3b37mr2416497ooa.1.1684560616676;
        Fri, 19 May 2023 22:30:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
        by smtp.gmail.com with ESMTPSA id j14-20020a4ad6ce000000b005524555de56sm365494oot.36.2023.05.19.22.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:30:16 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leonardo Bras <leobras@redhat.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] blk-mq: Move csd inside struct request so it's 32-byte aligned
Date:   Sat, 20 May 2023 02:29:56 -0300
Message-Id: <20230520052957.798486-2-leobras@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520052957.798486-1-leobras@redhat.com>
References: <20230520052957.798486-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, request->csd has type struct __call_single_data.

call_single_data_t is defined in include/linux/smp.h :

/* Use __aligned() to avoid to use 2 cache lines for 1 csd */
typedef struct __call_single_data call_single_data_t
	__aligned(sizeof(struct __call_single_data));

As the comment above the typedef suggests, having struct __call_single_data
split between 2 cachelines causes the need to fetch / invalidate / bounce 2
cachelines instead of 1 when the cpu receiving the request gets to run the
requested function. This is usually bad for performance, due to one extra
memory access and 1 extra cacheline usage.

As an example with a 64-bit machine with
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_WBT=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_INLINE_ENCRYPTION=y

Will output pahole with:
struct request {
[...]
	union {
		struct __call_single_data csd;           /*   240    32 */
		u64                fifo_time;            /*   240     8 */
	};                                               /*   240    32 */
[...]
}

At this config, and any cacheline size between 32 and 256, will cause csd
to be split between 2 cachelines: csd->node (16 bytes) in the first
cacheline, and csd->func (8 bytes) & csd->info (8 bytes) in the second.

During blk_mq_complete_send_ipi(), csd->func and csd->info are getting
changed, and when it calls __smp_call_single_queue() csd->node will get
changed.

On the cpu which got the request, csd->func and csd->info get read by
__flush_smp_call_function_queue() and csd->node gets changed by
csd_unlock(), meaning the two cachelines containing csd will get accessed.

To avoid this, it would be necessary to make sure request->csd is placed
somewhere else in the struct, so it is always in a single cacheline,
while avoiding the introduction of any hole in the struct. In order to
achieve this, move request->csd to after 'struct block_device *part'.

The rationale of this change is that:
- There will be no CONFIG_*-dependent field before csd, so there is no
  chance of having unexpected holes on given configs.
- On 64-bit machines, csd will be at byte 96, and
- On 32-bit machines, csd will be at byte 64.

This means after this change, request->csd will always be cacheline aligned
for cachelines >= 32-bytes (64-bit) and cachelines >= 16-bytes (32-bits),
as long as struct request is cacheline aligned.

In above change, the struct request size is not supposed to change in any
configuration.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/blk-mq.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..44201e18681f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -105,6 +105,11 @@ struct request {
 	};
 
 	struct block_device *part;
+
+	union {
+		struct __call_single_data csd;
+		u64 fifo_time;
+	};
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
 	/* Time that the first bio started allocating this request. */
 	u64 alloc_time_ns;
@@ -189,11 +194,6 @@ struct request {
 		} flush;
 	};
 
-	union {
-		struct __call_single_data csd;
-		u64 fifo_time;
-	};
-
 	/*
 	 * completion callback.
 	 */
-- 
2.40.1

