Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F74675924
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjATPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjATPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B137B64
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674229980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igRXIH+KqtPVXJtkAoq115yd3HwhwLpxiRSIxfxWSGI=;
        b=hCI5YTcAC26AbTAcaxdkiW6KnCRw0YIyGeAdyTButJoJGaN6lwgny8vyPb+tn2me5OmmI6
        J16qGVo6jtfN7cDZImVeDM82gtESiE4HOtCI3qSzd7rzZWKxov9RKRQfOX4DplMcMpr3PY
        G8RWTMLEzqJFTi4vAgpNRV/yEXjiUEM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-mV5MoWCBNMOamsMcPzLjwQ-1; Fri, 20 Jan 2023 10:52:58 -0500
X-MC-Unique: mV5MoWCBNMOamsMcPzLjwQ-1
Received: by mail-qt1-f200.google.com with SMTP id r24-20020ac85e98000000b003b68b691996so2570306qtx.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igRXIH+KqtPVXJtkAoq115yd3HwhwLpxiRSIxfxWSGI=;
        b=oOFV7SypE1a3QoWhKbPQ72Hv4uLBhThMfXqcfg7XqrhlUFncgz8Mucmgdd1siElGyS
         hg5HQK8+MQpw4xeQFwltiQ0z/I7i1k63aGFf4SC64CDsYeM1iKVawDRXi9YgtG0BxXKJ
         9zz0NLBcbFzsKKAHwX0QuDT5ZVZo9/hN9uKjsihP9Tpx2GJpUunSIq4SYaG7HjZOkyjV
         uPPWIjegBm+7c7/EqPOOAv8w4HUNcr72KZ5H+o4kmcSRVyxDCaEe8Guh2i6G2He+R1hb
         nbPSxFgaOCSOU6Op4aOXa+n2jCzSD9X/xlZHiO6sDvEKr0wxaRmLGxlPUrGWKgLB2mw1
         qJOA==
X-Gm-Message-State: AFqh2koVkxq+lz+JzK8pi2fCIsvfJanQTJX6mYZFyzyJNPF5ly6ZnA56
        8YS0oPaHDkIGj6JqT7XtvXCcuy2/ELiMRcOmQyCt9M8DVL2Mwd9aQFDcuaNEsF4cm6wF78gWT6u
        1xIvaOd//DwfCFSmEGVnuDIna
X-Received: by 2002:ac8:4b47:0:b0:3b6:309e:dfdd with SMTP id e7-20020ac84b47000000b003b6309edfddmr19870935qts.22.1674229978211;
        Fri, 20 Jan 2023 07:52:58 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtdo7Hfy2es6zdIjkULHuEJSHDAOgEAmuVI0UTr9GypQCgiKhHLlF4vksDCI9Keu1CiG42pfQ==
X-Received: by 2002:ac8:4b47:0:b0:3b6:309e:dfdd with SMTP id e7-20020ac84b47000000b003b6309edfddmr19870913qts.22.1674229978005;
        Fri, 20 Jan 2023 07:52:58 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id fu28-20020a05622a5d9c00b003a7f3c4dcdfsm20707767qtb.47.2023.01.20.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:52:57 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        vishalc@linux.vnet.ibm.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, ritesh.list@gmail.com
Subject: Re: [RESEND PATCH] sched/debug: Put sched/domains files under the
 verbose flag
In-Reply-To: <20230119150758.880189-1-pauld@redhat.com>
References: <20230119150758.880189-1-pauld@redhat.com>
Date:   Fri, 20 Jan 2023 15:52:55 +0000
Message-ID: <xhsmh1qnpi4o8.mognet@vschneid.remote.csb>
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

On 19/01/23 10:07, Phil Auld wrote:
> The debug files under sched/domains can take a long time to regenerate,
> especially when updates are done one at a time. Move these files under
> the sched verbose debug flag. Allow changes to verbose to trigger
> generation of the files. This lets a user batch the updates but still
> have the information available.  The detailed topology printk messages
> are also under verbose.
>
> Discussion that lead to this approach can be found in the link below.
>
> Simplified code to maintain use of debugfs bool routines suggested by
> Michael Ellerman <mpe@ellerman.id.au>.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/

Small nits below, other than that:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> @@ -402,15 +440,23 @@ void update_sched_domain_debugfs(void)
>       if (!debugfs_sched)
>               return;
>
> +	if (!sched_debug_verbose)
> +		return;
> +
>       if (!cpumask_available(sd_sysctl_cpus)) {
>               if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
>                       return;
>               cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
>       }
>
> -	if (!sd_dentry)
> +	if (!sd_dentry) {
>               sd_dentry = debugfs_create_dir("domains", debugfs_sched);
>
> +		/* rebuild sd_sysclt_cpus if empty since it gets cleared below */
                           ^^^^^^^^^^^^^^
Nit: sd_sysctl_cpus

> +		if (cpumask_first(sd_sysctl_cpus) >=  nr_cpu_ids)

Use cpumask_empty() instead?

> +			cpumask_copy(sd_sysctl_cpus, cpu_online_mask);
> +	}
> +
>       for_each_cpu(cpu, sd_sysctl_cpus) {
>               struct sched_domain *sd;
>               struct dentry *d_cpu;
> --
> 2.31.1

