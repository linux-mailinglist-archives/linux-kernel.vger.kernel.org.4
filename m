Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA2687A56
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBBKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjBBKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2724ED26
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675333990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzY8WLXPZBGvGs13fwLVzvdB3zWOPAiALRIUHU5zbPE=;
        b=IAkCbMir6+p4EmamJfiTwgX71gdCuLTAqAYLlGpBz2r9BjF+mhenguc2jCnZEJKRsqHjb/
        a2XRAFunYMBpcprcKRr3MZsgUzYn2jEH02AVkt96BRWA9Ey8Z9+NRyJKItc40/8BaqzvOd
        Nn2vL0cUu/+Byj5Nns7xnPHvawFcD2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-AqD6eUWHM7Co8h4SHKfI4Q-1; Thu, 02 Feb 2023 05:33:07 -0500
X-MC-Unique: AqD6eUWHM7Co8h4SHKfI4Q-1
Received: by mail-wm1-f70.google.com with SMTP id l31-20020a05600c1d1f00b003deab30bb8bso785803wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzY8WLXPZBGvGs13fwLVzvdB3zWOPAiALRIUHU5zbPE=;
        b=b+XVae/PVxo4Hs+GuYnZVyixjYEb24gUSqg1cHtWXg2CDNayO3CIf5RJv2VrZOR7OV
         hU4fj+GYAzDmar71bwH53KzmkWOXb/7fp5+idEp2k1T69Gv6qb++Tc9ssDqBLqvVeUTU
         C+OqLbgYfvSQkvUTlvM6cCEmx+qZXqIIW+bzwyrv5YOI4qIMQrv89SCs13Wd4bK0QTZy
         ehcOCHzdGGTEq5GlU+m2Q9B2tK9IYxUOT3RJxg3FyxwyCUyi8giKWODmi4F6XL4blcqI
         9MkjhcgWqG436N3q7PjFK6Q8R0HpJcQ7jiMlBZHZqdvAbpU0C0Rt8E+FH3DYfKAdUnjG
         guqA==
X-Gm-Message-State: AO0yUKUrofFI0VvHIDS/gIqJ3JUMmtOgKxKonOu91PXKzlwdozmMqm9N
        y3MAn5tVR3B67P60FH9mVTtCCRyBmmv/LyUNJQ88DRaG7QLv1J5LkkOKjl33PG/RyQ4HPkWNMXR
        /U84gpUTowRERiyDtJPwMVz5h
X-Received: by 2002:a05:600c:4e4e:b0:3d2:bca5:10a2 with SMTP id e14-20020a05600c4e4e00b003d2bca510a2mr5273854wmq.22.1675333984808;
        Thu, 02 Feb 2023 02:33:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/fHx8aUDAB0froK+lS+HWGLVJXUV/PDw9YBioywtgcQQqxlZhTuxBLUkkhhVkUE0oQ07IROQ==
X-Received: by 2002:a05:600c:4e4e:b0:3d2:bca5:10a2 with SMTP id e14-20020a05600c4e4e00b003d2bca510a2mr5273840wmq.22.1675333984603;
        Thu, 02 Feb 2023 02:33:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fc:826d:55d8:70a4:3d30:fc2f])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c544b000000b003dc4fd6e624sm4452688wmi.19.2023.02.02.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:33:03 -0800 (PST)
Date:   Thu, 2 Feb 2023 05:32:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] vringh: fix a typo in comments for vringh_kiov
Message-ID: <20230202053204-mutt-send-email-mst@kernel.org>
References: <20230202090934.549556-1-mie@igel.co.jp>
 <20230202090934.549556-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202090934.549556-2-mie@igel.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 06:09:28PM +0900, Shunsuke Mie wrote:
> Probably it is a simple copy error from struct vring_iov.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Drop the fixes tag pls it's not really relevantfor comments.
But the patch is correct, pls submit separately we can
already apply this.

> ---
>  include/linux/vringh.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index 212892cf9822..1991a02c6431 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -92,7 +92,7 @@ struct vringh_iov {
>  };
>  
>  /**
> - * struct vringh_iov - kvec mangler.
> + * struct vringh_kiov - kvec mangler.
>   *
>   * Mangles kvec in place, and restores it.
>   * Remaining data is iov + i, of used - i elements.
> -- 
> 2.25.1

