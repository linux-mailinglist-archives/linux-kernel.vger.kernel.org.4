Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A026166CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiKBQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKBQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:01:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3312BB20
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:01:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l9so11999543qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwlCCdTf5peRjA9UdgWv3tidaRoMW8GdJ7qWVu6/mpQ=;
        b=klk3CHlghwpcTSnxFenmxlF+94wvVJ41B276p+5LwLwthimJxA897yq85eitO6aX7l
         v9r78DtcJzs8vR1IaLm1mqLPwGo50YN5ZvsA9xP0mCP3XaM6kAMiwadNEfyizalpgEy6
         xpu/gQ6h1jDp5yNKpqqu97bUNooUtW3dy8rqI06GqcpWp1k+Tommq+Fdecr13d6nBG4a
         HlPzIBU0PkdPiMO/pu6z93gk8OkHW1JUwAQpikk0aV9fEx1RLHpZ62KpPbX3Fzz1JSNt
         Y8yj8QgJF4PbOmXe2muKlHyzTPiz6JzVapI4iOJkgTLQl0rPsJdJFsdmyH8upb1+vqqR
         ACQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwlCCdTf5peRjA9UdgWv3tidaRoMW8GdJ7qWVu6/mpQ=;
        b=n+lDAqdPXKq6sRhsy5Iq/nWfNQO1YURpxvkXpfE3p+vI0RyoTXQKEVHBqnsnrcPfJR
         hCC6OJVVb+JIpL0HIluvzHwqPXl5O/hZV7jhFNCcbfkiQ6vLdefq/3Q2+McRWWnZ4d8F
         msQhm6TSj+2obZsWpASboIIbNvNy7Hj7+v5pIwNl7ccbTI9EOUV4ckKfkialo4pXbNKj
         mfQ91thmwU7LhOflPE7b2lz2SrYP+lDWNMzXyrMPhilPoRUx/ZJVdOB2GTeUHPM4uzUe
         B+H1jzCJ3J2OsMsRlYmkdtczamLBdrm6icO6uv1sXY28RZub0GY2F+X/JThMxXDGlsyB
         tQ8w==
X-Gm-Message-State: ACrzQf1mOzhZtGpgvmITJEfpRWb9gvl1oCD1uucVUzDC2sQm+FMU65t/
        ygvV9v1rhhDABNmuM3h5BgRV6g==
X-Google-Smtp-Source: AMsMyM71i79h4m6uAcAPBmR6I+Ggmu3kDRaARfwlRupvZqKZ0lBCEAu8P0NHfif3Qu1mGGUg0tV7ng==
X-Received: by 2002:a05:620a:91d:b0:6fa:442d:9a72 with SMTP id v29-20020a05620a091d00b006fa442d9a72mr8035077qkv.487.1667404881673;
        Wed, 02 Nov 2022 09:01:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id e1-20020ac84b41000000b00398ed306034sm6725636qts.81.2022.11.02.09.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:01:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oqGB6-005EuR-KY;
        Wed, 02 Nov 2022 13:01:20 -0300
Date:   Wed, 2 Nov 2022 13:01:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Leonid Ravich <leonid.ravich@toganetworks.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Leon Ravich <lravich@gmail.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Message-ID: <Y2KUUHWdp1xV3AAA@ziepe.ca>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home>
 <Y2JqX3vC1mG/JDex@ziepe.ca>
 <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <Y2J4/NQMhRORqnZ0@ziepe.ca>
 <20221102101719.6cbcca6b@rorschach.local.home>
 <Y2J9lAqBvjjPUmJf@ziepe.ca>
 <20221102115947.000897fa@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102115947.000897fa@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:59:47AM -0400, Steven Rostedt wrote:
> On Wed, 2 Nov 2022 11:24:20 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > No, it doesn't muck with preemption, it will have some sleeping lock,
> > eg mlx5_ib_query_pkey() does a memory allocation as the first thing
> > 
> > It seems like a bug that calling kmalloc(GFP_KERNEL)/might_sleep()
> > from within a tracepoint doesn't trigger a warning?
> 
> Has nothing to do with tracepoints. You could call it a bug that it
> doesn't trigger a warning when preemption is disabled. But then again,
> it would if you enabled DEBUG_PREEMPT and possibly LOCKDEP too. So, I chalk
> this up to a lack of proper testing.

That makes sense, assuming it does trigger in those cases.

It is interesting nobody has run those tracepoints on a debug kernel.

Jason
