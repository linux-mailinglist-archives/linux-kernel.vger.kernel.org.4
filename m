Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64785F5811
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJEQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJEQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD207D1F9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664986461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8IFjZlZP/WQ78LWaXxVDrINKc4I9eLwNoWa4oc+Q8U=;
        b=DyN9n4amuGT4SbRZHy63sTzrZV3t14BxLnzqrjoAEBkkNrzSwQH0Rt6MQQfyzXFcwLWVK/
        Ap2AjdHIokk10UsEqKEG1j7SOsxVlSqMCqjSgLnTpE+hHKPOzpsPb7HVBtuJYv90/bSg3I
        600OQaz+iNhKPZ/1e3ndKTjvQ/dRoyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-160-IuDgR_6KOx2u3HHPpUeJmw-1; Wed, 05 Oct 2022 12:14:20 -0400
X-MC-Unique: IuDgR_6KOx2u3HHPpUeJmw-1
Received: by mail-wr1-f71.google.com with SMTP id i1-20020adfa501000000b0022cd1e1137bso5379761wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8IFjZlZP/WQ78LWaXxVDrINKc4I9eLwNoWa4oc+Q8U=;
        b=uRvw93Tf5uun378viRQdJpeM30MATDD3Oji0bdO96/1xaSce/t8tawa1VtyrY0BkEO
         cBtMsQcRJSIe0201H8G4b3TOMg5aI86Yg6UyqP5RUy0zHOIJ4z21M2+CEfJO1VRB3rJ5
         WPqbuzKs25aSZxYyi2Vy6F1mWSROmPqO8QKXg1mkEhYHQjKEFufzHIDS5ytM70vScWUu
         9uT5AUSyM196wFqVXqdiKcYVC0ltI+sPO+D1UMDlNxZjYIgk0RV4hgH+cMURKyqEHgJy
         NeeNZkeqfySjGGJDVgG+QH6pXGkPCskmeoHVTeuhpRG5g1zlutyKFXoGfWVl/n1VdItq
         97iA==
X-Gm-Message-State: ACrzQf1cR3L/q/V8FQHd9IqWDzETeFoiv3Ul43wL1X56wVd2uZ7qJcuc
        KNl6J25DQH5rPgtqmBpn9ef2DT/Bs0s0/4jwWFTTbn3bhzUQvLkQKmsP28mLYFLpfLRTOlSOGoV
        5Rxc+5D83jpQn3Xo2xWjiTEwf
X-Received: by 2002:a5d:5c08:0:b0:228:e139:43f3 with SMTP id cc8-20020a5d5c08000000b00228e13943f3mr351004wrb.396.1664986459307;
        Wed, 05 Oct 2022 09:14:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Ap+AkZUjQNOKuWLZsMO3FeanzD7owNw3uY2MOnJOOwA7JRKE7kP4/gxls+InRnf/RmtkN5A==
X-Received: by 2002:a5d:5c08:0:b0:228:e139:43f3 with SMTP id cc8-20020a5d5c08000000b00228e13943f3mr350996wrb.396.1664986459141;
        Wed, 05 Oct 2022 09:14:19 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id l128-20020a1c2586000000b003bd44dc524csm2324923wml.34.2022.10.05.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:14:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 4/4] workqueue: Unbind workers before sending them to
 exit()
In-Reply-To: <20221005145022.1695-1-hdanton@sina.com>
References: <20221004150521.822266-1-vschneid@redhat.com>
 <20221005010832.1934-1-hdanton@sina.com>
 <20221005145022.1695-1-hdanton@sina.com>
Date:   Wed, 05 Oct 2022 17:14:17 +0100
Message-ID: <xhsmh7d1e2qp2.mognet@vschneid.remote.csb>
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

On 05/10/22 22:50, Hillf Danton wrote:
> On 05 Oct 2022 12:13:17 +0100 Valentin Schneider <vschneid@redhat.com>
>
> Bound kworkers can be destroyed by the idle timer on a housekeeping CPU.
>
> Diff is only for thoughts.
>
> +++ b/kernel/workqueue.c
> @@ -1985,6 +1985,7 @@ fail:
>  static void destroy_worker(struct worker *worker)
>  {
>       struct worker_pool *pool = worker->pool;
> +	int cpu = smp_processor_id();
>
>       lockdep_assert_held(&pool->lock);
>
> @@ -1999,6 +2000,12 @@ static void destroy_worker(struct worker
>
>       list_del_init(&worker->entry);
>       worker->flags |= WORKER_DIE;
> +
> +	if (!(pool->flags & POOL_DISASSOCIATED) && pool->cpu != cpu) {
> +		/* send worker to die on a housekeeping cpu */
> +		cpumask_clear(&worker->task->cpus_mask);
> +		cpumask_set_cpu(cpu, &worker->task->cpus_mask);
> +	}
>       wake_up_process(worker->task);
>  }
>

The proper interface to play with that cpumask is set_cpus_allowed_ptr(),
which requires a sleepable context, hence the whole series.

