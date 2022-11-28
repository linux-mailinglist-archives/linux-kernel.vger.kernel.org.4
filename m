Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D763A727
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiK1LZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK1LZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D201B7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jltQZmYd/lY9y5fSVfHcTdMWRfmPvirwgsilr4KTWY=;
        b=GRI329FG5xX+yuWz7wwQFcO+4V+elAlGqKi+8JmNYApy4D/Jq8zl3EnRvAp0c9aXC1a+5l
        GSzmJX4S8IIOLWKSSVylD/Nw2+JJ7I6LNG/8nAh8ammo9aBk+KYGLMUjhkFgc7PN0fNIgx
        VxmqZ66/gHkYx3UuTe+a4Tzirz/3IJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-dy7rn9XZOtaC3OdmqGYmjw-1; Mon, 28 Nov 2022 06:24:13 -0500
X-MC-Unique: dy7rn9XZOtaC3OdmqGYmjw-1
Received: by mail-wr1-f70.google.com with SMTP id d6-20020adfa346000000b0024211c0f988so657885wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jltQZmYd/lY9y5fSVfHcTdMWRfmPvirwgsilr4KTWY=;
        b=N/ygNqDg0RfaFWfjKaEDU+3c2FqKHS7SMdg/y4an5iVVQj/NdTsPFoWlr+8aHlVOeV
         +st9uI4c5MRG7DRf+7p7ZuOqUdIr6WoF8mXd7+Bh/0rNJRUj8xpbyne8Jwaj4ekRZNXq
         aVqIxln2CFiTxDRzyj/gN5X6Krwtrx6LnvLEQrgsjFzYPMqYujKKyz/JajBGELCniTQl
         8Z1q1BJDZyuZkY48qW84VXjdOZnayjxRnOtekHm6Z4aGsKgXKhY5Vbzt7orynyknVeVG
         nB59tE49WI+pLyf8r0YMPYuOyANMh6wgUg+1DmXucsxcLLXx71GU3UILryFvYjwZoGy+
         n0rQ==
X-Gm-Message-State: ANoB5pmmoMc/ViTfpsuOfz9YDXMmYthfsC6npD3i74XgW1BPCMBhp/yx
        OHm5Sy8kS2MMo6RD6js7FURhjryYo8oXmzBUrTI51lZG/RSdCrSchgf/kl9mSYxqzEOxKcQQYk5
        NcxltQjjd5X7kjow5PqJEENQR
X-Received: by 2002:a5d:4706:0:b0:241:e77b:a81c with SMTP id y6-20020a5d4706000000b00241e77ba81cmr16680548wrq.145.1669634652788;
        Mon, 28 Nov 2022 03:24:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6PW00uwv1oUL3+mjre/bRJ4lh3ebEqHU1B5RXuxcKrEygZnnyKfzO3TDa3wC0o3lrlAc8QaQ==
X-Received: by 2002:a5d:4706:0:b0:241:e77b:a81c with SMTP id y6-20020a5d4706000000b00241e77ba81cmr16680537wrq.145.1669634652608;
        Mon, 28 Nov 2022 03:24:12 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c5-20020a056000104500b002421888a011sm2207114wrx.69.2022.11.28.03.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:24:12 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 4/5] workqueue: Convert the idle_timer to a timer +
 work_struct
In-Reply-To: <Y30vyTgB7+kGkDGa@slm.duckdns.org>
References: <20221122192937.2386494-1-vschneid@redhat.com>
 <20221122192937.2386494-5-vschneid@redhat.com>
 <Y30vyTgB7+kGkDGa@slm.duckdns.org>
Date:   Mon, 28 Nov 2022 11:24:10 +0000
Message-ID: <xhsmhcz97l3tx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/22 10:23, Tejun Heo wrote:
> Hello,
>

Thanks for having a look at this so quickly!

> On Tue, Nov 22, 2022 at 07:29:36PM +0000, Valentin Schneider wrote:
>> @@ -2039,12 +2060,48 @@ static void idle_worker_timeout(struct timer_list *t)
>>              worker = list_entry(pool->idle_list.prev, struct worker, entry);
>>              expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>>
>> +		/* All remaining entries will be younger than this */
>>              if (time_before(jiffies, expires)) {
>> -			mod_timer(&pool->idle_timer, expires);
>> +			if (!cull_cnt)
>> +				mod_timer(&pool->idle_timer, expires);
>>                      break;
>>              }
>>
>> +		/*
>> +		 * Mark the idle worker ripe for culling.
>> +		 * If a preempted idle worker gets to run before the idle cull
>> +		 * handles it, it will just pop itself out of that list and
>> +		 * continue as normal.
>> +		 */
>> +		list_move(&worker->entry, &pool->idle_cull_list);
>> +	}
>> +	raw_spin_unlock_irq(&pool->lock);
>> +
>> +	if (cull_cnt)
>> +		queue_work(system_unbound_wq, &pool->idle_cull_work);
>> +}
>
> So, you mentioned this explicitly in the cover letter but I think I'd prefer
> if the timer were simpler and all logic were in the work item. It just needs
> to pick at the first worker and compare the expiration once, right?

Yep exactly. I wasn't fond of repeating the expiration check pattern, and
also it meant the culling worker could see different things than the
timer.

Moving everything in the worker does however mean we can get rid of the new
worker_pool.idle_cull_list, which is my least favourite bit of that
approach, so I'll give that a try.

> If that
> bothers you, we can make workers keep track of the oldest idle's timestamp
> in, say, wq->first_idle_at as the workers go idle and busy and then the
> timer can simply look at the value and decide to schedule the work item or
> not.
>

I don't think the overhead at worker_{enter,leave}_idle() would be worth it.


> Thanks.
>
> --
> tejun

