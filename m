Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A56763E5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAUFAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUFAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:00:31 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881C6F8BD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:00:29 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30L502wU1448162
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 20 Jan 2023 21:00:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30L502wU1448162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674277203;
        bh=+8k25AOCrihnf45aEnkA7jOgPqlEvVSXlsVpqaj25DQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hr8q6dtnKDM62juOBngq/TGraCZHITm3YW5H8NEPjN22uRo4CXE5VjJytHVmG8gg0
         DGDA/hZsIOY+NrpPUzdOzv+yDndFor9oMSAfFMUCN6vpBwp9Drta+jqgdycg2OxUgj
         YXAan95Evp8Jr5Xu0b9X+OS0EGR4hYi8eeACtoDmiqG3WCZuB3BJikvtO4GrcP/3H/
         QtP1mAf5KbO+VCSxzKnPaSl1ULjBDgr3Ywda3aUtLqNeyqfUg9pljy6PQE+4WPuBCU
         e8tT6VfcWiLEopc9jwFeMYVQcWEF3Hj5zZei1hMoq91PvRjFpk7rrF00iMkXsUOEGV
         2Qlmft+hQ6IGA==
Date:   Fri, 20 Jan 2023 20:59:58 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Dave Hansen <dave.hansen@intel.com>,
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
In-Reply-To: <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
Message-ID: <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 20, 2023 9:45:26 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/19/23 23:49, Li, Xin3 wrote:
>> The x86 sysret_rip test has the following assertion:
>>=20
>>         /* R11 and EFLAGS should already match=2E */
>>         assert(ctx->uc_mcontext=2Egregs[REG_EFL] =3D=3D
>>                ctx->uc_mcontext=2Egregs[REG_R11]);
>>=20
>> This is being tested to avoid kernel state leak due to sysret vs iret,
>> but that on FRED r11 is *always* preserved, and the test just fails=2E
>
>Let's figure out the reason that FRED acts differently, first=2E  Right
>now, the SDM says:
>
>	SYSCALL also saves RFLAGS into R11
>
>so that behavior of SYSCALL _looks_ architectural to me=2E  Was this
>change in SYSCALL behavior with FRED intentional?
>
>If not intentional, it might be something that can still be fixed=2E  If
>it is intentional and is going to be with us for a while we have a few
>options=2E  If userspace is _really_ depending on this behavior, we could
>just clobber r11 ourselves in the FRED entry path=2E  If not, we can
>remove the assertion in the selftest=2E

We can't clobber it in the FRED entry path, since it is common for all eve=
nts, but we could do it in the syscall dispatch=2E

However, it doesn't seem to make sense to do so to me=2E The current behav=
ior is much more of an artifact than desired behavior=2E
