Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3960394E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJSFjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJSFj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2638B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666157964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TkKMuh+55DvT4EGTiPQiYJq9SDhwxssmhp76qd3oqnI=;
        b=BOIIu+wkDe4PuLk8/Na1TyibYDu4ZaQG6BBD7tpZ5O08BVItXdtAzHeD/c3m3EsGDyvopE
        s37xiGIJh3s0QItV5DSxwfoVK9mbOXzxKf6XMWn5ooFHUCkoOicSz0hpYkOSDwuyfn9/ew
        f/S5gQR6Nx74q+sIGqqQ3Te315+ZAmw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-tAc94c3JNBq-9De3pTDLGg-1; Wed, 19 Oct 2022 01:39:23 -0400
X-MC-Unique: tAc94c3JNBq-9De3pTDLGg-1
Received: by mail-ej1-f71.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so7398161ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkKMuh+55DvT4EGTiPQiYJq9SDhwxssmhp76qd3oqnI=;
        b=YXD/hJCeO+KDNNoWHXZG7aaJsx7AInutjYTzQveuPN+EfLeaKuZBeIBRNJA9qLX1Ai
         uDrjmq4/+bhLNZJE/h4ia0lsrQ/SkA4QOJdc25+2i/qP57kqDGqYSecPzU42klhTuI57
         I9pSlnuU0l/DhMCIhjx7LTNeulreQdecwt1gvjgQH5md8CWRwgDeztzrmYEFC8vY/MI5
         M99vdfGIBin2i5q5xUd4rFQlXOsH2R6ceXZ4as+xzLm3akn7V9S9WXjPssaLfIaorc2z
         vAHJWg3xvYm+v1yE9INLZfQX4eSDItCCekXJFzRYGgPmWS3GNVypVrdWzobebI04Am8x
         04WA==
X-Gm-Message-State: ACrzQf2lgPmz9Uxs1MCFH5F18Z6cHN7pguMteHbh4BmqbtRe8JXjrgAz
        2CeMHI4CvdHp2SEDwP12PtxkPlJAg0yexC0hFtvYr04/zoopcT+zL/32IiS95wfktbBt5XXRAnD
        8dcD24OnZeWVu5bdNOPIrXg9o
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id jg11-20020a170907970b00b0078d8d70e4e8mr5096290ejc.614.1666157961862;
        Tue, 18 Oct 2022 22:39:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7UHOeLw30fRkiNTxXa4b/V8OQ9Xj1Rly0I9lVeDKrAnPncM8RKf+ScmJKpOWADpEfwADI6vA==
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id jg11-20020a170907970b00b0078d8d70e4e8mr5096282ejc.614.1666157961674;
        Tue, 18 Oct 2022 22:39:21 -0700 (PDT)
Received: from redhat.com ([2.54.191.184])
        by smtp.gmail.com with ESMTPSA id c21-20020a17090603d500b00764a76d5888sm8346925eja.27.2022.10.18.22.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:39:21 -0700 (PDT)
Date:   Wed, 19 Oct 2022 01:39:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Message-ID: <20221019013733-mutt-send-email-mst@kernel.org>
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
 <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
 <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20221019013402-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D576AB4F9EE03205A919AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400D576AB4F9EE03205A919AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:36:17AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, 19 October 2022 8:34
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Si-Wei Liu <si-wei.liu@oracle.com>; jasowang@redhat.com; linux-
> > kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > 
> > On Wed, Oct 19, 2022 at 05:31:48AM +0000, Eli Cohen wrote:
> > > > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > > > Sent: Tuesday, 18 October 2022 22:21
> > > > To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com;
> > > > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org
> > > > Cc: eperezma@redhat.com; lulu@redhat.com
> > > > Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > > >
> > > > Hi Eli,
> > > >
> > > > It's not for this patch but something related, so just a friendly
> > > > heads-up. I haven't validated the VLAN tagging behavior yet for mlx5
> > > > vdpa, but from my quick read of the code it doesn't seem it
> > > > differentiates the case with and without VIRTIO_NET_F_CTRL_VLAN, to be
> > > > compatible/compliant with what's been implemented in QEMU software (a
> > > > spec addendum was filed as requested by Michael):
> > > >
> > > > https://github.com/oasis-tcs/virtio-spec/issues/147
> > > >
> > > > - when VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> > > > all VLANs filtered (meaning only untagged traffic can be received,
> > > > and traffic with VLAN tag will be dropped).
> > > >
> > > > - when VIRTIO_NET_F_CTRL_VLAN is not negotiated, all traffic including
> > > > untagged and tagged can be received.
> > > >
> > > > Can you please help check if we need further fix in terms of VLAN tagging?
> > > >
> > >
> > > Sure. It's broken today. I will fix this to conform to the above requirements
> > and send V1.
> > 
> > Did you mean v2?
> > 
> 
> I count from 0 and have been following this scheme but I can make it v2 if that's the norm.

Yes, most people seem to count patches from 1 so [PATCH] is followed by
[PATCH v2].  I don't know why. But it doesn't matter much - I just
wanted to understand whether you will be sending a new version of this
patchset. I know now.


> > > > Thanks,
> > > > -Siwei
> > > >
> > > >
> > > > On 10/18/2022 4:12 AM, Eli Cohen wrote:
> > > > > Set the VLAN id to the header values field instead of overwriting the
> > > > > headers criteria field.
> > > > >
> > > > > Before this fix, VLAN filtering would not really work and tagged packets
> > > > > would be forwarded unfiltered to the TIR.
> > > > >
> > > > > Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > >
> > > > > ---
> > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 90913365def4..dd29fdfc24ed 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -1472,7 +1472,7 @@ static int
> > mlx5_vdpa_add_mac_vlan_rules(struct
> > > > mlx5_vdpa_net *ndev, u8 *mac,
> > > > >   	if (tagged) {
> > > > >   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> > > > >   		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c,
> > > > first_vid);
> > > > > -		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> > > > > +		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
> > > > >   	}
> > > > >   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> > > > >   	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> > >
> 

