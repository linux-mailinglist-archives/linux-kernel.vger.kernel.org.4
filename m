Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EC68A2E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjBCTXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjBCTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:22:58 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA023402D;
        Fri,  3 Feb 2023 11:22:56 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-16332831ed0so7797469fac.10;
        Fri, 03 Feb 2023 11:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKX+QG3f/kc19mjMKFaEzy5Do8w/6oGAuZfhZ0dN2wQ=;
        b=hcWWA8n57Bri2yWCkTTmxoPeGkz0Di5IVhEW/KbnfCqBnvfg7TRCHoTYsM0hFrxkT+
         xEmLJkTcMikBM6c2xIKwaWVT69KnVe1UhWKfvBWVesfH9j1+J7mqQsF0Cd2u4pMZeoXG
         DDzQ7XnBExZKyByc9QXGYO81U3/ggGzcxRZTjcmfVvOp4WnZGGU1IqT/DWSFr3j1cfTK
         XkeWok4qaYqR9sDakpThBd4rejW+eSMEbA/06IpSCMFH4wVa5F/yI/7w9s3cN1D0hn2Z
         YEiymUZxtOosRCCGsFFTh6d1jzMkYi3KiPJN0qwwa1ls2ae/jCKx1ovvmr6Sk+XLtMv3
         hZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKX+QG3f/kc19mjMKFaEzy5Do8w/6oGAuZfhZ0dN2wQ=;
        b=MrM10mjhEAsAplDUpDOE1rwwFyRlqTxSUGrYCQTay9byi+9YR+cgn+Uul0CuXLqHT5
         ENlNJmsFGL/i4/ivVG5+njlkyD+TTwF1YhsCvl+m8ASvyg39RNlOifn/aYgNbWBeTB4O
         H6hgNi/V6bpxO0bJkWIzXtrXeaYTGQbqm+0AIxpoPe/C/wxebxTNzl+YhSi90t+Bpyah
         Y/GxVpryMsmvOA9wRWtOFn0aM2FJA5c6lj2eQPp+cGAQz6z2AKwI8tN3sWCHTWuddNPa
         I8b+HaX9m0K8YwH/S6W0oTmOugcQLOqbGZ60FQPK0Kd/1xDsPjQINkBwVsnoxL3xFOz6
         mVXQ==
X-Gm-Message-State: AO0yUKW93xga/Aj9QuSfAWZsxlS39jvS79U1QSQp6j2JHUuLnSUewNBc
        oiWXON0LX/PLZ5zSCUkDCIYaW6t4PlNQ1RCNmqs=
X-Google-Smtp-Source: AK7set90lQUTFlayzPSXnqM8r23BPi5UGVctFPWzVQhf+PMUB6V/J3d3O4ESdh9fzM8lHRQgOTxagrmjfLIe9EGRgY0=
X-Received: by 2002:a05:6870:a118:b0:163:cd38:813e with SMTP id
 m24-20020a056870a11800b00163cd38813emr654596oae.215.1675452175701; Fri, 03
 Feb 2023 11:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20230201232244.212908-3-boqun.feng@gmail.com> <Y9t+3u+2UcAFQc+r@hirez.programming.kicks-ass.net>
 <20230202142153.352ba479.gary@garyguo.net> <Y9vZu08L2WaLNJIc@kroah.com>
 <Y9vga90K0aVfGUwW@boqun-archlinux> <Y9viM2POUsSnbKUh@kroah.com>
 <Y9vqJ1h2nkaFRpOY@boqun-archlinux> <CANiq72kMZ9XQvte41Mzu4oXX=ujGRCrGDZDiYUBVD3=JTGG57g@mail.gmail.com>
 <Y9yaBybest8JBu8A@kroah.com> <Y9y21JyuPF1nCCzr@Boquns-Mac-mini.local>
 <Y9y58cy1GKZLdyjb@kroah.com> <9d144ca0-5cf2-a575-a30b-22f5ff4e8e2b@redhat.com>
In-Reply-To: <9d144ca0-5cf2-a575-a30b-22f5ff4e8e2b@redhat.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Fri, 3 Feb 2023 16:22:44 -0300
Message-ID: <CANeycqo088O+yCA91hujZtxZzbR4UyYrj_yvGYHp0MgWatxmpA@mail.gmail.com>
Subject: Re: [RFC 2/5] rust: sync: Arc: Introduces ArcInner::count()
To:     Josh Stone <jistone@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 at 16:17, Josh Stone <jistone@redhat.com> wrote:
>
> On 2/2/23 11:38 PM, Greg KH wrote:
> > How?  Because you have an implicit reference on it already?  If so, then
> > why does reading from it matter at all, as if you have a reference, you
> > know it isn't 0, and that's all that you can really care about.  You
> > don't care about any number other than 0 for a reference count, as by
> > definition, that's what a reference count does :)
>
> There is an additional ability for 1, mentioned up thread -- if you have
> &mut Arc<T>, and the inner count is 1, then you *know* there aren't any
> other Arc<T> handles anywhere else. Then it is safe to return an
> exclusive &mut T, like the upstream Arc::get_mut and Arc::make_mut. This
> can also be used for owned Arc<T> like the upstream Arc::try_unwrap.

The `Arc<T>` in the kernel is pinned so we can't return an `&mut T`,
though a `Pin<&mut T>` would be ok.
