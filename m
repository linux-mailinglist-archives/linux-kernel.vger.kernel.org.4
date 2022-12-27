Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9862D6568F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiL0JjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiL0JjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE02637
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672133912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3BLtHqoydlVUf+z9Cs67tPhoqV/CQzv2c7yUWqYhoE=;
        b=FGXHCX7/J1P9lPs3V0pXOwU6ADXhRDfzVKrgxBwG4hveR07PHhDR2n8DN7kxtUr1ke64HC
        qZOI+aIAz5ABo0I3n2MANhvg81l3LHXSeBZLjNHTRGjIoIjedJK7v4pSQAlyKsAQrbT4/n
        vEXJVRbQ7SroHB8Gefiv7lKINgVVUW8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-_9_JRL3vMLeCaLAq19NQbw-1; Tue, 27 Dec 2022 04:38:30 -0500
X-MC-Unique: _9_JRL3vMLeCaLAq19NQbw-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020a05640227cc00b004853521ef55so2770022ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3BLtHqoydlVUf+z9Cs67tPhoqV/CQzv2c7yUWqYhoE=;
        b=l2A+IIHuKAzFMI25GpkF1wrjiz1XZEbVPwMa331AnzAOQdrbmGGcvMVVUNNFfp7NtO
         HgHjNGumWXUBNBckX7BnWeczm66sbuOTqiMAYXDSusdJ30mhD/n25Lqm7hqEco3VCFPZ
         mgTLsn0z81FxytFxsJgDQbWQiVpc87UW5qX46Zdr9PZOM8EaFd69uhSi7VABV9aLA/xb
         TKCbMy3sHZ2L2UQnNRxdl0TyMHjtF8PkQoQKScREsvx4No1wTNmVVQgMUBVcy5P/wg91
         tAYDXIB3rfdmTfTId6ZhQYnOen+MRGOEKzfwd0jaMRe6LBgdq+4manM7ngFl6Qp+o5dJ
         5M4A==
X-Gm-Message-State: AFqh2kq6LuF5zi7KXSAfGpx4STkcsfpX1g6kUOx9ZCNeSagPjMzwzZ+d
        /Ggh+dT/8outZge3ZbZBdj0X+JT9cWtfT5/8lvK9sm5JQnwz2LJLOLd2N/o9CELOapKjNdCg3aj
        bSRAI0JYMeI4uYUtL9NDBi0Ww
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id qf4-20020a1709077f0400b007c100369002mr21415454ejc.67.1672133909656;
        Tue, 27 Dec 2022 01:38:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1izE+/u+Tuwf8tjP2vCdjI4kLYsk008OtSrOIXpnLKNcCpaysWJW9Xx5P3ns02pTzhv/LQg==
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id qf4-20020a1709077f0400b007c100369002mr21415444ejc.67.1672133909480;
        Tue, 27 Dec 2022 01:38:29 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906218900b007c4fbb79535sm5873901eju.82.2022.12.27.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 01:38:28 -0800 (PST)
Date:   Tue, 27 Dec 2022 04:38:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221227043148-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
 <20221227022255-mutt-send-email-mst@kernel.org>
 <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d77bc1ce-b73f-1ba8-f04f-b3bffeb731c3@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 05:12:58PM +0800, Jason Wang wrote:
> 
> 在 2022/12/27 15:33, Michael S. Tsirkin 写道:
> > On Tue, Dec 27, 2022 at 12:30:35PM +0800, Jason Wang wrote:
> > > > But device is still going and will later use the buffers.
> > > > 
> > > > Same for timeout really.
> > > Avoiding infinite wait/poll is one of the goals, another is to sleep.
> > > If we think the timeout is hard, we can start from the wait.
> > > 
> > > Thanks
> > If the goal is to avoid disrupting traffic while CVQ is in use,
> > that sounds more reasonable. E.g. someone is turning on promisc,
> > a spike in CPU usage might be unwelcome.
> 
> 
> Yes, this would be more obvious is UP is used.
> 
> 
> > 
> > things we should be careful to address then:
> > 1- debugging. Currently it's easy to see a warning if CPU is stuck
> >     in a loop for a while, and we also get a backtrace.
> >     E.g. with this - how do we know who has the RTNL?
> >     We need to integrate with kernel/watchdog.c for good results
> >     and to make sure policy is consistent.
> 
> 
> That's fine, will consider this.
> 
> 
> > 2- overhead. In a very common scenario when device is in hypervisor,
> >     programming timers etc has a very high overhead, at bootup
> >     lots of CVQ commands are run and slowing boot down is not nice.
> >     let's poll for a bit before waiting?
> 
> 
> Then we go back to the question of choosing a good timeout for poll. And
> poll seems problematic in the case of UP, scheduler might not have the
> chance to run.

Poll just a bit :) Seriously I don't know, but at least check once
after kick.

> 
> > 3- suprise removal. need to wake up thread in some way. what about
> >     other cases of device breakage - is there a chance this
> >     introduces new bugs around that? at least enumerate them please.
> 
> 
> The current code did:
> 
> 1) check for vq->broken
> 2) wakeup during BAD_RING()
> 
> So we won't end up with a never woke up process which should be fine.
> 
> Thanks


BTW BAD_RING on removal will trigger dev_err. Not sure that is a good
idea - can cause crashes if kernel panics on error.

> 
> > 
> > 

