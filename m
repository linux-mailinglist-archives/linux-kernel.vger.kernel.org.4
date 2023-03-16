Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977736BD2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCPO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCPO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:57:22 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABFCD663
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:57:18 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5447d217bc6so36805537b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678978637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w7zMMd7x6aGvImR8WNeqUFh64/lLSPtzRGITxok/+k=;
        b=C5SyNxP8fdmDzuY6FQgR2wVoMpRfFTRlNwcfeqtPE0JSARou3Jg06GsOFoed/IPUP/
         FGg73oIv2WXtlYLjrbc8T6c8LAZD96UVSCyxbqqGQV3L4UH2cf+OQs8QK/HIJXOvBoWO
         mvqO5y/lo0uyx+hHnIfggMQvGdmuvFsC9jtl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w7zMMd7x6aGvImR8WNeqUFh64/lLSPtzRGITxok/+k=;
        b=ORCgW+yJps+kDLfxOxYg7hgDpf7FJV03icACltRi7oQbPiz1zxkG/ke5IDaL9kpi+s
         8w83L1j9LLSRZ0QsbrfxyWCA3qR7QVY/Zy1Q/mxD0NPtswx0kglwQzMmb33SUdM+kSaj
         vfTyy42X/Ceucq/lBckppbFrpdMBQuMZbyeBJUWUUYu17wGt9HwsBeGNnxr69GTnDakb
         Vc5QUcmoSL8nYzeHvZnZpr0oZ7FJDDkzzVyQeyS/PkoJf5jqPKl+WoI3dNFtWWSeqyip
         WP4uspMorLNnn32R14VXLe3fwRy+aLUP4YTZEg1dMCnmkc6Ha10i8Z89wZ8O3Qy6pyZ0
         vxEQ==
X-Gm-Message-State: AO0yUKV2vU8AEFjMHb3B0dO/c3EMD6i2LogJMUL2KilpckeLlorqct0G
        IJ1G4h9PcSCdqilzDNa8mUbIFM299ObTyTKG/DI8CyK9WQT0wROJ2ec=
X-Google-Smtp-Source: AK7set9gpBrpMLVvGQC2SDucMEvxUx3cOcSddFhk/h8urAkE6LiD61jtKdlV6M25oA3yKcWDsAGh8dgHefbjAHSLht0=
X-Received: by 2002:a81:a807:0:b0:536:4ad1:f71 with SMTP id
 f7-20020a81a807000000b005364ad10f71mr2303020ywh.9.1678978637508; Thu, 16 Mar
 2023 07:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org> <IA1PR11MB6171C7FEE026F421A3CD6A9689BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6171C7FEE026F421A3CD6A9689BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 10:57:06 -0400
Message-ID: <CAEXW_YTh18nWTWjLBCRiB2AAH76oD7XrMMMPWZ+9thFSmcPaVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 9:53=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
[...]
> > >> From: Paul E. McKenney <paulmck@kernel.org> [...]
> > >>>>
> > >>>> How about to pull the rcu_scale_cleanup() function after
> > >> kfree_scale_cleanup().
> > >>>> This groups kfree_* functions and groups rcu_scale_* functions.
> > >>>> Then the code would look cleaner.
> > >>>> So, do you think the changes below are better?
> > >>>
> > >>> IMHO, I don't think doing such a code move is better. Just add a ne=
w
> > >>> header file and declare the function there. But see what Paul says
> > >>> first.
> > >>
> > >> This situation is likely to be an early hint that the kvfree_rcu()
> > >> testing should be split out from kernel/rcu/rcuscale.c.
> > >
> > > Another is that it's a bit expensive to create a new header file just
> > > for eliminating a function declaration. ;-)
> >
> > What is so expensive about new files? It is a natural organization stru=
cture.
> >
> > > So, if no objections, I'd like to send out the v2 patch with the upda=
tes below:
> > >
> > >   - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate=
 the
> > >     declaration of kfree_scale_cleanup(). Though this makes the patch=
 bigger,
> > >     get the file rcuscale.c much cleaner.
> > >
> > >   - Remove the unnecessary step "modprobe torture" from the commit
> > message.
> > >
> > >   - Add the description for why move rcu_scale_cleanup() after
> > >     kfree_scale_cleanup() to the commit message.
> >
> > Honestly if you are moving so many lines around, you may as well split =
it out
> > into a new module.
> > The kfree stuff being clubbed in the same file has also been a major
> > annoyance.
>
> I'm OK with creating a new kernel module for these kfree stuffs,
> but do we really need to do that?

If it were me doing this, I would try to split it just because in the
long term I may have to maintain or deal with it.

I was also thinking a new scale directory _may_ make sense for
performance tests.

kernel/rcu/scaletests/kfree.c
kernel/rcu/scaletests/core.c
kernel/rcu/scaletests/ref.c

Or something like that.

and then maybe putt common code into: kernel/rcu/scaletests/common.c

 - Joel

>
> @paulmck, what's your suggestion for the next step?
>
> >  - Joel
> >
> >
> > > Thanks!
> > > -Qiuxu
> > >
> > >> [...]
