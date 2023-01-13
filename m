Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA0566A17C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjAMSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjAMSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:03:34 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF407F9D0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:58:19 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id fd15so9727197qtb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwounBNqcFt0WNcsB2zzBI6/+gCmMNx+ampM2FZOqRs=;
        b=bRqlN8u/n+nMOL2S0M2dbaw6HTZpWGe4ACj4DqT5mAO/bmVutbUWTtz9F+dzuho9Xu
         wIhyrZnq7QkkHtz8hJF49/dfH5EXzP2KyO6lguO9GhLkh6AAwRsRPs2p4GDazYivsoaL
         qGqZ8z3OIVbHuDhDIQJKasftGjDvf/E9HMtUinwBIO+RGY6/yfuEdERcZG1mjG0oYc1K
         UpjwcFWn0VTeS2tO6Alkj6Km1vM9OwJU5zkcNzz0k4DaFgvaDJKt5R/xuwO2YhzYKl0n
         x1F4yff9zaHf2Qz3Xx67IocgR5hmWMNDg5hoVlh7X8Nu3h5CWs2naf5dVSv/Ip1zQ6y1
         W8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwounBNqcFt0WNcsB2zzBI6/+gCmMNx+ampM2FZOqRs=;
        b=H9a9VdFdXFQTv75h0ony/jEqH4pHqZoMpFDN66L85z9T2DaYwCNg0vxcEvjm+o4D+p
         7cKqTkmvCYY3uzLUNfaV3VpwtCUPUgWCNSP3yDiK+JUWu1ZA2XANCCAOzvRxFpEKY+jA
         Nn+07WlKWtR4P1wIxLoau7tIHVbLIPCrnA3VcoIi7qWcLbMpQ/sxrqo+B1xfVY7gN6um
         CeG3gSRoVtVyEH7EHXAksBxUmJ0tMYcpiXUMwwU2/IzE3op2uE0bmlBuDaSjdHDaUYJy
         QFkcyK/ls7PrKDsWIyuroKHGz8ZxfX8DlCdfPw+zCb6/ufr2a+akCGJ2WlxVlSwe9/y+
         aCLg==
X-Gm-Message-State: AFqh2kobnPsFxOW0GkhzaRrmNVR124vK+vgJytRnM5yO4TpWRYHZv2EG
        7RUVpKZZSIP2bhUoodlsQQk=
X-Google-Smtp-Source: AMrXdXuUuGAUif1AZgAb5hHYfIiUROV67NU8RM+1dHCDlc3JJIX/yITonzZOhWSGfUFpD0Jf/Qirbg==
X-Received: by 2002:a05:622a:4c08:b0:3a7:f599:9c6c with SMTP id ey8-20020a05622a4c0800b003a7f5999c6cmr116643440qtb.26.1673632698537;
        Fri, 13 Jan 2023 09:58:18 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ge9-20020a05622a5c8900b003a7e38055c9sm10875572qtb.63.2023.01.13.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:58:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8AD5627C005A;
        Fri, 13 Jan 2023 12:58:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Jan 2023 12:58:17 -0500
X-ME-Sender: <xms:uJvBYyUQH2y2hZr5dW5Bd-mrXUiE21Mzsxn2hIz_Sv31ta8BR7wlEw>
    <xme:uJvBY-k5zTFw0nimO6s_OF5w4HeTWFuHCHM8uezIkvCEJLaWt7R_hweXJiNG2U54h
    o2SXMHs53zisCBBtQ>
X-ME-Received: <xmr:uJvBY2ZWlf6pbWfTaT1q1d4I8Qu1ZmwqPAQWvyQN6H47aypcQABoBFjjFAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleekgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uJvBY5XZIPCgKBmxRx7YqlH9eqtZHEssKETb9bck8Gyz8wq1VLOs2g>
    <xmx:uJvBY8lGGMkIyfDyIEK5C0Z6HikPlgzFst1-usI83xrWwVp07Uk6WA>
    <xmx:uJvBY-dVIX_aZrOVWX-jOJYmY2W_2qrkznD_bcVLYbm9Rrp-rRM4Dw>
    <xmx:uZvBY6bINI4u5xnGpj4MUVM8zGKCdKI44b5cArqDI_HEH9p6OoD2uA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jan 2023 12:58:16 -0500 (EST)
Date:   Fri, 13 Jan 2023 09:58:10 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] rcu: Equip sleepable RCU with lockdep dependency
 graph checks
Message-ID: <Y8GbsulOXWNK9WGs@boqun-archlinux>
References: <20230113065955.815667-1-boqun.feng@gmail.com>
 <20230113130330.1027-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113130330.1027-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:03:30PM +0800, Hillf Danton wrote:
> On 12 Jan 2023 22:59:54 -0800 Boqun Feng <boqun.feng@gmail.com>
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1267,6 +1267,8 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
> >  {
> >  	struct rcu_synchronize rcu;
> >  
> > +	srcu_lock_sync(&ssp->dep_map);
> > +
> >  	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
> >  			 lock_is_held(&rcu_bh_lock_map) ||
> >  			 lock_is_held(&rcu_lock_map) ||
> > -- 
> > 2.38.1
> 
> The following deadlock is able to escape srcu_lock_sync() because the
> __lock_release folded in sync leaves one lock on the sync side.
> 
> 	cpu9		cpu0
> 	---		---
> 	lock A		srcu_lock_acquire(&ssp->dep_map);
> 	srcu_lock_sync(&ssp->dep_map);
> 			lock A

But isn't it just the srcu_mutex_ABBA test case in patch #3, and my run
of lockdep selftest shows we can catch it. Anything subtle I'm missing?

Regards,
Boqun
