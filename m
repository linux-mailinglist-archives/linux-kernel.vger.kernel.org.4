Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716F715D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjE3L2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjE3L2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE84E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685446058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLpDIoY/l+ntuQOmsSqPPsSE7Zqi06pR85Bxwal7ZuA=;
        b=f91S2VjRYu+BUyywsSwGxjbibcVUUYZ4ocFvNjDgv+WNNzrGbjKdN/zUT7tEBXGoRMMYJK
        +PTCNGPlvyH8Ahtj6XrRn++pjraCJBZayAKXIO17etjiKkyIrbhEk7/ICWzOEvPT5MdO4J
        4N7NLchHRgvc3McI15Abhuwe2fGZZ/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-bdfDFBfWNi---Tg3m0_1pw-1; Tue, 30 May 2023 07:27:37 -0400
X-MC-Unique: bdfDFBfWNi---Tg3m0_1pw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ac5fb0920so2345101f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446056; x=1688038056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLpDIoY/l+ntuQOmsSqPPsSE7Zqi06pR85Bxwal7ZuA=;
        b=d44Havb2ylrlzESy7ODERHsLh2yGN9i0XUBZLRxTj2iaV+wzkOM63GyyumnowJUhe9
         x3ithojGnvg9ml7ThqXMnbA4NsOIJeSi3t1C5wEHjCvqWjwIuL98GobJLAR/nAVmETW8
         SZG4cCwT8R7szyWGfAPTJv2d9UHbDOF+KDqBbXWe8QNdNFCalhGgA8T0W0vjWJFKKpHm
         vqm1JMkNpbz9OxZPSjtXfRB6LocipiWzlsrYxMLNgeVkSGATWQW72UeqEO17B5HzNxPp
         4mnUl+ewhPBYf+hMBvdPnvvpgwKc55rnXm3GkQQEgWZnKNfHXqecDiWPgRWkONNaftJ9
         REEg==
X-Gm-Message-State: AC+VfDzESZiQpkRp3IWH/p4Ju5eA3aQTMn75gYFQ9BvaOV3DUeLNMnRf
        HPMNaIM8JhzbHArvtnMu5CUNIuLzqsTO3tFLrJFA9Eigvgrz2ovvDF1NfGTLfuCnH3vjjvBsLT4
        N8IncHjFyO+b++PzTZgCT+yZs
X-Received: by 2002:adf:f2ca:0:b0:306:492c:cdd8 with SMTP id d10-20020adff2ca000000b00306492ccdd8mr1390215wrp.15.1685446056261;
        Tue, 30 May 2023 04:27:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6v5lVt1G56Fy0lybDZAjjMJK+Gr1E7oNlpLtLUFw/azeFRVrAPkC2Zu+XN8ZsiAG0mKTRyEg==
X-Received: by 2002:adf:f2ca:0:b0:306:492c:cdd8 with SMTP id d10-20020adff2ca000000b00306492ccdd8mr1390202wrp.15.1685446055944;
        Tue, 30 May 2023 04:27:35 -0700 (PDT)
Received: from redhat.com ([2.52.11.69])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5947000000b0030647d1f34bsm3014430wri.1.2023.05.30.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:27:35 -0700 (PDT)
Date:   Tue, 30 May 2023 07:27:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v1] virtio-pci: Improve code style for including header
 files
Message-ID: <20230530072642-mutt-send-email-mst@kernel.org>
References: <20230529181729.15745-1-feliu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529181729.15745-1-feliu@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:17:29PM -0400, Feng Liu wrote:
> Fix code style related to including header file. Include header files
> before declaring macro definitions to avoid conflicts.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Which conflicts? These macros are there precisely to change
how the header behaves.

> ---
>  drivers/virtio/virtio_pci_modern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d6bb68ba84e5..b21a489e0086 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -15,9 +15,10 @@
>   */
>  
>  #include <linux/delay.h>
> +#include "virtio_pci_common.h"
> +
>  #define VIRTIO_PCI_NO_LEGACY
>  #define VIRTIO_RING_NO_LEGACY
> -#include "virtio_pci_common.h"
>  
>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
> -- 
> 2.37.1 (Apple Git-137.1)

