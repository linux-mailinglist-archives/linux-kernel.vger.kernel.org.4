Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0FD6362C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiKWPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiKWPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:06:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C34286DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VSNs7i2DDd1lcBtejQ2RRSmdcUIngbdoewD94AhtZfA=; b=LohvG4T+23yEVb+iGlpMzqdW9c
        UOI9uUNjCL/527MmLDwtiBiZTgBGjqZJemoayMz+8Zad8cmHCZ2LcPW5s8T02Cw2NEovkB3N9Abtx
        vnE8djGd2ncof9liEQW96GwpAVntAO95mQ0U0yGS0/vDNsCVQfk57MG/MGDOwlWJGxmhX5BHDIeUW
        mRfOnruID+3ETbFXlvaD+y9ShNC8pl+zpB3UXSQfpTiAPFolm9LutkV9pJlguX4Pw8c+r3zHNNjUe
        X3Af2S+xN8r2jkLu2/vs9wrU0PfOE52Yw6WF+mLCYgUL4QUECyM4WSZIVsxUUPgmKSnDxhIEpzd79
        ij6yPuSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxrKU-007jq8-F0; Wed, 23 Nov 2022 15:06:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7792130034E;
        Wed, 23 Nov 2022 16:06:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6894320598379; Wed, 23 Nov 2022 16:06:17 +0100 (CET)
Date:   Wed, 23 Nov 2022 16:06:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     peter.zijlstra@intel.com, linux-kernel@vger.kernel.org,
        heng.su@intel.com, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>, namhyung@kernel.org
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y3426b4OimE/I5po@hirez.programming.kicks-ass.net>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
 <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:05:14PM +0100, Peter Zijlstra wrote:
> @@ -9330,7 +9350,7 @@ static int __perf_event_overflow(struct
>  		}
>  
>  		event->pending_addr = 0;
> -		if (data->sample_flags & PERF_SAMPLE_ADDR)
> +		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
>  			event->pending_addr = data->addr;
>  		irq_work_queue(&event->pending_irq);
>  	}

That is the result of this patch; also found in that branch:

---
Subject: perf: Fixup SIGTRAP and sample_flags interaction
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 21 15:57:44 CET 2022

The perf_event_attr::sigtrap functionality relies on data->addr being
set. However commit 7b0846301531 ("perf: Use sample_flags for addr")
changed this to only initialize data->addr when not 0.

Fixes: 7b0846301531 ("perf: Use sample_flags for addr")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9328,7 +9328,10 @@ static int __perf_event_overflow(struct
 			 */
 			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
 		}
-		event->pending_addr = data->addr;
+
+		event->pending_addr = 0;
+		if (data->sample_flags & PERF_SAMPLE_ADDR)
+			event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
 	}
 
