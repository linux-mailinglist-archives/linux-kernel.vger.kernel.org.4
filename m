Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA256A8AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCBVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBVDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E227D44
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677790882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68hVvuNII7UySVqdF6okTR6mypxI58Mkyx++AN+Buts=;
        b=Wst88w666+GRWa2SM6q9ThaXa9T1VnsW9S7T57EBEjg6n/7Eozk1csgJZd7++2Yx1xaPxo
        GRrippFYbz+XxQUY+ILXw0VbSip6wASSA8jb1yCOwssZ1hqo7Ell44SackvFbFOvJEsgHm
        +/AUv5G67ksTJZKmQtzb7r5wfpFgG+o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-aC1RrzXsPeuuMM9_uERHWA-1; Thu, 02 Mar 2023 16:01:11 -0500
X-MC-Unique: aC1RrzXsPeuuMM9_uERHWA-1
Received: by mail-qt1-f197.google.com with SMTP id g20-20020ac870d4000000b003b9c1013018so309832qtp.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677790870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68hVvuNII7UySVqdF6okTR6mypxI58Mkyx++AN+Buts=;
        b=8RE2KlOOFcs32QTROP7O3hrMHwgMcyVY2HkCmIeZMuPv0loIjhZfk7NZZYBWaMMfNK
         oEwbjBowe4z3sMrwr97ZuWUqN6wi3+QmGPzrQOm7mTSRPBgxkHaxs9+HVeXdBKeH4q+5
         49ct+yQwoSFA+Nyj/MoFBz1tshB1zvrxunOWduoOINE8SMrjHIU7An5M2sMjrk1+vRwJ
         v69/4zXVH5GWPU5RWqM2W15i4eIBnzDYefBKydCcgkeQwnXqAp2KXkTqxQu/ywnxpXSj
         vq94uLt4uga5MCaUnu0u1rUn0eTiHRxfsi/aUl8cX3avBMrky4n0TxbbsbASGAfS1Vsh
         G4Rw==
X-Gm-Message-State: AO0yUKVgPaDun8ahMASP9g/l9Eo1EO4Nw5MaCm3KCH7OpnSYqwFW9GNQ
        ko9MlYWyqMT6LLSJi9Szr6uIFSqn9lCULeE3ctoi3gQCDLg5QUxIb7AjtTFiLbaYvBrPDUKW7ef
        Q+yWMcuYL22+c3VmBHGZHMr3P8A3MUQ==
X-Received: by 2002:a05:622a:1391:b0:3bf:c38c:1d6c with SMTP id o17-20020a05622a139100b003bfc38c1d6cmr19756222qtk.2.1677790870349;
        Thu, 02 Mar 2023 13:01:10 -0800 (PST)
X-Google-Smtp-Source: AK7set84DR6At0AqCEYfzBCgau6wBISij6DWtBRh9Re0wFHCqoyD80hktYpaO3sgfY0al6wWNRDkQA==
X-Received: by 2002:a05:622a:1391:b0:3bf:c38c:1d6c with SMTP id o17-20020a05622a139100b003bfc38c1d6cmr19756119qtk.2.1677790869559;
        Thu, 02 Mar 2023 13:01:09 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 73-20020a370c4c000000b007423ccd892csm397038qkm.47.2023.03.02.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:01:09 -0800 (PST)
Date:   Thu, 2 Mar 2023 16:01:07 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/11] mm/vmstat: switch vmstat shepherd to flush
 per-CPU counters remotely
Message-ID: <ZAEOk7GdJ0c8NS+y@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.901518530@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209153204.901518530@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:02:00PM -0300, Marcelo Tosatti wrote:
> +#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> +/* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
> +static void vmstat_shepherd(struct work_struct *w)
> +{
> +	int cpu;
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		cpu_vm_stats_fold(cpu);

Nitpick: IIUC this line is the only change with CONFIG_HAVE_CMPXCHG_LOCAL
to replace the queuing.  Would it be cleaner to move the ifdef into
vmstat_shepherd, then, and keep the common logic?

> +		cond_resched();
> +	}
> +	cpus_read_unlock();
> +
> +	schedule_delayed_work(&shepherd,
> +		round_jiffies_relative(sysctl_stat_interval));
> +}
> +#else
>  static void vmstat_shepherd(struct work_struct *w)
>  {
>  	int cpu;
> @@ -2026,6 +2043,7 @@ static void vmstat_shepherd(struct work_
>  	schedule_delayed_work(&shepherd,
>  		round_jiffies_relative(sysctl_stat_interval));
>  }
> +#endif
>  
>  static void __init start_shepherd_timer(void)
>  {
> 
> 
> 

-- 
Peter Xu

