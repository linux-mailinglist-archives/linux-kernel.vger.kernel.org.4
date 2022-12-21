Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1D652D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiLUGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB61F2C4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671605341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/4TAy3lxZDNq7ujOJb9FKrW+iCRhzmTxD7N7cv0eCg=;
        b=M0Gx+SvVFpoLKQ8Odmy7Q5rAifxcqFJ0UeQOoJk1fXnQz3bHryG2OlrnpaokTj01rYhf4v
        Oj7NVg0BdHTuUOn23MfWPfNK15nnmO3Hy9TkuStP/uu8PvD2Fdt3W+b/WIGNe4WQMLV8/I
        KnKg3r5OE0G63ge/dw+KyB3UAYGoLn4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-kjiDS59sMcqND9-MV6_UWA-1; Wed, 21 Dec 2022 01:48:52 -0500
X-MC-Unique: kjiDS59sMcqND9-MV6_UWA-1
Received: by mail-oo1-f71.google.com with SMTP id u22-20020a4a6c56000000b004a38aa46a1fso6663287oof.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/4TAy3lxZDNq7ujOJb9FKrW+iCRhzmTxD7N7cv0eCg=;
        b=jLRoLzARokAFvR+kYWelLpXzRQX88X/t9V57Ox9N1MdEMCoBjmUQuu73WWnGr3fdr4
         b6lfmmbQA1Xh2QOocUKgD1GHTuheOyz4OUo5jfKiFkFYI97Yrd6RfTH0ANLjt6qDcqLD
         IssedVNBAEMw3zUqAUj49usNRxMyy9WThYqny5EAfYcR6nIKSXtnWSTgqtlZv+PCC8jo
         3MC/iqL1lCqa73zz3dMDj04QzZmq+e+b9OfJwc4h/wPgNtmfcSF301CmvB138y4EJQUf
         D3bnLtM84MXAGbydyAQsfzUk6D+8WWgV4bTyW2qyQDgey6+zrQx38egHh+KJZrKOm22o
         3r/g==
X-Gm-Message-State: AFqh2kr3buMXpkvUgrXJVNiuJ4QrZ1cfCdFildHRx7QlrdHXzyhMnCwc
        iZ3qPheaoZ1LCsl1UpGeCIrgX8IGHKBiZUowFudULvrWrufdOUq/xhLKjP1GclJqCtP8dZdtYRy
        RVWIum4s4U3ECgwnTUjt5HOy5msBsvNPGoh0gg/Fi
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id u19-20020a056870441300b00144a97b1ae2mr29059oah.35.1671605331286;
        Tue, 20 Dec 2022 22:48:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu80udxD6YrnxsV720q5HV+2HR8kMLdfBS0FZI0RkgPvpsYJe396SNLloD8Y2DlUjugZ1aCdXjvrEHubwRFXk0=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr29055oah.35.1671605331053; Tue, 20 Dec
 2022 22:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20221220140205.795115-1-lulu@redhat.com> <CACGkMEuJuUrA220XgHDOruK-aHWSfJ6mTaqNVQCAcOsPEwV91A@mail.gmail.com>
 <20221221013359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221221013359-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 21 Dec 2022 14:48:40 +0800
Message-ID: <CACGkMEuXPoR_yp3ZC7XH4TZ8NdL21kWtJaxq22+VU7RQG13f8Q@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the compile issue in commit 881ac7d2314f
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 2:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Dec 21, 2022 at 11:23:09AM +0800, Jason Wang wrote:
> > On Tue, Dec 20, 2022 at 10:02 PM Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > The input of  vhost_vdpa_iotlb_unmap() was changed in 881ac7d2314f,
> > > But some function was not changed while calling this function.
> > > Add this change
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 881ac7d2314f ("vhost_vdpa: fix the crash in unmap a large memory")
> >
> > Is this commit merged into Linus tree?
> >
> > Btw, Michael, I'd expect there's a respin of the patch so maybe Cindy
> > can squash the fix into the new version?
> >
> > Thanks
>
> Thanks, I fixed it myself already. Why do you want a respin?

For some reason I miss v4, so it should be fine.

Thanks

> That will mean trouble as the fixed patch is now being tested.
>
>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 46ce35bea705..ec32f785dfde 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -66,8 +66,8 @@ static DEFINE_IDA(vhost_vdpa_ida);
> > >  static dev_t vhost_vdpa_major;
> > >
> > >  static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> > > -                                  struct vhost_iotlb *iotlb,
> > > -                                  u64 start, u64 last);
> > > +                                  struct vhost_iotlb *iotlb, u64 start,
> > > +                                  u64 last, u32 asid);
> > >
> > >  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
> > >  {
> > > @@ -139,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
> > >                 return -EINVAL;
> > >
> > >         hlist_del(&as->hash_link);
> > > -       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
> > > +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> > >         kfree(as);
> > >
> > >         return 0;
> > > --
> > > 2.34.3
> > >
>

