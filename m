Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93D679089
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjAXF5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjAXF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:57:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857243344D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674539716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+nMn4Y7ib+ksp4an8hs+mxpzKixV/6cqrHGLxmxmZs=;
        b=h1vl50Bcg/y7qUcrh4KpKzfxl1Bpx3aNimHScedk8BFeahynqXQY5Cs0+pm/0pD2NGQUC6
        jGWWjC2ir1XWfu8+Mb3QAWT774gqDp5wfK+IU6UmMsOiLb4OebgScwWMHvvOyB9T+dTmZm
        Obn2SDmcAuonEWPJ9KAmgHHReButQlg=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-8Cllk9lcPPGi7yKmic3GYA-1; Tue, 24 Jan 2023 00:55:15 -0500
X-MC-Unique: 8Cllk9lcPPGi7yKmic3GYA-1
Received: by mail-vk1-f200.google.com with SMTP id u2-20020a1f6002000000b003e2481d7a4aso196972vkb.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+nMn4Y7ib+ksp4an8hs+mxpzKixV/6cqrHGLxmxmZs=;
        b=uZ+lZST9NliDdppSm8OxvXcGOVt5cmbwWRoGHdbqoiBYfWXLDRFH8KISxS8n9d/Hrq
         DSYmzC/EGErbpLsibtzNwdZ6qnuTkn8XHpekpzJ/7w7Jt4qUy8x99Xqw4atQak4XQZos
         lzDm+2ms2QhNBB8OLhKWijFtCl/DmmZbHq3qamSIQGQt7NVywBwVOZmojSXZOB8Obf7y
         NsnjSQ0M52w5ZqTgQGhGI7rvBhNolhexl/rsLcF3oUuHK5oqkz1k6x4+0ZUIhD+JO/iM
         1AMt9Jofb4ChcQ8WydfJTvU+Gyhjp0tMme735DD/Di054zgJRPpbNr8gEyazzayaaKpw
         uMpg==
X-Gm-Message-State: AFqh2koGXZ6QGW+2npIREKhupCD1H2FUZ9RmC3iSbWlI2d6pEQCtCBI5
        7hLzgRSK9foqV9lquPTZCK0gyMeonn3z9hRihNuH7yT8kySgcKkTEVQvlg3t6sa21ZQ2ZRGOrR1
        yLATmmU4wIlECQGbnyDew8edI
X-Received: by 2002:a05:6102:1517:b0:3d3:c855:bf54 with SMTP id f23-20020a056102151700b003d3c855bf54mr16402956vsv.34.1674539714875;
        Mon, 23 Jan 2023 21:55:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtIO8aXO9i+HLzZc6kLGRsWHVrO9s72UFSgMG1EytTFL2SpZojIc12K4cwqrrKZT6og3irEcA==
X-Received: by 2002:a05:6102:1517:b0:3d3:c855:bf54 with SMTP id f23-20020a056102151700b003d3c855bf54mr16402943vsv.34.1674539714642;
        Mon, 23 Jan 2023 21:55:14 -0800 (PST)
Received: from redhat.com ([45.144.113.7])
        by smtp.gmail.com with ESMTPSA id r15-20020ab04a4f000000b006180bedf1b8sm83195uae.26.2023.01.23.21.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 21:55:14 -0800 (PST)
Date:   Tue, 24 Jan 2023 00:55:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 02/19] drivers/vhost: Convert to use vm_account
Message-ID: <20230124005356-mutt-send-email-mst@kernel.org>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <97a17a6ab7e59be4287a2a94d43bb787300476b4.1674538665.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a17a6ab7e59be4287a2a94d43bb787300476b4.1674538665.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 04:42:31PM +1100, Alistair Popple wrote:
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ec32f78..a31dd53 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c

...

> @@ -780,6 +780,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  	u32 asid = iotlb_to_asid(iotlb);
>  	int r = 0;
>  
> +	if (!vdpa->use_va)
> +		if (vm_account_pinned(&dev->vm_account, PFN_DOWN(size)))
> +			return -ENOMEM;
> +
>  	r = vhost_iotlb_add_range_ctx(iotlb, iova, iova + size - 1,
>  				      pa, perm, opaque);
>  	if (r)

I suspect some error handling will have to be reworked then, no?

> -- 
> git-series 0.9.1

