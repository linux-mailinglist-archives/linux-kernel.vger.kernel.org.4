Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1C6BF548
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCQWl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQWlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D085B1C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679092865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTqXt+xo9t4MKZl9inPofpb9h7U7JlyPPD0kMbn7WHE=;
        b=a+C8PoK8O6QGcj0SWnFCIAKpJxgiZnNpUhilASsf4LwCT9hsBFDGn/Izb+udWcEhohf+Iw
        gMC7wkupE9DjINnltKjE0jxvgeklVnSPQ9N0i6YqqMgki0SLDA9jPFonX5FkzfbhY7kiEK
        C5wWFz0ISi8ehlzGkXXLGCRPQBGKjm4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-d0EHtZQZOjWGRssZ_xuP8Q-1; Fri, 17 Mar 2023 18:41:04 -0400
X-MC-Unique: d0EHtZQZOjWGRssZ_xuP8Q-1
Received: by mail-il1-f200.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so3109944ils.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679092863;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTqXt+xo9t4MKZl9inPofpb9h7U7JlyPPD0kMbn7WHE=;
        b=sDbDpLSljmO1dCxzB7ExTm//7BUOXeX2I3EyQrFO51p3DLq6GKSX76uC0BALfBDmjC
         sKAPGPWEoa+i8nRBEsZa1wPBigzopIvnvA/Cddce7QOrpZ2mP6nYfJgqclyU5cGhxB6V
         RLQmOsB3GsQi2kO/gK4VNWgxskQZ2TVem8ltpFjqA3gNHjqGl4xZCfk2onS3zOqwKEGy
         yr/K/vbcz5/zt7lTx+J/t8Q/Bed9fN3VyGTPZz2J0eH9MrbJ9unp5MHf8FZGvPfWayS9
         7CWNnYvfK/I2mp0rtFPlGz6HovgcJtgzng0pljy4hMpiIaWynoSAJMn9jRjEKXh9fRQh
         EytQ==
X-Gm-Message-State: AO0yUKV1CiyVVA0MErBhKDYT+dlM5A1ue0bqiH84cF+iIWphVg6vLS2P
        V/hLXWlpQo3oY9lLdKB5gDnwI2QAo62YKuUZG54Usuap5/u6R30ffmp3vYF8jl6/na4XAWKP8aq
        AwpMJUWRG4K7e3RhAWZKdxuwWXYsu4hyrDNM=
X-Received: by 2002:a92:c6ca:0:b0:317:951d:1696 with SMTP id v10-20020a92c6ca000000b00317951d1696mr85590ilm.3.1679092863438;
        Fri, 17 Mar 2023 15:41:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set87c1NIAKUmEpfr4tzQnIJXEdWv1u+znmZLZ35q/KPacnrvpXDdPzfrlB+0sZFBlBtfHyN/iw==
X-Received: by 2002:a92:c6ca:0:b0:317:951d:1696 with SMTP id v10-20020a92c6ca000000b00317951d1696mr85571ilm.3.1679092863136;
        Fri, 17 Mar 2023 15:41:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x10-20020a92300a000000b0030c0dce44b1sm930381ile.15.2023.03.17.15.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:41:01 -0700 (PDT)
Date:   Fri, 17 Mar 2023 16:40:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
        dimitri.sivanich@hpe.com
Subject: Re: [PATCH v4 0/7] introduce vm_flags modifier functions
Message-ID: <20230317164059.466d1c70.alex.williamson@redhat.com>
In-Reply-To: <CAJuCfpFkKuyBJkk8OzWEu2YCg-UYooS4bHuDaXvnCbeR-cBdVw@mail.gmail.com>
References: <20230126193752.297968-1-surenb@google.com>
        <20230314141144.6a0892e6.alex.williamson@redhat.com>
        <CAJuCfpFkKuyBJkk8OzWEu2YCg-UYooS4bHuDaXvnCbeR-cBdVw@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 12:08:32 -0700
Suren Baghdasaryan <surenb@google.com> wrote:

> On Tue, Mar 14, 2023 at 1:11=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Thu, 26 Jan 2023 11:37:45 -0800
> > Suren Baghdasaryan <surenb@google.com> wrote:
> > =20
> > > This patchset was originally published as a part of per-VMA locking [=
1] and
> > > was split after suggestion that it's viable on its own and to facilit=
ate
> > > the review process. It is now a preprequisite for the next version of=
 per-VMA
> > > lock patchset, which reuses vm_flags modifier functions to lock the V=
MA when
> > > vm_flags are being updated.
> > >
> > > VMA vm_flags modifications are usually done under exclusive mmap_lock
> > > protection because this attrubute affects other decisions like VMA me=
rging
> > > or splitting and races should be prevented. Introduce vm_flags modifi=
er
> > > functions to enforce correct locking.
> > >
> > > The patchset applies cleanly over mm-unstable branch of mm tree. =20
> >
> > With this series, vfio-pci developed a bunch of warnings around not
> > holding the mmap_lock write semaphore while calling
> > io_remap_pfn_range() from our fault handler, vfio_pci_mmap_fault().
> >
> > I suspect vdpa has the same issue for their use of remap_pfn_range()
> > from their fault handler, JasonW, MST, FYI.
> >
> > It also looks like gru_fault() would have the same issue, Dimitri.
> >
> > In all cases, we're preemptively setting vm_flags to what
> > remap_pfn_range_notrack() uses, so I thought we were safe here as I
> > specifically remember trying to avoid changing vm_flags from the
> > fault handler.  But apparently that doesn't take into account
> > track_pfn_remap() where VM_PAT comes into play.
> >
> > The reason for using remap_pfn_range() on fault in vfio-pci is that
> > we're mapping device MMIO to userspace, where that MMIO can be disabled
> > and we'd rather zap the mapping when that occurs so that we can sigbus
> > the user rather than allow the user to trigger potentially fatal bus
> > errors on the host.
> >
> > Peter Xu has suggested offline that a non-lazy approach to reinsert the
> > mappings might be more inline with mm expectations relative to touching
> > vm_flags during fault.  What's the right solution here?  Can the fault
> > handling be salvaged, is proactive remapping the right approach, or is
> > there something better?  Thanks, =20
>=20
> Hi Alex,
> If in your case it's safe to change vm_flags without holding exclusive
> mmap_lock, maybe you can use __vm_flags_mod() the way I used it in
> https://lore.kernel.org/all/20230126193752.297968-7-surenb@google.com,
> while explaining why this should be safe?

Hi Suren,

Thanks for the reply, but I'm not sure I'm following.  Are you
suggesting a bool arg added to io_remap_pfn_range(), or some new
variant of that function to conditionally use __vm_flags_mod() in place
of vm_flags_set() across the call chain?  Thanks,

Alex

