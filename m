Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1BF6F596E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjECNz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjECNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756DA5BBC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683122103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWLFrth5fSALbwonCRmuwo7go9iLbMbkb+uUwrAcVfM=;
        b=Q6LEjtCOCOhp5atxp4MuboIXWJlr/4mopetrI4flXm/KepLHxVJ/3wwaq88njjo3sEes5h
        ONKWCgPSufbBudBltR9sM392fN0mPcf/BQIr69LVW2VQ07Wp1A13DuHzFexhLbSxuia5mw
        O1+R0TuxOkDIgN+OlShlrQqx9Z3LOzY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-P8rIJI0eOFiv39G3YjwTFA-1; Wed, 03 May 2023 09:55:01 -0400
X-MC-Unique: P8rIJI0eOFiv39G3YjwTFA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso4362375276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683122101; x=1685714101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWLFrth5fSALbwonCRmuwo7go9iLbMbkb+uUwrAcVfM=;
        b=Zdlv1xq7xqvzqPueUV7B3rMCewxZUuNPlwxJWnVPCGb1aBZARm62YYnrknhfvwKrvx
         WPx5Ap+3nsmzLa5S/wCOvroAHIBGyUTHYw3picasNPDf6ixCQPXjX044PXeivUzalqSu
         UxCv8IUqt34atupgf3oIOlcveTG5N+3qrlTd5qwud1HQP97QCL7SzXec7RLde7JJycSb
         +HoXWUCPS+kzhy4CErm5YNGqYLvDJifF43+LhjhZr4Wy5G1Mhy0rFVRKq17kP17qs3I+
         I6IdWKc2YzM60dSKFmKM9wa1PBgXlnX5oqD4kTCvNj4eNQjawq9+Ng19mh2+5lGzX8pu
         lHWA==
X-Gm-Message-State: AC+VfDw5hvRygo2EfbSYMWJYdmhYleDF3yGt9ShCfQnmHcyecRfEsjVI
        oLk2JrjpzScUFAf/M1zLe6U9q7kiO5vgrpNd+fZfzIudGjk1nqsbvkiLrnmdngYSFcPNYU97Aly
        +oO4GOffAPUJh2rCZNk7zAkbmw3Cj3sordaB9Dq67GCZa+fQw
X-Received: by 2002:a25:25d2:0:b0:b8f:722b:3570 with SMTP id l201-20020a2525d2000000b00b8f722b3570mr2223264ybl.3.1683122100615;
        Wed, 03 May 2023 06:55:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7D1M4hXsG3LFiKMmrAvYm/BdXI8iJBBg+2O1IdzrNEikBSpnuMr7HRJnj24fNJmbw7wVQJ7H/L1j7R2j3SB4Q=
X-Received: by 2002:a25:25d2:0:b0:b8f:722b:3570 with SMTP id
 l201-20020a2525d2000000b00b8f722b3570mr2223244ybl.3.1683122100262; Wed, 03
 May 2023 06:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230423192643.1537470-1-AVKrasnov@sberdevices.ru>
 <i6swadylt57hrtxhpl5ag7s3dks536wg3vxoa7nuu2x37gxsbi@uj7od5ueq6yp>
 <a9ee9ef5-e707-65ff-3128-41d09fbe8655@sberdevices.ru> <23guh3txkghxpgcrcjx7h62qsoj3xgjhfzgtbmqp2slrz3rxr4@zya2z7kwt75l>
 <ba8c5cbf-a19d-134e-c6c4-845b072a490b@sberdevices.ru>
