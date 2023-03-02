Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA16A79CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCBDIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:08:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94D1E5C6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:08:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so1412356pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqBtE3NOsJu8MvEnf3aUHYU615ohnE5xpjxbq1CREUM=;
        b=g0PbF6iIj6B7JcL3+cGIH1ATmlDyafxz3eJnaoTlgm8xWUDKZWY6c08B4IX8yJk/QB
         lT/HSmomIt+smNub7Bpae3KIzBDmgcPXcKnCy0iIyQ/BdYd59OXFE9g2Mnwofg8K3v/i
         r0PSRKomZmXwdHZhm6nLl2yb2l3TX7ZopV8740CefYWpDiL9FRpjbI1OCh93IL5E8o9M
         sPs0uqzOzuW1QPtwh3SAj6SiMJvYANt09QMFNCcTMVd4gYFl4LxftfuI2aVga2RVSH9E
         nYPdrHrf2bygWAkG5Gf9guTx6mOZXQieNsxV6VEJ4Y1zP1eo24i/O/w/fe+yUUzzqFcn
         pb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqBtE3NOsJu8MvEnf3aUHYU615ohnE5xpjxbq1CREUM=;
        b=57xAzX5wQJr4U0HGFOL9eyuLJhKBXxbf0kl5fuFfwpe+jGn3KMgjAK/h1Vrl6vdoS5
         bX1reMK8+vaNdpkFUr2GaXklh6BvZFJGgHsJRdJg82HcQ7/OjRAkEDWbuqD1S5XQqvE7
         3pnc6+A8E6tmCJn5iI2rECSQFiEq1d5TTm43wVWQ1E0XGJPTBAEP0aniB8TAqHom2x7C
         YoGHG8Ldp+GIJ1mFJ5ic1vBsX03AWuxg/aWgSBt5nMGeg5GEsPezVS/pdDKkkdH5UfYB
         /qqvL0la1Z0ITJYLTNTzfhcfP8jfQCwXwvPDjf7Y68R2y6BQvbc+9baPO55gllg1JNyT
         lO5Q==
X-Gm-Message-State: AO0yUKWQWLKXjQgEhbR2QfmpDFAzyrJ65fcBxa6FNEyHB3KfJ1eE2oWD
        VPMn1P+zpyL3c05Zxaw9lAekDqBzcZ8h9dwIeiw=
X-Google-Smtp-Source: AK7set9aKf1EJlaulrBMMeK8S4ke5Z7Dw2QokmMznrk65BiyAyofnEyDVv9onk2GJzc/01Qe7URokcejY6wrpN/mxD8=
X-Received: by 2002:a17:902:6808:b0:19c:cf99:11f7 with SMTP id
 h8-20020a170902680800b0019ccf9911f7mr3236148plk.0.1677726507998; Wed, 01 Mar
 2023 19:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20230302-workqueue-avoid-iter-after-loop-v1-1-d83324743b99@gmail.com>
In-Reply-To: <20230302-workqueue-avoid-iter-after-loop-v1-1-d83324743b99@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 2 Mar 2023 11:08:16 +0800
Message-ID: <CAJhGHyCAGd3cK_hmV6sQZfODXwFT82g37xPhOcSWNO3ktH3V2g@mail.gmail.com>
Subject: Re: [PATCH] workqueue: avoid usage of list iterator after loop in __flush_workqueue()
To:     Jakob Koschel <jkl820.git@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 7:23=E2=80=AFAM Jakob Koschel <jkl820.git@gmail.com>=
 wrote:
>
> If the list_for_each_entry_safe() iteration never breaks, 'next' would
> contain an invalid pointer past the iterator loop. To ensure 'next' is
> always valid, we only set it if the correct element was found. That
> allows adding a WARN_ON_ONCE in case the code works incorrectly,
> exposing currently undetectable potential bugs.

Hello

In the code, if I did not miss anything important, I don't think there are =
any
way that the 'next' is invalid because it is used after this check:
        if (list_empty(&wq->flusher_queue))

which means the list_for_each_entry_safe() iteration did break and
the 'next' is valid.
(the code also moves entries from &wq->flusher_overflow to
wq->flusher_queue, but it only happens when wq->flusher_queue
is not empty because the number of colors > 2)

The logic is quite complicated and I agree with you that we
should avoid using the 'next' after the loop directly and remove
any possible misunderstanding/confusion.

But I don't want to make the code even more complicated by
adding more variables.

I prefer reinitializing the "next" before it is reused as:
   next =3D list_first_entry(&wq->flusher_queue, struct wq_flusher, list);

Thanks
Lai
