Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD706116B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJ1QBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJ1P7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:59:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE421CD6C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:58:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d26so13892954eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xr2CNsw+VY+dbet5pYw3oER8lbXOO+2VzqoPsHpdMI=;
        b=KhkLxBqfiFMHXECCShFAGZVJiXZW6+pBTKSgJlGaqwAQXWTPjqLBv9YWh8OjVv/+Mx
         cezH0PfN7bkIqQjRXdJpYhS4wQWs+j2prgc0/hEQKNoKFuDj73kTevLaUh1KTbWAxhF+
         YyJR/gPDjODa3qFLWqQ+64XL7XiglA1mZqUIh9W9xPrDOvGGzjaG+UXHlU+mbUcBerHr
         8k5gxP6SYS6q9dmhZHao0KXJMoMb0SMnq/TAz/IOC4Jcacex35pgBjKp7ihus91OjSid
         f1r7pRdwVhDDscDHsauqFOVu/lTZcspyO4Z9wgiNubrX9II3x+HT/X1iMqdyKFiawDmA
         C2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Xr2CNsw+VY+dbet5pYw3oER8lbXOO+2VzqoPsHpdMI=;
        b=uDwyCczc4Jm7GEMQEGhju2fI7PKYPPCv0X9HinzIbVRywwwE1a4DEyN4eEk+I4exyG
         P8FkBh1HOGVgVhtnsbBUdFeRfAfAg1F+NE2NcLUaTdK5FRMmw/5PPPy5RsOZES65j5Dl
         1iexrvPoTlj3TgiAguo4TW41a7IoIo6POMx1gWvSC5msxT3Mqj5P4gRvLYkyUJm2XlHU
         2OhI5inwvHfCErzOoVPTcohgSKBNN9W4v79DqEAMN7kq9BI0dgIhhyQ937qKmlXcxSaS
         7Lk7aEubyhVpvk/FjPMWvuLpgzVJWeHl0NerA8+OqXxJLWzmAGlAS3yHJP9eoW3CnBxZ
         CoZA==
X-Gm-Message-State: ACrzQf18xyoPv5T+iWStZhYg0HZ382QQ1z1ujvhWc7VNoMUEHtVZJ65v
        VkjQJYhWagYOGh5JOT2o8G8p+gz91TK46MyaN+DlSLChu6o49A==
X-Google-Smtp-Source: AMsMyM569TzZTM4irwGSuarUlt24Y6DZxt6SSBAo5Fiz5IQohK2zv7e3FaNQ4qlsnDS2NmVppAfYWbQNWNmvMEgJBjA=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr47792331ejc.719.1666972682791; Fri, 28
 Oct 2022 08:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com>
 <20221024224657.2917482-5-dionnaglaze@google.com> <31d7bd35-6b26-b7b8-0903-09c3d260d801@amd.com>
In-Reply-To: <31d7bd35-6b26-b7b8-0903-09c3d260d801@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Fri, 28 Oct 2022 08:57:51 -0700
Message-ID: <CAAH4kHa+-H6femVto=Jp2zCGaEesG4POpTdqtSCsCO_dx1phfA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] virt/coco/sev-guest: interpret VMM errors from
 guest request
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   static u32 vmpck_id;
> >   module_param(vmpck_id, uint, 0444);
> >   MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
> >
> > +static int rate_hz = 2;
>
> s/int/unsigned int/ to match uint below.
>

I'll change the uint to int, since the types in ratelimit_struct are int.

> > +module_param(rate_burst, uint, 0444);
> > +MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
> > +
> >   /* Mutex to serialize the shared buffer access and command handling. */
> >   static DEFINE_MUTEX(snp_cmd_mutex);
> >
> > @@ -305,9 +316,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
> >                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> >                               u32 resp_sz, __u64 *exitinfo2)
> >   {
> > +     unsigned int vmm_err;
> >       u64 seqno;
> >       int rc;
> >
> > +     might_resched();
> > +
>
> Not sure this is needed. This may call cond_resched() right away, so I
> don't think this is doing what you think it is (as I only see it used in
> scheduler code and spinlock code). Did you mean to use might_sleep()?

Rereading the docs about it, I'll remove it.

>
> >       /* Get message sequence and verify that its a non-zero */
> >       seqno = snp_get_msg_seqno(snp_dev);
> >       if (!seqno)
> > @@ -320,9 +334,35 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
> >       if (rc)
> >               return rc;
> >
> > +retry:
> > +     /*
> > +      * Rate limit commands internally since the host can also throttle, and
> > +      * we don't want to create a tight request spin that could end up
> > +      * getting this VM throttled more heavily.
> > +      */
> > +     if (!__ratelimit(&snp_dev->rs)) {
>
> This doesn't do any sleeping/delaying, it just returns a 0 or 1, so you
> could still cause a tight spin here. I guess that shouldn't be a problem
> is nothing else is ready to run. But maybe adding an msleep()/usleep()
> here based on the rate limit parameters (half the rate limit?) would be
> good so that the CPU isn't pegged while rating for the ratelimit to be
> satisified?
>

It looks like sleep_timeout_interruptible((rate_hz * HZ) / 2) could be
the appropriate solution for this.

> I'll let others chime in on that and see if it is appropriate.
>

Same, I'll wait until later Monday to send out v5.

> Thanks,
> Tom

Thanks for the reviews :)

-- 
-Dionna Glaze, PhD (she/her)
