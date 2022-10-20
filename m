Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF75606584
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJTQPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18C876A1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666282521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b1WN1oHs/R/WOYdwhyhp9dLQdWSmQvRGjrR6QDNMPz8=;
        b=TG7yhjAovzirIfpuhCAgyGDT1rZlbSdmQ+1GLF/H39CsWwb6hw/hpZK+6aU3JB4suT19/u
        jUNUR93G6t7FcRvDrNKb0pNsDHLkYAcchHbCu85oTGgcS5i9BttMjiQ2CvQZYeHMjvaF0k
        lRPvWI0InsqkpVqWpgvY0ilE04uBrI4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-bNdQBPJNO_-EwyxPCfipSw-1; Thu, 20 Oct 2022 12:15:20 -0400
X-MC-Unique: bNdQBPJNO_-EwyxPCfipSw-1
Received: by mail-io1-f71.google.com with SMTP id y4-20020a5e9204000000b006bbffbc3d27so16695937iop.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1WN1oHs/R/WOYdwhyhp9dLQdWSmQvRGjrR6QDNMPz8=;
        b=J+kpNXlDOFpJOD4/pyxhC6A9ZBa2JZVJo46/JERFLBixv5sfc47hSqALLpnfUaBrMY
         rjmTL6iLwOQY/daMMJ7HrUE9MmUNI+LowibILOcFeI51DtuFkxyAb44zvxbm/i4Kpc+s
         rvzzvYFfcwvZafXhtIuyQ/nxpWyJ3r5rYbFDkraIWuyFWpnHM1WJ4m1Eh/9w8VFjt9Et
         J+OhGUoVnktvN18dY7r61lhN44Nk6mlFhmaWZg4VvHKP+/F1X8NNXJ66TFVZTP18G6pC
         IYJ1aawq9pchDpOw2EpJOmZ62PXTxY6eBqnXLcB7tV27tcKg/H5dyfQie4Yi4vHLgJQs
         YNVg==
X-Gm-Message-State: ACrzQf0G+mCVzgkjG8lnlxVgkKmw0AC0qhxDBEw+ELRggRl+Yqk9A/cB
        uuB768H9jOdkCv2qnP3EujH73pNBdab7oWxxvjUFSdYkqFp0fOHSrW6V/ljjNaVvUiWTAtudc07
        o8dmmmaIXe61dQhBs2/oqSfYQ
X-Received: by 2002:a02:c8d7:0:b0:363:da23:bf8 with SMTP id q23-20020a02c8d7000000b00363da230bf8mr10939515jao.257.1666282514210;
        Thu, 20 Oct 2022 09:15:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4pMV8cgf4yyc6ji3q2u0JzUT2lH4SlTQrLRgven4sh2+e3qceyv3NCHb2gIAH3h/3kBT4PRw==
X-Received: by 2002:a05:622a:387:b0:394:7a0a:9584 with SMTP id j7-20020a05622a038700b003947a0a9584mr11870706qtx.60.1666282503087;
        Thu, 20 Oct 2022 09:15:03 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05622a1dc400b0039ccbf75f92sm6225927qtb.11.2022.10.20.09.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:15:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
In-Reply-To: <Y1FNcmLl678L/3Ah@localhost.localdomain>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-10-connoro@google.com>
 <xhsmhv8orgb59.mognet@vschneid.remote.csb>
 <CALE1s+ODz2FUJoSHcORa25kckk81qSHuZ6RSE6-k=s2gzQ+eOQ@mail.gmail.com>
 <xhsmhtu3zwxpt.mognet@vschneid.remote.csb>
 <Y1FNcmLl678L/3Ah@localhost.localdomain>
Date:   Thu, 20 Oct 2022 17:14:59 +0100
Message-ID: <xhsmho7u6wjy4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/22 15:30, Juri Lelli wrote:
> On 19/10/22 18:05, Valentin Schneider wrote:
>> One possible change here is to make the blocked chain migrate towards the
>> proxy rather than the owner - this makes scheduling priority considerations
>> a bit saner, but is bad towards the owner (migrating blocked tasks is
>> "cheap", migrating running tasks isn't).
>
> Plus we need to consider owner's affinity, maybe it can't really migrate
> towards proxy's CPU.
>

Right, "little" detail I forgot...

> It looks like in general we would like to perform load balancing
> decisions considering potential proxies attributes? Guess it might soon
> turn into a mess to implement, though.

I can't think of anything clever right now, but we do need something like
that to get "feature parity" with rtmutexes.

