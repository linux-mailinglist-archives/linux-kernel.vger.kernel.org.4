Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CCA71783D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjEaH31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjEaH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA6186
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685518088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/jcj1p+dPSX4LPtsNzKmq9GtWWjgKaTvB7WD/Tt27U=;
        b=RYO+BX4XX3EvuqiVeJsxz6VaPTU+Wdl7Sc8TVz2xEvetWlsntNu0aKAIWlJaCblRguMdaU
        xe9AKwzSL4BQWiEyqZ8PHp8RTfOhUfupOVP9og8YAhf2RWzmU0A7fk/lPGAnb2XboCxcy0
        M1DrUtet1zeg6Qx3nbQLZG+nXIDp5fM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-J9PtVEbQNp-6jlJXw1xHRA-1; Wed, 31 May 2023 03:28:07 -0400
X-MC-Unique: J9PtVEbQNp-6jlJXw1xHRA-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-ba8338f20bdso6326195276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685518086; x=1688110086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/jcj1p+dPSX4LPtsNzKmq9GtWWjgKaTvB7WD/Tt27U=;
        b=k/FFYB4stt3upH4hWyxT1sD9m+/xAn7iNdne0KKO980GLiVodt9RDb5DIjCSbrShyq
         xBiK/bKgULFz+hv1pMgyqpfkNzhMY16o8nDnCP6tmT1SKLRS8e4sUv2Xt6vYqtsNx/+k
         EvMwO3ZLOfqqPJHvorA7Iur7GlXwSLh6eV+DsRqlHIkkwev1l8FD7yvgEStq49+xjX7M
         L83QrrL5/gqenSWY3pt71RBmjiiPQZxBmksJWITZAprOX01rZFchsEt8biSK686r1nAl
         KTaivQM16teUswSO/NW+2r2HbFqh6OcwKafdOdUakMAiK1OywgECWmiMbq7+Qv3vyOvM
         a8bw==
X-Gm-Message-State: AC+VfDyEZftUlYc4k8LtQQF0SxMXXKacBVBS1OiswhE6HO5M4XMIqlbo
        lKAh9oX8dI5ob4RR9ZHbZNfo1cdhTmx8EAu9K09S/JtIaMXi85dXTiUJOA5QwLsCOwxcbH5ivBx
        1/eYNGzgnaRGhAVpDW9YIMzF+eL8e/mJYk+D14tll
X-Received: by 2002:a25:e74a:0:b0:ba8:c000:3da8 with SMTP id e71-20020a25e74a000000b00ba8c0003da8mr5501232ybh.32.1685518086707;
        Wed, 31 May 2023 00:28:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Plgt9hmPFiSDXc0oeLAkYKsykTTqd4B5pwE2g+dpW8bCb+6KVSnOeDacyokQkuQP23w/NyGAste2scW2tm4Y=
X-Received: by 2002:a25:e74a:0:b0:ba8:c000:3da8 with SMTP id
 e71-20020a25e74a000000b00ba8c0003da8mr5501224ybh.32.1685518086460; Wed, 31
 May 2023 00:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001777f605fce42c5f@google.com> <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com> <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
 <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
In-Reply-To: <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Wed, 31 May 2023 09:27:54 +0200
Message-ID: <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in vhost_work_queue
To:     michael.christie@oracle.com
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 6:30=E2=80=AFPM <michael.christie@oracle.com> wrote=
:
>
> On 5/30/23 11:17 AM, Stefano Garzarella wrote:
> > On Tue, May 30, 2023 at 11:09:09AM -0500, Mike Christie wrote:
> >> On 5/30/23 11:00 AM, Stefano Garzarella wrote:
> >>> I think it is partially related to commit 6e890c5d5021 ("vhost: use
> >>> vhost_tasks for worker threads") and commit 1a5f8090c6de ("vhost: mov=
e
> >>> worker thread fields to new struct"). Maybe that commits just
> >>> highlighted the issue and it was already existing.
> >>
> >> See my mail about the crash. Agree with your analysis about worker->vt=
sk
> >> not being set yet. It's a bug from my commit where I should have not s=
et
> >> it so early or I should be checking for
> >>
> >> if (dev->worker && worker->vtsk)
> >>
> >> instead of
> >>
> >> if (dev->worker)
> >
> > Yes, though, in my opinion the problem may persist depending on how the
> > instructions are reordered.
>
> Ah ok.
>
> >
> > Should we protect dev->worker() with an RCU to be safe?
>
> For those multiple worker patchsets Jason had asked me about supporting
> where we don't have a worker while we are swapping workers around. To do
> that I had added rcu around the dev->worker. I removed it in later patchs=
ets
> because I didn't think anyone would use it.
>
> rcu would work for your case and for what Jason had requested.

Yeah, so you already have some patches?

Do you want to send it to solve this problem?

Thanks,
Stefano

