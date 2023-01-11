Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A146F665855
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbjAKJ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:56:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0444D98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:54:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so12187204wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFXFErf1cq+teYIb8hlzraGgrqjKGOqEZ+fy0lNXo3c=;
        b=Ez55A3lcqCOOEpQ5a4MBkBx/2zChunM795At0TWV11V9WbBJ3DNkEB+66S9HGrtTvn
         ZDrwYqwzDgMm/GUyX2mzE2EyNcXUbISgQIhYJEFkNsxa/WJWRcmrCKKbqV3CK84/r0Hx
         gQf3ozUakFu5DN1h0mhXmm1aXmV2UdIPGbHqRzOGvUihTrEa/8iNTkAkHvzMJhamqLTm
         QEJD46zYp2AUnJ8M0wB+YLQ0S8c8KCU/HRIw8my1jcP70fUUhlXfPYdDdPu4vClkcdjb
         i8UhuaFbVL7Wq8WsQORBLS3P0UyAc+JZsDHoSzAQqympHQwKCHd983BEMxllkefRdkgp
         ruvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFXFErf1cq+teYIb8hlzraGgrqjKGOqEZ+fy0lNXo3c=;
        b=ovgHncY4XemHMBLP987cIyTKyriUWAEcNoLOZpnjtpSb8n5xIeG2ySQik8x/nOKG4d
         HIZHedvHRWCEyLTF/hxi/S2KUd2/HtaWymth/3/vgWnDyQVHWJTXslsEvEe91OmFeG9f
         opsWZfcTEgtqja0KpalrU+9+RoNdrGcGR24Q8NcY132KRhQ+FBpacok6s3CnqJLJ+AOX
         FyxUlTTR10WBhSL7gKmug6OsQQcEH+x/lG/A9EmMGXxDEwlBrzrBCMPrws4dZpTdVS6p
         gWdpd6AdFONVspF1vg3SSi3jXapvljhrz6BbHxUABQ0z7ZTwvHuapnRpTPQpZg7qJMZ9
         gklw==
X-Gm-Message-State: AFqh2krUsnhxRef0lq37vOt2RD14VTy6DdFPhrrGUXsNqy8fOdZYG+Wa
        saRZ+nL/wiqkRX3Xol1lMA4=
X-Google-Smtp-Source: AMrXdXs4Bilzbryqesa6Iq2CcbBPhULbeIu/iOoHs0IaVyp+PUdwh0hB46bGVPQijouO6TJpzE7mXw==
X-Received: by 2002:a05:600c:229a:b0:3d9:ec70:befc with SMTP id 26-20020a05600c229a00b003d9ec70befcmr9365764wmf.13.1673430866212;
        Wed, 11 Jan 2023 01:54:26 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003d9fb04f658sm4077431wmc.4.2023.01.11.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:54:25 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Jan 2023 10:54:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
Message-ID: <Y76HTfIeEt8ZOIH3@gmail.com>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld>
 <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
 <Y75x5fGPcJ63pBIp@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y75x5fGPcJ63pBIp@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Hocko <mhocko@suse.com> wrote:

> On Tue 10-01-23 16:44:42, Suren Baghdasaryan wrote:
> > On Tue, Jan 10, 2023 at 4:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> > >
> > > On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
> > >
> > > >This configuration variable will be used to build the support for VMA
> > > >locking during page fault handling.
> > > >
> > > >This is enabled by default on supported architectures with SMP and MMU
> > > >set.
> > > >
> > > >The architecture support is needed since the page fault handler is called
> > > >from the architecture's page faulting code which needs modifications to
> > > >handle faults under VMA lock.
> > >
> > > I don't think that per-vma locking should be something that is user-configurable.
> > > It should just be depdendant on the arch. So maybe just remove CONFIG_PER_VMA_LOCK?
> > 
> > Thanks for the suggestion! I would be happy to make that change if
> > there are no objections. I think the only pushback might have been the
> > vma size increase but with the latest optimization in the last patch
> > maybe that's less of an issue?
> 
> Has vma size ever been a real problem? Sure there might be a lot of those 
> but your patch increases it by rwsem (without the last patch) which is 
> something like 40B on top of 136B vma so we are talking about 400B in 
> total which even with wild mapcount limits shouldn't really be 
> prohibitive. With a default map count limit we are talking about 2M 
> increase at most (per address space).
> 
> Or are you aware of any specific usecases where vma size is a real 
> problem?

40 bytes for the rwsem, plus the patch also adds a 32-bit sequence counter:

  + int vm_lock_seq;
  + struct rw_semaphore lock;

So it's +44 bytes.

Thanks,

	Ingo
