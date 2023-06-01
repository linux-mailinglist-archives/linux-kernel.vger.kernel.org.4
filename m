Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808371F33B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFATxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFATxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:53:49 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DBBD1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:53:47 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-456f7ea8694so358237e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685649226; x=1688241226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3wsMJdspm7z8NQJJLLZwkqA93PAgwpcnaWodZ7jv3E=;
        b=zyyOiaeKEXDVRnfiSYoFMNi6zsJHqBMzLi1N71yQ7rl7aeNEFHJXtP/mYtCzWz4vS4
         xsz4tLWaE8JItcAX+DEptMCyTHfeB9DRdmrgQlGvcnH6Yl/FDqrvnM7uIBOc57vAd36K
         893GToJbh29EIbLSuehhEcEzgR44PkZ4HJ6WbDP5o9bnyLxjQLoqrSBeaSn8POUq+7B+
         +mW6QF5qavI2dyw2VQsbJ8bHGPBZdxwt9/ZLNlul87Bxzps2UybEE9KXZqNJbAPlyNZL
         exbRvpQrRHE2RtkiVYlsJLqQ5c7NZKsHEGeKJBQa++X3ICWdJXUyXTTjBt7iNaSO80G8
         /3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685649226; x=1688241226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3wsMJdspm7z8NQJJLLZwkqA93PAgwpcnaWodZ7jv3E=;
        b=LCShVfpkr/f21qDKKhwq9tM/08b5jdk8W64Pv1DQ3FgFQmygKv9La2QALTeDpOyJwK
         wEXAhmIb5YzXpGfQKsN3PsSp6WuXvSdpWZmgPjUSbBg0DCM6uBLAwyE7yM+evvvDjS0O
         lGAFDkVb/WECrimwg7KCwCdcGTcPmg6AqEj1WarGDZCuozrgaON6UjYp6TduSfIWB6h8
         O940FPkQOanVefRJO5aTZXq+mQ8eHcquv2lF+XGqvsfFx9Cbc3v70+feKc5viXJXasSq
         J6RNc0vLNCoD5QYfLV+uPpNZGxmlMCMutsktL86oEFoUKA1bB1dlldRHbcdAwILptyXo
         cFlQ==
X-Gm-Message-State: AC+VfDzAWK7iNmcEgt5fZZWLH/GkukPYdm2+qRnSewUO9rI8TLBXD5XM
        3DDJN25MHodqImeun6hff6yIaQ==
X-Google-Smtp-Source: ACHHUZ7JzeVdZ8ci8HY2hlPjcJMvaslhq2x8FpwT0K7+0s6RYbA1IYwmjIxMrtIVJi7HXqHX+Euxfg==
X-Received: by 2002:a1f:c158:0:b0:45e:bb34:e43d with SMTP id r85-20020a1fc158000000b0045ebb34e43dmr1126947vkf.15.1685649226593;
        Thu, 01 Jun 2023 12:53:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id q14-20020ac8450e000000b003e4f1b3ce43sm8041867qtn.50.2023.06.01.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 12:53:46 -0700 (PDT)
Date:   Thu, 1 Jun 2023 15:53:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Clarify usage of memory limits
Message-ID: <20230601195345.GB157732@cmpxchg.org>
References: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
 <e6ae97f4-cdae-e655-d118-a11b3d679fd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ae97f4-cdae-e655-d118-a11b3d679fd6@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 03:15:28PM -0400, Waiman Long wrote:
> On 6/1/23 14:38, Dan Schatzberg wrote:
> > The existing documentation refers to memory.high as the "main mechanism
> > to control memory usage." This seems incorrect to me - memory.high can
> > result in reclaim pressure which simply leads to stalls unless some
> > external component observes and actions on it (e.g. systemd-oomd can be
> > used for this purpose). While this is feasible, users are unaware of
> > this interaction and are led to believe that memory.high alone is an
> > effective mechanism for limiting memory.
> > 
> > The documentation should recommend the use of memory.max as the
> > effective way to enforce memory limits - it triggers reclaim and results
> > in OOM kills by itself.
> 
> That is not how my understanding of memory.high works. When memory usage
> goes past memory.high, memory reclaim will be initiated to reclaim the
> memory back. Stall happens when memory.usage keep increasing like by
> consuming memory faster than what memory reclaim can recover. When
> memory.max is reached, OOM killer will then kill off the tasks.

This was the initial plan indeed: Slow down the workload and thus slow
the growth; hope that the workload recovers with voluntary frees; set
memory.max as a safety if it keeps going beyond.

This never panned out. Once workloads are stuck, they might not back
down on their own. By increasingly slowing growth, it becomes harder
and harder for them to reach the memory.max intervention point.

It's a very brittle configuration strategy. Unless you very carefully
calibrate memory.high and memory.max together with awareness of the
throttling algorithm, workloads that hit memory.high will just go to
sleep indefinitely. They require outside intervention that either
adjusts limits or implements kill policies based on observed sleeps
(they're reported as pressure via psi).

So the common usecases today end up being that memory.max is for
enforcing kernel OOM kills, and memory.high is a tool to implement
userspace OOM killing policies.

Dan is right to point out the additional expectations for userspace
management when memory.high is in used. And memory.max is still the
primary, works-out-of-the-box method of memory containment.
