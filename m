Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E3644F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLFXYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLFXY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1631E429A6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670369010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIT+IhbrhdzO0SgdkPdvyfPRZXCHERs/Yxrz5ukRMiU=;
        b=B1UIExPTcNB8l896G2Kf9t/MNRO8na1k+9U/ANrpPKu1YPC03zRsmNzVA3XVMHVNkZIoJ+
        d2y71lVtIxChgSkynfhoqhGazX6dA9JoaUIg9k8mFWltHC/9xRoSJklWp1ngQ+PclnyTak
        JP3hGHm86X+L4fp8GavMXyQh44hszFo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-176-55xrESUWNqOrGrYxjDAFkg-1; Tue, 06 Dec 2022 18:23:29 -0500
X-MC-Unique: 55xrESUWNqOrGrYxjDAFkg-1
Received: by mail-il1-f200.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so8605627ilt.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIT+IhbrhdzO0SgdkPdvyfPRZXCHERs/Yxrz5ukRMiU=;
        b=Zc8BaZS05P7o1YFe4xOtrreyVICZHx6iWjOWS0YHq3ikiAgyOVyOM2CI3c+2tGS6NT
         iy9bUk9LX4mHsMcG6y/kzNs9RikqKGcQo1RPrCLZlzOtFEDPO7rKEihOilHugbRuvCOp
         lhyb+vlAsDFtFxwE9C3EA5oa760fXmXrWpl192y/2gUvnzbcNQmVIFZ+MSYRL9mIo5yW
         IQ8VLpzqZ4qS1dS5RGpfHr6B3Zn0r6+Zpb3Ujam9/sSnO87KawL721QuW9jmNjswjkLO
         4GW+6qML2RQssGvfROOo/re3p6ZNnnYJtNHTFrh+98rCcsqz2zs2q6JJnvGXKNiI8mjk
         P4WQ==
X-Gm-Message-State: ANoB5pkeNJFAqrjsDXhVDglZbu6JjSY5zx3pPQUGMElHFJGaPQF1CePs
        j+gQlS8gsU6McFZDDkw8Q8AroaP2ouWBnQi8X7QvHsDwIEO8tExbO5T3hBSW3zfpYWwlvwEUxs7
        q1UsAK8GLx0BPSWpA9jSopPR+
X-Received: by 2002:a6b:8e84:0:b0:6e0:34aa:4548 with SMTP id q126-20020a6b8e84000000b006e034aa4548mr955804iod.72.1670369008212;
        Tue, 06 Dec 2022 15:23:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf530+WYbRmxE0/7/iKzg+do/NfyBJnHrKsBJPekEOm6tgcPN5pQRTCdPQ2CDy6QsFVxD1wKKg==
X-Received: by 2002:a6b:8e84:0:b0:6e0:34aa:4548 with SMTP id q126-20020a6b8e84000000b006e034aa4548mr955798iod.72.1670369008010;
        Tue, 06 Dec 2022 15:23:28 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i44-20020a023b6c000000b00389e1142967sm7144835jaf.57.2022.12.06.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:23:27 -0800 (PST)
Date:   Tue, 6 Dec 2022 16:23:21 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the vfio tree
Message-ID: <20221206162321.33b41f1d.alex.williamson@redhat.com>
In-Reply-To: <20221206125542.52ea97a7@canb.auug.org.au>
References: <20221206125542.52ea97a7@canb.auug.org.au>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2022 12:55:42 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the iommufd tree got conflicts in:
> 
>   drivers/vfio/Kconfig
>   drivers/vfio/Makefile
> 
> between commits:
> 
>   20601c45a0fa ("vfio: Remove CONFIG_VFIO_SPAPR_EEH")
>   e2d55709398e ("vfio: Fold vfio_virqfd.ko into vfio.ko")
> 
> from the vfio tree and commits:
> 
>   a4d1f91db502 ("vfio-iommufd: Support iommufd for physical VFIO devices")
>   e5a9ec7e096a ("vfio: Make vfio_container optionally compiled")
>   c2849d718d26 ("vfio: Move vfio group specific code into group.c")
> 
> from the iommufd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Looks good, thank you,

Alex

