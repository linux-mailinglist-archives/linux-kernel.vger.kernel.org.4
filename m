Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B27166D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjE3PTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjE3PTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE58BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685459935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzUmgv4c0PPfLXFfcu4AEjs2wLKMpfg6cT4UKZmFGvQ=;
        b=RigjoFfSk7Soflr72dqpJ8ucxZl8glpmwiliOrNjw7zl/j+zXaFQpKYaY8KBGiIHx7uPlf
        Ltcd5l8btAbaQ3ns9McEmx92Tgc5iST0OozrXSTDpTxt+U8YQAsRTR6zhg+VoANaT7rcuE
        MyMt6LltpMS5xKGkTNE0Xu5QfhqIuH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-njIJ9U1NN2uPdW3Nv_c0Ow-1; Tue, 30 May 2023 11:18:51 -0400
X-MC-Unique: njIJ9U1NN2uPdW3Nv_c0Ow-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6069f764bso77279565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459930; x=1688051930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzUmgv4c0PPfLXFfcu4AEjs2wLKMpfg6cT4UKZmFGvQ=;
        b=NLN2tZ4+4gfwTMU7bdRCboYwuAa0Qm4h1xz18XwhuSFhuuiA6DDfvEy1rdIZI1eJuo
         luTj9+FFxUc1Kk71TgNxx+4U1B54hqeiVRC8ibX9qRU/svDiDatfW4W10OeejfH8KsPh
         cMoKpbYiDW5IgZxovQX6YRIhnwdNFYtuyvWdaBBP+V0+yCGJ6wQ+bPnUpoS4LOOpCXRF
         n3G0ss31cQmwM+E3i/EyWo5YPY5OkqWeqpP1tVkBMbwDAfCXEbFr/pMElLo1EB9jOUf3
         f0qF1c/yJoUCDisRlBhJIUoTT8lnxlecM0eR4A7beyF6S9HjsD4g3l5aQ21RNY2E4NHh
         syog==
X-Gm-Message-State: AC+VfDxevy1y4TmoI4oEscTOmmieP04s9g4NmgE1rZW9hSICEIfQHZdC
        ytaqlYttc9+Mj71HI/+BAnsqqQLjOSw7aQSZRHz1sCuounYLVdZ5MQGFyVQ9fottsjNnsKzapLh
        Adpoeq3hteROYj+0YxHE098Kw
X-Received: by 2002:a05:600c:2208:b0:3f6:a66:a36d with SMTP id z8-20020a05600c220800b003f60a66a36dmr1945449wml.10.1685459930664;
        Tue, 30 May 2023 08:18:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67j8zXMzDSexJ/DlnFeRckDXeWoBOmhzeJlskTQXAtICps4DBhodE0KhKNReQJ7N+WmLdGVw==
X-Received: by 2002:a05:600c:2208:b0:3f6:a66:a36d with SMTP id z8-20020a05600c220800b003f60a66a36dmr1945441wml.10.1685459930398;
        Tue, 30 May 2023 08:18:50 -0700 (PDT)
Received: from redhat.com ([2.52.11.69])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b003f09d7b6e20sm17727697wmj.2.2023.05.30.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:18:49 -0700 (PDT)
Date:   Tue, 30 May 2023 11:18:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v1] virtio-pci: Improve code style for including header
 files
Message-ID: <20230530111818-mutt-send-email-mst@kernel.org>
References: <20230529181729.15745-1-feliu@nvidia.com>
 <20230530072642-mutt-send-email-mst@kernel.org>
 <9d183df9-7047-0eee-b6d4-b0f9b8d21036@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d183df9-7047-0eee-b6d4-b0f9b8d21036@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:07:23AM -0400, Feng Liu wrote:
> 
> 
> On 2023-05-30 a.m.7:27, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, May 29, 2023 at 02:17:29PM -0400, Feng Liu wrote:
> > > Fix code style related to including header file. Include header files
> > > before declaring macro definitions to avoid conflicts.
> > > 
> > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > 
> > Which conflicts? These macros are there precisely to change
> > how the header behaves.
> > 
> 
> Hi Michael
>     I think including the header files should be placed before the macro
> definition.
>     If VIRTIO_PCI_NO_LEGACY and VIRTIO_RING_NO_LEGACY are needed for control
> header file, we should put them at the beginning of virtio_pci_common.h.
> 
> What do you think?

I think you should read the code in question not make guesses.

> > > ---
> > >   drivers/virtio/virtio_pci_modern.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index d6bb68ba84e5..b21a489e0086 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -15,9 +15,10 @@
> > >    */
> > > 
> > >   #include <linux/delay.h>
> > > +#include "virtio_pci_common.h"
> > > +
> > >   #define VIRTIO_PCI_NO_LEGACY
> > >   #define VIRTIO_RING_NO_LEGACY
> > > -#include "virtio_pci_common.h"
> > > 
> > >   static u64 vp_get_features(struct virtio_device *vdev)
> > >   {
> > > --
> > > 2.37.1 (Apple Git-137.1)
> > 

