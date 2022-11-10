Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C899623BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiKJG0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiKJG0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14444CE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668061554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cT7MIb473qqDDSVVXwyDEMmLSzN/VjsHwdjNL16ENvg=;
        b=Ga+4bQp9WAodEm7h8aaUgB4q2MPgvZ+QRj7INJOZDfH5ghYceLC49NdHTEnZVL+kQmbJF5
        K40SMMj5cmZ73BfWr/wHlrIVTKTk6e/e7aQ8d5ynwaBNnJ6pwgRen2uZTFtdYw6bQ6nNT4
        58XEkgUKXljQAHUa8T1nVx90MjcbckI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-IbdhP7PwNh6NJnpV64ohuw-1; Thu, 10 Nov 2022 01:25:52 -0500
X-MC-Unique: IbdhP7PwNh6NJnpV64ohuw-1
Received: by mail-ej1-f71.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso581245ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 22:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cT7MIb473qqDDSVVXwyDEMmLSzN/VjsHwdjNL16ENvg=;
        b=gzWNsIuumlioyMAR3Sqv4qA7a6TSteu8JkarCgAyi11VQ0ankRMTQe1XdVsfMH7qii
         xWB/EXMtmhn5F48DflN17gKHqE1hDeKQ19NZnVOK5SOxt9sHJxEtN8vqPxOXEjPD1E3k
         j++ORzIVuCCuKWCTHlHxdl9IKYYKGVRzEOUxiuDKNafm8a2Enq2is5Ir5zSDpFgPwS60
         RXHGvKrM0+MI1aLkI2oq8lE7EgrcpZiN1dDDpGJAUvoW3owBD8UmoYZsfkC3P5DJrDA6
         Q9olWNZkxyK6RuuhFIIfZmMkaps3cny9FEepZ0WFsrG+jEqfiqBwCo0dE7QhGSMw90GE
         fS/Q==
X-Gm-Message-State: ACrzQf2IOOcQkXgwObbY4ZPgDdQqN8rVqHuN4p5HClC1LKSjjdyjioqz
        8MW0JIaqdyT4y8bh5gVW5hfLVfg0OJ+yUcM/zVrf4Q1W1d9/i2+TnZjsjWg/bI4Jjcou7kiLwRQ
        TwWIFG7FIg8UrBlalCBKp6sN4NxI6dnYZZqdW8h0i
X-Received: by 2002:a17:906:8a54:b0:7ad:e517:1eb with SMTP id gx20-20020a1709068a5400b007ade51701ebmr45520142ejc.567.1668061551690;
        Wed, 09 Nov 2022 22:25:51 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7747G9NLhB7GE8qdR42UGnM94e4TCOGXhh6mmCvtRvV+rwu838gSmYF2yH5z1M0jPQd+NuaqydVuMzCLcQLhU=
X-Received: by 2002:a17:906:8a54:b0:7ad:e517:1eb with SMTP id
 gx20-20020a1709068a5400b007ade51701ebmr45520132ejc.567.1668061551543; Wed, 09
 Nov 2022 22:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Nov 2022 14:25:36 +0800
Message-ID: <CACGkMEtxEe=SdjgE=qm5_TNy-XrY0x9gRZFLNnrA+3JShfLtYw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use PAGE_SIZE for pci vring align
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 2:14 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> As the comments of VIRTIO_PCI_VRING_ALIGN shows, we should use
> PAGE_SZIE not the hard code 4096.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
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

See the comment above, PAGE_SIZE varies among archs.

Thanks

> -#define VIRTIO_PCI_VRING_ALIGN         4096
> +#define VIRTIO_PCI_VRING_ALIGN         PAGE_SIZE
>
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>
> --
> 2.17.1
>

