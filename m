Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA526B16B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCHXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCHXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6C193DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678318688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQh0drW5TlB+nMRkrwjuf/guCjqUNLrt66sZFoz2Zx4=;
        b=UXOseoEq++iGsV4ooDmYTqhSCQ1ZcXAzgQqnlP/VWjki9zh07Tvcg5fzBH2N4TMHdXPVaG
        8Vb6wLHLaXtU64p1JXYgaIuAmpyzhtGkkNgewvJH3uMgaYtkQlF0/pOcMcx++OuSF8PZ9D
        Yvbb/gVwJXxSdMmxBo0GpqX+6eoyAy4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-6b3YrDUfMG-KXtk57jetyA-1; Wed, 08 Mar 2023 18:38:07 -0500
X-MC-Unique: 6b3YrDUfMG-KXtk57jetyA-1
Received: by mail-il1-f197.google.com with SMTP id h19-20020a056e021d9300b00318f6b50475so80424ila.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQh0drW5TlB+nMRkrwjuf/guCjqUNLrt66sZFoz2Zx4=;
        b=i1FcWkLG3U3H9XPEyyXp+TQng76eE9lAiQXB4aVXodyF07tH6BTBy/6pPQPPaG/xuW
         cFbQWqk/WFw7sZSQ4IHSEOSj4TROHQLNNdvVsFOshh5KEH6vsXGnPtZbkFBodpZ0N/aw
         qga3X0rxsQn3z+zpDbFnAYb+zcNe76/iRHb3dKGH3ZuBEYonQYmmEHCdSiEN2Cg/gqhk
         INwOq2kNCaRNNQdYR1tlo+v++yKghWgdSwG8QV8TRp9wW4MvDHj21hmovy/jYUxR5mmC
         qb1HqY7wvuwPfzhIehBEyxlYPIfkYvWWs5AGI6KCP/wNbZ0ch282uj19pj4Z5osO3xwY
         i2Yg==
X-Gm-Message-State: AO0yUKUM4/x3FAXXL1mN/c7Ju0lpEh6Gl4T3Xw9bBFkxr9AXjrXDV52Q
        QA9EpKpNko8WQiBotwC1qr0V/r4t4W6QbD+VAO2K04YIkooA/H4CgcKHZHRLql5t8DbhR7+xcTI
        zHyo2qViiK/tBXg4CD+Yt5Uys
X-Received: by 2002:a5d:904e:0:b0:74c:87b5:a083 with SMTP id v14-20020a5d904e000000b0074c87b5a083mr222478ioq.17.1678318686531;
        Wed, 08 Mar 2023 15:38:06 -0800 (PST)
X-Google-Smtp-Source: AK7set8ZTTdc1V8/mXUIfkFzmtAh6Sqf9otuzL5L9q7AV9CasEm1PWwPQVqwzZCh+DKWPHf2/8jSaw==
X-Received: by 2002:a5d:904e:0:b0:74c:87b5:a083 with SMTP id v14-20020a5d904e000000b0074c87b5a083mr222461ioq.17.1678318686224;
        Wed, 08 Mar 2023 15:38:06 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id p11-20020a92d28b000000b003192b0b85eesm4890627ilp.81.2023.03.08.15.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:38:05 -0800 (PST)
Date:   Wed, 8 Mar 2023 16:38:03 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Dominik Behr <dbehr@google.com>
Cc:     Dominik Behr <dbehr@chromium.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        linux-kernel@vger.kernel.org, dmy@semihalf.com, tn@semihalf.com,
        upstream@semihalf.com, dtor@google.com, jgg@ziepe.ca,
        kevin.tian@intel.com, cohuck@redhat.com, abhsahu@nvidia.com,
        yishaih@nvidia.com, yi.l.liu@intel.com, kvm@vger.kernel.org,
        libvir-list@redhat.com
Subject: Re: [PATCH] vfio/pci: Propagate ACPI notifications to the
 user-space
Message-ID: <20230308163803.6bfc2922.alex.williamson@redhat.com>
In-Reply-To: <CABUrSUBBbXRVRo6b1EKBpgu7zk=8yZhQ__UXFGL_GpO+BA4Pkg@mail.gmail.com>
References: <20230307220553.631069-1-jaz@semihalf.com>
        <20230307164158.4b41e32f.alex.williamson@redhat.com>
        <CAH76GKNapD8uB0B2+m70ZScDaOM8TmPNAii9TGqRSsgN4013+Q@mail.gmail.com>
        <20230308104944.578d503c.alex.williamson@redhat.com>
        <CABUrSUD6hE=h3-Ho7L_J=OYeRUw_Bmg9o4fuw591iw9QyBQv9A@mail.gmail.com>
        <20230308130619.3736cf18.alex.williamson@redhat.com>
        <CABUrSUBBbXRVRo6b1EKBpgu7zk=8yZhQ__UXFGL_GpO+BA4Pkg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Wed, 8 Mar 2023 14:44:28 -0800
Dominik Behr <dbehr@google.com> wrote:

