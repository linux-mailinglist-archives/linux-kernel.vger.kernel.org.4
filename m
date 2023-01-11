Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFFC66650F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjAKUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjAKUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:52:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF23F114
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:51:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t5so11853164wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuw6px+NzHkBNfjG6tvmZnr4uMKhAycqN8SZaVocX44=;
        b=XS3UABdqsXtws7GWolvhofoc0b96n0Wk8v2VQT1k9TYAlQ2lmCPW6dqhoaixbkxYKK
         5lYAtYF3Qb81fDAxyc4L8qDtwGsCOgoq+toS8HopzfZYvrIM/d6evq/7NZTaC5dbLVxi
         qmNoqn8MkWyoBX9qo+k2FwaSb0OwzBeoSYl4yaRiuk7lKhjE7bXbhivtfDfAQwKKkAHV
         N+kFayQoiBsbxm1hUKyfx+fFtiPjQXtxay5dXzXeB+Ud3GfbJIPd5c/qatqbSvACgDVG
         8T0z1tum3Yv1yrKBGIgP3axyC8vBR8ksn7LOqd5OzChxIR6KNJzmU7DSwsea30V1lXU6
         dBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuw6px+NzHkBNfjG6tvmZnr4uMKhAycqN8SZaVocX44=;
        b=rKQ5D0KFqV+UIMGnBLIAHCDtEGEdvXrtfFOlh5boCZJR57aYRMuKtWvAm0N+CmQK1o
         2DDPrvu+ypXVMNxlD00tFgVAcgMb3o4fhxLnNmN/2k6nXNInoPT8QGljdGMWl5KFg9gm
         HyDa4tozCDxaK3q03y5pZgFzBx+JABKnZZgVRRWF2PHub9tZsbA1hqqPpE7qn8z2Xbwr
         YNNgpSJ2DYzIaJgceTxJLZ0enoPPCsTul3t2J7X+79Q0s5Vzxn/5T5YghUHkZFpFhms+
         ZnTEU8cKA6JSjMkj7NIoLMVA/IqvUMs3qBgU8h1hXRYSStxqA8fzLjlWkDXXo/bfq+Om
         mgCA==
X-Gm-Message-State: AFqh2krVS5S06PAIUlHvshjW3Yk9PYXYSDR6aSdwTr/pMONB7Kamr3da
        /tgTK4qYbLJU+YEoSkCp1oVhYA==
X-Google-Smtp-Source: AMrXdXvmKRHTscqR8X3iTF4QZSiewNgVao7ITeJEPGtsdgK8u07u6PP8JtCNJnRi0FFK8br1hpSF8w==
X-Received: by 2002:a05:6000:85:b0:2bc:7fdd:9245 with SMTP id m5-20020a056000008500b002bc7fdd9245mr6925493wrx.5.1673470315585;
        Wed, 11 Jan 2023 12:51:55 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id u5-20020adfdb85000000b002ba2646fd30sm17254823wri.36.2023.01.11.12.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 12:51:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v6 RESEND 0/2] use static key to optimize
 pgtable_l4_enabled
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230111190029.ltynngqnqs42gatd@orel>
Date:   Wed, 11 Jan 2023 20:51:54 +0000
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <391AFCB9-D314-4243-9E35-6D95B81C9400@jrtc27.com>
References: <20220821140918.3613-1-jszhang@kernel.org>
 <mhng-30c89107-c103-4363-b4af-7778d9512622@palmer-ri-x1c9>
 <Yz6T4EYKKns7OIVE@xhacker> <Y0GJDqLXFU81UdfW@xhacker>
 <Y5W0bv8Y/zCc+Fco@xhacker> <Y77xyNPNqnFQUqAx@xhacker>
 <20230111190029.ltynngqnqs42gatd@orel>
To:     Andrew Jones <ajones@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jan 2023, at 19:00, Andrew Jones <ajones@ventanamicro.com> wrote:
> On Thu, Jan 12, 2023 at 01:28:40AM +0800, Jisheng Zhang wrote:
>> On Sun, Dec 11, 2022 at 06:44:04PM +0800, Jisheng Zhang wrote:
>>> On Sat, Oct 08, 2022 at 10:28:35PM +0800, Jisheng Zhang wrote:
>>>> On Thu, Oct 06, 2022 at 04:37:57PM +0800, Jisheng Zhang wrote:
>>>>> On Wed, Oct 05, 2022 at 06:05:28PM -0700, Palmer Dabbelt wrote:
>>>>>> On Sun, 21 Aug 2022 07:09:16 PDT (-0700), jszhang@kernel.org =
wrote:
>>>>>>> The pgtable_l4|[l5]_enabled check sits at hot code path, =
performance
>>>>>>> is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed =
after
>>>>>>> boot, so static key can be used to solve the performance =
issue[1].
>>>>>>>=20
>>>>>>> An unified way static key was introduced in [2], but it only =
targets
>>>>>>> riscv isa extension. We dunno whether SV48 and SV57 will be =
considered
>>>>>>> as isa extension, so the unified solution isn't used for
>>>>>>> pgtable_l4[l5]_enabled now.
>>>>>>>=20
>>>>>>> patch1 fixes a NULL pointer deference if static key is used a =
bit earlier.
>>>>>>> patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
>>>>>>>=20
>>>>>>> [1] =
http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html=

