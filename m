Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D29675983
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjATQH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjATQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0393929A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674230801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h34pQaaNc3Py6uCbKcESZyQQ/4GYsCvU9GfSkH8JUgE=;
        b=AMGLwJ2z+tVg2+ulenhbIY/Diaw/VmbtRyx+YzU3xSf370fWI4s8ta7Q8Niu8GsDEeMdy7
        qW6wFNQv5ylGp5cOH7ON9VH0nW2Okahqj6kqokFtm26VmMrxut6FwCx7FFGwFMkJK8MUGQ
        VDPVbaSVsroqZ0WoSTDTBtWnqx2FTOY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-7y_Iflm6NJGEHzm2ve_kwA-1; Fri, 20 Jan 2023 11:06:38 -0500
X-MC-Unique: 7y_Iflm6NJGEHzm2ve_kwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7144B3C1834F;
        Fri, 20 Jan 2023 16:06:37 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08558C15BAE;
        Fri, 20 Jan 2023 16:06:36 +0000 (UTC)
Date:   Fri, 20 Jan 2023 11:06:35 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, vishalc@linux.vnet.ibm.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, ritesh.list@gmail.com
Subject: Re: [RESEND PATCH] sched/debug: Put sched/domains files under the
 verbose flag
Message-ID: <Y8q8Cz6B5NpAt0NW@lorien.usersys.redhat.com>
References: <20230119150758.880189-1-pauld@redhat.com>
 <xhsmh1qnpi4o8.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1qnpi4o8.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:52:55PM +0000 Valentin Schneider wrote:
> On 19/01/23 10:07, Phil Auld wrote:
> > The debug files under sched/domains can take a long time to regenerate,
> > especially when updates are done one at a time. Move these files under
> > the sched verbose debug flag. Allow changes to verbose to trigger
> > generation of the files. This lets a user batch the updates but still
> > have the information available.  The detailed topology printk messages
> > are also under verbose.
> >
> > Discussion that lead to this approach can be found in the link below.
> >
> > Simplified code to maintain use of debugfs bool routines suggested by
> > Michael Ellerman <mpe@ellerman.id.au>.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/
> 
> Small nits below, other than that:
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> 
> > @@ -402,15 +440,23 @@ void update_sched_domain_debugfs(void)
> >       if (!debugfs_sched)
> >               return;
> >
> > +	if (!sched_debug_verbose)
> > +		return;
> > +
> >       if (!cpumask_available(sd_sysctl_cpus)) {
> >               if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
> >                       return;
> >               cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
> >       }
> >
> > -	if (!sd_dentry)
> > +	if (!sd_dentry) {
> >               sd_dentry = debugfs_create_dir("domains", debugfs_sched);
> >
> > +		/* rebuild sd_sysclt_cpus if empty since it gets cleared below */
>                            ^^^^^^^^^^^^^^
> Nit: sd_sysctl_cpus
> 
> > +		if (cpumask_first(sd_sysctl_cpus) >=  nr_cpu_ids)
> 
> Use cpumask_empty() instead?

Heh, I didn't find that when I looked somehow :)  Yes, that's what this check
is doing. I'll fix these in a quick v2.


Thanks!


Cheers,
Phil



> 
> > +			cpumask_copy(sd_sysctl_cpus, cpu_online_mask);
> > +	}
> > +
> >       for_each_cpu(cpu, sd_sysctl_cpus) {
> >               struct sched_domain *sd;
> >               struct dentry *d_cpu;
> > --
> > 2.31.1
> 

-- 

