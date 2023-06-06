Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3EC723524
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjFFCRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFFCRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:17:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF8114;
        Mon,  5 Jun 2023 19:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=vEESWuWR6a7zo6/+YfJEjRj9QTT4KTa8skRBEe6P8zY=; b=zO2TB/k92D5ScwkozcyGQOy9TJ
        UPXtj0RdivvwIxboqyCmjYyNn2jN6D6YXFpr/+k5AslurE94wQsuY2lFFw/dNY14e9/gH8TGFJHmi
        YKyy3LfzKsV0c31BnZwS1hHyBJnLrDidS5zsxB2h0BCWhAtNaLsW4VQTmDsxO9hcJn/O1LTRFvo1f
        CEAs8ilAVpxvodkQ4EG8XCETHoZWSAXlq17kJX94OKI/uOym/IFvtEHirs3qEM51PXEvgYnKAITgs
        2VAldDn31fT8lmNFmejOrXrKUL+gCq/7JZ2BKJJpkMOoAInub5GbKxED654ulYKL1tuxnqy3Cf1v1
        NZQ/kOPg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6MGN-00HQTW-0Y;
        Tue, 06 Jun 2023 02:17:35 +0000
Message-ID: <32ffb593-c39c-c741-7b6f-6f1cbcb1d558@infradead.org>
Date:   Mon, 5 Jun 2023 19:17:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 01/12] Documentation/x86: Document Key Locker
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-2-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230603152227.12335-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/23 08:22, Chang S. Bae wrote:
> Document the overview of the feature along with relevant consideration
> when provisioning dm-crypt volumes with AES-KL instead of AES-NI.
> 
> ---
> ---
>  Documentation/arch/x86/index.rst     |  1 +
>  Documentation/arch/x86/keylocker.rst | 97 ++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/arch/x86/keylocker.rst
> 

> diff --git a/Documentation/arch/x86/keylocker.rst b/Documentation/arch/x86/keylocker.rst
> new file mode 100644
> index 000000000000..5557b8d0659a
> --- /dev/null
> +++ b/Documentation/arch/x86/keylocker.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +x86 Key Locker
> +==============
> +
> +Introduction
> +============
> +
> +Key Locker is a CPU feature to reduce key exfiltration opportunities
> +while maintaining a programming interface similar to AES-NI. It
> +converts the AES key into an encoded form, called the 'key handle'.
> +The key handle is a wrapped version of the clear-text key where the
> +wrapping key has limited exposure. Once converted, all subsequent data
> +encryption using new AES instructions (AES-KL) uses this key handle,
> +reducing the exposure of private key material in memory.
> +
> +CPU-internal Wrapping Key
> +=========================
> +
> +The CPU-internal wrapping key is an entity in a software-invisible CPU
> +state. On every system boot, a new key is loaded. So the key handle that
> +was encoded by the old wrapping key is no longer usable on system shutdown
> +or reboot.
> +
> +And the key may be lost on the following exceptional situation upon wakeup:
> +
> +Wrapping Key Restore Failure
> +----------------------------
> +
> +The CPU state is volatile with the ACPI S3/4 sleep states. When the system
> +supports those states, the key has to be backed up so that it is restored
> +on wake up. The kernel saves the key in non-volatile media.
> +
> +The event of a wrapping key restore failure upon resume from suspend, all

   Upon the event of a ...

> +established key handles become invalid. In flight dm-crypt operations
> +receive error results from pending operations. In the likely scenario that
> +dm-crypt is hosting the root filesystem the recovery is identical to if a
> +storage controller failed to resume from suspend, reboot. If the volume
> +impacted by a wrapping key restore failure is a data-volume then it is

                                                   data volume

> +possible that I/O errors on that volume do not bring down the rest of the
> +system. However, a reboot is still required because the kernel will have
> +soft-disabled Key Locker. Upon the failure, the crypto library code will
> +return -ENODEV on every AES-KL function call. The Key Locker implementation
> +only loads a new wrapping key at initial boot, not any time after like
> +resume from suspend.
> +
> +Use Case and Non-use Cases
> +==========================
> +
> +Bare metal disk encryption is the only intended use case.
> +
> +Userspace usage is not supported because there is no ABI provided to
> +communicate and coordinate wrapping-key restore failure to userspace. For
> +now, key restore failures are only coordinated with kernel users. But the
> +kernel can not prevent userspace from using the feature's AES instructions
> +('AES-KL') when the feature has been enabled. So, the lack of userspace
> +support is only documented, not actively enforced.
> +
> +Key Locker is not expected to be advertised to guest VMs and the kernel
> +implementation ignores it even if the VMM enumerates the capability. The
> +expectation is that a guest VM wants private wrapping key state, but the
> +architecture does not provide that. An emulation of that capability, by
> +caching per-VM wrapping keys in memory, defeats the purpose of Key Locker.
> +The backup / restore facility is also not performant enough to be suitable
> +for guest VM context switches.
> +
> +AES Instruction Set
> +===================
> +
> +The feature accompanies a new AES instruction set. This instruction set is
> +analogous to AES-NI. A set of AES-NI instructions can be mapped to an
> +AES-KL instruction. For example, AESENC128KL is responsible for ten rounds
> +of transformation, which is equivalent to nine times AESENC and one
> +AESENCLAST in AES-NI.
> +
> +But they have some notable differences:
> +
> +* AES-KL provides a secure data transformation using an encrypted key.
> +
> +* If an invalid key handle is provided, e.g. a corrupted one or a handle
> +  restriction failure, the instruction fails with setting RFLAGS.ZF. The
> +  crypto library implementation includes the flag check to return -EINVAL.
> +  Note that this flag is also set if the wrapping key is changed, e.g.,
> +  because of the backup error.
> +
> +* AES-KL implements support for 128-bit and 256-bit keys, but there is no
> +  AES-KL instruction to process an 192-bit key. The AES-KL cipher
> +  implementation logs a warning message with a 192-bit key and then falls
> +  back to AES-NI. So, this 192-bit key-size limitation is only documented,

Is it logged anywhere?  i.e., a kernel log message?

> +  not enforced. It means the key will remain in clear-text in memory. This
> +  is to meet Linux crypto-cipher expectation that each implementation must
> +  support all the AES-compliant key sizes.
> +
> +* Some AES-KL hardware implementation may have noticeable performance
> +  overhead when compared with AES-NI instructions.
> +

-- 
~Randy
