Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D8746E25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGDKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjGDKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78807E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688464774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=892aSalStYsQtwptK7t1c8HIhOOHEUNVf5ArLGswb+M=;
        b=clAFMLIO/SSTyVkTTgBIlXftRafs8ivjSjjfw2k7bslktXiGb1KMroyZysOSzOVl5cVQK1
        F9DF73xSzIYV4DC3B15iTg2Y0AOwnsrVJf12Ni9Kd7WQmnYKLEpV9RVXu5V0ed/1gEdghp
        bADxt142SO+hF2K9uPDqmwumY9yLqTg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-pk1VdRpcNjWvH_AY0oExgg-1; Tue, 04 Jul 2023 05:59:33 -0400
X-MC-Unique: pk1VdRpcNjWvH_AY0oExgg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31273e0507dso3130545f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688464772; x=1691056772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=892aSalStYsQtwptK7t1c8HIhOOHEUNVf5ArLGswb+M=;
        b=KKhWpDHf67cqYFu9cQ+fuWS8iyHXUPXugCaR/y8Be4FjXD6l9s409PbkyIT9gCAQbb
         Bbmuvtc66+eSH3E9aK+UEHCFt/RZ9FxHMwhZ0gakjEWOHUhT/EeOxtqfiByfLF58Urk/
         xDp1CKKrDqUSZ0vX0czSN6biMZ//wpJIxvLf6pgrHhJs0JDzv4mx8RSpf5jxUHcvqc7t
         3IyKngFycCzHhdZ2DRlqY4/EMUXoX3pQNodPxORKpN7un+1xOK5o96fnRZ/Y6TmUABPN
         SWsmc/BRA9cxYjh7AOEdpx/tBqVC547SUNykhn5FGZtKZaMiYS092e9ZMgvRyHOQ4RFF
         3UYg==
X-Gm-Message-State: ABy/qLZ45cA5Fva4Hl4rvDszKi8JJWqxbEk2RMjNh/j9Y/P4qWRX9el0
        tzs3kZxA5khrA8li6ofFR7GQiAHqEQz8iurg9TFIs1OJkfIc79R8v9EbbH5w0S8zQEOxSMc4tXF
        lUF+Bxjc3l0w3kNVQq55jy2Ru
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id q17-20020a5d61d1000000b00314012c4322mr9924369wrv.4.1688464772566;
        Tue, 04 Jul 2023 02:59:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFd/q5uFdR61nqrA+b7m+WX8tW3+kCffk5PcW2uKNzWMNMUWwL7eXK2DeOry/96kNoaIexczg==
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id q17-20020a5d61d1000000b00314012c4322mr9924352wrv.4.1688464772214;
        Tue, 04 Jul 2023 02:59:32 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b003142b0d98b4sm8771005wrt.37.2023.07.04.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 02:59:31 -0700 (PDT)
Date:   Tue, 4 Jul 2023 05:59:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230704055840-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
 <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 10:43:07AM +0200, Maxime Coquelin wrote:
> 
> 
> On 7/3/23 23:45, Michael S. Tsirkin wrote:
> > On Mon, Jul 03, 2023 at 09:43:49AM +0200, Maxime Coquelin wrote:
> > > 
> > > On 7/3/23 08:44, Jason Wang wrote:
> > > > On Sun, Jul 2, 2023 at 9:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> > > > > > This small series enables virtio-net device type in VDUSE.
> > > > > > With it, basic operation have been tested, both with
> > > > > > virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> > > > > > adding VDUSE support using split rings layout (merged in
> > > > > > DPDK v23.07-rc1).
> > > > > > 
> > > > > > Control queue support (and so multiqueue) has also been
> > > > > > tested, but requires a Kernel series from Jason Wang
> > > > > > relaxing control queue polling [1] to function reliably.
> > > > > > 
> > > > > > [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> > > > > 
> > > > > Jason promised to post a new version of that patch.
> > > > > Right Jason?
> > > > 
> > > > Yes.
> > > > 
> > > > > For now let's make sure CVQ feature flag is off?
> > > > 
> > > > We can do that and relax on top of my patch.
> > > 
> > > I agree? Do you prefer a features negotiation, or failing init (like
> > > done for VERSION_1) if the VDUSE application advertises CVQ?
> > > 
> > > Thanks,
> > > Maxime
> > 
> > Unfortunately guests fail probe if feature set is inconsistent.
> > So I don't think passing through features is a good idea,
> > you need a list of legal bits. And when doing this,
> > clear CVQ and everything that depends on it.
> 
> Since this is temporary, while cvq is made more robust, I think it is
> better to fail VDUSE device creation if CVQ feature is advertised by the
> VDUSE application, instead of ensuring features depending on CVQ are
> also cleared.
> 
> Jason seems to think likewise, would that work for you?
> 
> Thanks,
> Maxime

Nothing is more permanent than temporary solutions.
My concern would be that hardware devices then start masking CVQ
intentionally just to avoid the pain of broken software.

> > 
> > 
> > > > Thanks
> > > > 
> > > > > 
> > > > > > RFC -> v1 changes:
> > > > > > ==================
> > > > > > - Fail device init if it does not support VERSION_1 (Jason)
> > > > > > 
> > > > > > Maxime Coquelin (2):
> > > > > >     vduse: validate block features only with block devices
> > > > > >     vduse: enable Virtio-net device type
> > > > > > 
> > > > > >    drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> > > > > >    1 file changed, 11 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > --
> > > > > > 2.41.0
> > > > > 
> > > > 
> > 

