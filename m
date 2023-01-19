Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53C567423E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjASTHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjASTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E59B100
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674155118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxwOPOgGhsGm2CilOB8QktAtozAzPUo8tE7EUr+QkN4=;
        b=Kvw8gAoL+efqv7kwtJtND4o7yvHtTDiuiWPqP+tL80TmQioCjyDPUvCn5QF+/EDOkkIbwq
        lIGQ68wvDF0qUBBtVA8MYl1U6olzGoJavNWf0v3wdRyZUcTqM3uYw8uk6DQmCIljqURdVh
        OFQz5fUu7/7BXGjLa05mWIPqewVpQJE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-hopfedUeO6KrIDG9YMkn5g-1; Thu, 19 Jan 2023 14:05:17 -0500
X-MC-Unique: hopfedUeO6KrIDG9YMkn5g-1
Received: by mail-io1-f72.google.com with SMTP id t15-20020a5d81cf000000b006f95aa9ba6eso1626142iol.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxwOPOgGhsGm2CilOB8QktAtozAzPUo8tE7EUr+QkN4=;
        b=GZJ/343bK2zXo3G75msaFP/ocRUvRcE+e+daDpoFznnqQezx6rq/0AlgN6u+geXo+K
         gvLogU43L2dTSJ+MtPBm+UpcU76/bOatc0nrOYhhZBsFu2w98UP+QRi+856W1ndJqdCW
         JE1mrmeafgbZH+I7JIcX7WKVrdAWnlqapazQ1PSZBOdmXTO0aP1EXPERNMfeGzOKBkgL
         TBA3mDtNidCgefeXjFLmqe1v24hwZVIykprN3uBAXRdOs/9kg+zhRN15ngGDDeKHzdm2
         K3oyzPHQEGH5DM0jxwNdoRALAYBpJa6tV6hFAL4rjF+2oF5mOKK52CnbZQELPk03la8J
         3jMg==
X-Gm-Message-State: AFqh2kpCPqExza0Fo+ERI8xpRxil2Z4eZVByAk34tw4Y0ofmK/IbnDNc
        7ZSPLz54sG8BdtQgsKtpmb9T+KUaPbiLDHWhJDk0itM5kQE/EmJvhD6E7PMhlUIjxu6mG+qhB4o
        2nDst79Ze1Ek3SnCoIc2pigFh
X-Received: by 2002:a6b:dc12:0:b0:707:5b8d:745 with SMTP id s18-20020a6bdc12000000b007075b8d0745mr5702686ioc.15.1674155116316;
        Thu, 19 Jan 2023 11:05:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtAMnL3Goqn5o+Ir8AcCe1SjWgVNFXCOrdiM/sijKRrcXt8wW9+Bm8x+wiDCw846gf100RgOg==
X-Received: by 2002:a6b:dc12:0:b0:707:5b8d:745 with SMTP id s18-20020a6bdc12000000b007075b8d0745mr5702666ioc.15.1674155116049;
        Thu, 19 Jan 2023 11:05:16 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m4-20020a056638224400b0036c8a246f54sm11646670jas.142.2023.01.19.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:05:15 -0800 (PST)
Date:   Thu, 19 Jan 2023 12:05:13 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>,
        "jjherne@linux.ibm.com" <jjherne@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
        "david@redhat.com" <david@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Subject: Re: [PATCH v4] vfio: fix potential deadlock on vfio group lock
Message-ID: <20230119120513.3976cda7.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276CC29F17B87D14D1E61FF8CC49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230114000351.115444-1-mjrosato@linux.ibm.com>
        <20230117142252.70cc85c7.alex.williamson@redhat.com>
        <BN9PR11MB52763D861C254248FD33F65C8CC79@BN9PR11MB5276.namprd11.prod.outlook.com>
        <b5a7efc9-7cfa-3314-fe36-b8da4a25265d@linux.ibm.com>
        <BN9PR11MB5276CC29F17B87D14D1E61FF8CC49@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 19 Jan 2023 03:43:36 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Matthew Rosato <mjrosato@linux.ibm.com>
