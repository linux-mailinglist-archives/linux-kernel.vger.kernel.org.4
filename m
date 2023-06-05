Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4790D722481
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFELZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFELZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A2B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+GJJ8Mmc0oeDh8hL6S+8Cpv35FkmxFr8XDckyJUa00=;
        b=VFSRp2KKiF7K03GkClz/0zkAy2xd8vHXYGzofz+uwxpNaa6cYHuvRBKBAKdlUyv4oI191W
        tjTvMd8/9bqndCMWGRDcrboz5H9a+r/42R80T57QCLiFunxvIcyH1Mx/iN2xbxa/nvcggG
        m4/zHnyNk+AFycIhJ1Shaufxx3UcSd0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-bOt7v3LHOrGiAhjyL4dQkg-1; Mon, 05 Jun 2023 07:24:26 -0400
X-MC-Unique: bOt7v3LHOrGiAhjyL4dQkg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5343c1d114cso4445622a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964265; x=1688556265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+GJJ8Mmc0oeDh8hL6S+8Cpv35FkmxFr8XDckyJUa00=;
        b=IbvMtCn2/H8ZX4gtLkIjzN9ocwZIGzccSoROS6Jsjdy4GipIgAbyfI4Wwt+Q/cljWl
         fsFdEThpZVToo2NVjMc6bU1d/SkuwVUhzScjkHP2R6AHkXTAyNea1DnD1ooFRtgx2EFd
         2CkoxMj6q2kcoEd40wnf+Gxc1NP13czSOopIJj7UtAPA6e2Vt007x1UKnjSBCpKHd3he
         ICpmnYPdlrtbLJu8/s5tD+zMipqPz+Mud7C3Ov38/Bfo9VQ9wuRNfumcmpsCDVNVY/9I
         hNFXpYymPeVyD9TU8UGyoWo6xI6WW4PyWwx/gu3FHPhZOcOmslO+a7havtjQE79k26+n
         W0KA==
X-Gm-Message-State: AC+VfDznwkO+/raRP54E9ZebmDgdvBEAUWb6XSUtsRs+J97hh/Mh04/2
        /BQgGWUuqFHCoerbFMC7GML2RVBwaz53hri3RYtS5dqkInKowCqo9JEcR3KYZTKQOznYbLR5Vy9
        VnS+vSCa6KW89HT2fDyZbajCYoPij5l2+/2fnEsjB
X-Received: by 2002:a17:902:c1d4:b0:1b2:f8d:3ef5 with SMTP id c20-20020a170902c1d400b001b20f8d3ef5mr2192493plc.38.1685964265097;
        Mon, 05 Jun 2023 04:24:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RKFAFNgtiM520XaCdHK5b+127LBWwP1BgZ4d25GnqmIiaUyU4mm1SZuu9V7AC/j5D2Ybi0mMF+01Aosg4Jmc=
X-Received: by 2002:a17:902:c1d4:b0:1b2:f8d:3ef5 with SMTP id
 c20-20020a170902c1d400b001b20f8d3ef5mr2192459plc.38.1685964264837; Mon, 05
 Jun 2023 04:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230516191441.34377-1-wander@redhat.com> <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
 <20230529122256.GA588@redhat.com> <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
 <20230601181359.GA23852@redhat.com> <CAAq0SUk3c5H8YCVAfRAU=pZFNLrA90mNMq=k5BohTutM7cfcvg@mail.gmail.com>
 <20230602173302.GA32644@redhat.com>
In-Reply-To: <20230602173302.GA32644@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 5 Jun 2023 08:24:13 -0300
Message-ID: <CAAq0SU=A5j2-GF80Thi2vm8W+_AUquj6t+QK7cnWLz1jKEA4zg@mail.gmail.com>
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling context
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 2:34=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 06/01, Wander Lairson Costa wrote:
> >
> > On Thu, Jun 1, 2023 at 3:14=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> =
wrote:
> > >
> > > > but only in the RT kernel
> > >
> > > this again suggests that your testing was wrong or I am totally confu=
sed (quite
> > > possible, I know nothing about RT). I did the testing without CONFIG_=
PREEMPT_RT.
> > >
> >
> > Hrm, could you please share your .config?
>
> Sure. I do not want to spam the list, I'll send you a private email.
>

Thanks. I found an unrelated earlier splat in the console code. That's
why I couldn't reproduce it in the stock kernel.

> Can you share your kernel module code?
>

*facepalm* I forgot to post the link: https://github.com/walac/test-prove-l=
ock/

> Did you verify that debug_locks !=3D 0 as I asked in my previous email ?
>
> > > > But running the reproducer for put_task_struct(), works fine.
> > >
> > > which reproducer ?
> > >
> >
> > Only now I noticed I didn't add the reproducer to the commit message:
> >
> > while true; do
> >     stress-ng --sched deadline --sched-period 1000000000
> > --sched-runtime 800000000 --sched-deadline 1000000000 --mmapfork 23 -t
> > 20
> > done
>
> Cough ;) I think we need a more simple one to enssure that
> refcount_sub_and_test(nr, &t->usage) returns true under raw_spin_lock()
> and then __put_task_struct() actually takes spin_lock().
>
> Oleg.
>

