Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51B172D4A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjFLWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjFLWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:44:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9541985;
        Mon, 12 Jun 2023 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bUTekXXZksYz0j4KTi5h1Tvrk/JpZWYlb++kauNKZ9w=; b=G4qBB7T3E/QGhwonN9pnCQCUQM
        4+vpBYiDJJNgufp+7ec6pMYw0R2JpnD956FMdjPOuTUhV6i/fPM6ki/H+91KVhzca1+mEz4vpx4nB
        x8Cg2eQ0fR6E13PZ3G5u3e0hIOieUqNxZHD/0h2g83RO0bEVpNb83guxvgU8UoA+V5VaqCSl0x8V4
        +Ll5HZIoGY6UGoSKLTpx9Uw9g6YRD1PXgvcoD8/d+HZwtZlp4PUb1z7hXic/14VGKKBY/XPv2K/nj
        ugpGNTpYXzKNuPqPuCkjuUV3sU5fvSd80zopJWCCblhky3KkIbLV4BGJIRSUvjYQ2GLzCGTgC304x
        uHIb2Gag==;
Received: from [2601:1c2:980:9ec0::9d97]
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8qGF-0093Jt-2b;
        Mon, 12 Jun 2023 22:43:45 +0000
Message-ID: <82f5bcec-103b-f449-281e-ff82e2f27efe@infradead.org>
Date:   Mon, 12 Jun 2023 15:43:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com,
        gregkh@linuxfoundation.org, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230612164727.3935657-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/12/23 09:47, Carlos Bilbao wrote:
> Kernel developers working on confidential computing for virtualized
> environments in x86 operate under a set of assumptions regarding the Linux
> kernel threat model that differs from the traditional view. Historically,
> the Linux threat model acknowledges attackers residing in userspace, as
> well as a limited set of external attackers that are able to interact with
> the kernel through networking or limited HW-specific exposed interfaces
> (e.g. USB, thunderbolt). The goal of this document is to explain additional
> attack vectors that arise in the virtualized confidential computing space
> and discuss the proposed protection mechanisms for the Linux kernel.
> 
> Reviewed-by: Larry Dewey <larry.dewey@amd.com>
> Reviewed-by: David Kaplan <david.kaplan@amd.com>
> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
> 
> V1 can be found in:
>   https://lore.kernel.org/lkml/20230327141816.2648615-1-carlos.bilbao@amd.com/
> Changes since v1:
> 
> - Apply feedback from first version of the patch
> - Clarify that the document applies only to a particular angle of
>    confidential computing, namely confidential computing for virtualized
>    environments. Also, state that the document is specific to x86 and
>    that the main goal is to discuss the emerging threats.
> - Change commit message and file name accordingly
> - Replace AMD's link to AMD SEV SNP white paper
> - Minor tweaking and clarifications
> 
> ---
>   Documentation/security/index.rst              |   1 +
>   .../security/x86-confidential-computing.rst   | 298 ++++++++++++++++++
>   MAINTAINERS                                   |   6 +
>   3 files changed, 305 insertions(+)
>   create mode 100644 Documentation/security/x86-confidential-computing.rst
> 
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 6ed8d2fa6f9e..bda919aecb37 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -6,6 +6,7 @@ Security Documentation
>      :maxdepth: 1
>   
>      credentials
> +   x86-confidential-computing

Does the new entry align with the others?

>      IMA-templates
>      keys/index
>      lsm
> diff --git a/Documentation/security/x86-confidential-computing.rst b/Documentation/security/x86-confidential-computing.rst
> new file mode 100644
> index 000000000000..5c52b8888089
> --- /dev/null
> +++ b/Documentation/security/x86-confidential-computing.rst
> @@ -0,0 +1,298 @@
> +======================================================
> +Confidential Computing in Linux for x86 virtualization
> +======================================================
> +
> +.. contents:: :local:
> +
> +By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
> +
> +Motivation
> +==========
> +
> +Kernel developers working on confidential computing for virtualized
> +environments in x86 operate under a set of assumptions regarding the Linux
> +kernel threat model that differ from the traditional view. Historically,
> +the Linux threat model acknowledges attackers residing in userspace, as
> +well as a limited set of external attackers that are able to interact with
> +the kernel through various networking or limited HW-specific exposed
> +interfaces (USB, thunderbolt). The goal of this document is to explain
> +additional attack vectors that arise in the confidential computing space
> +and discuss the proposed protection mechanisms for the Linux kernel.
> +
> +Overview and terminology
> +========================
> +
> +Confidential Computing (CoCo) is a broad term covering a wide range of
> +security technologies that aim to protect the confidentiality and integrity
> +of data in use (vs. data at rest or data in transit). At its core, CoCo
> +solutions provide a Trusted Execution Environment (TEE), where secure data
> +processing can be performed and, as a result, they are typically further
> +classified into different subtypes depending on the SW that is intended
> +to be run in TEE. This document focuses on a subclass of CoCo technologies
> +that are targeting virtualized environments and allow running Virtual
> +Machines (VM) inside TEE. From now on in this document will be referring
> +to this subclass of CoCo as 'Confidential Computing (CoCo) for the
> +virtualized environments (VE)'.
> +
> +CoCo, in the virtualization context, refers to a set of HW and/or SW
> +technologies that allow for stronger security guarantees for the SW running
> +inside a CoCo VM. Namely, confidential computing allows its users to
> +confirm the trustworthiness of all SW pieces to include in its reduced
> +Trusted Computing Base (TCB) given its ability to attest the state of these
> +trusted components.
> +
> +While the concrete implementation details differ between technologies, all
> +available mechanisms aim to provide increased confidentiality and
> +integrity for the VM's guest memory and execution state (vCPU registers),
> +more tightly controlled guest interrupt injection, as well as some
> +additional mechanisms to control guest-host page mapping. More details on
> +the x86-specific solutions can be found in
> +:doc:`Intel Trust Domain Extensions (TDX) </arch/x86/tdx>` and

