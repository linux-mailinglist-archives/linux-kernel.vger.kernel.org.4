Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD122623BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiKJG22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKJG2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F42EF63
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668061647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPT2SlSbYl+8u2DBxIMbsp2kZiM/fVVnMLVLMjyKspc=;
        b=GGcSFG0AeeFOcwZjN8zvzfrH/Wn2KFlZUx+276OZyl+ooXumUH+zAXVDIKUE+c22cJ9K6s
        P05b9s+71QkrJKN4clFzgSXPIOOauII45Y1OcKqKdIgRF2yMZkVXoJhzaDRI+GRi1mnXPB
        szBxm3arNCw2Djrwx3SF2elHyetZqkw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-aT3WlBuiMSOkkDwj6OR1SA-1; Thu, 10 Nov 2022 01:27:26 -0500
X-MC-Unique: aT3WlBuiMSOkkDwj6OR1SA-1
Received: by mail-wm1-f70.google.com with SMTP id l42-20020a05600c1d2a00b003cf8e70c1ecso2166345wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 22:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPT2SlSbYl+8u2DBxIMbsp2kZiM/fVVnMLVLMjyKspc=;
        b=xEGNd/LcmjomsVlsPTYE/HUgxmJ5g8E0ecbyDvGQ//4KJewSCC2Wq/6RkrbrA35IKe
         /xTANHvX+mGnhHg95ByLMBS9qU5d8CGoDS8QkjY2dYPHUYlZRN5m5NDP0u2SXM8tfFh6
         Jngn4BV0nVAJ1qO321zw6JpgkEnz9BIv+Xv3CIS2ZDVd+mrgiUPtUUqKCAeAEAv+lhss
         JwEv18gscnbBJ1RBUu/angKQDNqAqKiWCuxWjlbHyd44MLNJc9RPiG8TjQfS7xywy8Jo
         FvXzI6VJQgGdqvxkxGxpaXXH5TKSj3XWPhKrBhBNTZeC11uIv8hWo0ZpsRT1P7sWDNFs
         kAfw==
X-Gm-Message-State: ANoB5plH/UwGPA8U8nJjUDr74pHSrJzz18OYVswLGB3vzHH9c9BkGiQt
        8G7YjIz/u2ijIqUNgBtQHb9O6oFd/TAx83Q/qcAGTuT8Kb4a+HPEJVtj+CEEOJPmFyeYkCGl+iQ
        muRMs0IPS/uCp8c4ypmh5Xrkh
X-Received: by 2002:a05:600c:4fd3:b0:3cf:a464:e881 with SMTP id o19-20020a05600c4fd300b003cfa464e881mr15090842wmq.54.1668061644653;
        Wed, 09 Nov 2022 22:27:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7F8ljwfsHi6Qg3i6MOW0kqbhg6e9MSwr915+n+jG7X9LJmAIvrroYMgfusPWAjiNyCNwL+cg==
X-Received: by 2002:a05:600c:4fd3:b0:3cf:a464:e881 with SMTP id o19-20020a05600c4fd300b003cfa464e881mr15090833wmq.54.1668061644392;
        Wed, 09 Nov 2022 22:27:24 -0800 (PST)
Received: from redhat.com ([2.52.23.68])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b0022cd96b3ba6sm17304181wrr.90.2022.11.09.22.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 22:27:23 -0800 (PST)
Date:   Thu, 10 Nov 2022 01:27:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: use PAGE_SIZE for pci vring align
Message-ID: <20221110012603-mutt-send-email-mst@kernel.org>
References: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:11:11PM +0800, Xianting Tian wrote:
> As the comments of VIRTIO_PCI_VRING_ALIGN shows, we should use
> PAGE_SZIE not the hard code 4096.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>


where does it show this?
what is the problem you are trying to solve?
PAGE_SIZE is generally not valid in uapi

> ---
>  include/uapi/linux/virtio_pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..ed5f678c682b 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -90,7 +90,7 @@
>  
>  /* The alignment to use between consumer and producer parts of vring.
>   * x86 pagesize again. */
> -#define VIRTIO_PCI_VRING_ALIGN		4096
> +#define VIRTIO_PCI_VRING_ALIGN		PAGE_SIZE
>  
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>  
> -- 
> 2.17.1

