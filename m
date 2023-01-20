Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA24B675F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjATVRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjATVR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:17:29 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C68B328
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:17:28 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30KLHBlO1334232
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 20 Jan 2023 13:17:12 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30KLHBlO1334232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674249433;
        bh=1di1ytCAR87Ab6rDJ2sun1qDRQeCO3rrEnsjyOolOaE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=L0piojDx+XwlPDJ+oQIATzUUy0XnR4dLsHr4Th8Bduawy/1d6FN0ye99Y0q5i2A0t
         Q9g3/DbXDNKXTs2je6HrNv7g5ZxWdANfaiZxoKp1cJs9Ku+SpOa9X9LwR9kMrfK8uA
         Gu+yARb9vkZNsjV7fWFmnDWbepu0mkw3xMDh5b2K6mzujw0BblTciCXmaQZuGFGasm
         uthFrarITNtRWdOMvStQUiCq8Y3c2OLMILE8XU2D4HpO7Bt8V/DU0c3GvzuE75llQ9
         1ESHtfmhXKR40VOVGubYDmRKSMy74NodfjCQyR6GI2teIA1iSpLBGhOGhwEN6BBTqW
         N1EtIq09YOqNg==
Date:   Fri, 20 Jan 2023 13:17:08 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
User-Agent: K-9 Mail for Android
In-Reply-To: <bf1ef4eb-4cc1-c862-287f-25e9144e1291@citrix.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <eb81f7f2-d266-d999-b41a-e6eae086e731@citrix.com> <A87231FB-5B5D-46B7-9888-5770039B7EA1@zytor.com> <bf1ef4eb-4cc1-c862-287f-25e9144e1291@citrix.com>
Message-ID: <096C16C1-5139-4775-8B45-B5A33F1C6F6D@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 20, 2023 1:10:09 PM PST, Andrew Cooper <Andrew=2ECooper3@citrix=
=2Ecom> wrote:
>On 20/01/2023 8:50 pm, H=2E Peter Anvin wrote:
>> On January 20, 2023 10:52:02 AM PST, Andrew Cooper <Andrew=2ECooper3@ci=
trix=2Ecom> wrote:
>>> On 20/01/2023 5:45 pm, Dave Hansen wrote:
>>>> On 1/19/23 23:49, Li, Xin3 wrote:
>>>>> The x86 sysret_rip test has the following assertion:
>>>>>
>>>>>         /* R11 and EFLAGS should already match=2E */
>>>>>         assert(ctx->uc_mcontext=2Egregs[REG_EFL] =3D=3D
>>>>>                ctx->uc_mcontext=2Egregs[REG_R11]);
>>>>>
>>>>> This is being tested to avoid kernel state leak due to sysret vs ire=
t,
>>>>> but that on FRED r11 is *always* preserved, and the test just fails=
=2E
>>>> Let's figure out the reason that FRED acts differently, first=2E  Rig=
ht
>>>> now, the SDM says:
>>>>
>>>> 	SYSCALL also saves RFLAGS into R11
>>>>
>>>> so that behavior of SYSCALL _looks_ architectural to me=2E  Was this
>>>> change in SYSCALL behavior with FRED intentional?
>>> FRED 3=2E0 Section 7=2E4 says the only changes for the SYSCALL and SYS=
ENTER
>>> instructions are the enablement conditions=2E=C2=A0 Nowhere else is th=
ere
>>> mention of a FRED OS needing to emulate legacy syscall behaviour by
>>> adjusting %r11/%rcx
>>>
>>> However, ERETU does handle flags different to SYSRET (in particular, I
>>> think you can establish TF on the instruction boundary after SYSCALL
>>> now)=2E=C2=A0 What are the raw values of REG_EFL and REG_R11 ?
>>>
>>> ~Andrew
>>>
>> Just to avoid any confusion:
>>
>> Syscall and sysenter in a FRED system are treated equivalently to softw=
are interrupts, e=2Eg=2E INT 0x80=2E They do not modify any registers=2E
>
>In which case can Intel please publish a v4 spec which actually says this=
?
>
>I can't see anything in the v3 spec which mentions a change in register
>behaviour for SYSCALL=2E
>
>~Andrew
>

I'll make sure it makes it into the next update=2E
