Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C3635B79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiKWLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiKWLVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:21:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774F258
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669202412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yntr30HDhqXyZ1w8rrZC4JD3zysTqY8HnCblqV5YZ4w=;
        b=bMFnXFDr1H8tLr325gNp8e3QjuIVL5Y3Ku8PoGHjGyrch+MSS+d9wzAfyZvHMpCRFCRTWq
        t/vwru1mvFup3moKC6+IaC/L2zO3a9OhIUPwiSmMPC7cPOOOipQGvxvxQG1v5cxGq6BuoT
        m5QyAA7u9+Xllg0PyvVFMx9he8LmKMw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-lvRuXjGkPk6_yrIYyLHd1w-1; Wed, 23 Nov 2022 06:20:07 -0500
X-MC-Unique: lvRuXjGkPk6_yrIYyLHd1w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64C57811E84;
        Wed, 23 Nov 2022 11:20:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-194-238.brq.redhat.com [10.40.194.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8816F4B3FC6;
        Wed, 23 Nov 2022 11:20:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Nov 2022 12:20:06 +0100 (CET)
Date:   Wed, 23 Nov 2022 12:20:03 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Petr Skocik <pskocik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix kill(-1,s) returning 0 on 0 kills
Message-ID: <20221123112002.GC32207@redhat.com>
References: <20221122161240.137570-1-pskocik@gmail.com>
 <20221122161240.137570-2-pskocik@gmail.com>
 <20221123103016.GA32207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123103016.GA32207@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23, Oleg Nesterov wrote:
>
> On 11/22, Petr Skocik wrote:
> >
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1600,20 +1600,18 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
> >  		ret = __kill_pgrp_info(sig, info,
> >  				pid ? find_vpid(-pid) : task_pgrp(current));
> >  	} else {
> > -		int retval = 0, count = 0;
> >  		struct task_struct * p;
> >
> > +		ret = -ESRCH;
> >  		for_each_process(p) {
> >  			if (task_pid_vnr(p) > 1 &&
> >  					!same_thread_group(p, current)) {
> >  				int err = group_send_sig_info(sig, info, p,
> >  							      PIDTYPE_MAX);
> > -				++count;
> >  				if (err != -EPERM)
> > -					retval = err;
> > +					ret = err; /*either all 0 or all -EINVAL*/
>
> The patch looks good to me, and it also simplifies the code.
>
> But I fail to understand the /*either all 0 or all -EINVAL*/ comment above..

OTOH... I think we do not really care, but there is another problem with
or without your patch. Suppose that group_send_sig_info() returns -EAGAIN,
then succeeds. So perhaps something like

		struct task_struct *p;
		int esrch = -ESRCH;

		ret = 0;
		for_each_process(p) {
			if (task_pid_vnr(p) > 1 &&
					!same_thread_group(p, current)) {
				int err = group_send_sig_info(sig, info, p,
							      PIDTYPE_MAX);
				if (err == 0)
					esrch = 0;
				else if (err != -EPERM)
					ret = err;
			}
		}
		ret = ret ?: esrch;

if we really want to make this code "100% correct". But again, I am not sure
this makes sense.

Oleg.