In-Reply-To: <ba8c5cbf-a19d-134e-c6c4-845b072a490b@sberdevices.ru>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Wed, 3 May 2023 15:54:48 +0200
Message-ID: <CAGxU2F41wtvE7ZjZmR6DwTiSOoO5XU6Ei9+EX6ca_w6JnspCQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/15] vsock: MSG_ZEROCOPY flag support
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 3:50=E2=80=AFPM Arseniy Krasnov <avkrasnov@sberdevic=
es.ru> wrote:
>
>
>
> On 03.05.2023 16:47, Stefano Garzarella wrote:
> > On Wed, May 03, 2023 at 04:11:59PM +0300, Arseniy Krasnov wrote:
> >>
> >>
> >> On 03.05.2023 15:52, Stefano Garzarella wrote:
> >>> Hi Arseniy,
> >>> Sorry for the delay, but I have been very busy.
> >>
> >> Hello, no problem!
> >>
> >>>
> >>> I can't apply this series on master or net-next, can you share with m=
e
> >>> the base commit?
> >>
> >> Here is my base:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3Db103bab0944be030954e5de23851b37980218f54
> >>
> >
> > Thanks, it worked!
> >
> >>>
> >>> On Sun, Apr 23, 2023 at 10:26:28PM +0300, Arseniy Krasnov wrote:
> >>>> Hello,
> >>>>
> >>>>                           DESCRIPTION
> >>>>
> >>>> this is MSG_ZEROCOPY feature support for virtio/vsock. I tried to fo=
llow
> >>>> current implementation for TCP as much as possible:
> >>>>
> >>>> 1) Sender must enable SO_ZEROCOPY flag to use this feature. Without =
this
> >>>>   flag, data will be sent in "classic" copy manner and MSG_ZEROCOPY
> >>>>   flag will be ignored (e.g. without completion).
> >>>>
> >>>> 2) Kernel uses completions from socket's error queue. Single complet=
ion
> >>>>   for single tx syscall (or it can merge several completions to sing=
le
> >>>>   one). I used already implemented logic for MSG_ZEROCOPY support:
> >>>>   'msg_zerocopy_realloc()' etc.
> >>>>
> >>>> Difference with copy way is not significant. During packet allocatio=
n,
> >>>> non-linear skb is created, then I call 'pin_user_pages()' for each p=
age
> >>>> from user's iov iterator and add each returned page to the skb as fr=
agment.
> >>>> There are also some updates for vhost and guest parts of transport -=
 in
