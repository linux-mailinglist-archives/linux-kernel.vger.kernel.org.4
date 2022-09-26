Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90E5E9A47
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiIZHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiIZHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C6E1C4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664176326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kk40Cb91ob6P3jMCeHmGVy6FEdXDb0iktyx6LRhCi4M=;
        b=Dsb1PjGsSMyX/F/a+mJ2qpTkNmurP234cezwBDM8vYtWyO+QNj3c2DsijLc1irFGrPt2dn
        //ayg/FiBlMlzfYTyG6bQxS8FcrVAOxZ34S0W3ekQERDeCrku+395QEhOcK6MfJgbOuvi/
        sB12wLKFnOtoiHglKN7no5EbLG/m8Ws=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-6KFMmSk4Oo6oaozsAlOvig-1; Mon, 26 Sep 2022 03:12:04 -0400
X-MC-Unique: 6KFMmSk4Oo6oaozsAlOvig-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-12dbfae38b0so1991106fac.16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Kk40Cb91ob6P3jMCeHmGVy6FEdXDb0iktyx6LRhCi4M=;
        b=ozXn+tgj4y2NvnxEn6EmIqCf8wmkksar7so1w80ypFDZnszFO8sHLWOOSgz2XUqWt8
         PnERmV0n3TKlbLcA6F2gdzzIkwwh8q1yY0Golre0MDVUkgXLs/Dx8Sz9N19yTREDVzNC
         mWvA5NR00znLA4Lfvo9382xDCxZKHIr0pIz/26E9DVXxSMkg88RQieq1MGrzjcOG1lPe
         1KBIBlRKNEF6riQbAHj1+xgAUwtOsWRVXWLk6qQYc2vqDxWFPLxxZRxlUxuDGC0zYoff
         Hd6eqXTI0S9tWOyBYtCUX4y6TlNhXqk1WVMKyh4PLvm1bT3Ed7pnrUjCQLztQAP4Bmrz
         i2FA==
X-Gm-Message-State: ACrzQf1xUad0BZGYgBSlgGmwsGWeemp30wN3pVsqO0vgyWi9u7XK/+tb
        J6cGoVsazwM4kcC2fKHyjPJ7bMpwA2W90c2MWMWWa5Uxs8wEaTnLKYv5qd7vbnxgwP/ivWG8lSB
        Y7KC6/b7Mq57kdmI6gQg0WT0RvRnDNrI7MamEmdCF
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id n9-20020a056870e40900b00127d330c941mr11041296oag.280.1664176324277;
        Mon, 26 Sep 2022 00:12:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Jh1aPfSlKDIhnP8B+svyyB4sY+Wby1jv2HNMTPvpWgii56PkLS0pySj74eksUz7kANrNmbNSqGoNQFSgvwUs=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr11041280oag.280.1664176324060; Mon, 26
 Sep 2022 00:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com> <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com> <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
In-Reply-To: <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Sep 2022 15:11:53 +0800
Message-ID: <CACGkMEt22w2rK058Bm692sb1xXsNRULcjgeCpoc6Fimn7suheA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        eperezma <eperezma@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Gautam Dawar <gdawar@xilinx.com>, Cindy Lu <lulu@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 3:11 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >
> >
> >
> > On 9/21/2022 7:43 PM, Jason Wang wrote:
> > > This patch implements features provisioning for vdpa_sim_net.
> > >
> > > 1) validating the provisioned features to be a subset of the parent
> > >     features.
> > > 2) clearing the features that is not wanted by the userspace
> > >
> > > For example:
> > >
> > > # vdpa mgmtdev show
> > > vdpasim_net:
> > >    supported_classes net
> > >    max_supported_vqs 3
> > >    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> > Sighs, not to blame any one and it's perhaps too late, but this
> > "dev_features" attr in "mgmtdev show" command output should have been
> > called "supported_features" in the first place.
>
> Not sure I get this, but I guess this is the negotiated features actually.
>
> I think Ling Shan is working on reporting both negotiated features
> with the device features.
>
> >
> > >
> > > 1) provision vDPA device with all features that are supported by the
> > >     net simulator
> > >
> > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > # vdpa dev config show
> > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > >    negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> > Maybe not in this patch, but for completeness for the whole series,
> > could we also add device_features to the output?
>
> Lingshan, could you please share your thoughts or patch on this?
>
> >
> > When simply look at the "vdpa dev config show" output, I cannot really
> > tell the actual device_features that was used in vdpa creation. For e.g.
> > there is a missing feature ANY_LAYOUT from negotiated_features compared
> > with supported_features in mgmtdev, but the orchestration software
> > couldn't tell if the vdpa device on destination host should be created
> > with or without the ANY_LAYOUT feature.

Btw, it might be helpful to show those features in hex as well.

>
> I think VERSION_1 implies ANY_LAYOUT. But it should be sufficient to
> use features_src & feature_dst in this case. Actually, it should work
> similar as to the cpu flags, the management software should introduce
> the concept of cluster which means the maximal set of common features
> is calculated and provisioned during device creation to allow
> migration among the nodes inside the cluster.
>
> Thanks
>
> >
> > Thanks,
> > -Siwei
> >
> >
> > >
> > > 2) provision vDPA device with a subset of the features
> > >
> > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
> > > # vdpa dev config show
> > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > >    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > >
> > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > index 886449e88502..a9ba02be378b 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> > >       dev_attr.work_fn = vdpasim_net_work;
> > >       dev_attr.buffer_size = PAGE_SIZE;
> > >
> > > +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > +             if (config->device_features &
> > > +                 ~dev_attr.supported_features)
> > > +                     return -EINVAL;
> > > +             dev_attr.supported_features &=
> > > +                      config->device_features;
> > > +     }
> > > +
> > >       simdev = vdpasim_create(&dev_attr);
> > >       if (IS_ERR(simdev))
> > >               return PTR_ERR(simdev);
> > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > >       .id_table = id_table,
> > >       .ops = &vdpasim_net_mgmtdev_ops,
> > >       .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > +                          1 << VDPA_ATTR_DEV_FEATURES),
> > >       .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > >       .supported_features = VDPASIM_NET_FEATURES,
> > >   };
> >

