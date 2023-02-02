Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0D68856A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBBRbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBBRbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC573074
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675359051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYKqs3MjGl7TQ1cHEqSG5d8XiBUPJ2VDaeFs07Gxf5M=;
        b=U6y35i1Ld8ySA5LIvYGHTvg6RlUMnqOXtvrYxiENbTu92DEJmkXNK1ltlZJd9e8h3HVkI8
        W19r/hXbA9L6/Yx5aSpANVKNtXBb289voqc+BqH77ka2x2UfLgB+107yp851KLP9ZgNz0n
        B98VMmEzZiGCCOgGtoQ3GfktLaMXri0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-1XnniSi4P9Wc36_aqJ_Mqw-1; Thu, 02 Feb 2023 12:30:50 -0500
X-MC-Unique: 1XnniSi4P9Wc36_aqJ_Mqw-1
Received: by mail-ej1-f70.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso1989080ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYKqs3MjGl7TQ1cHEqSG5d8XiBUPJ2VDaeFs07Gxf5M=;
        b=IWQvpwYF6HJE90OfAOes+FO+o7JmEAVTwRzMdNoGu2VCMdi9MAt/xO01tmz7VrhWHD
         c/P33eMVzqGRPAlCrOyrXdec25R9A3zrA8GVcvrEJsIxaix2RZis9eJwZc1EjVjDaA8t
         9G3ozwEJ4zVZkLSM3exoyqIytmCyLB054MRoWn/udg2BB9xM87o6ERxZDOGf9Vb6bsSc
         VJajzVpEciPOEljUd5sTLLAGpezC46lrtQ7HAXCbcs5iwRBCaR4ydhbU3eiL00iBQjqT
         WCGJTaFY2JUUi3NhZUv4oCSLoyHjhF1FMmlmImo5XprMjl2mbrBem1FBJwI2b0bcAbpE
         5DOQ==
X-Gm-Message-State: AO0yUKV9Lyt+R1/+ijvBOGmeqdOFUHOWwOIuvn+Ny0i7KbfIPZjjuGwp
        GO8g/ylxp9bWiqm6LL/5OdKu/j8eG6U1t+9Fpi/IwAtxVLYWfRqgNSp7/GwWVoZuF57fIQsGkOB
        OxCYH4we45bBAUsY9AAotuLJn
X-Received: by 2002:aa7:d54c:0:b0:4a3:43c1:8441 with SMTP id u12-20020aa7d54c000000b004a343c18441mr2229029edr.21.1675359049157;
        Thu, 02 Feb 2023 09:30:49 -0800 (PST)
X-Google-Smtp-Source: AK7set/8iTLbXbQv+s/UGj22Gc8lXgPP1ENSohhV651rdA6zrWZf+Ya3iBnFyTnbDxf3sgsW2UZ+Dg==
X-Received: by 2002:aa7:d54c:0:b0:4a3:43c1:8441 with SMTP id u12-20020aa7d54c000000b004a343c18441mr2229020edr.21.1675359049002;
        Thu, 02 Feb 2023 09:30:49 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm11448795edr.28.2023.02.02.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:30:48 -0800 (PST)
Date:   Thu, 2 Feb 2023 12:30:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] features provisioning fixes and mlx5_vdpa support
Message-ID: <20230202123024-mutt-send-email-mst@kernel.org>
References: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:22:01PM -0800, Si-Wei Liu wrote:
> This patchset is pre-requisite to export and provision device
> config attributes and features for vdpa live migration, in a way
> backward and forward compatibility can be retained. The follow up
> work [1] will need to be built around the new feature provisioning
> uAPI, with which it's easier to formalize migration compatibility
> support at the driver level.
> 
> Thanks,
> -Siwei
> 
> [1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
> https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/

1-6 look like bugfixes right?

> ---
> 
> Si-Wei Liu (6):
>   vdpa: fix improper error message when adding vdpa dev
>   vdpa: conditionally read STATUS in config space
>   vdpa: validate provisioned device features against specified attribute
>   virtio: VIRTIO_DEVICE_F_MASK for all per-device features
>   vdpa: validate device feature provisioning against supported class
>   vdpa/mlx5: support device features provisioning
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 72 ++++++++++++++++++++++------
>  drivers/vdpa/vdpa.c                | 98 ++++++++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_config.h |  8 ++++
>  3 files changed, 149 insertions(+), 29 deletions(-)
> 
> -- 
> 1.8.3.1

