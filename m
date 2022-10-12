Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE45FC339
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJLJqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJLJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87744A3F51
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665567999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YfsXCwTcSggyX7tuAnY2CtFIQ9nALKDQL/d2xvVqOBk=;
        b=DaYjFAJUUK6KMfulpUFDxEubPJ2Xaql/QhkGQS3jc+guMhOMr5wgYc8cdUg7l/1y74rbUS
        je6/k2uctMGhFT+xSLh/hGZsAJzo+cSwGaF/oHhJnvoiTQXpDf5gSTqCgd2zHtJ7wkyUot
        1h/upa+ZTpwFhIK0wBeGiS9T875Lf+s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-Duc00O_HOqyRvo5y6ye90A-1; Wed, 12 Oct 2022 05:46:38 -0400
X-MC-Unique: Duc00O_HOqyRvo5y6ye90A-1
Received: by mail-qt1-f199.google.com with SMTP id n11-20020ac8674b000000b0039c9e248175so2546510qtp.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 02:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfsXCwTcSggyX7tuAnY2CtFIQ9nALKDQL/d2xvVqOBk=;
        b=0fM2VFts5yShz2YS0SfEMUCefxRYAFhZtRpGwfT0CTdSFNtUl+6tPyHrBwTxN1TDj6
         gW4CeQ3If882QEKDXzVNXIYFGCrc5ua/e7+J9vYzCbvnCTyvrtaK2v87eNR4sgdlm68r
         grQGgeeTzk+b5FNUOyhiPNKJg1qzLgktwRvcLZPsAweYw1kGopPlBBc8uKdbUGza6iZw
         nDLOKHzXOropJfgMwgz3H4Gp85eLdgoNKJPyF4uV+ZXQe2S1CWr1VzbEAHVCvt8m0JTv
         5ShGw4XLLA4iMg2GOaQRS33tjQTJkKNFN3DqyIXc29EHfkV/QxUnN8PbgGDtzTEF1bql
         UEAQ==
X-Gm-Message-State: ACrzQf3mhKZnYui64ouMI+tZAGCYuyByCT/NnsN8z0fpNYK3zwV/z1rH
        8fDcgY8mX4ElTBSUXpT1WM0AoRkIWwPu45HgpIeW+zpx9zwSxD4RV5epufSI5tpz7DjO9E+J8P9
        Fd7Tw/MXkhIenHG/7gLl3kh8y
X-Received: by 2002:a37:65c1:0:b0:6ee:9097:9ce3 with SMTP id z184-20020a3765c1000000b006ee90979ce3mr3418775qkb.620.1665567997630;
        Wed, 12 Oct 2022 02:46:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7IbP9QpkDA3jmDDRVyMxAGQ7tjY8Kcqrh5p5rLXHpHhVZdnmtnF8Z4Qbia42uCvUHPiB+UWw==
X-Received: by 2002:a37:65c1:0:b0:6ee:9097:9ce3 with SMTP id z184-20020a3765c1000000b006ee90979ce3mr3418760qkb.620.1665567997320;
        Wed, 12 Oct 2022 02:46:37 -0700 (PDT)
Received: from localhost.localdomain ([151.29.60.69])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b006ecdfcf9d81sm7480168qkm.84.2022.10.12.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:46:36 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:46:29 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0aM9T600RUlR8PI@localhost.localdomain>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
 <Y0YeUhDZWb49mpLo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0YeUhDZWb49mpLo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/22 01:54, Joel Fernandes wrote:

...

> > +migrate_task:
> > +	/*
> > +	 * The blocked-on relation must not cross CPUs, if this happens
> > +	 * migrate @p to the @owner's CPU.
> > +	 *
> > +	 * This is because we must respect the CPU affinity of execution
> > +	 * contexts (@owner) but we can ignore affinity for scheduling
> > +	 * contexts (@p). So we have to move scheduling contexts towards
> > +	 * potential execution contexts.
> > +	 *
> > +	 * XXX [juril] what if @p is not the highest prio task once migrated
> > +	 * to @owner's CPU?
> 
> Then that sounds like the right thing is happening, and @p will not proxy()
> to @owner. Why does @p need to be highest prio?

No, indeed. I (now :) don't think the above is a problem.

> > +	 *
> > +	 * XXX [juril] also, after @p is migrated it is not migrated back once
> > +	 * @owner releases the lock? Isn't this a potential problem w.r.t.
> > +	 * @owner affinity settings?
> 
> Juri, Do you mean here, '@p affinity settings' ?  @p's affinity is being
> ignored right?

Yeah, @p affinity.

> > +	 * [juril] OK. It is migrated back into its affinity mask in
> > +	 * ttwu_remote(), or by using wake_cpu via select_task_rq, guess we
> > +	 * might want to add a comment about that here. :-)
> 
> Good idea!

Connor, maybe you can add such a comment in the next version? Thanks!

> I am also wondering, how much more run-queue lock contention do these
> additional migrations add, that we did not have before. Do we have any data
> on that? Too much migration should not negate benefits of PE hopefully.

Looks like this is a sensible thing to measure.

Best,
Juri

