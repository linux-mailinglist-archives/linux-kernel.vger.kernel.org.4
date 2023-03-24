Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C436C760A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCXCzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCXCzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3D9756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679626493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uAUlOWmnaNVo/VWoXQNmQTS2u7vnkE353p3vcNlNhc=;
        b=Yi1EsPyVBvI0hkrRYM3GszLSgDJNbK2UFGDw2WxUtIObPLdEME6sbKDoEsk12gAEYCc8pA
        VCPitFti9zLqjMRdgdqdQyp5wqPPDNlMNE+aDnxJ+FF5lgOYiGeMW5aC/sA0rG0F3kuc33
        2OAn1mD5TRVxycVcC33yekc39qelhoA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-q3y_l-5IMW6Kgka7xhTZkQ-1; Thu, 23 Mar 2023 22:54:51 -0400
X-MC-Unique: q3y_l-5IMW6Kgka7xhTZkQ-1
Received: by mail-ot1-f71.google.com with SMTP id e2-20020a9d5602000000b00694299f6ea9so165920oti.19
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 19:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679626491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uAUlOWmnaNVo/VWoXQNmQTS2u7vnkE353p3vcNlNhc=;
        b=BDbEbIyM09UO/+oH/OKi8IWGhBlIh1jXRYyjETRX5WZTwA+JQdIzfoREfvS28rfKEm
         9TK8gEX37NXboZe6nJcKPTM6jv6d69VijkkNVB9gfSohCR3lzzshx3WRJnFigU3iy41K
         apQg8fa5zJUattqX8gug4sCK4y5f1i7etq+TH/AzO8b9bo74DhU9Qf41Tq2HeBNIaYr2
         Z47OXSIy2V5STAQqXOeO53rVZi8xaTrU2pvGfsDHMtstq0PxpEaGYRnxaviPUeWPF2dY
         GhDSB/m5dmfU6uy/gf2RPZMZPd+n5Uh884vJekUWKrYPgfR9T/03aUF2t/8Pue75fLjm
         zIxw==
X-Gm-Message-State: AO0yUKX4vogd2menqMIJbkGrm/QYr/c3sbU7Df3hPTx8ArXvoeELuga7
        eKNhFXjC7IvvsuL6cNseuABdloz7SvyMlct6EbX7m0B89z9iQIvrKWLiAjxaRUoQjTTaCoeohAE
        3tXNBmGhrPRanmaDCg+7BeXbz6BmYEOMGk3X9JqsBI5YAOdGQa4QpZw==
X-Received: by 2002:a05:6871:b19b:b0:177:9f9c:dc5 with SMTP id an27-20020a056871b19b00b001779f9c0dc5mr512928oac.9.1679626491037;
        Thu, 23 Mar 2023 19:54:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set9fm4WXoQhc8oPxzAxZzgWX14feJUPEMiSJPQgN0rubtFNZsrLMc1kcr+QSYvWg5YQ6SKRhX2omEeiDY+P3wck=
X-Received: by 2002:a05:6871:b19b:b0:177:9f9c:dc5 with SMTP id
 an27-20020a056871b19b00b001779f9c0dc5mr512917oac.9.1679626490818; Thu, 23 Mar
 2023 19:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154804.184577-1-sgarzare@redhat.com> <20230321154804.184577-4-sgarzare@redhat.com>
 <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com> <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
In-Reply-To: <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 24 Mar 2023 10:54:39 +0800
Message-ID: <CACGkMEveMGEzX7bCPuQuqm=9q7Ut-k=MLrRYM3Bq6cMpaw9fVQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] vdpa_sim: add support for user VA
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        stefanha@redhat.com, linux-kernel@vger.kernel.org,
        eperezma@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 5:50=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Thu, Mar 23, 2023 at 11:42:07AM +0800, Jason Wang wrote:
> >On Tue, Mar 21, 2023 at 11:48=E2=80=AFPM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> >>
> >> The new "use_va" module parameter (default: true) is used in
> >> vdpa_alloc_device() to inform the vDPA framework that the device
> >> supports VA.
> >>
> >> vringh is initialized to use VA only when "use_va" is true and the
> >> user's mm has been bound. So, only when the bus supports user VA
> >> (e.g. vhost-vdpa).
> >>
> >> vdpasim_mm_work_fn work is used to serialize the binding to a new
> >> address space when the .bind_mm callback is invoked, and unbinding
> >> when the .unbind_mm callback is invoked.
> >>
> >> Call mmget_not_zero()/kthread_use_mm() inside the worker function
> >> to pin the address space only as long as needed, following the
> >> documentation of mmget() in include/linux/sched/mm.h:
> >>
> >>   * Never use this function to pin this address space for an
> >>   * unbounded/indefinite amount of time.
> >
> >I wonder if everything would be simplified if we just allow the parent
> >to advertise whether or not it requires the address space.
> >
> >Then when vhost-vDPA probes the device it can simply advertise
> >use_work as true so vhost core can use get_task_mm() in this case?
>
> IIUC set user_worker to true, it also creates the kthread in the vhost
> core (but we can add another variable to avoid this).
>
> My biggest concern is the comment in include/linux/sched/mm.h.
> get_task_mm() uses mmget(), but in the documentation they advise against
> pinning the address space indefinitely, so I preferred in keeping
> mmgrab() in the vhost core, then call mmget_not_zero() in the worker
> only when it is running.

Ok.

>
> In the future maybe mm will be used differently from parent if somehow
> it is supported by iommu, so I would leave it to the parent to handle
> this.

This should be possible, I was told by Intel that their IOMMU can
access the process page table for shared virtual memory.

Thanks

>
> Thanks,
> Stefano
>

