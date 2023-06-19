Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67868734E37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjFSInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFSInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:43:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE3E35B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:41:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687164047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUlbkGJCuvyMh1uRW/BF3POrtz1pE51GldRG3yIglCQ=;
        b=2AZtzytovYeaAw/aPOP7wVBgZjBLXDzmU7PNrOkk1uEulIJW94dBlfw0MDxe4omKc71vBy
        9fZ9ZD+w8C3vD4v57wmB+vlcvgZsoqyVESdlznap6G4ZpJq9nXwV4Zzk6ISIBA1AQkeayV
        k7wohhPAC3RTrh2cRwtwL6nJcmzIoYLyEHM3HjYnKxKM3+LagQ6SbAxBoCsYmZAAzA9wpx
        oG4jpmTd3cvVSSNNIrvWm+oVR0lW8Fwb39EvHIsD1OzWyEhIh/Wd7hPdTB+SEQkSeSKndt
        e39zuGPRKCmoEi56egbQ8olGZSjwuNFoi8ELFOa66DJeCvpsL2fE8z8XJ1VWQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687164047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUlbkGJCuvyMh1uRW/BF3POrtz1pE51GldRG3yIglCQ=;
        b=UmqJfv0XdPrxI5aLJ1CLBVwYzcGOYNMgeh3MbDNi6d1FmwklT85EqpKqu1h9J5VAoKggln
        CkHXuZTQ199JwvDA==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
Subject: Re: [PATCH v3 5/5] x86/entry: Make IA32 syscalls' availability
 depend on ia32_enabled()
In-Reply-To: <cf24db95-9c91-5d30-fe83-3a1e2cbf0cc1@suse.com>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-6-nik.borisov@suse.com> <87mt0wqxkt.ffs@tglx>
 <cf24db95-9c91-5d30-fe83-3a1e2cbf0cc1@suse.com>
Date:   Mon, 19 Jun 2023 10:40:46 +0200
Message-ID: <87a5wvrgj5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19 2023 at 09:28, Nikolay Borisov wrote:
> On 19.06.23 =D0=B3. 0:17 =D1=87., Thomas Gleixner wrote:
>> On Fri, Jun 16 2023 at 15:57, Nikolay Borisov wrote:
>>> Another major aspect of supporting running of 32bit processes is the
>>> ability to access 32bit syscalls. Such syscalls are invoked either by
>>> using the legacy int 0x80 call gate interface or via the newer sysenter
>>> instruction.
>>>
>>> Ensure that if ia32 emulation is disabled (either at compile time or
>>> runtime) then those 2 syscall mechanisms are also disabled.
>>=20
>> AFAICT there are _three_ mechanisms for 32bit syscalls, no?
>
> int 0x80 and sysenter make it 2? Which one is the 3rd one - the "native=20
> 64bit syscall" used in for X32 ABI ? This patch specifically deals with=20
> the first 2?

int 80, sysenter, syscall =3D 3

They obviously depend on the vendor preference when the CPU has enabled
long mode:

                      AMD    Intel
compat_int 80         y      y
compat_sysenter       #UD    y
compat_syscall        y      #UD

On Intel SYSENTER is trivial to disable by setting MSR_IA32_SYSENTER_CS
to 0 which makes sysenter raise #GP.

The nasty one is SYSCALL on AMD. If MSR_EFER.SCE=3D1 then MSR_CSTAR must
contain a valid kernel text address because otherwise compat SYSCALL
faults with CPL0 and user GSBASE. That's the whole reason for the stub
function which just sets EAX to -ENOSYS and returns via SYSRET.

And your patch deals with all _three_:

                    compat=3DON                    compat=3DOFF
compat_int 80:      Set system interrupt gate    ---

compat_sysenter:    Set up SYSENTER MSRs for     Invalidate SYSENTER
                    entry_SYSENTER_compat()      MSRs

compat_syscall:     Set MSR_CSTAR to             Set MSR_CSTAR to
                    entry_SYSCALL_compat()       stub function
                    (AMD only)                   (AMD only)

No?

Changelogs have to be precise. Otherwise they are useless and in the
worst case actively misleading.

Thanks,

        tglx
