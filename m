Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1466C63CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCWJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCWJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C122101
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679564008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UvjK3G8PubwXqQtONySfIeDtd3meQ2XWO8kr4rkCdUw=;
        b=Zlw1Ha0OeDKk3ojOBCbTMc0J/NhGBylv+k2yRgK50nD+BJGInUxi4207Gu1mJf3s12qPZh
        Inqjqbw/GSJL+Ck4yjAiD9JJPzGFq+e9/iuVL1EeOvF4N0iU8GJD2l9U0jky+jxnPjYg1A
        JVTKvcvUhOYf29UpmZX41niy798HyGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-MvMdG8_EPNanqbYuyUhZow-1; Thu, 23 Mar 2023 05:33:27 -0400
X-MC-Unique: MvMdG8_EPNanqbYuyUhZow-1
Received: by mail-wm1-f71.google.com with SMTP id e5-20020a05600c4e4500b003edc5824521so746221wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679564006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvjK3G8PubwXqQtONySfIeDtd3meQ2XWO8kr4rkCdUw=;
        b=OWREMh57umTsozKznF/FbdZQ2D3M5HN1CjzgY2QJ/qaTHGQ5atTSQjNigjpx4t5kuk
         HaKv0Z9/WN/BUKuBHYEyzcdgxewiyvEvDM1vEclYUQ4W1phnEaGAkZ3E5o2q/9T1aVK+
         jlBlsPmckJ29wxBwL25/h4r504HQX5DQtInjihd7OoWV8jWEt0f8C3IJEgjPpoa+lXBu
         qgjiGVyjDXlgW8GU9D+ObswH/aXPiUna51meQwJTG21Mzv54SpPD6l+50ym3T/42CXsZ
         XPlWFA7zm/+DrUg5tXmGCxaZn4Acc1b0KZh35cDE/nv64HdJ00JVGyNHwNrkXhysI8yE
         TzcA==
X-Gm-Message-State: AO0yUKXBCz+Nyg9nbaw16pLyQDHbmK41SGz/yjYzRMo7PovlKqnT180j
        LR8XByeTXjSFcsZkn+y9s4T1P19LRg794OjwlGNJXOm8Yf/xUwgfAx9CmfIdxvi+eVqTQMNnFmo
        qXX+Lujooo36RB4Kyqy4AuPaj
X-Received: by 2002:a7b:c409:0:b0:3e2:201a:5bcc with SMTP id k9-20020a7bc409000000b003e2201a5bccmr1755000wmi.33.1679564006126;
        Thu, 23 Mar 2023 02:33:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set+dED/VZywkfBRbZ/TenSZ0T7kW9lQyYoxtjIFT5J6quinfNocd9Wx4xJUrnsA9R303Cqb0Rw==
X-Received: by 2002:a7b:c409:0:b0:3e2:201a:5bcc with SMTP id k9-20020a7bc409000000b003e2201a5bccmr1754978wmi.33.1679564005817;
        Thu, 23 Mar 2023 02:33:25 -0700 (PDT)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id z21-20020a1cf415000000b003ee3e075d1csm1328198wma.22.2023.03.23.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:33:25 -0700 (PDT)
Date:   Thu, 23 Mar 2023 10:33:22 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Qais Yousef <qyousef@layalina.io>, Wei Wang <wvw@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] sched/cpuset: Fix DL BW accounting in case
 can_attach() fails
Message-ID: <ZBwc4l0ZyyRQPiSP@localhost.localdomain>
References: <20230322135959.1998790-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322135959.1998790-1-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/03/23 14:59, Dietmar Eggemann wrote:
> I followed Longman's idea to add a `deadline task transfer count` into
> cpuset and only update the `dl task count` in cpuset_attach().
> 
> Moreover, I switched from per-task DL BW request to a per-cpuset one.
> This way we don't have to free per-task in case xxx_can_attach() fails.
> 
> The DL BW freeing is handled in cpuset_cancel_attach() for the case
> `multiple controllers and one of the non-cpuset can_attach() fails`.
> 
> Only lightly tested on cgroup v1 with exclusive cpusets so far.

This makes sense to me. Thanks for working on it!

Guess I might incorporate these in my (RFC) series and re-post the whole
lot?

Best,
Juri