<Documentation/arch/x86/tdx>
or does it work without the leading subdir?

> +`AMD Memory Encryption <https://www.amd.com/system/files/techdocs/sev-snp-strengthening-vm-isolation-with-integrity-protection-and-more.pdf>`_.
> +
> +The basic CoCo guest layout includes the host, guest, the interfaces that
> +communicate guest and host, a platform capable of supporting CoCo VMs, and
> +a trusted intermediary between the guest VM and the underlying platform
> +that acts as a security manager. The host-side virtual machine monitor
> +(VMM) typically consists of a subset of traditional VMM features and
> +is still in charge of the guest lifecycle, i.e. create or destroy a CoCo
> +VM, manage its access to system resources, etc. However, since it
> +typically stays out of CoCo VM TCB, its access is limited to preserve the

                                                        to preserving the
?

> +security objectives.
> +
> +In the following diagram, the "<--->" lines represent bi-directional
> +communication channels or interfaces between the CoCo security manager and
> +the rest of the components (data flow for guest, host, hardware) ::
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
> +
> +The specific details of the CoCo security manager vastly diverge between
> +technologies. For example, in some cases, it will be implemented in HW
> +while in others it may be pure SW. In some cases, such as for the
> +`Protected kernel-based virtual machine (pKVM) <https://github.com/intel-staging/pKVM-IA>`,
> +the CoCo security manager is a small, isolated and highly privileged
> +(compared to the rest of SW running on the host) part of a traditional
> +VMM.
> +
> +Existing Linux kernel threat model
> +==================================
> +
> +The overall components of the current Linux kernel threat model are::
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
> +
> +There is also communication between the bootloader and the kernel during
> +the boot process, but this diagram does not represent it explicitly. The
> +"Interfaces" box represents the various interfaces that allow
> +communication between kernel and userspace. This includes system calls,
> +kernel APIs, device drivers, etc.
> +
> +The existing Linux kernel threat model typically assumes execution on a
> +trusted HW platform with all of the firmware and bootloaders included on
> +its TCB. The primary attacker resides in the userspace, and all of the data
> +coming from there is generally considered untrusted, unless userspace is
> +privileged enough to perform trusted actions. In addition, external
> +attackers are typically considered, including those with access to enabled
> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
> +of disks offline.
> +
> +Regarding external attack vectors, it is interesting to note that in most
> +cases external attackers will try to exploit vulnerabilities in userspace
> +first, but that it is possible for an attacker to directly target the
> +kernel; particularly if the host has physical access. Examples of direct
> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
> +and CVE-2020-24490.
> +
> +Confidential Computing threat model and its security objectives
> +===============================================================
> +
> +Confidential Computing adds a new type of attacker to the above list: a
> +potentially misbehaving host (which can also include some part of a
> +traditional VMM or all of it), which is typically placed outside of the
> +CoCo VM TCB due to its large SW attack surface. It is important to note
> +that this doesn’t imply that the host or VMM are intentionally
> +malicious, but that there exists a security value in having a small CoCo
> +VM TCB. This new type of adversary may be viewed as a more powerful type
> +of external attacker, as it resides locally on the same physical machine
> +-in contrast to a remote network attacker- and has control over the guest

Hyphens (dashes) are not normally used for a parenthetical phrase AFAIK.

> +kernel communication with most of the HW::

