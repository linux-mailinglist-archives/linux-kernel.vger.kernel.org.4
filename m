Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE1675F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjATUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:51:48 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337D1633A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:51:44 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30KKot2Q1327193
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 20 Jan 2023 12:50:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30KKot2Q1327193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674247857;
        bh=OozNsf8rAfuwn9CoxcIek5bYmCojoGQsnmeZkcjPGVQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=YxKvUX7WU7r0KamhV+ty/mDtyqx5Re/PvBOXexT5CiBoGllf59meZjJkoqpdIKk4M
         Rsy1dgkTutivfrBEGX/xu3EJH6eSYL0vrcb5fCoqYoOLvh7u6Xc/5WLy2QQgYmVrfK
         5d4Xmza89DxAOcNde/uJcRu7b7K+ZQw+spzAhJO0ZccdIchKoH7wZkgDKEaXg4p3XI
         lLDpSlEWJJPbVP2iTQh/AO2xky0+ucixz7WEvMcBsWLxPZcJTNJyzVbtyYlkg6lmfS
         ww5C6nJ47xa4BFtIU3KucuhIyqBgBCuR8gLT+Y9IkLYmoXVu5T0auCKqOnvE8fDCZ7
         3rmAflkeT2RzQ==
Date:   Fri, 20 Jan 2023 12:50:51 -0800
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
In-Reply-To: <eb81f7f2-d266-d999-b41a-e6eae086e731@citrix.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <eb81f7f2-d266-d999-b41a-e6eae086e731@citrix.com>
Message-ID: <A87231FB-5B5D-46B7-9888-5770039B7EA1@zytor.com>
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

On January 20, 2023 10:52:02 AM PST, Andrew Cooper <Andrew=2ECooper3@citrix=
=2Ecom> wrote:
>On 20/01/2023 5:45 pm, Dave Hansen wrote:
>> On 1/19/23 23:49, Li, Xin3 wrote:
>>> The x86 sysret_rip test has the following assertion:
>>>
>>>         /* R11 and EFLAGS should already match=2E */
>>>         assert(ctx->uc_mcontext=2Egregs[REG_EFL] =3D=3D
>>>                ctx->uc_mcontext=2Egregs[REG_R11]);
>>>
>>> This is being tested to avoid kernel state leak due to sysret vs iret,
>>> but that on FRED r11 is *always* preserved, and the test just fails=2E
>> Let's figure out the reason that FRED acts differently, first=2E  Right
>> now, the SDM says:
>>
>> 	SYSCALL also saves RFLAGS into R11
>>
>> so that behavior of SYSCALL _looks_ architectural to me=2E  Was this
>> change in SYSCALL behavior with FRED intentional?
>
>FRED 3=2E0 Section 7=2E4 says the only changes for the SYSCALL and SYSENT=
ER
>instructions are the enablement conditions=2E=C2=A0 Nowhere else is there
>mention of a FRED OS needing to emulate legacy syscall behaviour by
>adjusting %r11/%rcx
>
>However, ERETU does handle flags different to SYSRET (in particular, I
>think you can establish TF on the instruction boundary after SYSCALL
>now)=2E=C2=A0 What are the raw values of REG_EFL and REG_R11 ?
>
>~Andrew
>

Just to avoid any confusion:

Syscall and sysenter in a FRED system are treated equivalently to software=
 interrupts, e=2Eg=2E INT 0x80=2E They do not modify any registers=2E
