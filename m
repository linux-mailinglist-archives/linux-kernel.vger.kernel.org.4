Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417867B5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjAYPaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjAYP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9053233C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674660547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRCiLRdneBPyIkrvbI4baasI0smwzLWL7OfELwvnIk8=;
        b=AqeLw/MY8hz/uHZTI1zxXqTnEzx2N136Xdbb1eabg0FspJzGUHsCc+bie+NYtjo0CWs1PQ
        6qeggDLokfF+6fVmGUkAzDmM4D80c5TrkvimV/dlReWR/Vb6ApLDjuyKUxZsctyZWOX3oD
        rJdGrkR9URR1VnCZse9f2zZLxtTQnbU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-YngmS4tQOE2XLbs-ANU3Lg-1; Wed, 25 Jan 2023 10:29:05 -0500
X-MC-Unique: YngmS4tQOE2XLbs-ANU3Lg-1
Received: by mail-wr1-f70.google.com with SMTP id h17-20020a5d5491000000b002bfb1375c4eso963158wrv.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRCiLRdneBPyIkrvbI4baasI0smwzLWL7OfELwvnIk8=;
        b=cNdVzcZ8grzXXU1qRqOZAQQcZPcQjkmekDky8gj8DgF6saJ95Xqam09jM+E+1WjYah
         J3zwfBo57vKxkAf+XA2fBj4KGVm5Tup3I5GDCvdKffduWYlGHU4rpQ9etCBdUbye/umr
         XCRTQ1XdzmvR19Ab6AeYzj07h1WhtURm3ppMycjXohqafs+1vRZFxRZQuA1OXBS5VL0f
         gt8WMeHXYlO7UQmElctm3zGvTYgHZ10sezhRFhbBUl2nKWDau8tsyaMZ6FWQWM0wZnEp
         QZFnyCO3aIsw/4F1OnmQ3JZrXB4A7wQ3QhAo+L12EJ4jHtu7DWdMv46KXxfExayXbond
         4djA==
X-Gm-Message-State: AFqh2kpXheXkQSFTpNMmtsx5UYbgxImCMdUbirGlpBhKlT/RrBGSuKbA
        EPRi0W4CUynToeqgEJcePJsMn1su5CVpNec019ki1g6FiQqnnp6dWSlTjeEWAHv1BoGTTUGagt8
        mo2p46DqgPlxvSKQsOzcVK1/H
X-Received: by 2002:a05:600c:43d3:b0:3da:fbcd:cdd2 with SMTP id f19-20020a05600c43d300b003dafbcdcdd2mr32579872wmn.9.1674660543964;
        Wed, 25 Jan 2023 07:29:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsZBYCFSrUe78yGSsNUU0iGKqLYv5QAnF8wkN1Cr3k2ZykigrRpMAE1TBT00xxPuSXYYVYUWQ==
X-Received: by 2002:a05:600c:43d3:b0:3da:fbcd:cdd2 with SMTP id f19-20020a05600c43d300b003dafbcdcdd2mr32579844wmn.9.1674660543744;
        Wed, 25 Jan 2023 07:29:03 -0800 (PST)
Received: from work-vm (ward-16-b2-v4wan-166627-cust863.vm18.cable.virginm.net. [81.97.203.96])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bc8c1000000b003c6bbe910fdsm2605382wml.9.2023.01.25.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:29:03 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:29:00 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9FKvOYlOv3I24yD@work-vm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E5Cg7mreDx737N@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9E5Cg7mreDx737N@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
> > * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > > Hi Greg, 
> > > > 
> > > > You mentioned couple of times (last time in this recent thread:
> > > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> > > > discussing the updated threat model for kernel, so this email is a start in this direction. 
> > > 
> > > Any specific reason you didn't cc: the linux-hardening mailing list?
> > > This seems to be in their area as well, right?
> > > 
> > > > As we have shared before in various lkml threads/conference presentations
> > > > ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> > > > change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> > > 
> > > That is, frankly, a very funny threat model.  How realistic is it really
> > > given all of the other ways that a hypervisor can mess with a guest?
> > 
> > It's what a lot of people would like; in the early attempts it was easy
> > to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
> > can mess with - remember that not just the memory is encrypted, so is
> > the register state, and the guest gets to see changes to mapping and a
> > lot of control over interrupt injection etc.
> > 
> > > So what do you actually trust here?  The CPU?  A device?  Nothing?
> > 
> > We trust the actual physical CPU, provided that it can prove that it's a
> > real CPU with the CoCo hardware enabled.  Both the SNP and TDX hardware
> > can perform an attestation signed by the CPU to prove to someone
> > external that the guest is running on a real trusted CPU.
> > 
> > Note that the trust is limited:
> >   a) We don't trust that we can make forward progress - if something
> > does something bad it's OK for the guest to stop.
> >   b) We don't trust devices, and we don't trust them by having the guest
> > do normal encryption; e.g. just LUKS on the disk and normal encrypted
> > networking. [There's a lot of schemes people are working on about how
> > the guest gets the keys etc for that)
> 
> I think we need to more precisely say what we mean by 'trust' as it
> can have quite a broad interpretation.
> 
> As a baseline requirement, in the context of confidential computing the
> guest would not trust the hypervisor with data that needs to remain
> confidential, but would generally still expect it to provide a faithful
> implementation of a given device.
> 
> IOW, the guest would expect the implementation of virtio-blk devices to
> be functionally correct per the virtio-blk specification, but would not
> trust the host to protect confidentiality any stored data in the disk.
> 
> Any virtual device exposed to the guest that can transfer potentially
> sensitive data needs to have some form of guest controlled encryption
> applied. For disks this is easy with FDE like LUKS, for NICs this is
> already best practice for services by using TLS. Other devices may not
> have good existing options for applying encryption.
> 
> If the guest has a virtual keyboard, mouse and graphical display, which
> is backed by a VNC/RDP server in the host, then all that is visible to the
> host. There's no pre-existing solutions I know can could offer easy
> confidentiality for basic console I/O from the start of guest firmware
> onwards. The best is to spawn a VNC/RDP server in the guest at some
> point during boot. Means you can't login to the guest in single user
> mode with your root password though, without compromising it.
> 
> The problem also applies for common solutions today where the host passes
> in config data to the guest, for consumption by tools like cloud-init.
> This is used in the past to inject an SSH key for example, or set the
> guest root password. Such data received from the host can no longer be
> trusted, as the host can see the data, or subsitute its own SSH key(s)
> in order to gain access. Cloud-init needs to get its config data from
> a trusted source, likely an external attestation server
> 
> 
> A further challenge surrounds handling of undesirable devices. A goal
> of OS development has been to ensure that both coldplugged and hotplugged
> devices "just work" out of the box with zero guest admin config required.
> To some extent this is contrary to what a confidential guest will want.
> It doesn't want a getty spawned on any console exposed, it doesn't want
> to use a virtio-rng exposed by the host which could be feeding non-random.
> 
> 
> Protecting against malicious implementations of devices is conceivably
> interesting, as a hardening task. A malicious host may try to take
> advantage of the guest OS device driver impl to exploit the guest OS
> kernel with an end goal of getting into a state where it can be made
> to reveal confidential data that was otherwise protected.

I think this is really what the Intel stuff is trying to protect
against.

Dave

> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

