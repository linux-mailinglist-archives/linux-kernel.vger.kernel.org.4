Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFD6567A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiL0HFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiL0HFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5CE1164
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672124665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aoTymnMJhMCAhdxLx/6Xd8j2K/EbpmVCnrzJwfgh2hQ=;
        b=gjuKed5QBwXNcfMp9j3eUvlXusUGm9TwpT6r41jEC0+y0Qw+T0CtJPLbxFR6cJEwFsBbYN
        REKxXbxpt5SZS/rMzoVhHYSGKK/cyu7YQvFdI2dFYkOXoNVTlnK2DvkSr5m+Ck5IiYEMl8
        vnA6fkC1s0IrrHIacQitLU3NGU0OOJE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-68-S2qZF5qQNgyYHSO15VTc4A-1; Tue, 27 Dec 2022 02:04:23 -0500
X-MC-Unique: S2qZF5qQNgyYHSO15VTc4A-1
Received: by mail-ej1-f70.google.com with SMTP id qa18-20020a170907869200b007df87611618so8472486ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoTymnMJhMCAhdxLx/6Xd8j2K/EbpmVCnrzJwfgh2hQ=;
        b=Ho69wcjDxogdhOOtVsejL6iWAywcJz4Z6/EQKzevvNasaYX77n23zHhCTq8LXZT6hH
         rgcA/VmGtAAU41rj2JpMkeeSGJ/U9kehi503soxnEEX40UBSK2ZKIvzRWR+QVHlUakEq
         L/ARENcTNuZAv0wLrGRVwk5oIcuRfzjwhhVtp4gJdrI46h5ulfHOlFECZgsfqRvLjsjD
         r9rEXEkEQs7WEuWW8LPJQhZL2/XwsTfzUhPwkQE9RjTlKzr5tMPydKIQp3aL/NK9oApb
         g3SpCLXJWDVeWVd0meuYBSx+BsNAEEaUMBJzYl4vNtRs8QvquacADlquUBF+nzvKrFDw
         wjWw==
X-Gm-Message-State: AFqh2kplcL4G4mp+ESHcSjO/Tv0oYIt0/vcnZljXj4TILC7TUtA4bCpr
        OvtNEsIu2cK6TiGGpA9OrUT+fPkQWJhLSPX+ffPH/zFoAY/hYYbA4RAobZGXo0e8ZQ2haM/9wOE
        dO2OjhCt0BKsAv4TAe3PFuLc/
X-Received: by 2002:a17:907:2388:b0:7c0:e0d9:d20d with SMTP id vf8-20020a170907238800b007c0e0d9d20dmr19088747ejb.37.1672124662541;
        Mon, 26 Dec 2022 23:04:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6gAxH/ncrPcbp+Eit49juvH4l55QVsieawsjzQ5QHGjjI86Ork+Wd8xiQwiDtwhCgj4ZHBw==
X-Received: by 2002:a17:907:2388:b0:7c0:e0d9:d20d with SMTP id vf8-20020a170907238800b007c0e0d9d20dmr19088733ejb.37.1672124662287;
        Mon, 26 Dec 2022 23:04:22 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709061c0d00b0082000f8d871sm5695709ejg.152.2022.12.26.23.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 23:04:21 -0800 (PST)
Date:   Tue, 27 Dec 2022 02:04:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] vringh: unify the APIs for all accessors
Message-ID: <20221227020007-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-5-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227022528.609839-5-mie@igel.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:25:26AM +0900, Shunsuke Mie wrote:
> Each vringh memory accessors that are for user, kern and iotlb has own
> interfaces that calls common code. But some codes are duplicated and that
> becomes loss extendability.
> 
> Introduce a struct vringh_ops and provide a common APIs for all accessors.
> It can bee easily extended vringh code for new memory accessor and
> simplified a caller code.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/vhost/vringh.c | 667 +++++++++++------------------------------
>  include/linux/vringh.h | 100 +++---
>  2 files changed, 225 insertions(+), 542 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index aa3cd27d2384..ebfd3644a1a3 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -35,15 +35,12 @@ static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
>  }
>  
>  /* Returns vring->num if empty, -ve on error. */
> -static inline int __vringh_get_head(const struct vringh *vrh,
> -				    int (*getu16)(const struct vringh *vrh,
> -						  u16 *val, const __virtio16 *p),
> -				    u16 *last_avail_idx)
> +static inline int __vringh_get_head(const struct vringh *vrh, u16 *last_avail_idx)
>  {
>  	u16 avail_idx, i, head;
>  	int err;
>  
> -	err = getu16(vrh, &avail_idx, &vrh->vring.avail->idx);
> +	err = vrh->ops.getu16(vrh, &avail_idx, &vrh->vring.avail->idx);
>  	if (err) {
>  		vringh_bad("Failed to access avail idx at %p",
>  			   &vrh->vring.avail->idx);

I like that this patch removes more lines of code than it adds.

However one of the design points of vringh abstractions is that they were
carefully written to be very low overhead.
This is why we are passing function pointers to inline functions -
compiler can optimize that out.

I think that introducing ops indirect functions calls here is going to break
these assumptions and hurt performance.
Unless compiler can somehow figure it out and optimize?
I don't see how it's possible with ops pointer in memory
but maybe I'm wrong.

Was any effort taken to test effect of these patches on performance?

Thanks!


