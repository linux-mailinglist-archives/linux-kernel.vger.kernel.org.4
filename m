Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E96E2DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDNXvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDNXvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:51:45 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57C2A5F2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:51:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54c12009c30so477184827b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681516171; x=1684108171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No46jFhwGzkRNUpDWHs00ERh1TJYKH/sOU4hg7TOFIE=;
        b=Y/0uIWDs7JruwuGPhftvVUvAzBHjysvv1C0uwnnnVgunNCWugJF0fxx/j8VtpL3PC7
         9BXu7sZfji0Pu6jLEcV/0u29Xo1y2q1nj0v/aNx3D/ypJm9uYLeZF9jXSsvWJdUBYspV
         673r1xgprfwfvd6GClwVeNSByKcn6KXpd9QvzA0L5jMD5f4c/VAOJuCL/tiQvGkONU0s
         RgNUrvI9FzV6Xx2agJunBEoHwNpTHpKkHtVgH0itjcK/lrCwUK36Zd0VHREE40zNJd4v
         dFNu7TbC2ag8TlFU5sPT5DKIJV3d5ifyvVGn+4PjLrRDzpaLjo5fUK/3uFUA7gViZyDe
         cBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681516171; x=1684108171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No46jFhwGzkRNUpDWHs00ERh1TJYKH/sOU4hg7TOFIE=;
        b=Q//lpKPeHJ/1AIceBHHR1oVnIyXGHLSWHAk3QTip7+GkMiqpKz74mLzTgrgWYbnIbf
         mmXVULL9ZqCDbPs3v+L/SJAlbfXux0y0YGBafZzLT7LiGrFfZ6vX6Js9Qj9EXWQxcZ/6
         glrrlov2qCV4u6Xwz9mhqE0tkrGAsVv1Pc5nMOrIfesNk6scNQO7JL/8MM4esBAMzNp2
         qwMI9aILr0hQoWDuxJZmsPcFohMTMPOTXw3WS0mKHQYWenQTnNyQaUUjeOZX+IJBx4GO
         ZbE/wQNDESHa68bVK7jsp9ZprXVQlKPZ/lOjDinHQ2qD3H1RiKHgVwTR1npCwhLg16pF
         O10Q==
X-Gm-Message-State: AAQBX9eb1IZcJNer2QDj0kk0MZ6ewY7XIlunj+zlsXaJowiKQPmy9Fuy
        fJxco/POCsGo3gHg4X79SmAg1+s/qDfDLhRuNSeECg==
X-Google-Smtp-Source: AKy350bSj1CSWDY36bOsJSsoidHfrQ6bQV1QcvO4pqangbXIyw9XYy4patdK5PqOcIhIsOqfrXxeZSv8RhGW+y1n/iA=
X-Received: by 2002:a81:af0c:0:b0:54f:8566:495 with SMTP id
 n12-20020a81af0c000000b0054f85660495mr4919497ywh.1.1681516170910; Fri, 14 Apr
 2023 16:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230414175444.1837474-1-surenb@google.com> <ZDnJ1dOU2tpK6l68@x1n>
 <CAJuCfpFc2SohkkJnEFqZD-uCpSS9sUzToPcQXOR6dHTTE0Ty5w@mail.gmail.com> <ZDnVETTFus3BFLxH@x1n>
In-Reply-To: <ZDnVETTFus3BFLxH@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 16:49:19 -0700
Message-ID: <CAJuCfpH278ozvhz=z4W0d6TxY6HhrORbsBPFM5d4x1M=EM23WQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 3:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Suren,
>
> On Fri, Apr 14, 2023 at 03:14:23PM -0700, Suren Baghdasaryan wrote:
> > > It also already ignores invalid faults:
> > >
> > >         if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > >                 return;
> >
> > Can there be a case of (!VM_FAULT_ERROR && VM_FAULT_RETRY) - basically
> > we need to retry but no errors happened? If so then this condition
> > would double-count pagefaults in such cases.
>
> If ret=3D=3DVM_FAULT_RETRY it should return here already, so I assume
> mm_account_fault() itself is fine regarding fault retries?
>
> Note that I think "ret & (VM_FAULT_ERROR | VM_FAULT_RETRY)" above means
> "either ERROR or RETRY we'll skip the accounting".
>
> IMHO we should have 3 cases here:
>
>   - ERROR && !RETRY
>     error triggered of any kind
>
>   - RETRY && !ERROR
>     we need to try one more time
>
>   - !RETRY && !ERROR
>     we finished the fault

After looking some more into mm_account_fault(), I think it would be
fine to count the faults which produced errors. IIUC these counters
represent the total number of faults, not the number of valid and
successful faults. If so then I think simply using VM_FAULT_RETRY
should be ok without considering all possible combinations. WDYT?

>
> I don't think ERROR & RETRY can even be set at the same time so I assume
> there's no option 4) - a RETRY should imply no ERROR already, even though
> it's still incomplete so need another attempt.
>
> Thanks,
>
> --
> Peter Xu
>
