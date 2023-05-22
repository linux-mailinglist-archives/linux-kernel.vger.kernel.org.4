Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BC70C22F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjEVPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEVPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5CE6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684768724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtwpGxtG++IildS19TxDJ64n89sIOkk1Zx05HB1YFBA=;
        b=QtnjMcePCuZm1jVPW4C9Ja2yKH5deBmTVeQfuqXfDFwz7OYgX0nrQpTCmJyDh4VcAVtcXn
        4Ab9b5bnYqvMqOumFY2aZxmqakG4RiQzVufaqmlEab7rKvrRlEhEYH/O0KVVyvM2pWguRM
        7dsUwrcOuBq0b9VDpHq8+6PKl5dmEgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-YwC0V6HHODGbt_kJYc1h5Q-1; Mon, 22 May 2023 11:18:42 -0400
X-MC-Unique: YwC0V6HHODGbt_kJYc1h5Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-306362a1607so3970548f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768721; x=1687360721;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtwpGxtG++IildS19TxDJ64n89sIOkk1Zx05HB1YFBA=;
        b=Czy+m10prASafJz2fbtMqChA9pRFrfAn1jmpcE2X6igzz7UyPvkq5ZvEzArT943u62
         AeWzUeVnc1JBFZ1arm7UO4S9Wz0W0yjXBC6GYAZBXLx6c8LRdad2zwgbqF0z7gPCSHHU
         q/5oo3jChgtLtv3ko0xWGuS9RpvDtbswYeygPb0mnpGyisAgzjo7GMk/Tmvjk9PA2gTn
         RGAiJiqYZXlHQngBQPmr0iCyy4e8kekoR5Kzl1eCBLvwPz4UQ73f6jvuM1Ht+QfHEJM8
         zSaZ8c3CYUHOtqTr+8nOfTgpZJBmE8vtFvRE4bpdpkTESnz1+zXcM0KlyjMMM13khJur
         vWXA==
X-Gm-Message-State: AC+VfDzyJ6KTC+4xHhPeszjHSfkqOQkInJ6gX8Z9yCxqOWbYlASeqf2T
        9aW205u9crw3aWhlcDQTrJkPjzWSkj8cKshYqB4TCJarV999XXrfFugg+Zmed82kSa+UI5fgMVJ
        z7gbp/rNWQTp+aHX+KbGX5hvx
X-Received: by 2002:adf:f3cd:0:b0:307:a4ee:4a25 with SMTP id g13-20020adff3cd000000b00307a4ee4a25mr7567575wrp.28.1684768720936;
        Mon, 22 May 2023 08:18:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5c5Jh29rHJWdlcSftb4ivtZudFaESkFZGZH5aeQjTlOaWyT+K5kG/FE0wh/FICWlng66JoQQ==
X-Received: by 2002:adf:f3cd:0:b0:307:a4ee:4a25 with SMTP id g13-20020adff3cd000000b00307a4ee4a25mr7567565wrp.28.1684768720646;
        Mon, 22 May 2023 08:18:40 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600012c900b003078354f774sm7963718wrx.36.2023.05.22.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:18:40 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v4] fs/buffer.c: update per-CPU bh_lru cache via RCU
In-Reply-To: <ZCXipBvmhAC1+eRi@tpad>
References: <ZCXipBvmhAC1+eRi@tpad>
Date:   Mon, 22 May 2023 16:18:39 +0100
Message-ID: <xhsmha5xwqtrk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/23 16:27, Marcelo Tosatti wrote:
> +/*
> + * invalidate_bh_lrus() is called rarely - but not only at unmount.
> + */
>  void invalidate_bh_lrus(void)
>  {
> -	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> +	int cpu, oidx;
> +
> +	mutex_lock(&bh_lru_invalidate_mutex);
> +	cpus_read_lock();
> +	oidx = bh_lru_idx;

> +	bh_lru_idx++;
> +	if (bh_lru_idx >= 2)
> +		bh_lru_idx = 0;
> +

You could make this a bool and flip it:
  bh_lru_idx = !bh_lru_idx

> +	/* Assign the per-CPU bh_lru pointer */
> +	for_each_online_cpu(cpu)
> +		rcu_assign_pointer(per_cpu(bh_lrup, cpu),
> +				   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
> +	synchronize_rcu_expedited();
> +
> +	for_each_online_cpu(cpu) {
> +		struct bh_lru *b = per_cpu_ptr(&bh_lrus[oidx], cpu);
> +
> +		bh_lru_lock();
> +		__invalidate_bh_lrus(b);
> +		bh_lru_unlock();

Given the bh_lrup has been updated and we're past the synchronize_rcu(),
what is bh_lru_lock() used for here?

> +	}
> +	cpus_read_unlock();
> +	mutex_unlock(&bh_lru_invalidate_mutex);

Re scalability, this is shifting a set of per-CPU-IPI callbacks to a single
CPU, which isn't great. Can we consider doing something like [1], i.e. in
the general case send an IPI to:

  rcu_assign_pointer() + call_rcu(/* invalidation callback */)

and in the case we're NOHZ_FULL and the target CPU is not executing in the
kernel, we do that remotely to reduce interference. We might want to batch
the synchronize_rcu() for the remote invalidates, maybe some abuse of the
API like so?

  bool do_local_invalidate(int cpu, struct cpumask *mask)
  {
          if (cpu_in_kernel(cpu)) {
              __cpumask_clear_cpu(cpu, mask);
              return true;
          }

          return false;
  }

  void invalidate_bh_lrus(void)
  {
          cpumask_var_t cpumask;

          cpus_read_lock();
          cpumask_copy(&cpumask, cpu_online_mask);
          on_each_cpu_cond(do_local_invalidate, invalidate_bh_lru, &cpumask, 1);

          for_each_cpu(cpu, &cpumask)
                  rcu_assign_pointer(per_cpu(bh_lrup, cpu),
                                             per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));

          synchronize_rcu_expedited();

          for_each_cpu(cpu, &cpumask) {
                  // Do remote invalidate here
          }
  }

[1]: https://lore.kernel.org/lkml/20230404134224.137038-4-ypodemsk@redhat.com/

>  }
>  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>
> @@ -1465,8 +1505,10 @@ void invalidate_bh_lrus_cpu(void)
>       struct bh_lru *b;
>
>       bh_lru_lock();
> -	b = this_cpu_ptr(&bh_lrus);
> +	rcu_read_lock();
> +	b = rcu_dereference(per_cpu(bh_lrup, smp_processor_id()));
>       __invalidate_bh_lrus(b);
> +	rcu_read_unlock();
>       bh_lru_unlock();
>  }
>
> @@ -2968,15 +3010,25 @@ void free_buffer_head(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(free_buffer_head);
>
> +static int buffer_cpu_online(unsigned int cpu)
> +{
> +	rcu_assign_pointer(per_cpu(bh_lrup, cpu),
> +			   per_cpu_ptr(&bh_lrus[bh_lru_idx], cpu));
> +	return 0;
> +}

What serializes this against invalidate_bh_lrus()? Are you relying on this
running under cpus_write_lock()?