> >>>> both cases i've added handling of non-linear skb for virtio part. vh=
ost
> >>>> copies data from such skb to the guest's rx virtio buffers. In the g=
uest,
> >>>> virtio transport fills tx virtio queue with pages from skb.
> >>>>
> >>>> This version has several limits/problems:
> >>>>
> >>>> 1) As this feature totally depends on transport, there is no way (or=
 it
> >>>>   is difficult) to check whether transport is able to handle it or n=
ot
> >>>>   during SO_ZEROCOPY setting. Seems I need to call AF_VSOCK specific
> >>>>   setsockopt callback from setsockopt callback for SOL_SOCKET, but t=
his
> >>>>   leads to lock problem, because both AF_VSOCK and SOL_SOCKET callba=
ck
> >>>>   are not considered to be called from each other. So in current ver=
sion
> >>>>   SO_ZEROCOPY is set successfully to any type (e.g. transport) of
> >>>>   AF_VSOCK socket, but if transport does not support MSG_ZEROCOPY,
> >>>>   tx routine will fail with EOPNOTSUPP.
> >>>
> >>> Do you plan to fix this in the next versions?
> >>>
> >>> If it is too complicated, I think we can have this limitation until w=
e
> >>> find a good solution.
> >>>
> >>
> >> I'll try to fix it again, but just didn't pay attention on it in v2.
> >>
> >>>>
> >>>> 2) When MSG_ZEROCOPY is used, for each tx system call we need to enq=
ueue
> >>>>   one completion. In each completion there is flag which shows how t=
x
> >>>>   was performed: zerocopy or copy. This leads that whole message mus=
t
> >>>>   be send in zerocopy or copy way - we can't send part of message wi=
th
> >>>>   copying and rest of message with zerocopy mode (or vice versa). No=
w,
> >>>>   we need to account vsock credit logic, e.g. we can't send whole da=
ta
> >>>>   once - only allowed number of bytes could sent at any moment. In c=
ase
> >>>>   of copying way there is no problem as in worst case we can send si=
ngle
> >>>>   bytes, but zerocopy is more complex because smallest transmission
> >>>>   unit is single page. So if there is not enough space at peer's sid=
e
> >>>>   to send integer number of pages (at least one) - we will wait, thu=
s
> >>>>   stalling tx side. To overcome this problem i've added simple rule =
-
> >>>>   zerocopy is possible only when there is enough space at another si=
de
> >>>>   for whole message (to check, that current 'msghdr' was already use=
d
> >>>>   in previous tx iterations i use 'iov_offset' field of it's iov ite=
r).
> >>>
> >>> So, IIUC if MSG_ZEROCOPY is set, but there isn't enough space in the
> >>> destination we temporarily disable zerocopy, also if MSG_ZEROCOPY is =
set.
> >>> Right?
> >>
> >> Exactly, user still needs to get completion (because SO_ZEROCOPY is en=
abled and
> >> MSG_ZEROCOPY flag as used). But completion structure contains informat=
ion that
> >> there was copying instead of zerocopying.
> >
> > Got it.
> >
> >>
> >>>
> >>> If it is the case it seems reasonable to me.
> >>>
> >>>>
> >>>> 3) loopback transport is not supported, because it requires to imple=
ment
> >>>>   non-linear skb handling in dequeue logic (as we "send" fragged skb
> >>>>   and "receive" it from the same queue). I'm going to implement it i=
n
> >>>>   next versions.
> >>>>
> >>>>   ^^^ fixed in v2
> >>>>
> >>>> 4) Current implementation sets max length of packet to 64KB. IIUC th=
is
> >>>>   is due to 'kmalloc()' allocated data buffers. I think, in case of
> >>>>   MSG_ZEROCOPY this value could be increased, because 'kmalloc()' is
> >>>>   not touched for data - user space pages are used as buffers. Also
> >>>>   this limit trims every message which is > 64KB, thus such messages
> >>>>   will be send in copy mode due to 'iov_offset' check in 2).
> >>>>
> >>>>   ^^^ fixed in v2
> >>>>
> >>>>                         PATCHSET STRUCTURE
> >>>>
> >>>> Patchset has the following structure:
> >>>> 1) Handle non-linear skbuff on receive in virtio/vhost.
> >>>> 2) Handle non-linear skbuff on send in virtio/vhost.
> >>>> 3) Updates for AF_VSOCK.
> >>>> 4) Enable MSG_ZEROCOPY support on transports.
> >>>> 5) Tests/tools/docs updates.
> >>>>
> >>>>                            PERFORMANCE
> >>>>
> >>>> Performance: it is a little bit tricky to compare performance betwee=
n
> >>>> copy and zerocopy transmissions. In zerocopy way we need to wait whe=
n
> >>>> user buffers will be released by kernel, so it something like synchr=
onous
> >>>> path (wait until device driver will process it), while in copy way w=
e
> >>>> can feed data to kernel as many as we want, don't care about device
> >>>> driver. So I compared only time which we spend in the 'send()' sysca=
ll.
> >>>> Then if this value will be combined with total number of transmitted
> >>>> bytes, we can get Gbit/s parameter. Also to avoid tx stalls due to n=
ot
> >>>> enough credit, receiver allocates same amount of space as sender nee=
ds.
> >>>>
> >>>> Sender:
> >>>> ./vsock_perf --sender <CID> --buf-size <buf size> --bytes 256M [--zc=
]
> >>>>
> >>>> Receiver:
> >>>> ./vsock_perf --vsk-size 256M
> >>>>
> >>>> G2H transmission (values are Gbit/s):
> >>>>
> >>>> *-------------------------------*
> >>>> |          |         |          |
> >>>> | buf size |   copy  | zerocopy |
> >>>> |          |         |          |
> >>>> *-------------------------------*
> >>>> |   4KB    |    3    |    10    |
> >>>> *-------------------------------*
> >>>> |   32KB   |    9    |    45    |
> >>>> *-------------------------------*
> >>>> |   256KB  |    24   |    195   |
> >>>> *-------------------------------*
> >>>> |    1M    |    27   |    270   |
> >>>> *-------------------------------*
> >>>> |    8M    |    22   |    277   |
> >>>> *-------------------------------*
> >>>>
> >>>> H2G:
> >>>>
> >>>> *-------------------------------*
> >>>> |          |         |          |
> >>>> | buf size |   copy  | zerocopy |
> >>>> |          |         |          |
> >>>> *-------------------------------*
> >>>> |   4KB    |    17   |    11    |
> >>>
> >>> Do you know why in this case zerocopy is slower in this case?
> >>> Could be the cost of pin/unpin pages?
> >> May be, i think i need to analyze such enormous difference more. Also =
about
> >> pin/unpin: i found that there is already implemented function to fill =
non-linear
> >> skb with pages from user's iov: __zerocopy_sg_from_iter() in net/core/=
datagram.c.
> >> It uses 'get_user_pages()' instead of 'pin_user_pages()'. May be in my=
 case it
