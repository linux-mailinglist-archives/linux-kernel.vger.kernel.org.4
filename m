Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDA68C5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBFSfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBFSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:35:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9512052
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675708458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cgTZ19pW0iVDL2Qnv65/qHceF/KDKwiWrxxdH0jwAM=;
        b=g1rN8Y/JLOKzoRcELBNjcjwxLnnnJehGof2uTVeRwu+rjSBQWqsRIFgEUj6MvIOG+mdaiN
        phZgBBNuvIl6uV2E5T1JsWWWPjW+3A9uR9tkIMcc7+E+8C4JZy8RvQiOBxvFgjFmX3f1Ev
        gPR7stuhYlDmdqve9/uIyWfPW8RFPT8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-6vJlnMW9Nke6GzGv_2OhJw-1; Mon, 06 Feb 2023 13:34:16 -0500
X-MC-Unique: 6vJlnMW9Nke6GzGv_2OhJw-1
Received: by mail-pf1-f199.google.com with SMTP id s4-20020a056a00194400b0058d9b9fecb6so6795205pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cgTZ19pW0iVDL2Qnv65/qHceF/KDKwiWrxxdH0jwAM=;
        b=Rf/8Y7/4ZBaQ+qtu5r2Epuii0iKBRehjQxkzbDbFy+dKLdH9ji24ohqBXuUZ58HSn3
         0xIPNNlYydMXY3UNJjgJF65M0Mb5bB0r8Y5fJ9TgW/v+eyySr29Dll1/X9mUXGzpkCTN
         /bqJTvSgWZBw80iSHM38HrBjvzevtgLfHDk5AdAs9OjMFiSONQGxJHIhvMHgWLgXQRf0
         7BqnXnrClhCyHMgNM8wRiXH/9WLfp8mDK270Na5ueJHrEXUs25zCUmjgmtA7uxks+suh
         M2rvDV0KQHQXY9gPUV+lP2jLcvY7BRo0aScz9vevFXVuzGgBTQyxEM6XHopyP6CfwFhZ
         cJgg==
X-Gm-Message-State: AO0yUKU9e/zmnUn8sxp5hlTMr9hqD4omsvJspCE3DGQO7wSlrgBfsCo4
        RH8w2JM/Zfo9DtHj6+uYhmHpNYOfQEoUtmRts+KxSVjUZ0F9wCQ2ry0vayz6NjAgJOUNta2p9Bw
        xiMOqT5MUYjETkBgkCBz4e+APyh2xba2CBId3JjTI
X-Received: by 2002:a17:90a:d70b:b0:230:8730:c1f7 with SMTP id y11-20020a17090ad70b00b002308730c1f7mr2091716pju.27.1675708455518;
        Mon, 06 Feb 2023 10:34:15 -0800 (PST)
X-Google-Smtp-Source: AK7set99C69oyk06AxHIzT3fesAXXKUZuijYWDoZHCBV3QRnsJM9HcMtQx/DP//qweF37aJ7AMfpkLmCPzlCfzhvYXA=
X-Received: by 2002:a17:90a:d70b:b0:230:8730:c1f7 with SMTP id
 y11-20020a17090ad70b00b002308730c1f7mr2091703pju.27.1675708455255; Mon, 06
 Feb 2023 10:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20230206130449.41360-1-wander@redhat.com> <Y+EVNz4ORkFSvTfP@linutronix.de>
 <20230206152712.GA1487@redhat.com>
In-Reply-To: <20230206152712.GA1487@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 6 Feb 2023 15:34:04 -0300
Message-ID: <CAAq0SUndxzcvaJ+4ELXcWN1hNF+6S7HRDryc4r1VqCiw4W_78A@mail.gmail.com>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling context
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 12:27 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 02/06, Sebastian Andrzej Siewior wrote:
> >
> > On 2023-02-06 10:04:47 [-0300], Wander Lairson Costa wrote:
> >
> > > @@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk)
> > =E2=80=A6
> > > +void __put_task_struct(struct task_struct *tsk)
> > > +{
> > > +   if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task(=
)))
> >
> > Is it safe to use the rcu member in any case?
>
> I thinks it is safe but deserves a comment. I guess Wander misunderstood
> me when I asked him to do this...
>

Oops, sorry. Next version, I will include this description.

> __put_task_struct() is called when refcount_dec_and_test(&t->usage) succe=
eds.
>
> This means that it can't "conflict" with put_task_struct_rcu_user() which
> abuses ->rcu the same way; rcu_users has a reference so task->usage can't
> be zero after rcu_users 1 -> 0 transition.
>
> > If so why not use it
> > unconditionally?
>
> performance ?
>
>
> And... I still don't like the name of delayed_put_task_struct_rcu() to me
> ___put_task_struct_rcu() looks a bit less confusing, note that we already
> have delayed_put_task_struct(). But this is minor.
>

Ok, I will change it.

> Oleg.
>