>>>>>>> [2] =
https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.o=
rg/T/#t
>>>>>>>=20
>>>>>>> Since v5:
>>>>>>> - Use DECLARE_STATIC_KEY_FALSE
>>>>>>>=20
>>>>>>> Since v4:
>>>>>>> - rebased on v5.19-rcN
>>>>>>> - collect Reviewed-by tags
>>>>>>> - Fix kernel panic issue if SPARSEMEM is enabled by moving the
>>>>>>>   riscv_finalise_pgtable_lx() after sparse_init()
>>>>>>>=20
>>>>>>> Since v3:
>>>>>>> - fix W=3D1 call to undeclared function 'static_branch_likely' =
error
>>>>>>>=20
>>>>>>> Since v2:
>>>>>>> - move the W=3D1 warning fix to a separate patch
>>>>>>> - move the unified way to use static key to a new patch series.
>>>>>>>=20
>>>>>>> Since v1:
>>>>>>> - Add a W=3D1 warning fix
>>>>>>> - Fix W=3D1 error
>>>>>>> - Based on v5.18-rcN, since SV57 support is added, so convert
>>>>>>>   pgtable_l5_enabled as well.
>>>>>>>=20
>>>>>>>=20
>>>>>>> Jisheng Zhang (2):
>>>>>>>  riscv: move sbi_init() earlier before jump_label_init()
>>>>>>>  riscv: turn pgtable_l4|[l5]_enabled to static key for RV64
>>>>>>>=20
>>>>>>> arch/riscv/include/asm/pgalloc.h    | 16 ++++----
>>>>>>> arch/riscv/include/asm/pgtable-32.h |  3 ++
>>>>>>> arch/riscv/include/asm/pgtable-64.h | 60 =
++++++++++++++++++---------
>>>>>>> arch/riscv/include/asm/pgtable.h    |  5 +--
>>>>>>> arch/riscv/kernel/cpu.c             |  4 +-
>>>>>>> arch/riscv/kernel/setup.c           |  2 +-
>>>>>>> arch/riscv/mm/init.c                | 64 =
++++++++++++++++++-----------
>>>>>>> arch/riscv/mm/kasan_init.c          | 16 ++++----
>>>>>>> 8 files changed, 104 insertions(+), 66 deletions(-)
>>>>>>=20
>>>>>> Sorry for being slow here, but it looks like this still causes =
some early
>>>>>> boot hangs.  Specifically kasan+sparsemem is failing.  As you can =
probably
>>>>>> see from the latency I'm still a bit buried right now so I'm not =
sure when
>>>>>> I'll have a chance to take more of a look.
>>>>>=20
>>>>> Hi Palmer,
>>>>>=20
>>>>> Before V4, there is a bug which can cause kernel panic when =
SPARSEMEM
>>>>> is enabled, V4 have fixed it by moving the =
riscv_finalise_pgtable_lx()
>>>>> after sparse_init(). And I just tested the =
riscv-pgtable_static_key
>>>>> branch in your tree, enabling KASAN and SPARSEMEM, system booted =
fine.
>>>>> I'm not sure what happened. Could you please send me your kernel
>>>>> config file? I want to fix any issue which can block this series =
being
>>>>> merged in 6.1-rc1.
>>>>=20
>>>> Hi Palmer,
>>>>=20
>>>> I know you are busy ;) Do you have time to send me your test kernel
>>>> config file so that I can reproduce the "early boot hang"?
>>>>=20
>>>> Thanks
>>>=20
>>> Hi Palmer,
>>>=20
>>> I think the early boot hangs maybe the same as the one which has =
been
>>> fixed by commit 9f2ac64d6ca6 ("riscv: mm: add missing memcpy in
>>> kasan_init"). Will you give this series another try for v6.2-rc1? If
>>> the boot hang can still be reproduced, could you please send me your
>>> .config file?
>>>=20
>>> Thanks in advance
>> Hi all,
>>=20
>> Just request to comment what to do with this patch, I think there
>> are two independent points to consult:
>>=20
>> 1. IIRC, Palmer gave this patch two chances to merge in early =
versions
>> but he found boot hangs if enable KASAN and SPARSEMEM, while I can't
>> reproduce the boot hang. And I also expect the hang should be fixed =
by
>> commit 9f2ac64d6ca6 ("riscv: mm: add missing memcpy in kasan_init")
>>=20
>> 2. Now we know alternative is preferred than static branch for ISA
>> extensions dynamic code patching. So we also need to switch static
>> branch usage here to alternative mechanism, but the problem is
>> SV48 and SV57 are not ISA extensions, so we can't directly make use
>> of the recently introduced riscv_has_extension_likely|unlikely()[1]=20=

>> which is based on alternative mechanism.
>=20
> We could rename the "has_extension" framework to "has_cpufeature" and
> then lump extensions and features such as sv48 and sv57 together. Or,
> if it's best to keep extensions separate, then duplicate the framework
> to create a "has_non_extension_feature" version where features like
> sv48 and sv57 live.

Sv39, Sv48 and Sv57 are extensions these days (see the draft profiles
spec[1] and [2]).

Jess

[1] =
https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#522-rva20s=
64-mandatory-extensions
[2] https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions

> Thanks,
> drew
>=20
>>=20
>> Any comments are appreciated.
>>=20
>> Thanks in advance
>>=20
>> [1] =
https://lore.kernel.org/linux-riscv/20230111171027.2392-1-jszhang@kernel.o=
rg/T/#t
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