> > Sent: Wednesday, January 18, 2023 10:56 PM
> >=20
> > On 1/18/23 4:03 AM, Tian, Kevin wrote: =20
> > >> From: Alex Williamson
> > >> Sent: Wednesday, January 18, 2023 5:23 AM
> > >>
> > >> On Fri, 13 Jan 2023 19:03:51 -0500
> > >> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> > >> =20
> > >>>  void vfio_device_group_close(struct vfio_device *device)
> > >>>  {
> > >>> +	void (*put_kvm)(struct kvm *kvm);
> > >>> +	struct kvm *kvm;
> > >>> +
> > >>>  	mutex_lock(&device->group->group_lock);
> > >>> +	kvm =3D device->kvm;
> > >>> +	put_kvm =3D device->put_kvm;
> > >>>  	vfio_device_close(device, device->group->iommufd);
> > >>> +	if (kvm =3D=3D device->kvm)
> > >>> +		kvm =3D NULL; =20
> > >>
> > >> Hmm, so we're using whether the device->kvm pointer gets cleared in
> > >> last_close to detect whether we should put the kvm reference.  That'=
s a
> > >> bit obscure.  Our get and put is also asymmetric.
> > >>
> > >> Did we decide that we couldn't do this via a schedule_work() from the
> > >> last_close function, ie. implementing our own version of an async pu=
t?
> > >> It seems like that potentially has a cleaner implementation, symmetr=
ic
> > >> call points, handling all the storing and clearing of kvm related
> > >> pointers within the get/put wrappers, passing only a vfio_device to =
the
> > >> put wrapper, using the "vfio_device_" prefix for both.  Potentially
> > >> we'd just want an unconditional flush outside of lock here for
> > >> deterministic release.
> > >>
> > >> What's the downside?  Thanks,
> > >> =20
> > >
> > > btw I guess this can be also fixed by Yi's work here:
> > >
> > > https://lore.kernel.org/kvm/20230117134942.101112-6-yi.l.liu@intel.co=
m/
> > >
> > > with set_kvm(NULL) moved to the release callback of kvm_vfio device,
> > > such circular lock dependency can be avoided too. =20
> >=20
> > Oh, interesting...  It seems to me that this would eliminate the report=
ed call
> > chain altogether:
> >=20
> > kvm_put_kvm =20
> >  -> kvm_destroy_vm
> >   -> kvm_destroy_devices
> >    -> kvm_vfio_destroy (starting here -- this would no longer be execut=
ed)
> >     -> kvm_vfio_file_set_kvm
> >      -> vfio_file_set_kvm
> >       -> group->group_lock/group_rwsem =20
> >=20
> > because kvm_destroy_devices now can't end up calling kvm_vfio_destroy
> > and friends, it won't try and acquire the group lock a 2nd time making a
> > kvm_put_kvm while the group lock is held OK to do.  The vfio_file_set_k=
vm
> > call will now always come from a separate thread of execution,
> > kvm_vfio_group_add, kvm_vfio_group_del or the release thread:
> >=20
> > kvm_device_release (where the group->group_lock would not be held since
> > vfio does not trigger closing of the kvm fd) =20
> >  -> kvm_vfio_destroy (or, kvm_vfio_release)
> >   -> kvm_vfio_file_set_kvm
> >    -> vfio_file_set_kvm
> >     -> group->group_lock/group_rwsem =20
>=20
> Yes, that's my point. If Alex/Jason are also OK with it probably Yi can
> send that patch separately as a fix to this issue. It's much simpler. =F0=
=9F=98=8A

If we can extract that flow separate from the cdev refactoring, ideally
something that matches the stable kernel backport rules, then that
sounds like the preferred solution.  Thanks,

Alex

