Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAF67550E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjATMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0817AF2F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674219287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Za8Y4nDbP8CWvHTQOrddwheGGIMRpuQAQh3mIFbUx8U=;
        b=FuKStdoCHaEuiTW6lff4q/eLNkFmsJrjIsnvj6oAalFW0pkodc2c6ezPZ4TXdUOo9ptsXK
        E5oiIlkzFBr/m9qhBAGdC6CWwcSD0Tt0mikkPYr4cw/kuKbm7Y8VEw2P96ALING5S+B258
        8ZqU5CpvdB4PQ1p7QggiwaKZRCK4XFg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-vG1b8e-hOKKUBujdv2VS-w-1; Fri, 20 Jan 2023 07:54:45 -0500
X-MC-Unique: vG1b8e-hOKKUBujdv2VS-w-1
Received: by mail-wm1-f70.google.com with SMTP id fl5-20020a05600c0b8500b003db12112fdeso2976381wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za8Y4nDbP8CWvHTQOrddwheGGIMRpuQAQh3mIFbUx8U=;
        b=U+Jpnkrh/T4Ill9o88uI6ZYJj3lSEN/Mc69ev2lt9C1BN/85hLcT1GkYvk5fDV/jOA
         X1jIGNvdPKXDSRWhgRSg6RztYvc8Jba6QcohdH1vfxGZ9xvQ1/r9e7TYIaGjF87zYRct
         nqbF2ppiudK5swX8La6tGT79LN0Holvuo1y0CBPJtMJlmLJ6nSA/PRBryXJXeLCaTRDl
         edShMk+SOA/jAA61knE2sZd5sDNzhOTwqWg3XLwERhewx6Y11JIadF27xwlbH/FMMFYJ
         ZslRAHG4G6VoL6uX5Su67k6Ph3vVEZkeZ8Boil8+w4Jr/w3w/s5FDS9Bur5xbOUrwGjq
         gxKQ==
X-Gm-Message-State: AFqh2kpIM+kDEeK+n0PeDpswhxVmHR4EY0KOFhtug3agUaUeGbBlL5k8
        D5nJvKm69Pe2j7P1HpVKht2038xabqN0UP4dpdBXVB7EtLkUvPs7KCdH1WW/iURD9hsLOdRXWaN
        Zk79evd0f2p9u1VYm+GzLaUg7
X-Received: by 2002:a05:600c:2103:b0:3d3:43ae:4d10 with SMTP id u3-20020a05600c210300b003d343ae4d10mr14429483wml.11.1674219284584;
        Fri, 20 Jan 2023 04:54:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtT9yqfP8Lvim31ZX9JEKbLExcTKqA9SmCXtTx+VQEAGdKIv1O2jbkTfAw7i5Vsh2YUHhYkxQ==
X-Received: by 2002:a05:600c:2103:b0:3d3:43ae:4d10 with SMTP id u3-20020a05600c210300b003d343ae4d10mr14429466wml.11.1674219284369;
        Fri, 20 Jan 2023 04:54:44 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003db06493ee7sm2206862wmn.47.2023.01.20.04.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:54:43 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:54:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v1 3/6] virtio 9p: Fix an overflow
Message-ID: <20230120074817-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-4-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:18PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> tag_len is read as a u16 from the untrusted host. It could overflow
> in the memory allocation, which would lead to a too small buffer.
> 
> Some later loops use it when extended to 32bit, so they could overflow
> the too small buffer.
> 
> Make sure to do the arithmetic for the buffer size in 32bit to avoid
> wrapping.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: v9fs-developer@lists.sourceforge.net
> ---
>  net/9p/trans_virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 3c27ffb781e3..a78e4d80e5ba 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -629,7 +629,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> -	tag = kzalloc(tag_len + 1, GFP_KERNEL);
> +	tag = kzalloc((u32)tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
>  		goto out_free_vq;

Hmm are you sure there's a difference in behaviour? I thought C will just
extend the integer to int.

> -- 
> 2.39.0

