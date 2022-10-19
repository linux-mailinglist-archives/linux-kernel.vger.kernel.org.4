Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0A603946
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJSFej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJSFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D7CB1DD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666157673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Vfj5MuYwEDLW1gKn2gdMUxDMm1tBwT8JsH+LnyHaeM=;
        b=dKB0rpGVtGVo+7QzmtnKzVA+/H5FuqWnj0Rbw+zMa+ZpXgYzdsxrN2e+FsG3m11xvxeRE4
        qt2Flp1Wq+XcNdelpT6gWraTvhinJZ55KuJyAZE8sLJCJygN6lKPvhyf4Cs8wQ7OYmDpxQ
        rXCPdPz9goCy1vw/mlshSSTJdcI5d9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-u6d0Qgq5Nbea3mJzCNkssw-1; Wed, 19 Oct 2022 01:34:31 -0400
X-MC-Unique: u6d0Qgq5Nbea3mJzCNkssw-1
Received: by mail-wm1-f71.google.com with SMTP id bg21-20020a05600c3c9500b003c2acbff422so226083wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vfj5MuYwEDLW1gKn2gdMUxDMm1tBwT8JsH+LnyHaeM=;
        b=2WNIRrFVuCNTaLfe4+3NsJCR0Ys9sC+orW+qslDLHfrC/saa5ic7CZ6HRFlis08MG7
         qkMA5sPIC1cNgKgMHs3uWzltIroeITmVSRQL0uzWtiw8rn378jvtFBgl5YIqp3qhrLZ0
         w+MlA+38G/whRfMFwFqPLthdkh4QwlDUxbZAHlamFxkUFZYJpDPip+jHDmiwCkyHyC2T
         odCGsp5NaDFtXAfWDD270W2H0YAcw70WlwgoZe91iyEjTMWVZe4asV6hBt6PFp/q6szn
         LyI9auD0KXzLhRWvN/AbMc8Lx/fsoPdhKIrCs9N9nb1Uj6h9u/KuH3AKY64j8fSmV5f0
         ELjw==
X-Gm-Message-State: ACrzQf1nsBFhmQ+oKI38pkIg+pMpjGgeUH4sHb5+02yLG9rkIs3UtIlV
        aMa+/5I8OfEvOXjQhPlRipgrnrRynu7O1+WLIg/JidduUVbHXIcA5gpxqx9ZZ+ahK4cCr0Hgcwh
        foqCFtjf/vjKNR8W8sS6vQffH
X-Received: by 2002:a05:6000:1e17:b0:22e:618f:b9d8 with SMTP id bj23-20020a0560001e1700b0022e618fb9d8mr3690571wrb.280.1666157670219;
        Tue, 18 Oct 2022 22:34:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7o9MFWDHGx4YaY6MVWmGaWkVEK4VcTVqnehSs1l742aYijDHIWJsqEoztB+11w7fU7P2ZjsA==
X-Received: by 2002:a05:6000:1e17:b0:22e:618f:b9d8 with SMTP id bj23-20020a0560001e1700b0022e618fb9d8mr3690556wrb.280.1666157669949;
        Tue, 18 Oct 2022 22:34:29 -0700 (PDT)
Received: from redhat.com ([2.54.191.184])
        by smtp.gmail.com with ESMTPSA id p39-20020a05600c1da700b003c6d21a19a0sm15231591wms.29.2022.10.18.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:34:29 -0700 (PDT)
Date:   Wed, 19 Oct 2022 01:34:26 -0400
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
Message-ID: <20221019013402-mutt-send-email-mst@kernel.org>
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
 <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
 <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:31:48AM +0000, Eli Cohen wrote:
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > Sent: Tuesday, 18 October 2022 22:21
> > To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; jasowang@redhat.com;
> > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org
> > Cc: eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > 
> > Hi Eli,
> > 
> > It's not for this patch but something related, so just a friendly
> > heads-up. I haven't validated the VLAN tagging behavior yet for mlx5
> > vdpa, but from my quick read of the code it doesn't seem it
> > differentiates the case with and without VIRTIO_NET_F_CTRL_VLAN, to be
> > compatible/compliant with what's been implemented in QEMU software (a
> > spec addendum was filed as requested by Michael):
> > 
> > https://github.com/oasis-tcs/virtio-spec/issues/147
> > 
> > - when VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
> > all VLANs filtered (meaning only untagged traffic can be received,
> > and traffic with VLAN tag will be dropped).
> > 
> > - when VIRTIO_NET_F_CTRL_VLAN is not negotiated, all traffic including
> > untagged and tagged can be received.
> > 
> > Can you please help check if we need further fix in terms of VLAN tagging?
> > 
> 
> Sure. It's broken today. I will fix this to conform to the above requirements and send V1.

Did you mean v2?

> > Thanks,
> > -Siwei
> > 
> > 
> > On 10/18/2022 4:12 AM, Eli Cohen wrote:
> > > Set the VLAN id to the header values field instead of overwriting the
> > > headers criteria field.
> > >
> > > Before this fix, VLAN filtering would not really work and tagged packets
> > > would be forwarded unfiltered to the TIR.
> > >
> > > Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 90913365def4..dd29fdfc24ed 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1472,7 +1472,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct
> > mlx5_vdpa_net *ndev, u8 *mac,
> > >   	if (tagged) {
> > >   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> > >   		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c,
> > first_vid);
> > > -		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> > > +		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
> > >   	}
> > >   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> > >   	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
> 

