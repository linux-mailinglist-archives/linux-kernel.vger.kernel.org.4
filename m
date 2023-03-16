Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3936BD1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCPOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCPOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356ADD5A53
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678975593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgMDTiStEF85Ioza/girhQTz9UClQi/pg6W3A0BYpDE=;
        b=D+MN9IxFuE95VqmJ5J1rVJMvuRhynfRUg+pOxocmJ+fzD2Wy+RcF+B2TEZCrUQ/mX2b+RP
        h2yNqy+HSCFTMJ2UDyqDlKO2QESkf10gwkJM23CA5y5lMAdJcIUO0UPfDnMmu4sXH0OHD6
        HQaobRyQZqBAAwFBfqmeh3lEoNy0vnM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-inaDC2REP52hMlmhfW0hDg-1; Thu, 16 Mar 2023 10:06:27 -0400
X-MC-Unique: inaDC2REP52hMlmhfW0hDg-1
Received: by mail-yb1-f200.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so1942084ybe.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgMDTiStEF85Ioza/girhQTz9UClQi/pg6W3A0BYpDE=;
        b=HVFMXYahEhfpM26dulufmuZeOaVVrHzSvdFemewk25oAhpWVZEbP6QvqTeTY8H8J0j
         vxP1CglV20tDcDGnMAMR5gMLroAJRj4BKFEioxfIaCnZPk8Y9FkWPkBwWLCHXrYvKvC6
         2d3eP095p9fftia9Hm2ayDObEOFI3cnCbupepM0T7NnXT8nCjeUF+7sNSqGvvadwJWTQ
         VLwXiiE0CMVQanz8OoNzXGAo9Oor0Udg2Icg//OkfyuWSBKOByzxOs0iKOKWLkzk6D3B
         wdFo5cx5cqp7B3U2SLtCEjBBEuZqINCofjwrkaeo1cvCuvDNgZ7GZDsdznBDYErPy7Nw
         ZBCw==
X-Gm-Message-State: AO0yUKW4NxoA7oddLIVqn8gQ8tJbHqgMcQc+DJRGOub7e4zgr3sK4zCf
        i0/8zXQXfWVGHx1KooAFpydkLor/wSdGANNJmKc153EdJV/OU3HKSgNOWWCHwQkqADfqycTxnS6
        PtZleFe/tFLIr64RfFiqsN/RT3GRXdT/HYy0sxUdX
X-Received: by 2002:a81:4317:0:b0:52e:f77c:315d with SMTP id q23-20020a814317000000b0052ef77c315dmr2404699ywa.3.1678975586632;
        Thu, 16 Mar 2023 07:06:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set+W06+Z1Quvd50yqRAEEP3PdK81dRQNkqvZUU49Z41ptq0NMe3jeG2hBo4qkYa3hyse6foi7+3YaeAREaFfyZk=
X-Received: by 2002:a81:4317:0:b0:52e:f77c:315d with SMTP id
 q23-20020a814317000000b0052ef77c315dmr2404677ywa.3.1678975586373; Thu, 16 Mar
 2023 07:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230315192130.970021-1-desnesn@redhat.com> <20230315192130.970021-2-desnesn@redhat.com>
 <44d364bc-62ac-7d31-b886-0f7ee94e3a08@arm.com>
In-Reply-To: <44d364bc-62ac-7d31-b886-0f7ee94e3a08@arm.com>
From:   Desnes Nunes <desnesn@redhat.com>
Date:   Thu, 16 Mar 2023 11:06:15 -0300
Message-ID: <CACaw+exWmGQwBz5oCsz_YTiQfNt4=hSm1UDb6aV75gABwRb4Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dma-debug: small dma_debug_entry's comment and
 variable name updates
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, jejb@linux.ibm.com, jsnitsel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Robin,

Thank you very much for the review and clarification - will send a v2
with the proper comment update.

Best Regards,

On Thu, Mar 16, 2023 at 7:24=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-03-15 19:21, Desnes Nunes wrote:
> > Small update on dma_debug_entry's struct commentary and also standardiz=
e
> > the usage of 'dma_addr' variable name from debug_dma_map_page() on
> > debug_dma_unmap_page(), and similarly on debug_dma_free_coherent()
> >
> > Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> > ---
> >   kernel/dma/debug.c | 11 ++++++-----
> >   1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 18c93c2276ca..e0ad8db1ec25 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -52,7 +52,8 @@ enum map_err_types {
> >   /**
> >    * struct dma_debug_entry - track a dma_map* or dma_alloc_coherent ma=
pping
> >    * @list: node on pre-allocated free_entries list
> > - * @dev: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_coher=
ent
> > + * @dev: pointer to the device driver
>
> The original comment was correct...
>
> > + * @dev_addr: 'dev' argument to dma_map_{page|single|sg} or dma_alloc_=
coherent
>
> ...and the address is clearly not the argument representing the device,
> since it is an address :/
>
> Thanks,
> Robin.
>
> >    * @size: length of the mapping
> >    * @type: single, page, sg, coherent
> >    * @direction: enum dma_data_direction
> > @@ -1262,13 +1263,13 @@ void debug_dma_mapping_error(struct device *dev=
, dma_addr_t dma_addr)
> >   }
> >   EXPORT_SYMBOL(debug_dma_mapping_error);
> >
> > -void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
> > +void debug_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
> >                         size_t size, int direction)
> >   {
> >       struct dma_debug_entry ref =3D {
> >               .type           =3D dma_debug_single,
> >               .dev            =3D dev,
> > -             .dev_addr       =3D addr,
> > +             .dev_addr       =3D dma_addr,
> >               .size           =3D size,
> >               .direction      =3D direction,
> >       };
> > @@ -1403,13 +1404,13 @@ void debug_dma_alloc_coherent(struct device *de=
v, size_t size,
> >   }
> >
> >   void debug_dma_free_coherent(struct device *dev, size_t size,
> > -                      void *virt, dma_addr_t addr)
> > +                      void *virt, dma_addr_t dma_addr)
> >   {
> >       struct dma_debug_entry ref =3D {
> >               .type           =3D dma_debug_coherent,
> >               .dev            =3D dev,
> >               .offset         =3D offset_in_page(virt),
> > -             .dev_addr       =3D addr,
> > +             .dev_addr       =3D dma_addr,
> >               .size           =3D size,
> >               .direction      =3D DMA_BIDIRECTIONAL,
> >       };
>


--=20
Desnes Nunes
Principal Software Engineer
Red Hat Brasil