> On Wed, Mar 8, 2023 at 12:06=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Wed, 8 Mar 2023 10:45:51 -0800
> > Dominik Behr <dbehr@chromium.org> wrote:
> > =20
> > > It is the same interface as other ACPI events like AC adapter LID etc
> > > are forwarded to user-space.
> > >  ACPI events are not particularly high frequency like interrupts. =20
> >
> > I'm not sure that's relevant, these interfaces don't proclaim to
> > provide isolation among host processes which manage behavior relative
> > to accessories.  These are effectively system level services.  It's only
> > a very, very specialized use case that places a VMM as peers among these
> > processes.  Generally we don't want to grant a VMM any privileges beyond
> > what it absolutely needs, so letting a VMM managing an assigned NIC
> > really ought not to be able to snoop host events related to anything
> > other than the NIC. =20
> How is that related to the fact that we are forwarding VFIO-PCI events
> to netlink? Kernel does not grant any privileges to VMM.
> There are already other ACPI events on netlink. The implementer of the
> VMM can choose to allow VMM to snoop them or not.
> In our case our VMM (crosvm) does already snoop LID, battery and AC
> adapter events so the guest can adjust its behavior accordingly.
> This change just adds another class of ACPI events that are forwarded
> to netlink.

That's true, it is the VMM choice whether to allow snooping netlink,
but this is being proposed as THE solution to allow VMMs to receive
ACPI events related to vfio assigned devices.  If the solution
inherently requires escalating the VMM privileges to see all netlink
events, that's a weakness in the proposal.  As noted previously,
there's also no introspection here, the VMM can't know whether it
should listen to netlink for ACPI events or include AML related to a
GPE for the device.  It cannot determine if either the kernel supports
this feature or if the device has an ACPI companion that can generate
these events.

> > =20
> > > > > > What sort of ACPI events are we expecting to see here and what =
does user space do with them? =20
> > > The use we are looking at right now are D-notifier events about the
> > > GPU power available to mobile discrete GPUs.
> > > The firmware notifies the GPU driver and resource daemon to
> > > dynamically adjust the amount of power that can be used by the GPU.
> > > =20
> > > > The proposed interface really has no introspection, how does the VMM
> > > > know which devices need ACPI tables added "upfront"?  How do these
> > > > events factor into hotplug device support, where we may not be able=
 to
> > > > dynamically inject ACPI code into the VM? =20
> > >
> > > The VMM can examine PCI IDs and the associated firmware node of the
> > > PCI device to figure out what events to expect and what ACPI table to
> > > generate to support it but that should not be necessary. =20
> >
> > I'm not entirely sure where your VMM is drawing the line between the VM
> > and management tools, but I think this is another case where the
> > hypervisor itself should not have privileges to examine the host
> > firmware tables to build its own.  Something like libvirt would be
> > responsible for that. =20
> Yes, but that depends on the design of hypervisor and VMM and is not
> related to this patch.

It is very much related to this patch if it proposes an interface to
solve a problem which is likely not compatible with the security model
of other VMMs.  We need a single solution to support all VMMs.

> > =20
> > > A generic GPE based ACPI event forwarder as Grzegorz proposed can be
> > > injected at VM init time and handle any notification that comes later,
> > > even from hotplug devices. =20
> >
> > It appears that forwarder is sending the notify to a specific ACPI
> > device node, so it's unclear to me how that becomes boilerplate AML
> > added to all VMs.  We'll need to notify different devices based on
> > different events, right? =20
> Valid point. The notifications have a "scope" ACPI path.
> In my experience these events are consumed without looking where they
> came from but I believe the patch can be extended to
> provide ACPI path, in your example "_SB.PCI0.GPP0.PEGP" instead of
> generic vfio_pci which VMM could use to translate an equivalent ACPI
> path in the guest and pass it to a generic ACPI GPE based notifier via
> shared memory. Grzegorz could you chime in whether that would be
> possible?

So effectively we're imposing the host ACPI namespace on the VM, or at
least a mapping between the host and VM namespace?  The generality of
this is not improving.

> > > > The acpi_bus_generate_netlink_event() below really only seems to fo=
rm a
> > > > u8 event type from the u32 event.  Is this something that could be
> > > > provided directly from the vfio device uAPI with an ioeventfd, thus
> > > > providing introspection that a device supports ACPI event notificat=
ions
> > > > and the ability for the VMM to exclusively monitor those events, and
> > > > only those events for the device, without additional privileges? =20
> > >
> > > From what I can see these events are 8 bit as they come from ACPI.
> > > They also do not carry any payload and it is up to the receiving
> > > driver to query any additional context/state from the device.
> > > This will work the same in the VM where driver can query the same
> > > information from the passed through PCI device.
> > > There are multiple other netflink based ACPI events forwarders which
> > > do exactly the same thing for other devices like AC adapter, lid/power
> > > button, ACPI thermal notifications, etc.
> > > They all use the same mechanism and can be received by user-space
> > > programs whether VMMs or others. =20
> >
> > But again, those other receivers are potentially system services, not
> > an isolated VM instance operating in a limited privilege environment.
> > IMO, it's very different if the host display server has access to lid
> > or power events than it is to allow some arbitrary VM that happens to
> > have an unrelated assigned device that same privilege. =20
> Therefore these VFIO related ACPI events could be received by a system
> service via this netlink event and selectively forwarded to VMM if
> such is a desire of whoever implements the userspace.
> This is outside the scope of this patch. In our case our VMM does
> receive these LID, AC or battery events.

But this is backwards, we're presupposing the choice to use netlink
based on the convenience of one VMM, which potentially creates
obstacles, maybe even security isolation issues for other VMMs.  The
method of delivering ACPI events to a VMM is very much within the scope
of this proposal.  Thanks,

Alex

