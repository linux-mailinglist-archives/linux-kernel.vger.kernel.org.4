Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221C706EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEQQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEQQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A999E1BF3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684342643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDub+o6M+RWugzBvVPuIrQdrJwbEeKap5Wz6vwEUlm4=;
        b=c4ibvk3n6FnvPP6OuGufGZgwYaOyEU8B2wMCIpftPddRJYpk5cYlqKzNA3iq2SZh1HyHCW
        AhOEhSEcBPQwfRJ5I1DHu+10OsrWzG79sR2JabPv9144z3Czj+cwTpd+yxc8nxkF71yrKR
        JHjfAhy2vN0ZGuV/DcTlwEfDnq05Vzc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-l0DbFWoIM9eE2IyqFOgirA-1; Wed, 17 May 2023 12:57:22 -0400
X-MC-Unique: l0DbFWoIM9eE2IyqFOgirA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-643bc9cb443so618891b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342641; x=1686934641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDub+o6M+RWugzBvVPuIrQdrJwbEeKap5Wz6vwEUlm4=;
        b=hS0PiZ/9qlJNzEDHpMeWvL53bjCD32scJF8+PDCzIMPMQC+wdu1VfIHVglhe12Egmv
         3yintxryxuZMEs2ip1tt6/zmPH6RUca5cHPq0YuM4OuqII9TQtfN5C0glonr2nb4NaNV
         uzk8v36Yb13/OhLS8d7IscGQMqSeGGpCj6OdkrAlOWxXL1MQXvOy5LwWMnSjOIl3HTrj
         OMSatrHH20mihS6QyrkUP83vQhs/fhj0uLk9OgzE7bvIRSXHFIbHVHsSc9Ixv3bGEX9U
         ao41T/vHB7uJ9byMnUI8qZj001HIsnHJXD2VYMMvrDavSyLHRDFfqLbrCg9BhmSHSMLQ
         sBIw==
X-Gm-Message-State: AC+VfDx7Z//OW7waefExII6zhmeiGSxCqZGgDY5gf+mUqFGdttxYZwzD
        7MnimL+TrPdRjHWqa58w3EbKigTM25iqOauomxYMxMfbSeA9apH0pxz7b5Ig9N7t+FG9BUE4JMT
        9NS9G+wO7StS5qHfR0JEYiHKORBF8nKo7y8tRRFXs
X-Received: by 2002:a05:6a21:32a1:b0:103:ee82:dc9e with SMTP id yt33-20020a056a2132a100b00103ee82dc9emr28626062pzb.50.1684342641417;
        Wed, 17 May 2023 09:57:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tCuigFagpK3UoiInD0Wdc2Zn19i4g9p6ClzcBE9LcolJuKrvOWlZjL5/shjzl7zKaPJcgqW3/eQzIln1wYx0=
X-Received: by 2002:a05:6a21:32a1:b0:103:ee82:dc9e with SMTP id
 yt33-20020a056a2132a100b00103ee82dc9emr28626048pzb.50.1684342641175; Wed, 17
 May 2023 09:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230516191441.34377-1-wander@redhat.com> <20230517152632.GC1286@redhat.com>
In-Reply-To: <20230517152632.GC1286@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Wed, 17 May 2023 13:57:09 -0300
Message-ID: <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
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

On Wed, May 17, 2023 at 12:26=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 05/16, Wander Lairson Costa wrote:
> >
> >  static inline void put_task_struct(struct task_struct *t)
> >  {
> > -     if (refcount_dec_and_test(&t->usage))
> > +     if (!refcount_dec_and_test(&t->usage))
> > +             return;
> > +
> > +     /*
> > +      * under PREEMPT_RT, we can't call put_task_struct
> > +      * in atomic context because it will indirectly
> > +      * acquire sleeping locks.
> > +      *
> > +      * call_rcu() will schedule delayed_put_task_struct_rcu()
> > +      * to be called in process context.
> > +      *
> > +      * __put_task_struct() is called when
> > +      * refcount_dec_and_test(&t->usage) succeeds.
> > +      *
> > +      * This means that it can't "conflict" with
> > +      * put_task_struct_rcu_user() which abuses ->rcu the same
> > +      * way; rcu_users has a reference so task->usage can't be
> > +      * zero after rcu_users 1 -> 0 transition.
> > +      *
> > +      * delayed_free_task() also uses ->rcu, but it is only called
> > +      * when it fails to fork a process. Therefore, there is no
> > +      * way it can conflict with put_task_struct().
> > +      */
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > +             call_rcu(&t->rcu, __put_task_struct_rcu_cb);
> > +     else
> >               __put_task_struct(t);
> >  }
>
> LGTM but we still need to understand the possible problems with CONFIG_PR=
OVE_RAW_LOCK_NESTING ...
>
> Again, I'll try to investigate when I have time although I am not sure I =
can really help.
>
> Perhaps you too can try to do this ? ;)
>

FWIW, I tested this patch with CONFIG_PROVE_LOCK_NESTING in RT and
stock kernels. No splat happened.

> Oleg.
>

