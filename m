Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630FE6048A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiJSOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiJSOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB3E18B48A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666186904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/ejTOn5apSyXH3oKsqag9ewPFfVKrJTc7t7+ljEoJ0=;
        b=DgO+mH7fT2aExiMVSg02X+x7NrDSmeUpdJLhsDxESnjB3IIJLfo77m2FnmdsAlkttoKTRP
        65Q/VfxZWbj8Zm/tR6EtrKkGhfWtNkGCM3CN1H0smkrwOkE/8yul8/ERUYrxvFu0aUuaNu
        vSNx+MdCY7IpfWvzRlAo32hfJJFNv9s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-84-DH7D2Tj_OymtCnr3a-0EXg-1; Wed, 19 Oct 2022 09:41:43 -0400
X-MC-Unique: DH7D2Tj_OymtCnr3a-0EXg-1
Received: by mail-qt1-f199.google.com with SMTP id c11-20020ac87dcb000000b0039cdb815f3bso9700166qte.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/ejTOn5apSyXH3oKsqag9ewPFfVKrJTc7t7+ljEoJ0=;
        b=L+WhZ48RcnflV2xRmVaPUqkT5Ei2QluLxSVVXY8ioTQtqPT6yTHDv6xnPurd6ARN3m
         baXWYvyvoNLUZcwxC1/I98jguIDwtxOzXkBd/p+MlkeNMjVhscQoyJmIuMmRVMf2sjvX
         p04pKXKZlcTZ06+aLx4UDU19Z78NnBObOHvCIKuYPBkSh9Gq2TfqPwGbDP5YcHhyVSI0
         3ZMxh/1PKGFRfiarVLJ723Ukp/y+Imzwad/iKtfZ9FqUUYs9yDa7axMDo1rmH1/EeT6a
         BU6nQJ4J+lKc8+r94rzVTybZ5h9ukIdlf3NED8lufPnZNL33GuxAsscAM7Xvr8EzR4On
         +4Cw==
X-Gm-Message-State: ACrzQf3ovho1Sbh459kVyCQOuLyfK70mojUm4VDLPoo7girwYShCgXj+
        DDaRv7wMSpmlp4CF0utBmAG4Uogach1t3Mt4WBw88Cj2HsS5o61yXBI0Fwe5ozID/c6J7RrBWeI
        23XOnABOz1szUie0OTeBE4HN9
X-Received: by 2002:a05:620a:40c9:b0:6ed:562d:ee0 with SMTP id g9-20020a05620a40c900b006ed562d0ee0mr5586568qko.750.1666186902332;
        Wed, 19 Oct 2022 06:41:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Opfqij/l061f2ilWXn7894+tZ7vznSjddIJdEOD/gnA79BitcyIF8kIWJBCTB8OPsZNydgQ==
X-Received: by 2002:a05:620a:40c9:b0:6ed:562d:ee0 with SMTP id g9-20020a05620a40c900b006ed562d0ee0mr5586529qko.750.1666186902010;
        Wed, 19 Oct 2022 06:41:42 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.101])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006aedb35d8a1sm4832412qkp.74.2022.10.19.06.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:41:41 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:41:29 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <Y0/+ieCymugrjheC@localhost.localdomain>
References: <20221019114357.yipijpetxz7ns5aq@airbuntu>
 <F9BCD313-15BA-429C-B50C-1391DDC1239B@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F9BCD313-15BA-429C-B50C-1391DDC1239B@joelfernandes.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 08:23, Joel Fernandes wrote:
> 
> 
> > On Oct 19, 2022, at 7:43 AM, Qais Yousef <qyousef@layalina.io> wrote:
> > 
> > ﻿On 10/17/22 02:23, Joel Fernandes wrote:
> > 
> >> I ran a test to check CFS time sharing. The accounting on top is confusing,
> >> but ftrace confirms the proxying happening.
> >> 
> >> Task A - pid 122
> >> Task B - pid 123
> >> Task C - pid 121
> >> Task D - pid 124
> >> 
> >> Here D and B just spin all the time. C is lock owner (in-kernel mutex) and
> >> spins all the time, while A blocks on the same in-kernel mutex and remains
> >> blocked.
> >> 
> >> Then I did "top -H" while the test was running which gives below output.
> >> The first column is PID, and the third-last column is CPU percentage.
> >> 
> >> Without PE:
> >>  121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (task C)
> >>  123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task B)
> >>  124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task D)
> >> 
> >> With PE:
> >>  PID
> >>  122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (task A)
> >>  121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task C)
> >>  123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task B)
> >>  124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task D)
> >> 
> >> With PE, I was expecting 2 threads with 25% and 1 thread with 50%. Instead I
> >> get 4 threads with 25% in the top. Ftrace confirms that the D-state task is
> >> in fact not running and proxying to the owner task so everything seems
> >> working correctly, but the accounting seems confusing, as in, it is confusing
> >> to see the D-state task task taking 25% CPU when it is obviously "sleeping".
> >> 
> >> Yeah, yeah, I know D is proxying for C (while being in the uninterruptible
> >> sleep state), so may be it is OK then, but I did want to bring this up :-)
> > 
> > I seem to remember Valentin raised similar issue about how userspace view can
> > get confusing/misleading:
> > 
> >    https://www.youtube.com/watch?v=UQNOT20aCEg&t=3h21m41s
> 
> Thanks for the pointer! Glad to see the consensus was that this is not
> acceptable.
> 
> I think we ought to write a patch to fix the accounting, for this
> series. I propose adding 2 new entries to proc/pid/stat which I think
> Juri was also sort of was alluding to:
> 
> 1. Donated time.
> 2. Proxied time.

Sounds like a useful addition, at least from a debugging point of view.

> User space can then add or subtract this, to calculate things
> correctly. Or just display them in new columns. I think it will also
> actually show how much the proxying is happening for a use case.

Guess we'll however need to be backward compatible with old userspace?
Probably reporting the owner as running while proxied (as in the
comparison case vs. rtmutexes Valentin showed).

