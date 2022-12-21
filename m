Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD03652CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiLUGgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiLUGfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E21EC51
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671604509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oogjy+HZSATwQ8rGTEmVI9Wh5GRJb31ePjraWFpnkQk=;
        b=eja6HyZ/Kk/6V2g3NdFBxcDSvqimdxB5aVkN5K+LbtejNkrxf/iX1sTyQbikZB9S9Yza0g
        1IaF8IKfpvSK7nlepptWrN7za+VthIXR9gmAKAY3SNZNfG2mlkq6H632IQhdQ/d90wEiOR
        fgOhTbAficxHtOFmwkMiHyOEgBsipAc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-m0jwKiuzM_a5dfYDYr0dUA-1; Wed, 21 Dec 2022 01:35:08 -0500
X-MC-Unique: m0jwKiuzM_a5dfYDYr0dUA-1
Received: by mail-qt1-f199.google.com with SMTP id n26-20020ac8675a000000b003a97d74d134so4333349qtp.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oogjy+HZSATwQ8rGTEmVI9Wh5GRJb31ePjraWFpnkQk=;
        b=MGgtgeP2ghyuX3mYXVsFtFWG/B6VmFY+OyFROE8or1jtyeJaLT5vLtSpnjZKBkVC5l
         QKeAQl69xV9V53QliRQjRpfz0G+FXkwpdENRIIFQBeKo1vejDRQLjCBj4Kl8eVdoHwAM
         OczZxjnDdpVvnM45Trxz3tXmeygbyaEb52kYUe+d0a62WHjChe2sOr7hzLuZbAK5+/q5
         W6TpPPIFh2yhC+hLRIzD4TMzt1tAUGiv0LX9pwBDnQl/+25VVquDtofbbKUCvHl2AQKz
         2QuqaRhTvIGO5QPa6LP8QXSUs0ONm1vsxKbQvcK8zWfOUnR0X04owsKzi6YhwtUCA1/4
         2VDw==
X-Gm-Message-State: AFqh2krYxAJrn+2HPZ5amgKp4vCjVcNgXs9bOV1mbjEJ7A8W/YgC/evg
        OrJrRNZZcGcRMtluLHWlmGTtXuaRhH1DVpC2IXpb6SpfynWATro4Lp9OOSmAaHlFmHedgjcEbfQ
        SiDs+DtpwvVbch55KsYUm0Rhn
X-Received: by 2002:ac8:5e8f:0:b0:3a6:a292:286c with SMTP id r15-20020ac85e8f000000b003a6a292286cmr634084qtx.18.1671604507911;
        Tue, 20 Dec 2022 22:35:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvLb3tolXBEGGnqe6rCD+KVURXzM+dzc3FfO7RoLpOTxOFn0WRR3dQpaeRRHkQJy4ymraACkQ==
X-Received: by 2002:ac8:5e8f:0:b0:3a6:a292:286c with SMTP id r15-20020ac85e8f000000b003a6a292286cmr634076qtx.18.1671604507655;
        Tue, 20 Dec 2022 22:35:07 -0800 (PST)
Received: from redhat.com ([37.19.199.117])
        by smtp.gmail.com with ESMTPSA id h9-20020ac81389000000b003a530a32f67sm8639661qtj.65.2022.12.20.22.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:35:07 -0800 (PST)
Date:   Wed, 21 Dec 2022 01:35:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
Message-ID: <20221221013359-mutt-send-email-mst@kernel.org>
References: <20221220140205.795115-1-lulu@redhat.com>
 <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 11:23:09AM +0800, Jason Wang wrote:
> On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> > But some function was not changed while calling this function.
> > Add this change
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")
> 
> Is this commit merged into Linus tree?
> 
> Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
> can squash the fix into the new version?
> 
> Thanks

Thanks, I fixed it myself already. Why do you want a respin?
That will mean trouble as the fixed patch is now being tested.


> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vdpa.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 46ce35bea705..ec32f785dfde 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
> >  static dev_t vhost_vdpa_major;
> >
> >  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> > -                                  struct vhost_iotlb *iotlb,
> > -                                  u64 start, u64 last);
> > +                                  struct vhost_iotlb *iotlb, u64 start,
> > +                                  u64 last, u32 asid);
> >
> >  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> >  {
> > @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> >                 return -EINVAL;
> >
> >         hlist_del(&as->hash_link);
> > -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> > +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> >         kfree(as);
> >
> >         return 0;
> > --
> > 2.34.3
> >