I would prefer to capitalize "kernel" above.

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
> +   |     CoCo security     |<--->| Host/Host-side VMM |
> +   |      manager          |     +------------------------+
> +   |                       |     +------------------------+
> +   |                       |<--->|   CoCo platform        |
> +   +-----------------------+     +------------------------+
> +
> +While traditionally the host has unlimited access to guest data and can
> +leverage this access to attack the guest, the CoCo systems mitigate such
> +attacks by adding security features like guest data confidentiality and
> +integrity protection. This threat model assumes that those features are
> +available and intact.
> +
> +The **Linux kernel CoCo VM security objectives** can be summarized as follows:
> +
> +1. Preserve the confidentiality and integrity of CoCo guest's private
> +memory and registers.
> +
> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
> +While it is true that the host (and host-side VMM) requires some level of
> +privilege to create, destroy, or pause the guest, part of the goal of
> +preventing privileged escalation is to ensure that these operations do not
> +provide a pathway for attackers to gain access to the guest's kernel.
> +
> +The above security objectives result in two primary **Linux kernel CoCo
> +VM assets**:
> +
> +1. Guest kernel execution context.
> +2. Guest kernel private memory.
> +
> +The host retains full control over the CoCo guest resources, and can deny
> +access to them at any time. Examples of resources include CPU time, memory
> +that the guest can consume, network bandwidth, etc. Because of this, the
> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
> +scope of this threat model.
> +
> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> +guest Linux kernel towards an untrusted host that is not covered by the
> +CoCo technology SW/HW protection. This includes any possible
> +side-channels, as well as transient execution side channels. Examples of
> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> +and DMA interfaces, access to PCI configuration space, VMM-specific
> +hypercalls (towards Host-side VMM), access to shared memory pages,
> +interrupts allowed to be injected into the guest kernel by the host, as
> +well as CoCo technology specific hypercalls, if present. Additionally, the

                 technology-specific

> +host in a CoCo system typically controls the process of creating a CoCo
> +guest: it has a method to load into a guest the firmware and bootloader
> +images, the kernel image together with the kernel command line. All of this
> +data should also be considered untrusted until its integrity and
> +authenticity is established via attestation.
> +
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
> +     - Mitigation strategies
> +
> +   * - Guest malicious configuration
> +     - A misbehaving host modifies one of the following guest's
> +       configuration:
> +
> +       1. Guest firmware or bootloader
> +
> +       2. Guest kernel or module binaries
> +
> +       3. Guest command line parameters
> +
> +       This allows the host to break the integrity of the code running
> +       inside a CoCo guest, and violates the CoCo security objectives.
> +     - The integrity of the guest's configuration passed via untrusted host
> +       must be ensured by methods such as remote attestation and signing.
> +       This should be largely transparent to the guest kernel, and would
> +       allow it to assume a trusted state at the time of boot.
> +
> +   * - CoCo guest data attacks
> +     - A misbehaving host retains full control of the CoCo guest's data
> +       in-transit between the guest and the host-managed physical or
> +       virtual devices. This allows any attack against confidentiality,
> +       integrity or freshness of such data.
> +     - The CoCo guest is responsible for ensuring the confidentiality,
> +       integrity and freshness of such data using well-established
> +       security mechanisms. For example, for any guest external network
> +       communications passed via the untrusted host, an end-to-end
> +       secure session must be established between a guest and a trusted
> +       remote endpoint using well-known protocols such as TLS.
> +       This requirement also applies to protection of the guest's disk
> +       image.
> +
> +   * - Malformed runtime input
> +     - A misbehaving host injects malformed input via any communication
> +       interface used by the guest's kernel code. If the code is not
> +       prepared to handle this input correctly, this can result in a host
> +       --> guest kernel privilege escalation. This includes traditional
> +       side-channel and/or transient execution attack vectors.
> +     - The attestation or signing process cannot help to mitigate this
> +       threat since this input is highly dynamic. Instead, a different set
> +       of mechanisms is required:
> +
> +       1. *Limit the exposed attack surface*. Whenever possible, disable
> +       complex kernel features and device drivers (not required for guest
> +       operation) that actively use the communication interfaces between
> +       the untrusted host and the guest. This is not a new concept for the
> +       Linux kernel, since it already has mechanisms to disable external
> +       interfaces, such as attacker's access via USB/Thunderbolt subsystem.
> +
> +       2. *Harden the exposed attack surface*. Any code that uses such
> +       interfaces must treat the input from the untrusted host as malicious,
> +       and do sanity checks before processing it. This can be ensured by
> +       performing a code audit of such device drivers as well as employing
> +       other standard techniques for testing the code robustness, such as
> +       fuzzing. This is again a well-known concept for the Linux kernel,
> +       since all its networking code has been previously analyzed under
> +       presumption of processing malformed input from a network attacker.
> +
> +   * - Malicious runtime input
> +     - A misbehaving host injects a specific input value via any
> +       communication interface used by the guest's kernel code. The
> +       difference with the previous attack vector (malformed runtime input)
> +       is that this input is not malformed, but its value is crafted to
> +       impact the guest's kernel security. Examples of such inputs include
> +       providing a malicious time to the guest or the entropy to the guest
> +       random number generator. Additionally, the timing of such events can
> +       be an attack vector on its own, if it results in a particular guest
> +       kernel action (i.e. processing of a host-injected interrupt).
> +     - Similarly, as with the previous attack vector, it is not possible to
> +       use attestation mechanisms to address this threat. Instead, such
> +       attack vectors (i.e. interfaces) must be either disabled or made
> +       resistant to supplied host input.
> +
> +As can be seen from the above table, the potential mitigation strategies
> +to secure the CoCo Linux guest kernel vary, but can be roughly split into
> +mechanisms that either require or do not require changes to the existing
> +Linux kernel code. One main goal of the CoCo security architecture is to
> +minimize changes to the Linux kernel code, while also providing usable
> +and scalable means to facilitate the security of a CoCo guest kernel.

HTH.
~Randy

