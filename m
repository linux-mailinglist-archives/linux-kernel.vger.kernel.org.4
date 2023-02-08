Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106E068F3E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjBHQ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBHQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D515566
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675875541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xgaVUBF+/8bDqe3+Ui9xABz8f15H8GOU/J1zXI44cU=;
        b=hSg+BSL1cp14PN+Djfi0wa1PKhcUsqmcPdNNiTsSPlXrozJOtQ/IceIdEG2ISxNYbsXn64
        h7iQd6m3qRKAnMxR3HDwVSuhf649WYOE7ZzINOnpCaoQarDVUd11lwHpKYZ459ClUB5lFq
        5/dBVaPvyEM3i/rH0tgfdVwOKM2M6C4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-1p6-zDETP1eBSwqtmCiHpQ-1; Wed, 08 Feb 2023 11:58:54 -0500
X-MC-Unique: 1p6-zDETP1eBSwqtmCiHpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB6A857D07;
        Wed,  8 Feb 2023 16:58:52 +0000 (UTC)
Received: from ptitbras (unknown [10.39.192.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66848175AD;
        Wed,  8 Feb 2023 16:58:48 +0000 (UTC)
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com>
 <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com> <Y+MAPHZNLeBY13Pj@mit.edu>
 <20230208041913-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750D93CD9481F6AB78F1FB4E7D89@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y+OAZTljX1I6ZvR/@kroah.com>
User-agent: mu4e 1.8.0; emacs 28.2
From:   Christophe de Dinechin <dinechin@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Date:   Wed, 08 Feb 2023 17:19:37 +0100
In-reply-to: <Y+OAZTljX1I6ZvR/@kroah.com>
Message-ID: <m2edr03xh4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-02-08 at 11:58 +01, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote...
> On Wed, Feb 08, 2023 at 10:44:25AM +0000, Reshetova, Elena wrote:
>>
>> The CC threat model does change the traditional linux trust boundary regardless of
>> what mitigations are used (kernel config vs. runtime filtering). Because for the
>> drivers that CoCo guest happens to need, there is no way to fix this problem by
>> either of these mechanisms (we cannot disable the code that we need), unless somebody
>> writes a totally new set of coco specific drivers (who needs another set of
>> CoCo specific virtio drivers in the kernel?).
>
> It sounds like you want such a set of drivers, why not just write them?
> We have zillions of drivers already, it's not hard to write new ones, as
> it really sounds like that's exactly what you want to have happen here
> in the end as you don't trust the existing set of drivers you are using
> for some reason.

In the CC approach, the hypervisor is considered as hostile. The rest of the
system is not changed much. If we pass-through some existing NIC, we'd
rather use the existing driver for that NIC rather than reinvent
it. However, we need to also consider the possibility that someone
maliciously replaced the actual NIC with a cleverly crafted software
emulator designed to cause the driver to leak confidential data.


>> So, if the path is to be able to use existing driver kernel code, then we need:
>
> Wait, again, why?  Why not just have your own?  That should be the
> simplest thing overall.  What's wrong with that?

That would require duplication for the majority of hardware drivers.



>> 1. these selective CoCo guest required drivers (small set) needs to be hardened
>>  (or whatever word people prefer to use here), which only means that in
>> the presence of malicious host/hypervisor that can manipulate pci config space,
>> port IO and MMIO, these drivers should not expose CC guest memory
>> confidentiality or integrity (including via privilege escalation into CC guest).
>
> Again, stop it please with the "hardened" nonsense, that means nothing.
> Either the driver has bugs, or it doesn't.  I welcome you to prove it
> doesn't :)

In a non-CC scenario, a driver is correct if, among other things, it does
not leak kernel data to user space. However, it assumes that PCI devices are
working correctly and according to spec.

In a CC scenario, an additional condition for correctness is that it must
not leak data from the trusted environment to the host. It assumes that a
_virtual_ PCI device can be implemented on the host side to cause an
existing driver to leak secrets to the host.

It is this additional condition that we are talking about.

Think of this as a bit similar to the introduction of IOMMUs, which meant
there was a new condition impacting _the entire kernel_ that you had to make
sure your DMA operations and IOMMU were in agreement. Here, it is a bit of a
similar situation: CC forbids some specific operations the same way an IOMMU
does, except instead of stray DMAs, it's stray accesses from the host.

Note that, as James Bottomley pointed out, a crash is not seen as a failure
of the CC model, unless it leads to a subsequent leak of confidential data.
Denial of service, through crash or otherwise, is so easy to do from host or
hypervisor side that it is entirely out of scope.


>
>> Please note that this only applies to a small set (in tdx virtio setup we have less
>> than 10 of them) of drivers and does not present invasive changes to the kernel
>> code. There is also an additional core pci/msi code that is involved with discovery
>> and configuration of these drivers, this code also falls into the category we need to
>> make robust.
>
> Again, why wouldn't we all want "robust" drivers?  This is not anything
> new here,

What is new is that CC requires driver to be "robust" against a new kind of
attack "from below" (i.e. from the [virtual] hardware side).

> all you are somehow saying is that you are changing the thread
> model that the kernel "must" support.  And for that, you need to then
> change the driver code to support that.

What is being argued is that CC is not robust unless we block host-side
attacks that can cause the guest to leak data to the host.

>
> So again, why not just have your own drivers and driver subsystem that
> meets your new requirements?  Let's see what that looks like and if
> there even is any overlap between that and the existing kernel driver
> subsystems.

Would a "CC-aware PCI" subsystem fit your definition?

>
>> 2. rest of non-needed drivers must be disabled. Here we can argue about what
>> is the correct method of doing this and who should bare the costs of enforcing it.
>
> You bare that cost.

I believe the CC community understands that.

The first step before introducing modifications in the drivers is getting an
understanding of why we think that CC introduces a new condition for
robustness.

We will not magically turn all drivers into CC-safe drivers. It will take a
lot of time, and the patches are likely to come from the CC community. At
that stage, though, the question is: "do you understand the problem we are
trying to solve?". I hope that my IOMMU analogy above helps.


> Or you get a distro to do that.

Best a distro can do is have a minified kernel tuned for CC use-cases, or
enabling an hypothetical CONFIG_COCO_SAFETY configuration.
A distro cannot decide what work goes behing CONFIG_COCO_SAFETY.


> That's not up to us in the kernel community, sorry, we give you the option
> to do that if you want to, that's all that we can do.

I hope that the explanations above will help you change your mind on that
statement. That cannot be a config-only or custom-drivers-only solution.
(or maybe you can convince us it can ;-)

>
>> But from pure security point of view: the method that is simple and clear, that
>> requires as little maintenance as possible usually has the biggest chance of
>> enforcing security.
>
> Again, that's up to your configuration management.  Please do it, tell
> us what doesn't work and send changes if you find better ways to do it.
> Again, this is all there for you to do today, nothing for us to have to
> do for you.
>
>> And given that we already have the concept of authorized devices in Linux,
>> does this method really brings so much additional complexity to the kernel?
>
> No idea, you tell us!  :)
>
> Again, I recommend you just having your own drivers, that will allow you
> to show us all exactly what you mean by the terms you keep using.  Why
> not just submit that for review instead?
>
> good luck!
>
> greg k-h


--
Cheers,
Christophe de Dinechin (https://c3d.github.io)
Theory of Incomplete Measurements (https://c3d.github.io/TIM)

