Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF46945C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjBMM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2C6A71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676291179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bYAi+KZbADlPRkjU5Qjf0pWYUfcTGnNZhSgKsO4qTic=;
        b=GzkwqNJbMXgu57c2WBw5UyW7BuzOEQffB60nGSZxeCJa0fsin8NNU2iMKJu32PeUwr0ege
        H/5W0mLLTluJj9/5TPY0F2nqiZw9f5b4l3LECb6ep27pO284UBqdHmuhbiFkDeT/Bfm7gi
        ECxM4OAYZaQ8khxg62dctFDH/eaFlCM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-_qWv6cQtN6O18GibNrVD1w-1; Mon, 13 Feb 2023 07:26:18 -0500
X-MC-Unique: _qWv6cQtN6O18GibNrVD1w-1
Received: by mail-ej1-f69.google.com with SMTP id qn8-20020a170907210800b0088eda544bd6so7576511ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYAi+KZbADlPRkjU5Qjf0pWYUfcTGnNZhSgKsO4qTic=;
        b=2mWPo14F5cUCsdZjPWJSTi2bICm8+ig0VDhdWJ2LKpqXfzAoZqtNv6ymF+sUBi2jq7
         tk1JLWQrzQlUzbzBaU51F2I4yvH9IQKgPRNYCYs1y7HBQFG6u6obOBuoBQbFvchifKEp
         3jWN2p356uaZfNwThAGZEQcc9VRoJlgaIH22tMQ7kikAwS33TspBwE7XKubgV+aYo9oc
         twnRTolkpnI6uC8bI9h2LotisHjnljgVjVyFqeHEdVw2MV0dS8CZq21qKWu68fv5Vz0u
         rDSKLUYwhH2VR6xt5YYjVvJsmZYD0Hea5pKphM2yImsnkDKq6tvxfCcKBVq6G9X0cFwW
         hvWw==
X-Gm-Message-State: AO0yUKXNVf/ydJ0sDnY9V/EwYwTA/mpgKMUWLdqCU/q9f/ylWbTp1f5h
        yc7L3Ig2jbiwF73/h9YoJqZjTQmr+jp1BHfxuiteuRdQ0pICKdt1k60R8m7dvMDwEVp+7fCWp4c
        w72u8CVzljWIJ1hVtXXj2WvBG
X-Received: by 2002:a17:907:72d2:b0:8af:ef00:b853 with SMTP id du18-20020a17090772d200b008afef00b853mr10986421ejc.73.1676291177260;
        Mon, 13 Feb 2023 04:26:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9D6+DyAHCli0gWTvlnEmn3aEja9HqsIfJ6Xv6OFZmnLVMJua5RhJODuIKRPOQ7jzKGIJB3tA==
X-Received: by 2002:a17:907:72d2:b0:8af:ef00:b853 with SMTP id du18-20020a17090772d200b008afef00b853mr10986408ejc.73.1676291177060;
        Mon, 13 Feb 2023 04:26:17 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090636d300b0085d6bfc6201sm6727325ejc.86.2023.02.13.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:26:16 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:26:13 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initialize CVQ iotlb spinlock
Message-ID: <20230213072516-mutt-send-email-mst@kernel.org>
References: <20230206122016.1149373-1-elic@nvidia.com>
 <20230213071855-mutt-send-email-mst@kernel.org>
 <570ab4b9-eed7-3c5a-400a-261a9a205b4f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570ab4b9-eed7-3c5a-400a-261a9a205b4f@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 02:24:40PM +0200, Eli Cohen wrote:
> 
> On 13/02/2023 14:19, Michael S. Tsirkin wrote:
> > On Mon, Feb 06, 2023 at 02:20:16PM +0200, Eli Cohen wrote:
> > > Initialize itolb spinlock.
> > > 
> > > Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > threading was broken here but whatevs.
> What exactly do you mean by "threading was broken". Is it because I sent two
> unrelated fixes together appearing as patch 1/2 and 2/2?

exactly. if I see 2/2 I expect a thread so I can find 1/2
and preferably a cover letter explaining what unifies all
these patches.
If they are unrelated no need to number them.

> > 
> > > ---
> > >   drivers/vdpa/mlx5/core/resources.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > index 45ad41287a31..d5a59c9035fb 100644
> > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > @@ -233,6 +233,7 @@ static int init_ctrl_vq(struct mlx5_vdpa_dev *mvdev)
> > >   	if (!mvdev->cvq.iotlb)
> > >   		return -ENOMEM;
> > > +	spin_lock_init(&mvdev->cvq.iommu_lock);
> > >   	vringh_set_iotlb(&mvdev->cvq.vring, mvdev->cvq.iotlb, &mvdev->cvq.iommu_lock);
> > >   	return 0;
> > > -- 
> > > 2.38.1

