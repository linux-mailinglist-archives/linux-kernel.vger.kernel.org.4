Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8D651ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiLTGpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiLTGpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:45:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18447638D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671518669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwzbCVxJgzqh/hZntLgZPVw/8F+zWvpGjiJvEA/MIXQ=;
        b=fOT8LjDr7XUfp+a4RAtm99I9HZKBSmGtUs5DevYXnP1VicAX0sU7YKconJeIBCf2CGBndk
        rQs3jHOX8Y5FbW823MVFZcLo40XNGc7PVkyN8ef81sDUiH4oqTTSodFiv5wI3IJSGCz4Y1
        ustFzTjHLSCfVijSgtmCwflVEg+T2yY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-qPomGjvvM2OQfM1RlrzlUg-1; Tue, 20 Dec 2022 01:44:28 -0500
X-MC-Unique: qPomGjvvM2OQfM1RlrzlUg-1
Received: by mail-ot1-f70.google.com with SMTP id cj4-20020a056830640400b0066dee63bd77so6578310otb.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwzbCVxJgzqh/hZntLgZPVw/8F+zWvpGjiJvEA/MIXQ=;
        b=EzSuCeJpuvyprZUbS40ixA4m5WhocUumPWUbtScpVPDaHK8WA4nmohVWnGPXyLDxne
         jr0cQkkcCAGE3g7FqBPwMiiBbuvEZc+bA7SSFdAHUmn7SZ56wGAPoytVbvmy8a0ud/EU
         +7L2ihc8WNqWep3qIvjZTJdCkwcafJq5JlJexxhiMsO5zaVwmcJA68/np1GVtS+7gLV7
         ypOSjJ5x+gzIEPMNMWHb5gou1EaAQg4zPKpQ87aPFrYflyiqaK1spBp9zCxTYJw1ipX/
         xHUtJJGXOy02WjelIDeAds7jS7AUOUYFTOjAr8vWJqFVjfb8T/0goRCuF/E+639VOSCo
         YUFQ==
X-Gm-Message-State: ANoB5pmWDD+aQL6GNE5zAOvSjvmlgcVBIDcqeerF8SjfPOQuQQ56G32V
        /sNnPoZZG4LKyJ8kL63iYupzHEgDbI8FT0irfwiBoYv2L0OMVsTYEZ2D3z97m8vqYVoYHd0P5iJ
        qh9tgKF2IWLlxwr2VKv5LqOOyFkGlePnX95vfdDPa
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id u12-20020a056808114c00b0035e7a427ab5mr1228661oiu.280.1671518667327;
        Mon, 19 Dec 2022 22:44:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jGysDqwGrWJu197Nisc2Stp5MBJuSZWK+fp7URpsNdbjTOdPL95/ws7E6NNNRPis0ciTrq34bL9g/AETi3fk=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr1228649oiu.280.1671518667107; Mon, 19
 Dec 2022 22:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com> <20221128042945-mutt-send-email-mst@kernel.org>
 <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com> <20221219050716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219050716-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 14:44:16 +0800
Message-ID: <CACGkMEsHojBVQWUDH4L1xiVTjNm3JgkYBppyOHKr8QLUg3=FsQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Li Zetao <lizetao1@huawei.com>, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk, kraxel@redhat.com,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, rusty@rustcorp.com.au,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 6:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 29, 2022 at 11:37:09AM +0800, Jason Wang wrote:
> > >
> > >
> > > Quite a lot of core work here. Jason are you still looking into
> > > hardening?
> >
> > Yes, last time we've discussed a solution that depends on the first
> > kick to enable the interrupt handler. But after some thought, it seems
> > risky since there's no guarantee that the device work in this way.
> >
> > One example is the current vhost_net, it doesn't wait for the kick to
> > process the rx packets. Any more thought on this?
> >
> > Thanks
>
> Specifically virtio net is careful to call virtio_device_ready
> under rtnl lock so buffers are only added after DRIVER_OK.

Right but it only got fixed this year after some code audit.

>
> However we do not need to tie this to kick, this is what I wrote:
>
> > BTW Jason, I had the idea to disable callbacks until driver uses the
> > virtio core for the first time (e.g. by calling virtqueue_add* family of
> > APIs). Less aggressive than your ideas but I feel it will add security
> > to the init path at least.
>
> So not necessarily kick, we can make adding buffers allow the
> interrupt.

Some questions:

1) It introduces a code defined behaviour other than depending on the
spec defined behavior like DRIVER_OK, this will lead extra complexity
in auditing
2) there's no guarantee that the interrupt handler is ready before
virtqueue_add(), or it requires barriers before virtqueue_add() to
make sure the handler is commit

So it looks to me the virtio_device_ready() should be still the
correct way to go:

1) it depends on spec defined behaviour like DRIVER_OK, and it then
can comply with possible future security requirement of drivers
defined in the spec
2) choose to use a new boolean instead of reusing vq->broken
3) enable the harden in driver one by one

Does it make sense?

Thanks

>
>
>
> --
> MST
>

