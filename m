Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF916CD7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjC2Kkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjC2Kkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:40:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3C3C21;
        Wed, 29 Mar 2023 03:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF07FB82249;
        Wed, 29 Mar 2023 10:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDFAC433D2;
        Wed, 29 Mar 2023 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680086426;
        bh=3/EYlpKA/WAhFjAC+6ttrKSSg5D43RrofkB8s9tg/JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbgJov/FjAyGNtxTvxU0IRjiquduZah7SZoWZ0QoZNSdPIfv9wOxRYfDyWvODIBdv
         0mY8FkkD7hax+aGY50MNvh3qEXEhg4nTgIJOfaczOPaZu1Y5ifLZoq6Nv5rGhY8flR
         8HAi/Ka8HnfSBSuJKg4MqrVYHowdwIg0VZvLQAV8=
Date:   Wed, 29 Mar 2023 12:40:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Message-ID: <ZCQVmIKXWXX2xvo-@kroah.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327141816.2648615-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:18:16AM -0500, Carlos Bilbao wrote:
> Kernel developers working on confidential computing operate under a set of
> assumptions regarding the Linux kernel threat model that differ from the
> traditional view. In order to effectively engage with the linux-coco
> mailing list and contribute to ongoing kernel efforts, one must have a
> thorough familiarity with these concepts. Add a concise,
> architecture-agnostic introduction and threat model to provide a reference
> for ongoing design discussions and to help developers gain a foundational
> understanding of the subject.

Thanks for putting this together.  Some questions below:

> +The basic CoCo layout includes the host, guest, the interfaces that
> +communicate guest and host, a platform capable of supporting CoCo, and an
> +intermediary between the guest virtual machine (VM) and the underlying
> +platform that acts as security manager::
> +
> +    +-------------------+      +-----------------------+
> +    | CoCo guest VM     |<---->|                       |
> +    +-------------------+      |                       |
> +      | Interfaces |           | CoCo security manager |
> +    +-------------------+      |                       |
> +    | Host VMM          |<---->|                       |
> +    +-------------------+      |                       |
> +                               |                       |
> +    +--------------------+     |                       |
> +    | CoCo platform      |<--->|                       |
> +    +--------------------+     +-----------------------+

I do not understand, what are the "<--->" lines representing?  Function
calls?  APIs?  something else?

> +The specific details of the CoCo intermediary vastly diverge between
> +technologies, so much so that in some cases it will be HW and in others
> +SW.
> +
> +Existing Linux kernel threat model
> +==================================
> +
> +The components of the current Linux kernel threat model are::
> +
> +     +-----------------------+      +-------------------+
> +     |                       |<---->| Userspace         |
> +     |                       |      +-------------------+
> +     |   External attack     |         | Interfaces |
> +     |       vectors         |      +-------------------+
> +     |                       |<---->| Linux Kernel      |
> +     |                       |      +-------------------+
> +     +-----------------------+      +-------------------+
> +                                    | Bootloader/BIOS   |
> +                                    +-------------------+
> +                                    +-------------------+
> +                                    | HW platform       |
> +                                    +-------------------+

Again, what do the "<---->" lines mean?  there's no talking betwen the
bootloader and the kernel?  What about the kernel talking to the HW
without the BIOS (as is most of the time)?  What is "Interfaces"?

And "external attack vectors" is odd, how can they get to the kernel
without going through userspace?

> +The existing Linux kernel threat model typically assumes execution on a
> +trusted HW platform with all of the firmware and bootloaders included on
> +its TCB. The primary attacker resides in the userspace and all of the data
> +coming from there is generally considered untrusted, unless userspace is
> +privileged enough to perform trusted actions. In addition, external
> +attackers are typically considered, including those with access to enabled
> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
> +of disks offline.

I can not parse that last sentance well, sorry.  What is in addition?
What are you trying to say, some hardware the kernel trusts and some it
doesn't?  Note there are different "levels" of trust for hardware as
well (i.e. we attempt to accept any USB configuration header and treat
that as untrusted but the USB data path we totally trust.)

> +Confidential Computing threat model and security objectives
> +===========================================================
> +
> +Confidential Cloud Computing adds a new type of attacker to the above list:
> +an untrusted and potentially malicious host. This can be viewed as a more
> +powerful type of external attacker, as it resides locally on the same
> +physical machine, in contrast to a remote network attacker, and has control
> +over the guest kernel communication with most of the HW::
> +
> +                                 +------------------------+
> +                                 |    CoCo guest VM       |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->|  | Userspace         | |
> +   |                       |     |  +-------------------+ |
> +   |   External attack     |     |     | Interfaces |     |
> +   |       vectors         |     |  +-------------------+ |
> +   |                       |<--->|  | Linux Kernel      | |
> +   |                       |     |  +-------------------+ |
> +   +-----------------------+     |  +-------------------+ |
> +                                 |  | Bootloader/BIOS   | |
> +   +-----------------------+     |  +-------------------+ |
> +   |                       |<--->+------------------------+
> +   |                       |          | Interfaces |
> +   |                       |     +------------------------+
> +   |     CoCo security     |<--->|   Host VMM             |
> +   |      manager          |     +------------------------+
> +   |                       |     +------------------------+
> +   |                       |<--->|   CoCo platform        |
> +   +-----------------------+     +------------------------+

