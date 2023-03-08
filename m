Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460256B03E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjCHKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCHKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:20:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94FAB4829
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678270754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oj8X+oVpalTPTCAltQyKK/P/y4ZD06O85L5kpsJEEdg=;
        b=KywT+M53Y7Hxkgahi8VlEHIvh9MiJheCT1wqaplCWA+wRBbbNKLqkmNlRgouIullRKcpDP
        spWpCWJRVhTVXLEyBz+MCqCkdwbF4Yy+tjByILRBWFOjjpo7byUmQP7Xg1p89KpmBNZ8GS
        UW+j3jpH7LKJmqtMlPgMF1Z6JOMtQw0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-9n9raJXCNyKpGOWpSWsZfg-1; Wed, 08 Mar 2023 05:19:13 -0500
X-MC-Unique: 9n9raJXCNyKpGOWpSWsZfg-1
Received: by mail-qv1-f70.google.com with SMTP id s18-20020a0cf792000000b00572c04240f1so9005858qvn.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj8X+oVpalTPTCAltQyKK/P/y4ZD06O85L5kpsJEEdg=;
        b=TwbQXlG2PD/Ggo/FyYrJmVZJfFDOJynXQbdunIYjJLeEgLVISc12t+KkzDNBlN6UyO
         XnkX/Ec1dR87gRuZi1re6tG0rNswP9Vh/gAHDLq2IRiO8pckxyF9ksxqQOwYs+gZQGsK
         7O97/OuF0gJ2TQTnEzvYdvvPmWkvMBFltPkICDfLF90djuuQga5Qw14zhxyJ/zEe2PhA
         JbnXXwuSunx41+VnSX+Ev5HzDTS8Y4oaFt9gGO7SBWRm1NC+dmLiWLZvz/jwQepa1NL5
         p2wOZVnCnrxh1u9XSe9jVh2r9+aKxppUWzihWv+KGUmh0glS615BAOJ8y1Ma062k3jtc
         Rd8Q==
X-Gm-Message-State: AO0yUKXzE3L9bvsZ8wrSeFBQcR+E5bXUJ8zAK82tv7syzl9K/HrHIvya
        Zmz4eQwalxNmiuMaqvsPLplRedAwze/4eAIOfiuWOPeLha0FpCQE09w0nAd/8BKk2tBa35StwF5
        haZl5xuKp9i4lVYl2SOo6LIs2
X-Received: by 2002:a05:622a:296:b0:3b8:2ce4:3e9 with SMTP id z22-20020a05622a029600b003b82ce403e9mr2589372qtw.32.1678270753271;
        Wed, 08 Mar 2023 02:19:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/LL640GoLzKxvWa0khcVjeXxW1ACJtg1i5ABO802iOBx9DYnk4+UTJC6G6xesFIWMGPhLmHQ==
X-Received: by 2002:a05:622a:296:b0:3b8:2ce4:3e9 with SMTP id z22-20020a05622a029600b003b82ce403e9mr2589355qtw.32.1678270752972;
        Wed, 08 Mar 2023 02:19:12 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id d17-20020ac800d1000000b003b848759ed8sm11263243qtg.47.2023.03.08.02.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:19:12 -0800 (PST)
Date:   Wed, 8 Mar 2023 11:19:06 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <ZAhhGi55BkYkc3ss@localhost.localdomain>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170322.xthlso7jfkixlyex@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 17:03, Qais Yousef wrote:
> On 03/01/23 15:26, Juri Lelli wrote:
> > On 01/03/23 12:28, Qais Yousef wrote:
> > > On 03/01/23 08:31, Juri Lelli wrote:
> > 
> > ...
> > 
> > > > Not ignoring you guys here, but it turns out I'm quite bogged down with
> > > > other stuff at the moment. :/ So, apologies and I'll try to get to this
> > > > asap. Thanks a lot for all your efforts and time reviewing so far!
> > > 
> > > Np, I can feel you :-)
> > 
> > Eh. :/
> 
> I hope I did not offend. That was meant as no pressure, I understand.

No offence at all! I meant "we are all on the same boat it seems". :)

> > BTW, do you have a repro script of some sort handy I might play with?
> 
> Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
> the time around the call and trace_printk'ed the result.
> 
> I was working on a android phone which just suspends to ram if you turn the
> screen off and disconnect the usb.

Looks like I could come up with the following

https://github.com/jlelli/linux.git deadline/rework-cpusets
https://github.com/jlelli/linux/tree/deadline/rework-cpusets

which I don't think it's at a point that I feel comfortable to propose
as an RFC (not even sure if it actually makes sense), but it survived my
very light testing.

Could you please take a look and, if it makes some sense in theory, give
it a try on your end?

Thanks!
Juri