> >> is also valid to user 'get_XXX()' instead of 'pin_XXX()', because it i=
s used by
> >> TCP MSG_ZEROCOPY and iouring MSG_ZEROCOPY.
> >
> > If we can reuse them, it will be great!
> >
> >>
> >>>
> >>>> *-------------------------------*
> >>>> |   32KB   |    30   |    66    |
> >>>> *-------------------------------*
> >>>> |   256KB  |    38   |    179   |
> >>>> *-------------------------------*
> >>>> |    1M    |    38   |    234   |
> >>>> *-------------------------------*
> >>>> |    8M    |    28   |    279   |
> >>>> *-------------------------------*
> >>>>
> >>>> Loopback:
> >>>>
> >>>> *-------------------------------*
> >>>> |          |         |          |
> >>>> | buf size |   copy  | zerocopy |
> >>>> |          |         |          |
> >>>> *-------------------------------*
> >>>> |   4KB    |    8    |    7     |
> >>>> *-------------------------------*
> >>>> |   32KB   |    34   |    42    |
> >>>> *-------------------------------*
> >>>> |   256KB  |    43   |    83    |
> >>>> *-------------------------------*
> >>>> |    1M    |    40   |    109   |
> >>>> *-------------------------------*
> >>>> |    8M    |    40   |    171   |
> >>>> *-------------------------------*
> >>>>
> >>>> I suppose that huge difference above between both modes has two reas=
ons:
> >>>> 1) We don't need to copy data.
> >>>> 2) We don't need to allocate buffer for data, only for header.
> >>>>
> >>>> Zerocopy is faster than classic copy mode, but of course it requires
> >>>> specific architecture of application due to user pages pinning, buff=
er
> >>>> size and alignment.
> >>>>
> >>>> If host fails to send data with "Cannot allocate memory", check valu=
e
> >>>> /proc/sys/net/core/optmem_max - it is accounted during completion sk=
b
> >>>> allocation.
> >>>
> >>> What the user needs to do? Increase it?
> >>>
> >> Yes, i'll update it.
> >>>>
> >>>>                            TESTING
> >>>>
> >>>> This patchset includes set of tests for MSG_ZEROCOPY feature. I trie=
d to
> >>>> cover new code as much as possible so there are different cases for
> >>>> MSG_ZEROCOPY transmissions: with disabled SO_ZEROCOPY and several io
> >>>> vector types (different sizes, alignments, with unmapped pages). I a=
lso
> >>>> run tests with loopback transport and running vsockmon.
> >>>
> >>> Thanks for the test again :-)
> >>>
> >>> This cover letter is very good, with a lot of details, but please add
> >>> more details in each single patch, explaining the reason of the chang=
es,
> >>> otherwise it is very difficult to review, because it is a very big
> >>> change.
> >>>
> >>> I'll do a per-patch review in the next days.
> >>
> >> Sure, thanks! In v3 i'm also working on io_uring test, because this th=
ing also
> >> supports MSG_ZEROCOPY, so we can do virtio/vsock + MSG_ZEROCOPY + io_u=
ring.
> >
> > That would be cool!
> >
> > Do you want to me to review these patches or it is better to wait for v=
3?
>
> I think it is ok to wait for v3, as i'm going to reduce size of new kerne=
l source code,
> especially by reusing already implemented functions instead of my own.

Okay, great! I'll wait for it ;-)

Thanks,
Stefano

