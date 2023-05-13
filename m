Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4187019F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjEMVCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 17:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEMVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 17:02:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA1E30C4;
        Sat, 13 May 2023 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684011649; i=deller@gmx.de;
        bh=S8BdFQeWXnw0k7xb/Pd2AhJXn5drG2VSOAIP2nWf5C4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mcUG47eX0Gn5veG6Ma/ul80RdUo6bsI8PVfZz0zKmUflnHrmh7e47BPa5vNQH5AE5
         xN8t8csT87bACHCqA8OsuJ2hWYdHBaim0kPYxyJPyGV+wdFIZqdMZ2KWJkGpMA71P/
         egT+C+AIP++kGZ4bJ4izMXA5xAwpUSXSFsk26PUoT8kKqTDoQAx1/dB+6F6qtKXT3r
         GvfRk5+vnzNiG67CzR+x13ghBN34jZ4cPRgxhCtav+HMxKP6wiojHtau4ptA6nVxv6
         cehya8971oTBpuL9wmCK7IO8pT5+JyFocI4nxvSEkGnCMrJGyPpXH1ZFrtHGaJENlu
         oDzqQ+ljsk/Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.158.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1puuDq2TVb-0036k5; Sat, 13
 May 2023 23:00:49 +0200
Message-ID: <f918a8af-5a9b-1309-e19a-4f3f09ebab7f@gmx.de>
Date:   Sat, 13 May 2023 23:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [patch V4 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20230512203426.452963764@linutronix.de>
 <12207466.O9o76ZdvQC@natalenko.name>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <12207466.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RpgEId2B9D5HBcL9fBRb+3JWwwhOteIZ1nytZcasaTAmfarvNwn
 fMFgkrHHFQUTus1MzALvRPziABh8c3qvbp7zrAUgbDN6l4imCV7IS4gxdfOdNFI3zgs3XcO
 11oz6jBIU+1Ra6lyKd+YTydDGuvPMiAY0/gQGWH75WYI+9H8qnSK0e5rvRvnBk3gV+e2mh4
 /Iype0ZePC7XiPoEhVRJQ==
UI-OutboundReport: notjunk:1;M01:P0:ea8O6TsDxRo=;lqMJCETSNInGwiqOiM4sQMSPd/7
 etoWsuDh2oxQRCTcOm6dNI+74udQOMfHHsm5ViBWq91/zE7BHjEibpBxtH5P3frWwqkILGDJY
 77TFvDyNXPxd7F47SPcZN1Y3tC0PxkAf8D2O4cXgxGzfXcqh6ZU5OdAWofsVnHmYksoaSdtQK
 /sdWCcq3GNm8Op/iz5sawvt5qV1caIjxirPF8NcX0+HOQDWTmdrgC3KQzahSNe6sgpUYU6A0L
 mj7+P2ZJAxwQSxuoPapXn3E9fK1sETKVzH5EkA2MRPR0BSWfZGm58+nvXtGRoh46V31D9fD3Q
 NgyF0MBkq1h5MMqm1cehrsOqM2fbQUc0mMtImW91/3B0tJVWvww1nAEia9y/XTCE6oKIP/2gr
 +84+DVNsM/OlplgxXAFgsPN0eCrTWdSERofcLepJeNo96NsytLDtOEC7en5zvPV0KkUQe00QS
 7rl6hFiJ2MYRqfAsgTAw+jmhG8FlpDZPBv8Qq+5EkCGTbFJhfELHNgSJGuuUlUFEGFIKg7jXn
 TbfcaEF6rc4H+WtmaiTMOKNj/SAINwPT+rP+dvyLp2D+729pu0fnQ5k2EkmED+YwXds8vE225
 wFJ3/ZTMghskjLsZVfA+2lbtPTtpXWJ2p2zBBziSEqo2Kk1sKdgS8zq+73wIqibIA4jML/dNg
 OjnqB1D1UaKpKshMSbg63O+5KVXRw0oSgTABWdEzITLhLZrpla6aYa+4BT2wx4mVopNigTidP
 6HmdhUQpPsfRRdKs/r4DivnIBsaKGWFyGuHjs39P1LTXCnQY+bq7LDx/BcQ49EV022T0FmVHP
 KfxdeSRzDf8VaI7h0Pu+Db96WH9ssPLUVoP+CljJisx2W/IBROPWWx2uhxuL/WIb5UkL14enC
 X/qSeD3BduOA1I9b5VZJterCRzLCiAvjZkN8LbeJOzVdVWMV4EDWlFIivJLXJf7C5BFFtiTfU
 ffX/dDZ8QuTU2qdmz3lPDMkbZx0=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
> On p=C3=A1tek 12. kv=C4=9Btna 2023 23:06:56 CEST Thomas Gleixner wrote:
>> This is version 4 of the reworked parallel bringup series. Version 3 ca=
n be
>> found here:
>>
>>     https://lore.kernel.org/lkml/20230508181633.089804905@linutronix.de
>> ...
>>
>> Other than that there are no changes and the other details are all the =
same
>> as in V3 and V2.
>>
>> It's also available from git:
>>
>>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git hotpl=
ug

I tested your series on the parisc architecture just to make sure that it =
still works
with your patch applied.
On parisc the CPU bringup happens later in the boot process (after the inv=
entory),
so your patch won't have an direct impact anyway.
But at least everything still works, incl. manual CPU enable/disable.

So, you may add
Tested-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge
