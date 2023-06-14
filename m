Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BEB7302D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbjFNPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbjFNPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:06:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA304198D;
        Wed, 14 Jun 2023 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=MHhoy+aXdzABuPyOvTHtKHIRHy9vgBPmvGrwO4Er2DI=; b=nf1RNAdEwaCweVdy6yI/iwSaQd
        lgG/ZfH09FYEDMQ5+zRocH9yDfrTC7TSJ/eyTpjfhWHXsD1AbJd1rISvFp3DjX9pnDGSWACCup/XK
        ym2mPcVhxEHhou5q0lXcQ9oBdUzl5cq6ap5mgeOoHulIh5HrAijYGC6QdO5usxJgxN/SEmfTn5HJ1
        0Y+652+xz9JYTRfeXUWfAM8H/nCUjv3ATx7mdPF9zqGB+bR6GWDTaRc5bF02ODlb4Wr1Wlvd64cxm
        74R7lES1XGNMXbEbjc9nwVnbmWDtwWjKLKRt9DBD7llZZMx6KVdwSAUROYT6RVC99HCCbxCBi0zai
        +6UY7hbw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9S4X-00C031-2S;
        Wed, 14 Jun 2023 15:06:09 +0000
Message-ID: <4bde30cd-3ec6-bacd-5d92-1b52489a8c48@infradead.org>
Date:   Wed, 14 Jun 2023 08:06:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
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
 <82f5bcec-103b-f449-281e-ff82e2f27efe@infradead.org>
 <902093e0-dd44-d542-363d-06367a533fce@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <902093e0-dd44-d542-363d-06367a533fce@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

On 6/14/23 06:55, Carlos Bilbao wrote:
> Hello Randy,
> 
> On 6/12/23 17:43, Randy Dunlap wrote:
>> Hi--
>>
>> On 6/12/23 09:47, Carlos Bilbao wrote:
>>> Kernel developers working on confidential computing for virtualized
>>> environments in x86 operate under a set of assumptions regarding the Linux
>>> kernel threat model that differs from the traditional view. Historically,
>>> the Linux threat model acknowledges attackers residing in userspace, as
>>> well as a limited set of external attackers that are able to interact with
>>> the kernel through networking or limited HW-specific exposed interfaces
>>> (e.g. USB, thunderbolt). The goal of this document is to explain additional
>>> attack vectors that arise in the virtualized confidential computing space
>>> and discuss the proposed protection mechanisms for the Linux kernel.
>>>
>>> Reviewed-by: Larry Dewey <larry.dewey@amd.com>
>>> Reviewed-by: David Kaplan <david.kaplan@amd.com>
>>> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
>>> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>> ---
>>>
>>> ---
>>>   Documentation/security/index.rst              |   1 +
>>>   .../security/x86-confidential-computing.rst   | 298 ++++++++++++++++++
>>>   MAINTAINERS                                   |   6 +
>>>   3 files changed, 305 insertions(+)
>>>   create mode 100644 Documentation/security/x86-confidential-computing.rst
>>>

>>> diff --git a/Documentation/security/x86-confidential-computing.rst b/Documentation/security/x86-confidential-computing.rst
>>> new file mode 100644
>>> index 000000000000..5c52b8888089
>>> --- /dev/null
>>> +++ b/Documentation/security/x86-confidential-computing.rst
>>> @@ -0,0 +1,298 @@
>>> +======================================================
>>> +Confidential Computing in Linux for x86 virtualization
>>> +======================================================
>>> +
>>> +.. contents:: :local:
>>> +
>>> +By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao <carlos.bilbao@amd.com>
>>> +

>>> +The basic CoCo guest layout includes the host, guest, the interfaces that
>>> +communicate guest and host, a platform capable of supporting CoCo VMs, and
>>> +a trusted intermediary between the guest VM and the underlying platform
>>> +that acts as a security manager. The host-side virtual machine monitor
>>> +(VMM) typically consists of a subset of traditional VMM features and
>>> +is still in charge of the guest lifecycle, i.e. create or destroy a CoCo
>>> +VM, manage its access to system resources, etc. However, since it
>>> +typically stays out of CoCo VM TCB, its access is limited to preserve the
>>
>>                                                         to preserving the
>> ?
> 
> I think that using "preserving" and "preserve" here may result in two
> different interpretations:
> 
> "limited to preserve the security objectives" suggests that the limited
> access is enforced to preserve the security guarantees. In other words, the
> act of limiting access itself, particularly from the VMM, helps to maintain
> the security objectives. This is what we want to say.
> 
> "limited to preserving the security objectives" suggests that the access of
> the VMM is limited to the components that allow the VMM to preserve the
> security objectives.
> 
> Hope that makes sense?

Yes, I get it, thanks.

>>
>>> +security objectives.
>>> +
>>> +In the following diagram, the "<--->" lines represent bi-directional
>>> +communication channels or interfaces between the CoCo security manager and
>>> +the rest of the components (data flow for guest, host, hardware) ::
>>> +
>>> +    +-------------------+      +-----------------------+
>>> +    | CoCo guest VM     |<---->|                       |
>>> +    +-------------------+      |                       |
>>> +      | Interfaces |           | CoCo security manager |
>>> +    +-------------------+      |                       |
>>> +    | Host VMM          |<---->|                       |
>>> +    +-------------------+      |                       |
>>> +                               |                       |
>>> +    +--------------------+     |                       |
>>> +    | CoCo platform      |<--->|                       |
>>> +    +--------------------+     +-----------------------+
>>> +
>>> +The specific details of the CoCo security manager vastly diverge between
>>> +technologies. For example, in some cases, it will be implemented in HW
>>> +while in others it may be pure SW. In some cases, such as for the
>>> +`Protected kernel-based virtual machine (pKVM) <https://github.com/intel-staging/pKVM-IA>`,
>>> +the CoCo security manager is a small, isolated and highly privileged
>>> +(compared to the rest of SW running on the host) part of a traditional
>>> +VMM.
>>> +

>>> +Confidential Computing threat model and its security objectives
>>> +===============================================================
>>> +
>>> +Confidential Computing adds a new type of attacker to the above list: a
>>> +potentially misbehaving host (which can also include some part of a
>>> +traditional VMM or all of it), which is typically placed outside of the
>>> +CoCo VM TCB due to its large SW attack surface. It is important to note
>>> +that this doesn’t imply that the host or VMM are intentionally
>>> +malicious, but that there exists a security value in having a small CoCo
>>> +VM TCB. This new type of adversary may be viewed as a more powerful type
>>> +of external attacker, as it resides locally on the same physical machine
>>> +-in contrast to a remote network attacker- and has control over the guest
>>
>> Hyphens (dashes) are not normally used for a parenthetical phrase AFAIK.
> 
> Yes, parentheses would be more appropriate.
> 
>>
>>> +kernel communication with most of the HW::
>>
>> I would prefer to capitalize "kernel" above.
> 
> I'm not sure I follow, we don't capitalize kernel elsewhere, why here?
> 

My mistake in reading. :(



Thanks.

-- 
~Randy
