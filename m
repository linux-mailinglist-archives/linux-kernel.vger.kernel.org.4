Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2333766AEE0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 01:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjAOATP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 19:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAOATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 19:19:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23321A271
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 16:19:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fd15so12148633qtb.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9NlsPlpNd7WXgq+xHOVgza2BZyYigkU2oTgae9LxSE=;
        b=N85udYLKFRE92xIWBkwfGphVp4OMvAHnhw5YLiibpwUn46qrpBTBnP1iIqP+Tbunt8
         w3L4mFT8bCjMeLB5lYZGtzYSTvJNiIja20pMrmJxKt4O52OGI2FlJ1w/ORLFrCVpdUZF
         tZuCrE+l/XnHeu4GwHsGMkOnHxR5vCpUC5v1ihlTDL3YWBoAY9wKxGP+SaXy7y9sVEkT
         x0WKS9vVvcY58NUMy1h8a/4aJA3QmW2mILApSS4KcJXyAMWdrNVwASktUmNUTOxiQ7Ey
         ChlChka8zsQO3bqMPgMG1e8jWK7v8ifd3NyQrBnOKrODepoQXgVT9Z00daQg6zQUQ1Sn
         j2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9NlsPlpNd7WXgq+xHOVgza2BZyYigkU2oTgae9LxSE=;
        b=h9xZdjufve8WelUOo7gxKvH931lx8RY1CClYZyGYjyZzQzb36YrJ+WsUGnwgktXmaM
         VdzHLVPU9ZmtfCUm7v6vgfMCxjA9GbndBkVN43rcSQKPP7h5cNE1x/RyTR+/KvQJG8Vy
         nm9l5P+e3R/kf080Ga7bDB3V+TVFG1YqAgYD8O0Ul19ZBVVAB7PkPwflaJdGG8Y9LAB4
         VTM4H+VLugeDYAmL3+cLYzfHmkCjQVCfTnFj26nDCWyoyl7pEZDlTwarxo5rAH40Mp1i
         OBY6LmZRLvfUuEw60WNvzIXL/get0hkrGLT98O4EMx7L1LJwKahEoXweH3tcE6dLuTvX
         Z8Pw==
X-Gm-Message-State: AFqh2kpb2ldz+1JvOMjfBeUyI8uBEoEMjQP5gZXjGpNwdkVZXASl6GN/
        ug6yIr5ThOGG3BQrOa/9bvg=
X-Google-Smtp-Source: AMrXdXtv6M25sTMF2oI3BC60FhEW0IjAnvHzamIW9UnlhI3R24tysCrcSVWtn3vFluI+tCRK+Fqp/g==
X-Received: by 2002:a05:622a:4c88:b0:3a8:21a5:d93 with SMTP id ez8-20020a05622a4c8800b003a821a50d93mr139131967qtb.39.1673741950267;
        Sat, 14 Jan 2023 16:19:10 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006fa43e139b5sm15306709qkl.59.2023.01.14.16.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 16:19:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 17A8C27C0054;
        Sat, 14 Jan 2023 19:19:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 14 Jan 2023 19:19:09 -0500
X-ME-Sender: <xms:fEbDYx3fYMWly2zTJT0ynGYbOyT1T5BjowN0l9ugfyL99KpzFVjZyQ>
    <xme:fEbDY4EpZS-o0OPAOklgJ07DERAMyBMw27jlPoRmRzJocL4kDd38Uhh9_pxWdGvb7
    xgf6g5342mQPl0R3g>
X-ME-Received: <xmr:fEbDYx7qqCnZq3T0nYbjCrS2H9_aNtc0bfxEZ0w8YF0_n9uMT5tjpsJ_t30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtuddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:fEbDY-0Ozpvm3EfKem59VUNmGKE0WSNUSaOZYihMkx0pRfhkqx4G1w>
    <xmx:fEbDY0EN5fyjPZTyLZ22MRURYyRBWEXpU6bdXuyGW92M5LeKp3thtQ>
    <xmx:fEbDY_-mQY4poTq8DZ_FEIxpwYF5Wh_SgC0UVz3LfcfMNoW8bEZgYA>
    <xmx:fEbDY55F6INZaSwnIAX8A01rIIM8XFhSHLfJFdj8nlTgXhk3MXsrfQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jan 2023 19:19:07 -0500 (EST)
Date:   Sat, 14 Jan 2023 16:18:57 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] rcu: Equip sleepable RCU with lockdep dependency
 graph checks
Message-ID: <Y8NGcaMmFgxBmhXN@boqun-archlinux>
References: <20230113065955.815667-1-boqun.feng@gmail.com>
 <20230113130330.1027-1-hdanton@sina.com>
 <20230113235809.1085-1-hdanton@sina.com>
 <20230114071832.1162-1-hdanton@sina.com>
 <20230114102659.1219-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114102659.1219-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 06:26:59PM +0800, Hillf Danton wrote:
> On Fri, 13 Jan 2023 23:32:01 -0800 Boqun Feng <boqun.feng@gmail.com>
> > On Sat, Jan 14, 2023 at 03:18:32PM +0800, Hillf Danton wrote:
> > >
> > >  	task X			task Y
> > >  	---			---
> > >  	mutex_lock(A);
> > >  				srcu_read_lock(B);
> > > 				srcu_lock_acquire(&B->dep_map);
> > > 				a) lock_map_acquire_read(&B->dep_map);
> > >  	synchronze_srcu(B);
> > > 	__synchronize_srcu(B);
> > > 	srcu_lock_sync(&B->dep_map);
> > > 	lock_map_sync(&B->dep_map);
> > > 	lock_sync(&B->dep_map);
> > > 	__lock_acquire(&B->dep_map);
> > 
> > At this time, lockdep add dependency A -> B in the dependency graph.
> > 
> > > 				b) lock_map_acquire_read(&B->dep_map);
> > > 	__lock_release(&B->dep_map);
> > > 				c) lock_map_acquire_read(&B->dep_map);
> > >  				mutex_lock(A);
> > 
> > and here, lockdep will try to add dependency B -> A into the dependency
> > graph, and find that A -> B -> A will form a circle (with strong
> > dependency), therefore lockdep knows it's a deadlock. 
> 
> Is the strong dependency applying to mode c)?
> If yes then deadlock should be also detected in the following locking
> pattern that has no deadlock.
> 
> 	cpu0			cpu1
> 	---			---
> 	mutex_lock A
> 	mutex_lock B
> 	mutex_unlock B
> 				mutex_lock B
> 				mutex_lock A

Well, of course, this is how lockdep works. Lockdep detects the
*potential* deadlocks rather than detects the deadlocks when they
really happen. Otherwise lockdep is useless.

The execution in your example shows the potential deadlocks, i.e. one
task acquires A and then acquires B, the other task acquires B and then
acquires A. Potential deadlocks mean given a correct timing, a deadlock
may happen.

Regards,
Boqun

> > 
> > >  
> > > No deadlock could be detected if taskY takes mutexA after taskX releases B,
> > 
> > The timing that taskX releases B doesn't master, since lockdep uses
> > graph to detect deadlocks rather than after-fact detection.
> > 
> > > and how taskY acquires B does not matter as per the a), b) and c) modes in
> > > the above chart, again because releasing lock can break deadlock in general.
> > 
> > I have test cases showing the above deadlock can be detected, so if you
> > think there is a deadlock that may dodge from my change, feel free to
> > add a test case in lib/locking-selftest.c ;-)
> > 
> > Regards,
> > Boqun
