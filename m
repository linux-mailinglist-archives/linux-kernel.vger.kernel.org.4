Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE76644D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLFU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLFU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:58:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821944509A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:58:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so4956303pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 12:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ5/FowzAocI0ttW8zswzJn2dKKUi5iFR0Wy//VpliA=;
        b=z9dSMG0BIaedzOQwBdxMcaOKoxGIB8Vr2V3Xcp1oB8Ls3IOBLO5SbowSKXTrGfZ2bY
         B6JW75Vm8GCXneh/xp4CnHEWzPEPEJHzPfPH4qdHnH+Ke0eSgYINGnxFz66jj6CqmWPv
         wl7UFEivh3viOKQjIGEU2i6HbzogPwFL87iJVZrY/pJJkdSrQy2YCz51+aPVuE+Qmmjc
         8giA5yJxl0lA2Rm/Iq9umfTDesSf6meHAoeOt8Zp5CZmTtTh035jyUH5X49EhidLfCD9
         5NxNe6ib7O8ayWjGYnEh0kM2Fj0zG3aK0/BXwqpmpKm1GUMN45oNZg1/KRFzxah2dwpf
         AWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ5/FowzAocI0ttW8zswzJn2dKKUi5iFR0Wy//VpliA=;
        b=NqNeoo3Af/2/qt/CWUCT+Y54Vdpwn/JdHndvAOBEJAmBnM9DYS8GKoNRnVIV9ZGxs5
         acU0t3uQNVVn7m1YzTJhjiGP3iYKot1Z5XXt8gEDAxyP62GiqpQenJfZYPSOpgnXPmzd
         sOtC/GT7fv4QV8OyMB4svEOhT3fx0nt2t0sGFqroX2LEcDMIftKyDzNK5RwBiI0hI5xR
         Xk7yiOKkMbzQOXplfvuUnBMoNlNfCRg/kcdIuAymbkN//RELaZzyd861h4lG+3MtHbvT
         ixVkVoXnQNWzDdBhHiD803AHcWA3kWLj/0O8XVQzS06YNHvt/Mz5pce6G4SE/0VXRP+Z
         Bujg==
X-Gm-Message-State: ANoB5pnMnnarFe5aAFvbMt/YHA5IiID0uAEMxk6GCfr7v5meQS6Zd8Pn
        7eaRU5qgczypJeLAmlZlEJ3MrQ==
X-Google-Smtp-Source: AA0mqf40viWKnr8AZ2Bv4zDz+yx+XuVLm4+yfcthP+MgoEp2B+LO40XR1hqp80sZLtlD0PL9B2oQ8w==
X-Received: by 2002:a17:90a:f406:b0:219:9e8:84b2 with SMTP id ch6-20020a17090af40600b0021909e884b2mr59976215pjb.121.1670360336013;
        Tue, 06 Dec 2022 12:58:56 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id s30-20020a63925e000000b00477def759cbsm4179848pgn.58.2022.12.06.12.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 12:58:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2f1e-005KXs-TS; Wed, 07 Dec 2022 07:58:50 +1100
Date:   Wed, 7 Dec 2022 07:58:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        RCU <rcu@vger.kernel.org>,
        syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
Message-ID: <20221206205850.GT3600936@dread.disaster.area>
References: <000000000000bd587705ef202b08@google.com>
 <20221206033450.GS3600936@dread.disaster.area>
 <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:06:10PM +0100, Dmitry Vyukov wrote:
> On Tue, 6 Dec 2022 at 04:34, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Dec 05, 2022 at 07:12:15PM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > INFO: rcu detected stall in corrupted
> > >
> > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
> > > rcu: blocking rcu_node structures (internal RCU debug):
> >
> > I'm pretty sure this has nothing to do with the reproducer - the
> > console log here:
> >
> > > Tested on:
> > >
> > > commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
> > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000
> >
> > indicates that syzbot is screwing around with bluetooth, HCI,
> > netdevsim, bridging, bonding, etc.
> >
> > There's no evidence that it actually ran the reproducer for the bug
> > reported in this thread - there's no record of a single XFS
> > filesystem being mounted in the log....
> >
> > It look slike someone else also tried a private patch to fix this
> > problem (which was obviously broken) and it failed with exactly the
> > same RCU warnings. That was run from the same commit id as the
> > original reproducer, so this looks like either syzbot is broken or
> > there's some other completely unrelated problem that syzbot is
> > tripping over here.
> >
> > Over to the syzbot people to debug the syzbot failure....
> 
> Hi Dave,
> 
> It's not uncommon for a single program to trigger multiple bugs.
> That's what happens here. The rcu stall issue is reproducible with
> this test program.
> In such cases you can either submit more test requests, or test manually.

So you're telling us syzbot reproducers are unreliable and we are
expected to play whack-a-mole with test resubmission until we get
the result we want?

How do I tell syzbot to resubmit the same patch for testing without
having to send the same patch to syzbot via email again? Can I
retrigger a new test run through the web interface?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
