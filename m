Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDA5F9DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiJJLkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiJJLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE511457
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665402006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mvkLHliTWyJalGvJEn/LbIoAUknRrs9S+yAlsWJI1+c=;
        b=Lt2hIaNcrRuoczKHNKOmp5Cr+37Jp/r5fwrFpMkaPPXF6cpJxRe/5hszNnbrg4/iY9EWEY
        iXizsYntkLlLdDZN/4DhZhwXN30HoF5xV9K6dbMpTv7W59IJUWsVuBh13EXXWv/7diS17U
        5VRuLdyrVu3GPQZbZm+FpjnGqiekWNY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-KKxloCBEM3GCYjhvfqzv6Q-1; Mon, 10 Oct 2022 07:40:05 -0400
X-MC-Unique: KKxloCBEM3GCYjhvfqzv6Q-1
Received: by mail-wm1-f69.google.com with SMTP id i5-20020a1c3b05000000b003c47c8569easo3710538wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvkLHliTWyJalGvJEn/LbIoAUknRrs9S+yAlsWJI1+c=;
        b=tt1+VR1FRKWjeIA1Hquu/Ms+9OoeQWkWxPmrok4b0ZiFdbTj9v90k3rnud0gdRLmIA
         sIYPxFhCNgNvT8pvWe7EL7zGRdb9MJ8ZX7CFoGIlB0LsHAMNjn1g6EFbwytkdznGP3pk
         CcCBILy0I+tXkXplXj0Sbr+Lnj0rNd3LGfAE6mBVnM6wtjnNgva5SXgw3BOgcTD7WP2/
         mnRABByD/01gEa30gqDWqo1nOd/KdDFQ67jgel9tse7E7Udbh44VjrrX3JfbTfwSqICn
         CXniLl8VYAuuCNJ0p4JpNywsZBMl9hN/C3JPsuYcoyqKPQN/1Ia9BpCvfRj+lXuPagv+
         4GyQ==
X-Gm-Message-State: ACrzQf08Dgy7OoV6jyp0Zry9uZER/hmJgB+zqONRfW1pSXqW3oZv2gEt
        v0MJ43dGnykJGJLzXBn6kmQ9r+sn57u/NnyM7D5Adu6mQIthKaQCSxRSAvRDKrNQZpR1px+h4TW
        oTpp0te+6c3IfP9auTP6vBTEi
X-Received: by 2002:a5d:5231:0:b0:22e:2ff9:3a65 with SMTP id i17-20020a5d5231000000b0022e2ff93a65mr11258599wra.171.1665402004688;
        Mon, 10 Oct 2022 04:40:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ReaJLjlMjWnIX0C7954a5HBK8Fz1ZiJOIJpqTQUg9oBptcbR+u3Ec/tVlxNMeKCwUE492pA==
X-Received: by 2002:a5d:5231:0:b0:22e:2ff9:3a65 with SMTP id i17-20020a5d5231000000b0022e2ff93a65mr11258592wra.171.1665402004502;
        Mon, 10 Oct 2022 04:40:04 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b0022b11a27e39sm8556636wrw.1.2022.10.10.04.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 04:40:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
In-Reply-To: <20221003214501.2050087-10-connoro@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-10-connoro@google.com>
Date:   Mon, 10 Oct 2022 12:40:02 +0100
Message-ID: <xhsmhv8orgb59.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/22 21:44, Connor O'Brien wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>

This was one of my attempts at fixing RT load balancing (the BUG_ON in
pick_next_pushable_task() was quite easy to trigger), but I ended up
convincing myself this was insufficient - this only "tags" the donor and
the proxy, the entire blocked chain needs tagging. Hopefully not all of
what I'm about to write is nonsense, some of the neurons I need for this
haven't been used in a while - to be taken with a grain of salt.

Consider pick_highest_pushable_task() - we don't want any task in a blocked
chain to be pickable. There's no point in migrating it, we'll just hit
schedule()->proxy(), follow p->blocked_on and most likely move it back to
where the rest of the chain is. This applies any sort of balancing (CFS,
RT, DL).

ATM I think PE breaks the "run the N highest priority task on our N CPUs"
policy. Consider:

   p0 (FIFO42)
    |
    | blocked_on
    v
   p1 (FIFO41)
    |
    | blocked_on
    v
   p2 (FIFO40)

  Add on top p3 an unrelated FIFO1 task, and p4 an unrelated CFS task.

  CPU0
  current:  p0
  proxy:    p2
  enqueued: p0, p1, p2, p3

  CPU1
  current:  p4
  proxy:    p4
  enqueued: p4


pick_next_pushable_task() on CPU0 would pick p1 as the next highest
priority task to push away to e.g. CPU1, but that would be undone as soon
as proxy() happens on CPU1: we'd notice the CPU boundary and punt it back
to CPU0. What we would want here is to pick p3 instead to have it run on
CPU1.

I *think* we want only the proxy of an entire blocked-chain to be visible
to load-balance, unfortunately PE gathers the blocked-chain onto the
donor's CPU which kinda undoes that.

Having the blocked tasks remain in the rq is very handy as it directly
gives us the scheduling context and we can unwind the blocked chain for the
execution context, but it does wreak havock in load-balancing :/

