Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95F6680C15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjA3LhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjA3LhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859DA3029C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675078582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeBW6EwqBQR8mcb+U6gPECyycxrOzab1UxBLSfBKtfI=;
        b=YODwslUKZE/zzWiTskJX6lDMS9Tke5yYMxjc3unYNX1e0GDqN45LR8Bbyz02lQu8eITiDa
        2PVvhkSWWvqmcuvQo3pB9vGZpRtN+n6kBzUyPBys4RohXbkCct4WeH1g9x7tX618TKfO9U
        s0S9bi0parVM8lqWpuxsg6n+H9XS5ps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-M2TzEfdmPy6zBLJdpkOz2Q-1; Mon, 30 Jan 2023 06:36:19 -0500
X-MC-Unique: M2TzEfdmPy6zBLJdpkOz2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31EF0101A521;
        Mon, 30 Jan 2023 11:36:18 +0000 (UTC)
Received: from ptitbras (unknown [10.39.195.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C675EC15BAD;
        Mon, 30 Jan 2023 11:36:13 +0000 (UTC)
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E5Cg7mreDx737N@redhat.com>
User-agent: mu4e 1.8.0; emacs 28.2
From:   Christophe de Dinechin <dinechin@redhat.com>
To:     =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Date:   Mon, 30 Jan 2023 12:30:45 +0100
In-reply-to: <Y9E5Cg7mreDx737N@redhat.com>
Message-ID: <m2tu085k5v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-01-25 at 14:13 UTC, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote...
> On Wed, Jan 25, 2023 at 01:42:53PM +0000, Dr. David Alan Gilbert wrote:
>> * Greg Kroah-Hartman (gregkh@linuxfoundation.org) wrote:
>> > On Wed, Jan 25, 2023 at 12:28:13PM +0000, Reshetova, Elena wrote:
>> > > Hi Greg,
>> > >
>> > > You mentioned couple of times (last time in this recent thread:
>> > > https://lore.kernel.org/all/Y80WtujnO7kfduAZ@kroah.com/) that we oug=
ht to start
>> > > discussing the updated threat model for kernel, so this email is a s=
tart in this direction.
>> >
>> > Any specific reason you didn't cc: the linux-hardening mailing list?
>> > This seems to be in their area as well, right?
>> >
>> > > As we have shared before in various lkml threads/conference presenta=
tions
>> > > ([1], [2], [3] and many others), for the Confidential Computing gues=
t kernel, we have a
>> > > change in the threat model where guest kernel doesn=E2=80=99t anymor=
e trust the hypervisor.
>> >
>> > That is, frankly, a very funny threat model.  How realistic is it real=
ly
>> > given all of the other ways that a hypervisor can mess with a guest?
>>
>> It's what a lot of people would like; in the early attempts it was easy
>> to defeat, but in TDX and SEV-SNP the hypervisor has a lot less that it
>> can mess with - remember that not just the memory is encrypted, so is
>> the register state, and the guest gets to see changes to mapping and a
>> lot of control over interrupt injection etc.
>>
>> > So what do you actually trust here?  The CPU?  A device?  Nothing?
>>
>> We trust the actual physical CPU, provided that it can prove that it's a
>> real CPU with the CoCo hardware enabled.  Both the SNP and TDX hardware
>> can perform an attestation signed by the CPU to prove to someone
>> external that the guest is running on a real trusted CPU.
>>
>> Note that the trust is limited:
>>   a) We don't trust that we can make forward progress - if something
>> does something bad it's OK for the guest to stop.
>>   b) We don't trust devices, and we don't trust them by having the guest
>> do normal encryption; e.g. just LUKS on the disk and normal encrypted
>> networking. [There's a lot of schemes people are working on about how
>> the guest gets the keys etc for that)
>
> I think we need to more precisely say what we mean by 'trust' as it
> can have quite a broad interpretation.
>
> As a baseline requirement, in the context of confidential computing the
> guest would not trust the hypervisor with data that needs to remain
> confidential, but would generally still expect it to provide a faithful
> implementation of a given device.

... or to have a reliable faulting behaviour (e.g. panic) if the device is
found to be malicious, e.g. attempting to inject bogus data in the driver to
trigger unexpected paths in the guest kernel.

I think that part of the original discussion is really about being able to
do that at least for the small subset of (mostly virtio) devices that would
typically be of use in a CoCo setup.

As was pointed out elsewhere in that thread, doing so for physical devices,
to the point of enabling end-to-end attestation and encryption, is work that
is presently underway, but there is work to do already with the
comparatively small subset of devices we need in the short-term. Also, that
work needs only the Linux kernel community, whereas changes for example at
the PCI level are much broader, and therefore require a lot more time.

--
Cheers,
Christophe de Dinechin (https://c3d.github.io)
Theory of Incomplete Measurements (https://c3d.github.io/TIM)

