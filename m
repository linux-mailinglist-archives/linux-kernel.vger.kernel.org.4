Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABB36B397D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCJJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCJJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:00:57 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3234103EC6;
        Fri, 10 Mar 2023 00:55:06 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t14so4562120ljd.5;
        Fri, 10 Mar 2023 00:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678438505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edHnODkVWzD+JR+bIoyydgYcG1zz8EnEa8mgd61cqd4=;
        b=nmn+F3bhghEzrDjK+rq8mJoQDiXrzHkgCqz3pHyVPvaFeJq8qRdE8ugHF3IJEigW5V
         IwiItpBnhJ7WbwRrgw/hSRgAfWk0tHLzpPk/ARjx4zAcm4qfOsU2exfOl0qxXmYkiWxT
         GuY3a+yrqrQT9Cm4kAqU9JTxOpjEr8drlhImeOH5O77f9YNpnC9MyDwkUsk0Hut+0V6U
         VJBgwOI75xKOjvLFlreqmNsXM0BPuXwvWA9CzrVpxCFoNkXxYRdkrlwsHVtJZnQIQKzP
         frfdAjA4Ojtsu7sA+BHGZu2NS49gC7N3fG8VyMwPjglXqCmb/ANq6UTnRWLMwmo86A2K
         xVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edHnODkVWzD+JR+bIoyydgYcG1zz8EnEa8mgd61cqd4=;
        b=0NrD0ZZhJtjwCme+pZgaOWBRTiEGUXtIiM76Wh8WxXtvW3PXX2rZr7FFwcaoWnqhv5
         Rdv3PEUlUKMnSiGjqqZUkBzRl5SaKAChercigmAOto02Y4QmklyHhwZMza3/Gxe8rTOo
         grIH9tIMJ9Xg3+OSjdpOxYpgI4/GbgQPitJc6AItfZs2x8KMZ1IusgltOlxSJgmBmOoK
         /SRzF2ITpi422PfaFUuNKY2p2kgfgipNP8/89/2ts4gTaqP/JNsskpB0W+ITTxWNqrYw
         B/iw9jHfWccTuSYVf6ELapz+RL5ZOjzH2WoknN9CE6wpsnIIJDh+DB8EXmPp3j3iVz1r
         RNzg==
X-Gm-Message-State: AO0yUKWKrFaJ8FRIBP8iRk0H0+6MRab3ygcAvjuwOvyHzyPqTcLaQZuE
        e+Pm2KslN2jV9It2NNOmJh8=
X-Google-Smtp-Source: AK7set9EPLvV8/fiDbNrHoqBIWcqqujsy5NVulXNwQtqB/IxLfKm9VS5QRJOmJCt3huq1TdIgzVodQ==
X-Received: by 2002:a2e:96cb:0:b0:295:c333:2a24 with SMTP id d11-20020a2e96cb000000b00295c3332a24mr9123946ljj.19.1678438504927;
        Fri, 10 Mar 2023 00:55:04 -0800 (PST)
Received: from pc636 (host-78-79-233-41.mobileonline.telia.com. [78.79.233.41])
        by smtp.gmail.com with ESMTPSA id q19-20020a2eb4b3000000b0029868d1820dsm159165ljm.60.2023.03.10.00.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:55:04 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Mar 2023 09:55:02 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZArwZjcEYXAYwmqi@pc636>
References: <ZAc1wsvd4trjP/xi@lothringen>
 <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309221056.GB148448@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> [..]
> > > > > > > See this commit:
> > > > > > > 
> > > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > > > expedited RCU primitives")
> > > > > > > 
> > > > > > > Antti provided this commit precisely in order to allow Android
> > > > > > > devices to expedite the boot process and to shut off the
> > > > > > > expediting at a time of Android userspace's choosing.  So Android
> > > > > > > has been making this work for about ten years, which strikes me
> > > > > > > as an adequate proof of concept.  ;-)
> > > > > > 
> > > > > > Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > > find that Android Mediatek devices at least are setting
> > > > > > rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > > weird, it should be set to 1 as early as possible), and
> > > > > > interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > > they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > > 
> > > > > Interesting.  Though this is consistent with Antti's commit log,
> > > > > where he talks about expediting grace periods but not unexpediting
> > > > > them.
> > > > > 
> > > > Do you think we need to unexpedite it? :))))
> > > 
> > > Android runs on smallish systems, so quite possibly not!
> > > 
> > We keep it enabled and never unexpedite it. The reason is a performance.  I
> > have done some app-launch time analysis with enabling and disabling of it.
> > 
> > An expedited case is much better when it comes to app launch time. It
> > requires ~25% less time to run an app comparing with unexpedited variant.
> > So we have a big gain here.
> 
> Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> be slowing down other usecases! I find it hard to believe, real-time
> workloads will run better without those callbacks being always-expedited if
> it actually gives back 25% in performance!
> 
I can dig further, but on a high level i think there are some spots
which show better performance if expedited is set. I mean synchronize_rcu()
becomes as "less blocking a context" from a time point of view.

The problem of a regular synchronize_rcu() is - it can trigger a big latency
delays for a caller. For example for nocb case we do not know where in a list
our callback is located and when it is invoked to unblock a caller.

I have already mentioned somewhere. Probably it makes sense to directly wake-up
callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
one by one.

--
Uladzislau Rezki
