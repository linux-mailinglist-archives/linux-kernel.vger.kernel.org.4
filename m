Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7CE70B999
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjEVKGX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 May 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEVKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:06:21 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 03:06:19 PDT
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 435C0B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:06:19 -0700 (PDT)
Received: from ursule.remlab.net (localhost [IPv6:::1])
        by ursule.remlab.net (Postfix) with ESMTP id 42F46C0014;
        Mon, 22 May 2023 12:58:46 +0300 (EEST)
Received: from [IPv6:::1] ([2001:14bb:cb:caf7:3010:ddff:fe1d:8405])
        by ursule.remlab.net with ESMTPSA
        id lAH3DNY8a2QVZTEAwZXkwQ
        (envelope-from <remi@remlab.net>); Mon, 22 May 2023 12:58:46 +0300
Date:   Mon, 22 May 2023 12:58:45 +0300
From:   =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To:     Andy Chiu <andy.chiu@sifive.com>
CC:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_-next_v20_20/26=5D_riscv=3A_Add_prc?= =?US-ASCII?Q?tl_controls_for_userspace_vector_management?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CABgGipW9xtZp-c2xWakz+EzrMbviN_9iAEtmfx73L4TJAn3K8Q@mail.gmail.com>
References: <20230518161949.11203-1-andy.chiu@sifive.com> <20230518161949.11203-21-andy.chiu@sifive.com> <5677700.DvuYhMxLoT@basile.remlab.net> <CABgGipW9xtZp-c2xWakz+EzrMbviN_9iAEtmfx73L4TJAn3K8Q@mail.gmail.com>
Message-ID: <2760633E-0DFA-4A72-AF4A-21613BEBA55D@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 22 mai 2023 11:28:28 GMT+03:00, Andy Chiu <andy.chiu@sifive.com> a écrit :
>On Sun, May 21, 2023 at 1:41 PM Rémi Denis-Courmont <remi@remlab.net> wrote:
>>
>>         Hi all,
>>
>> Le torstaina 18. toukokuuta 2023 19.19.43 EEST, vous avez écrit :
>> > This patch add two riscv-specific prctls, to allow usespace control the
>> > use of vector unit:
>> >
>> >  * PR_RISCV_V_SET_CONTROL: control the permission to use Vector at next,
>> >    or all following execve for a thread. Turning off a thread's Vector
>> >    live is not possible since libraries may have registered ifunc that
>> >    may execute Vector instructions.
>> >  * PR_RISCV_V_GET_CONTROL: get the same permission setting for the
>> >    current thread, and the setting for following execve(s).
>>
>> So far the story was that if the nth bit in the ELF HWCAP auxillary vector was
>> set, then the nth single lettered extension was supported. There is already
>> userspace code out there that expects this of the V bit. (I know I have
>> written such code, and I also know others did likewise.) This is how it
>> already works for the D and F bits.
>
>Yes, the V bit in ELF_HWCAP becomes vague in this series.


>> Admittedly, upstream Linux has never ever set that bit to this day. But still,
>> if we end up with the bit set in a process that has had V support disabled by
>> the parent (or the sysctl), existing userspace will encounter SIGILL and
>> break.
>>
>> IMO, the bit must be masked not only whence the kernel lacks V support (as
>> PATCH 02 does), but also if the process starts with V disabled.
>
>This is going to change ELF_HWCAP from a macro to a function. The
>function will turn on COMPAT_HWCAP_ISA_V iff V is supported and
>allowed. I am going to do this in v21 If this looks sane. i.e.
>Currently I don't see other architectures which give different
>ELF_HWCAP values on each execve. If ELF_HWCAP is not a right place to
>encode the information then userspace has to make the prctl() call to
>be certain on whether V is usable.

I don't think the value of an auxillary vector entry can change in an existing process nor that we need that. If an application starts with V disabled, you can keep the V bit clear even if V gets enabled later on; that won't break existing userspace code, which simply won't use vectors.

What does break existing userspace is setting the V bit whilst vectors are disabled.



>
>>
>> There are two ways to achieve this:
>> 1) V is never ever set, and userspace is forced to use hwprobe() instead.
>> 2) V is set only in processes starting with V enabled (and it's their own
>> fault if they disabled it in future child threads).
>
>The prctl() interface does not allow processes to turn off V once it
>is enabled in its current (execve) context. The process can only
>disable V when the next execve() happens. Then, if we implement
>ELF_HWCAP as mentioned above, the kernel will reload a new HWCAP for
>the process. By then, the new HWCAP will have V masked since it is not
>allowed.
>
>>
>> Br,
>>
>> --
>> レミ・デニ-クールモン
>> http://www.remlab.net/
>>
>>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>Thanks,
>Andy
>
