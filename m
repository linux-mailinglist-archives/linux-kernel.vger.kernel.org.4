Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5755E9D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiIZJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiIZJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185521901B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664184009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Epy/7zqqrTfa8taaB6YCWyslKlnR9eGzWLHjaNGqb/g=;
        b=dQpdyxbtcMyiZN8ykQFwRu/272k4YbQ3WYlWIznqMlp7OCtFsYcVuggYqYohPPDR+9SvSn
        7IbcNP/vKh4SBMc5qyx97j48hxy2wOjWo+FXpAQauoyyHpDPyaBCcnq08H0ovAoWwradQs
        kLDp0vCiKj88IcFJQWa0clZ0bh4ppVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-tjGktGFzM7eLcCx113VqJw-1; Mon, 26 Sep 2022 05:20:07 -0400
X-MC-Unique: tjGktGFzM7eLcCx113VqJw-1
Received: by mail-wm1-f70.google.com with SMTP id r7-20020a1c4407000000b003b3f017f259so3887139wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Epy/7zqqrTfa8taaB6YCWyslKlnR9eGzWLHjaNGqb/g=;
        b=a9PxoiMjRLp+kfVj/5pXOINpxN/UGLiK9ausz/PtuTct0vpx/8W3ktWCjzP3Uv6LIT
         +KnD3OjdJ1kXWZex6MYXRaIF80xH+MkQHjqGTFRpPSKIaOt3Qbvg6Wx0izFO+Tul8dju
         yP4UjRo2KbCOMqoFPY9qMM7KAVYDfwWYV+B/xE/86A96pjFP59a893DT4bEKIb4gGlYU
         lYnLBhiaENJK3xJ/Fozw3jZxaMcRJXRa1e0Wq5045e0QqdjAoERBQiKj7Qorl8pezFU2
         4hH3PuEIVOil6N+Toau7IG0+jGEs/vRQBoJJfrrMAtPEN3vI/aOP6WgIvvWpAytJo0UN
         kKxg==
X-Gm-Message-State: ACrzQf2iJmpyhkQgTl2VlSrBYGkjT1hfvfqBUfh1CKoMDBRqWHWyjHQ+
        rEiu5yrjmiaa9qfoZ0IlCakCt0WOAz/3nsIfpTSBYRQhu82EqcJl2a1OEd5af2d+hA1cV31ox+p
        YIGpu3GrHl/XQOAiPyS16z1A=
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id p34-20020a05600c1da200b003b4856a162cmr20744541wms.28.1664184006648;
        Mon, 26 Sep 2022 02:20:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4O10ud01X05NuL5j619KmQloVdO1h/gePTEO4YRt3KfnyyXZVXaqo5TEcdt+SaCSs3uR5o8A==
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id p34-20020a05600c1da200b003b4856a162cmr20744517wms.28.1664184006400;
        Mon, 26 Sep 2022 02:20:06 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b002250c35826dsm13750502wrx.104.2022.09.26.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:20:05 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:20:04 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     frederic@kernel.org, mtosatti@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 5/5] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220926092004.to2zrcxjz5oj3lid@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220925010511.1482-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220925010511.1482-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-09-25 09:05 +0800, Hillf Danton wrote:
> On 24 Sep 2022 16:24:41 +0100 Aaron Tomlin <atomlin@redhat.com> wrote:
> > 
> > In the context of the idle task and an adaptive-tick mode/or a nohz_full
> > CPU, quiet_vmstat() can be called: before stopping the idle tick,
> > entering an idle state and on exit. In particular, for the latter case,
> > when the idle task is required to reschedule, the idle tick can remain
> > stopped and the timer expiration time endless i.e., KTIME_MAX. Now,
> > indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
> > counters should be processed to ensure the respective values have been
> > reset and folded into the zone specific 'vm_stat[]'. That being said, it
> > can only occur when: the idle tick was previously stopped, and
> > reprogramming of the timer is not required.
> > 
> > A customer provided some evidence which indicates that the idle tick was
> > stopped; albeit, CPU-specific vmstat counters still remained populated.
> > Thus one can only assume quiet_vmstat() was not invoked on return to the
> > idle loop.
> 
> Why did housekeeping CPUs fail to do their works, with this assumption
> put aside?

Hi Hillf,

I'm not sure I understand your question.

In this context, when tick processing is stopped, delayed work is not going
to be handled until the CPU exits idle.


Kind regards,

-- 
Aaron Tomlin

