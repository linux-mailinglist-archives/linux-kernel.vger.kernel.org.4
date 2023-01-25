Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315267B400
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjAYOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:14:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B95925C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674656021;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBTVJEiEIva6aiwNg+MvF+yngIhGMSpeSJbbXk9BNss=;
        b=P5N0DVTWlwdajFVgLMlrYrdXeBKpTw5P8dEgk5Nh7k1io4XlJDfhzXRpIWn9taj8XzPxuC
        uCfW5zftDlwJqtR1Mg/u0BdApWldBiGyglu2mgw0/bD459QaiFRBKby4p/TxpoTpsNqF/Z
        M+UZ6vQUIsibE3yh7AVDZWU1FxLA8xU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-YTMvLTIoODW62EMT5TnoEA-1; Wed, 25 Jan 2023 09:13:37 -0500
X-MC-Unique: YTMvLTIoODW62EMT5TnoEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F2FE3C1068D;
        Wed, 25 Jan 2023 14:13:36 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0414E492C14;
        Wed, 25 Jan 2023 14:13:32 +0000 (UTC)
Date:   Wed, 25 Jan 2023 14:13:30 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Message-ID: <Y9E5Cg7mreDx737N@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9Ex3ZUIFxwOBg1n@work-vm>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
> * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
> > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
> > > Hi Greg, 
> > > 
> > > You mentioned couple of times (last time in this recent thread:
> > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we ought to start
> > > discussing the updated threat model for kernel, so this email is a start in this direction. 
> > 
> > Any specific reason you didn't cc: the linux-hardening mailing list?
> > This seems to be in their area as well, right?
> > 
> > > As we have shared before in various lkml threads/conference presentations
> > > ([1], [2], [3] and many others), for the Confidential Computing guest kernel, we have a 
> > > change in the threat model where guest kernel doesn’t anymore trust the hypervisor. 
> > 
> > That is, frankly, a very funny threat model.  How realistic is it really
> > given all of the other ways that a hypervisor can mess with a guest?
> 
> It's what a lot of people would like; in the early attempts it was easy
> to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
> can mess with - remember that not just the memory is encrypted, so is
> the register state, and the guest gets to see changes to mapping and a
> lot of control over interrupt injection etc.
> 
> > So what do you actually trust here?  The CPU?  A device?  Nothing?
> 
> We trust the actual physical CPU, provided that it can prove that it's a
> real CPU with the CoCo hardware enabled.  Both the SNP and TDX hardware
> can perform an attestation signed by the CPU to prove to someone
> external that the guest is running on a real trusted CPU.
> 
> Note that the trust is limited:
>   a) We don't trust that we can make forward progress - if something
> does something bad it's OK for the guest to stop.
>   b) We don't trust devices, and we don't trust them by having the guest
> do normal encryption; e.g. just LUKS on the disk and normal encrypted
> networking. [There's a lot of schemes people are working on about how
> the guest gets the keys etc for that)

I think we need to more precisely say what we mean by 'trust' as it
can have quite a broad interpretation.

As a baseline requirement, in the context of confidential computing the
guest would not trust the hypervisor with data that needs to remain
confidential, but would generally still expect it to provide a faithful
implementation of a given device.

IOW, the guest would expect the implementation of virtio-blk devices to
be functionally correct per the virtio-blk specification, but would not
trust the host to protect confidentiality any stored data in the disk.

Any virtual device exposed to the guest that can transfer potentially
sensitive data needs to have some form of guest controlled encryption
applied. For disks this is easy with FDE like LUKS, for NICs this is
already best practice for services by using TLS. Other devices may not
have good existing options for applying encryption.

If the guest has a virtual keyboard, mouse and graphical display, which
is backed by a VNC/RDP server in the host, then all that is visible to the
host. There's no pre-existing solutions I know can could offer easy
confidentiality for basic console I/O from the start of guest firmware
onwards. The best is to spawn a VNC/RDP server in the guest at some
point during boot. Means you can't login to the guest in single user
mode with your root password though, without compromising it.

The problem also applies for common solutions today where the host passes
in config data to the guest, for consumption by tools like cloud-init.
This is used in the past to inject an SSH key for example, or set the
guest root password. Such data received from the host can no longer be
trusted, as the host can see the data, or subsitute its own SSH key(s)
in order to gain access. Cloud-init needs to get its config data from
a trusted source, likely an external attestation server


A further challenge surrounds handling of undesirable devices. A goal
of OS development has been to ensure that both coldplugged and hotplugged
devices "just work" out of the box with zero guest admin config required.
To some extent this is contrary to what a confidential guest will want.
It doesn't want a getty spawned on any console exposed, it doesn't want
to use a virtio-rng exposed by the host which could be feeding non-random.


Protecting against malicious implementations of devices is conceivably
interesting, as a hardening task. A malicious host may try to take
advantage of the guest OS device driver impl to exploit the guest OS
kernel with an end goal of getting into a state where it can be made
to reveal confidential data that was otherwise protected.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

