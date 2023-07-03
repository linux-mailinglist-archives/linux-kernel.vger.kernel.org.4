Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106BB746507
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGCVrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGCVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E6E47
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688420784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tARB5Wn5Gx1zOd7JWlq2DBGoUqFTRjKmGP2nqR1fdFE=;
        b=KWiahIhd0MIYfdHggjmf0iR3FxsOoVkUmBElumm9D+0mQ5ScyZOMs8qAiHZQIKD6NSjyWt
        L2fIVd2buC+nbHT2UJ5RiBGVCevvM3eSGnfar0ltn+bXzCEJGcCc1vgXt2PSTuaZ3vUdtu
        G9bUiSD6j0gfs2SbUlQS6wdfrTNaY4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-tUgAOJwkN1Gf6SHoF5jujg-1; Mon, 03 Jul 2023 17:45:14 -0400
X-MC-Unique: tUgAOJwkN1Gf6SHoF5jujg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3141325af78so3324921f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 14:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688420713; x=1691012713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tARB5Wn5Gx1zOd7JWlq2DBGoUqFTRjKmGP2nqR1fdFE=;
        b=af2IS1cQsQjwgw4j/ryo41062GHF990grActoUEDUKyb3ZwWEUF0oxjdVDqE17vNzg
         KtrfjDbq6gmZ1J79PCVd8kdgmuQBBvbj9FkiuB34z19s8adyhoIWaVPnQUe58SSswQuR
         OPHAuTuWwPbauC45u4Lltt7z3ZJSST/Kmi4MuExEGoOuLadWOhtU4P0AroKFxED3hksI
         Nq0b08YsXwhi7qIzFLGm6nsn+v/qiUcvnNSjbQgxJVpxU0Gwr0jmxt0TcAZlDyqJraNH
         PYDCFQBN6tkofA03fIi512bTX2IBpRFhTuZoMSZITCjHGjm4zqI5eujp/D6j/+T69axB
         sZqA==
X-Gm-Message-State: ABy/qLZDkPuvZPmBu0p5Jhc443eBCZXOogumXDwdmm2LhGHW3nSC4gfz
        snrK+T1oxmOWErN9M4V/JgSWnpTKBls+lOaggaTRII0juHyGZjquwretv5uKQCIpmSvw9o1dzm3
        rMa0n1Rlu1EWW0FDX+tZXBTycaxIiBMSl
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id n2-20020adffe02000000b00313f124aa53mr9386206wrr.45.1688420713232;
        Mon, 03 Jul 2023 14:45:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwxrKykcKROIp8288hJK2F1DWQTpGg+15j/Wx8NbEXoDCuZbeNevgm5l58+rk/qYWMMQkJGg==
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id n2-20020adffe02000000b00313f124aa53mr9386193wrr.45.1688420712899;
        Mon, 03 Jul 2023 14:45:12 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b003143d80d11dsm611369wrw.112.2023.07.03.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 14:45:12 -0700 (PDT)
Date:   Mon, 3 Jul 2023 17:45:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230703174043-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:43:49AM +0200, Maxime Coquelin wrote:
> 
> On 7/3/23 08:44, Jason Wang wrote:
> > On Sun, Jul 2, 2023 at 9:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> > > > This small series enables virtio-net device type in VDUSE.
> > > > With it, basic operation have been tested, both with
> > > > virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> > > > adding VDUSE support using split rings layout (merged in
> > > > DPDK v23.07-rc1).
> > > > 
> > > > Control queue support (and so multiqueue) has also been
> > > > tested, but requires a Kernel series from Jason Wang
> > > > relaxing control queue polling [1] to function reliably.
> > > > 
> > > > [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> > > 
> > > Jason promised to post a new version of that patch.
> > > Right Jason?
> > 
> > Yes.
> > 
> > > For now let's make sure CVQ feature flag is off?
> > 
> > We can do that and relax on top of my patch.
> 
> I agree? Do you prefer a features negotiation, or failing init (like
> done for VERSION_1) if the VDUSE application advertises CVQ?
> 
> Thanks,
> Maxime

Unfortunately guests fail probe if feature set is inconsistent.
So I don't think passing through features is a good idea,
you need a list of legal bits. And when doing this,
clear CVQ and everything that depends on it.



> > Thanks
> > 
> > > 
> > > > RFC -> v1 changes:
> > > > ==================
> > > > - Fail device init if it does not support VERSION_1 (Jason)
> > > > 
> > > > Maxime Coquelin (2):
> > > >    vduse: validate block features only with block devices
> > > >    vduse: enable Virtio-net device type
> > > > 
> > > >   drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
> > > >   1 file changed, 11 insertions(+), 4 deletions(-)
> > > > 
> > > > --
> > > > 2.41.0
> > > 
> > 