Again, I don't undertand the layers or <---> here, sorry.

> +While the traditional hypervisor has unlimited access to guest data and
> +can leverage this access to attack the guest, the CoCo systems mitigate
> +such attacks by adding security features like guest data confidentiality
> +and integrity protection. This threat model assumes that those features
> +are available and intact.
> +
> +The **Linux kernel CoCo security objectives** can be summarized as follows:
> +
> +1. Preserve the confidentiality and integrity of CoCo guest private memory.

Confidentiality from/to what?  Itself?  Someone else?  Userspace?

> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.

But a host has to have privileges in order to create/destroy/sleep the
guest, right?

> +
> +The above security objectives result in two primary **Linux kernel CoCo
> +assets**:
> +
> +1. Guest kernel execution context.
> +2. Guest kernel private memory.
> +
> +The host retains full control over the CoCo guest resources and can deny
> +access to them at any time. Because of this, the host Denial of Service
> +(DoS) attacks against CoCo guests are beyond the scope of this threat
> +model.

So all resources provided by the host to the guest are trusted?  Or are
not trusted?  Confused...

> +The **Linux CoCo attack surface** is any interface exposed from a CoCo
> +guest Linux kernel towards an untrusted host that is not covered by the
> +CoCo technology SW/HW protections.

"not covered by" is an odd way to say "we trust lots of things, but not
all", right?  If not, I don't understand again.

> This includes any possible
> +side-channels, as well as transient execution side channels. Examples of
> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> +and DMA interfaces, access to PCI configuration space, VMM-specific
> +hypercalls, access to shared memory pages, interrupts allowed to be
> +injected to the guest kernel by the host, as well as CoCo technology
> +specific hypercalls.

So all of those things are trusted?  Or are not trusted?  Again, I'm
confused.  And who is trusting, or not trusting them?  The host?  The
guest?

> Additionally, the host in a CoCo system typically
> +controls the process of creating a CoCo guest: it has a method to load
> +into a guest the firmware and bootloader images, the kernel image
> +together with the kernel command line. All of this data should also be
> +considered untrusted until its integrity and authenticity is established.

Who does the authentication?  The host?  The guest?  Through what
channel?

> +The table below shows a threat matrix for the CoCo guest Linux kernel with
> +the potential mitigation strategies. The matrix refers to CoCo-specific
> +versions of the guest, host and platform.
> +
> +.. list-table:: CoCo Linux guest kernel threat matrix
> +   :widths: auto
> +   :align: center
> +   :header-rows: 1
> +
> +   * - Threat name
> +     - Threat description
> +     - Mitigation strategy
> +
> +   * - Guest malicious configuration
> +     - A malicious host modifies one of the following guest's
> +       configuration:
> +
> +       1. Guest firmware or bootloader
> +
> +       2. Guest kernel or module binaries
> +
> +       3. Guest command line parameters
> +
> +       This allows the host to break the integrity of the code running
> +       inside a CoCo guest and violate the CoCo security objectives.

So hosts are not allowed to change this?  I don't understand the use of
"violate" here, sorry.

> +     - The integrity of the guest's configuration passed via untrusted host
> +       must be ensured by methods such as remote attestation and signing.
> +       This should be largely transparent to the guest kernel and would
> +       allow it to assume a trusted state at the time of boot.

How can it be transparent if the guest has to do this?  If the guest
isn't doing it, who is?  Can configuration be changed while the guest is
running?

> +
> +   * - CoCo guest data attacks
> +     - A malicious host retains full control of the CoCo guest's data
> +       in-transit between the guest and the host-managed physical or
> +       virtual devices. This allows any attack against confidentiality,
> +       integrity or freshness of such data.
> +     - The CoCo guest is responsible for ensuring the confidentiality,
> +       integrity and freshness of such data using well-established
> +       security mechanisms. For example, for any guest external network
> +       communications that are passed via the untrusted host, an end-to-end
> +       secure session must be established between a guest and a trusted
> +       remote endpoint using well-known protocols such as TLS.
> +       This requirement also applies to protection of the guest's disk
> +       image.

So you trust all I/O into the guest by virtue of it having to be
encrypted/protected somehow at the data layer?  So the guest kernel
doesn't have to worry about the data contents it is receiving any more
than it does today?

I'm stopping here, sorry...

greg k-h
