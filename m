Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE896609828
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJXCRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJXCRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D972950
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666577860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5ejgXTPkf9QyM7vcgzmFiIJ4FUH4N8fN2CgcASFjFc=;
        b=b7ssFmebHmIvOnvaz9oY4xo+KfZrynMVCBGA6P04xsEZ3MnB06KuZS2ZKMyqQIka2TwOmD
        pM8Omeld0kp1qOjHI7sU++Ik94e75nvIQZw6if9iO1HUqSlwFwYWy1JNukPJ89Tz6Bw4r3
        xLpgAD5hnwZ+O5+wszb3QSjrm8pDN0o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-JdqdKJn1Mfm54mrLg68WHw-1; Sun, 23 Oct 2022 22:17:36 -0400
X-MC-Unique: JdqdKJn1Mfm54mrLg68WHw-1
Received: by mail-ed1-f69.google.com with SMTP id v13-20020a056402348d00b0045d36615696so7983899edc.14
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5ejgXTPkf9QyM7vcgzmFiIJ4FUH4N8fN2CgcASFjFc=;
        b=ZYv0VQqGozmCS6LOz6sOhgtmABHymQWMJMrSXMRbn4TflY7RH4XaeSS6+kgJZUq6+W
         n+8I+kMsOXVCAYxVuYH3GALO3WaI3zdKheT8xxhcqg7GvR18dOWECuB44EyD0n23Ct/R
         NCyVeU8+iw9o9zU+6Ba3+M4Dz4+iOtDSRksjlktrdyatT+XnP52ZGlqogw4BqN0dPWi8
         lS5AjDBK3l2YWwd+Gdw66oqVxejtxs4Kk+o7s2znNkwGW+qKZquy7fo5EFCNne0Pv55w
         aVAN8tswxpGK69uyOE1o/10Rcbdb290sPBt4J3rbEEst67EllIa5kEcIlQvICMgL8aAv
         rLGw==
X-Gm-Message-State: ACrzQf1yEu6CPJ9fFKA2R3bb/YBclhbt79NuC1YWlowqbqVqqG9rbgXJ
        FB12mEiEYg9UyzyDB7qZnMsGRnt4Cxd8wEkLjQopcJvjXRxrDOeoLjr4CtGKEUgnxoj9E3i5gpC
        mnw/2cPyBrrnvLPnC21IUYHpD66OCwUvkygnJo7Yc
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id mp31-20020a1709071b1f00b0072f56dbcce9mr24877731ejc.605.1666577855632;
        Sun, 23 Oct 2022 19:17:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4V4+oouWykGGn8UXC6mX8Y9laaJOnj+0dXphRCw8klmWC6rlnvVSDb4GdYlsBcZV+YqjW90k9m84ED2AwLQCs=
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id
 mp31-20020a1709071b1f00b0072f56dbcce9mr24877721ejc.605.1666577855494; Sun, 23
 Oct 2022 19:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
 <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com> <TY2PR06MB342493C73F9119E847765796852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB342493C73F9119E847765796852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 24 Oct 2022 10:17:22 +0800
Message-ID: <CACGkMEsVP8qwT5aOqvwp-YjswT59Ctu6jDfYPBftzbn_wb7ZzA@mail.gmail.com>
Subject: Re: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:16 AM Angus Chen <angus.chen@jaguarmicro.com> wr=
ote:
>
> Hi Jason
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, October 24, 2022 10:01 AM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; lingshan.zhu@intel.com
> > Subject: Re: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
> >
> > On Mon, Oct 24, 2022 at 9:56 AM Angus Chen <angus.chen@jaguarmicro.com>
> > wrote:
> > >
> > > The get_vq_num_max of vdpa_config_ops is mean get the max size of vq,=
not
> > > the max number of vq,it is kind of confused,rename it.
> > > And get_vq_num_min rename to get_vq_size_min,
> > > set_vq_num rename to set_vq_size,
> > > rename implement of this ops also.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> >
> > Not a native sparker. But num_max came from virtqueue structure:
> >
> > /*
> >  ...
> >  * @num_max: the maximum number of elements supported by the device.
> >  ...
> >  */
> >
> > struct virtqueue {
> >         ...
> >         unsigned int num_max;
> I noticed this also=EF=BC=8Cand I always confused by the definition. Take=
 virtio_pci_common_cfg for example:
>
> /* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
> struct virtio_pci_common_cfg {
>         ...
>     __le16 num_queues;      /* read-only */
>
> It just a suggestion.
> Thank you.

Let's hear from the others then decide.

Thanks

> >         ...
> > };
> >
> > Thanks
>

