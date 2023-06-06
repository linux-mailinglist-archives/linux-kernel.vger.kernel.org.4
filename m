Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED8724A75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbjFFRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbjFFRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:42:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958110F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:42:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba8151a744fso7309751276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686073351; x=1688665351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qcl1xVv0DZKFv/tl9qF3aaNP9Nfg+EcmIEUZmmRBufc=;
        b=qc7dJ1SUYr4ppYF2g41koTNU6n3Y8g+nKQPoUBcUvC1gHq6zqDipikpYL3kNbWo6r/
         /T/XPVgW+/VFt2BFFu3I9s5D33yPObqSpB4aL4v0LC4qRCpI4wp/w0ooja1XG7q5R/X3
         fyRO4Nq5XPZjlVejykFBCNlC7A7hw1PcOiS580psL4E66wdu0TGIHlpik0ux9SmUVQQq
         f9XjEDANTUdqb7oTQOU1NOgldiCki0WkKYqOuwSmMLBMV5O/G85MtPm2/7itmWbixgoD
         FeGui90Rlt4xB250Uf4lxmmCLZzO/KvecElZ/HSpmEmHxPFU3pglGNOIQQ1RojLzKtmR
         DFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073351; x=1688665351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qcl1xVv0DZKFv/tl9qF3aaNP9Nfg+EcmIEUZmmRBufc=;
        b=d0+emnJ1ro49MncmuorX1j50v3XLIXjEaE3pQBt62nNQaYaucRJt/IzUdcfEfX0Bl0
         AW9EIG6hXwty1uSYD1ZjNfIaegc+5LUVs0FQhHQfO1KXr0kFB3Zg7shJOHrk/aORfAc8
         rzphaAzlY5touAv3Q84lkTAuzO6Oq3NUqd0y5yJDXPStsHHQ5RVbOM7xII5/IKnplFIC
         DcC3stl9fEpc3xsEzLhB3c3b19FPzV7kTYSaEByg388vEVuU2lzgwmBZu7Sp7kz+xwOL
         Z7D3NIYLKWS4HrmD0JQkbB88ucMYq85mvN1qRoy6soYfB6XPY0JrUVdskWehCKOKq1ml
         Wghw==
X-Gm-Message-State: AC+VfDz4g6LHbVW7agW4UWcpZtbl5UD635mhkH39fb+mPI36LTykmroB
        oh2u+1jWEDxbnPur/cnJqUNwLOWPsWg20uokwJTzRA==
X-Google-Smtp-Source: ACHHUZ7NVt8mLpnu6WuW8VSN85wkluvK9KNbxJKLv2M1d1HvwSgkyINMeZzGDBD2aJ6e4HUUjKIKfK0sDXQ9oMHsRak=
X-Received: by 2002:a81:4e44:0:b0:561:d6dd:bc84 with SMTP id
 c65-20020a814e44000000b00561d6ddbc84mr3585116ywb.48.1686073350739; Tue, 06
 Jun 2023 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230602103750.2290132-1-vladimir.oltean@nxp.com>
 <CAM0EoMnqscw=OfWzyEKV10qFW5+EFMd5JWZxPSPCod3TvqpnuQ@mail.gmail.com>
 <20230605165353.tnjrwa7gbcp4qhim@skbuf> <CAM0EoM=qG9sDjM=F6D=i=h3dKXwQXAt1wui8W_EXDJi2tijRnw@mail.gmail.com>
 <20230606163156.7ee6uk7jevggmaba@skbuf>
In-Reply-To: <20230606163156.7ee6uk7jevggmaba@skbuf>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue, 6 Jun 2023 13:42:19 -0400
Message-ID: <CAM0EoM=3+qwj+C9MzDEULeYc3B=_N=vHyP_QDdhcrNsyaQQODw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 0/5] Improve the taprio qdisc's
 relationship with its children
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 12:32=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Tue, Jun 06, 2023 at 11:39:32AM -0400, Jamal Hadi Salim wrote:
> > 1)Just some details become confusing in regards to offload vs not; F.e
> > class grafting (taprio_graft()) is de/activating the device but that
> > seems only needed for offload. Would it not be better to have those
> > separate and call graft_offload vs graft_software, etc? We really need
> > to create a generic document on how someone would write code for
> > qdiscs for consistency (I started working on one but never completed
> > it - if there is a volunteer i would be happy to work with one to
> > complete it).
>
> I would be a happy reader of that document. I haven't studied whether
> dev_deactivate() and dev_activate() are necessary for the pure software
> data path, where the root taprio is also directly attached to the netdev
> TXQs and that fact doesn't change across its lifetime.

I didnt go that far in the doc but was intending to. It was supposed
to be a tutorial somewhere and i ended not doing it.
something like htb will be a good example to compare with (it is a
classful qdisc which is also capable of offloading). It is not the
same as mqprio which can only be root.

> > 2) It seems like in mqprio this qdisc can only be root qdisc (like
> > mqprio)
>
> so far so good
>
> > and you dont want to replace the children with other types of
> > qdiscs i.e the children are always pfifo? i.e is it possible or
> > intended for example to replace 8001:x with bfifo etc? or even change
> > the pfifo queue size, etc?
>
> no, this is not true, why do you say this?

I am just asking questions trying to understand;-> So if can i
replace, for example, with a tbf would it make sense even in s/w?

> > 3) Offload intention seems really to be bypassing enqueue() and going
> > straigth to the driver xmit() for a specific DMA ring that the skb is
> > mapped to. Except for the case where the driver says it's busy and
> > refuses to stash the skb in ring in which case you have to requeue to
> > the appropriate child qdisc/class. I am not sure how that would work
> > here - mqprio gets away with it by not defining any of the
> > en/de/requeue() callbacks
>
> wait, there is a requeue() callback? where?

Hrm, someone removed that ops i guess at some point - not sure when,
need to look at git history.
But short answer is yes it used to be there; git will probably reveal
from the commit its disappearance.

>
> > - but likely it will be the lack of requeue that makes it work.
>
> Looking at dev_requeue_skb(), isn't it always going to be requeued to
> the same qdisc it was originally dequeued from? I don't see what is the
> problem.

In the basic case that approach is sufficient. For pfifo you want it
to the first skb dequeued the next opportunity to send to h/w.
Basically the idea is/was: if the hardware is busy you may need to run
some algorithm (present in requeue but not in enqueu) to decide if you
should put the skb at the head, at the tail, somewhere else, drop it,
check if some time limit has exceeded and do something funky etc etc.

> My understanding of the offload intention is not really to bypass dequeue=
()
> in general and as a matter of principle, but rather to bypass the root's
> taprio_dequeue() specifically, as that could do unrelated work, and jump
> right to the specific child's dequeue().
>
> The child could have its own complex enqueue() and dequeue() and that is
> perfectly fine - for example cbs_dequeue_soft() is a valid child dequeue
> procedure - as long as the process isn't blocked in the sendmsg() call
> by __qdisc_run() processing packets belonging to unrelated traffic
> classes.

Does it matter what type the child enqueue/dequeue? eg can i attach htb, et=
c?

cheers,
jamal
