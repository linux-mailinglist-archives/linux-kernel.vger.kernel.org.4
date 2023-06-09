Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F05E72A2DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFITIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFITIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687383
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686337689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5jvtYj4ss3gRxhJMAUhGD1nCKZcTExe3MbvBgI5pR8=;
        b=Emyl6B7qyTyOgTC0m0+4AbWz93k8Mi7XfbWVZrRbLyjUN050/OJQ8zQEP9sBCa9vbIkLwp
        33GgVXz9IxqgqQiT0Qu+bXp2F237hI+cMtGpcaUsNYmsPtGM9jwC54GTZlD2QhubefH/Bt
        H9bTtKNb9HdI1l219jwUCnka5FXhCC0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-XWIZrI_HMxKJqDWRxSn8LQ-1; Fri, 09 Jun 2023 15:08:07 -0400
X-MC-Unique: XWIZrI_HMxKJqDWRxSn8LQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-256719f2381so946985a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337686; x=1688929686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5jvtYj4ss3gRxhJMAUhGD1nCKZcTExe3MbvBgI5pR8=;
        b=Ige22cw7vHZ2UTtpPepYR7Pr3d2dI3M2gnAj3z/vrbclqwYLrXRW6S7MJaXwEDGMSb
         wvz0i0SeENAr23gxltQft//ILVECf4pqEiHEdr0ovEZhYU+PWaIJBgzAUwg1T6Sz8NOm
         BzvR+96/d165WItOJkFrh0xXxuJyA7xhbjPAT9qwqQ099316qNbQJMhjsx2d5kLVII8/
         gW59w4z3vZ2unhh8TYz0svyYpIG1Z36ryDECks4KhwFEc4bEgW8YAVYMZ3jg+bYtDmKD
         4E9lgxQoCEO7tEyeYD+sqA++q8S99sil7JxxULJjTEdPB1FEkMDkOnG/mmd3wRGXzlP8
         9DTg==
X-Gm-Message-State: AC+VfDxfzR9fJklzJK4MWs5ShfpnDmYNjBFuz3AoM0fghv43Wb2iFxJ/
        rx73WheUAwQVPe+0MbFPyOaJtCDwSM3ztIJFcIVD8AIIjbl+qpZOjPlfn9ac2kZU4Fj8FBLwO7T
        FE2MYGrQimFdUJCu+t3nf9VOin9IO5LotzwoyIz7h
X-Received: by 2002:a17:90a:10c9:b0:258:fdd9:585a with SMTP id b9-20020a17090a10c900b00258fdd9585amr2037495pje.3.1686337686126;
        Fri, 09 Jun 2023 12:08:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cAyDYi2RfVp9SHiYPSQK//kXAM3G4rYsNmvFEHNfZQZ4LOzUO+PWGwVGIScDeQVZKF1Vt9M1qUV2gBfdXHIo=
X-Received: by 2002:a17:90a:10c9:b0:258:fdd9:585a with SMTP id
 b9-20020a17090a10c900b00258fdd9585amr2037465pje.3.1686337685870; Fri, 09 Jun
 2023 12:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230516191441.34377-1-wander@redhat.com> <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
 <20230529122256.GA588@redhat.com> <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
 <20230601181359.GA23852@redhat.com> <CAAq0SUk3c5H8YCVAfRAU=pZFNLrA90mNMq=k5BohTutM7cfcvg@mail.gmail.com>
 <20230602173302.GA32644@redhat.com> <CAAq0SU=A5j2-GF80Thi2vm8W+_AUquj6t+QK7cnWLz1jKEA4zg@mail.gmail.com>
 <20230606203958.GC18866@redhat.com>
In-Reply-To: <20230606203958.GC18866@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Fri, 9 Jun 2023 16:07:54 -0300
Message-ID: <CAAq0SUnNNQr=k8ZJfKsaXgZUCCEFLj6=OCMwRenFCgB9yFKD=g@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 5:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 06/05, Wander Lairson Costa wrote:
> >
> > Thanks. I found an unrelated earlier splat in the console code. That's
> > why I couldn't reproduce it in the stock kernel.
>
> As expected...
>
> So... Not sure what can I say ;) can you verify that this patch doesn't s=
olve
> the issues with CONFIG_PROVE_RAW_LOCK_NESTING pointed out by Sebastian? U=
sing
> stress-ng or anything else.
>

I managed to test it without a console. No issues happened in the stock ker=
nel.

> This is not that bad, unless I am totally confused the current code (with=
out
> your patch) has the same problem (otherwise we wouldn't need this fix).
>

That's my understanding as well.

> But perhaps you can make 2/2 which adds the DEFINE_WAIT_OVERRIDE_MAP() ha=
ck
> as Peter suggested?
>

Yes, sure. I would like to get the issue reproduced in practice to
make sure I am really fixing the problem. But I can live with that.

> Oleg.
>

