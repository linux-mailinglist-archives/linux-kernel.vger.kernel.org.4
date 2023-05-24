Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE170EA25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjEXASb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjEXAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:18:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09289E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:18:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae8ecb4f9aso2269105ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1684887507; x=1687479507;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eY2Gd7QrMKjx8vRnDhUl56JLsTlMZyMcAagquTq27qE=;
        b=SA1VzhrN365+fJKAfjgd5AfhToSao9IMVByCyCTklEtZ0fHLrd4MlKFK17OwL/C9Ii
         HDKpR7yTQnpwWmDRzpvlIlHc6aWgUPRqazXNDY0LpvVX1MCFtr40GRHNYTf5XfmNISRB
         TEZSNc3LE2Kv1jUpO3pcfqgC6EDgWjs4D+X9bm3OFQCjMZK0Zm/SvmDDhCjDMxBFRBRO
         Adno05tlKKIu2zTWLif7D+pSTd2+rZok3F4Xtm6YtZ5WVp4U05Yu7f2VSws9eNsEE3aM
         Ioa4PTspUw4LEF7m4NmRNggq3IEGvkBV9J29jzpi1/tdO0U/1g+e0zytoPrxVCxG5K5q
         HlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887507; x=1687479507;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eY2Gd7QrMKjx8vRnDhUl56JLsTlMZyMcAagquTq27qE=;
        b=U0hd1t0yBkAYVGPZ/w8xb/ez+u8sKDD4mtjRYXOivBSjfF57Ly6F1O/U5HNg+lbjFz
         RuAQdWGJ+uyR7rc6sIOQXM1CGLBsWYNSQjhmxfWpPO63X72WjGXc09juaDDKdZUjkg4y
         /FXUwB/GwOVcWHhSiuGbn55bMP3T7z+bBqd3qy5VI0X74wYwIiJZwkUgDWHCtSpm0CnB
         5jp5R5ePFBXriOP5T0dFA4qQxJI/0J0eXreaHujTq8tMPlD2t+ynPsnubZkFw63/PGZM
         f647nm8qYxT2mwj/op1zsaApyEe8H/vAhZ5XN6NAoSvjr6LRKGgt9qCcn8ABZlcu+xIT
         jdOQ==
X-Gm-Message-State: AC+VfDyG4EtXqqVR/kGV/ly1wi5M9DfT8unOiozsKKrFnFxAj52lTkEb
        28tiOKcxXYZb0xzs0elfN6CLBw==
X-Google-Smtp-Source: ACHHUZ73JXw+RxC9DdESjYXahQownYY485zJlj5BGmpc8z9C67e625FSxJHEiocQhKmi2CmGa1v9oQ==
X-Received: by 2002:a17:902:f54d:b0:1a6:45e5:a26a with SMTP id h13-20020a170902f54d00b001a645e5a26amr20492740plf.27.1684887507294;
        Tue, 23 May 2023 17:18:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b001a634e79af0sm7296067plb.283.2023.05.23.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:18:26 -0700 (PDT)
Date:   Tue, 23 May 2023 17:18:26 -0700 (PDT)
X-Google-Original-Date: Tue, 23 May 2023 17:18:00 PDT (-0700)
Subject:     Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace vector management
In-Reply-To: <2760633E-0DFA-4A72-AF4A-21613BEBA55D@remlab.net>
CC:     andy.chiu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     remi@remlab.net
Message-ID: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 02:58:45 PDT (-0700), remi@remlab.net wrote:
> Hi,
>
> Le 22 mai 2023 11:28:28 GMT+03:00, Andy Chiu <andy.chiu@sifive.com> a écrit :
>>On Sun, May 21, 2023 at 1:41 PM Rémi Denis-Courmont <remi@remlab.net> wrote:
>>>
>>>         Hi all,
>>>
>>> Le torstaina 18. toukokuuta 2023 19.19.43 EEST, vous avez écrit :
>>> > This patch add two riscv-specific prctls, to allow usespace control the
>>> > use of vector unit:
>>> >
>>> >  * PR_RISCV_V_SET_CONTROL: control the permission to use Vector at next,
>>> >    or all following execve for a thread. Turning off a thread's Vector
>>> >    live is not possible since libraries may have registered ifunc that
>>> >    may execute Vector instructions.
>>> >  * PR_RISCV_V_GET_CONTROL: get the same permission setting for the
>>> >    current thread, and the setting for following execve(s).
>>>
>>> So far the story was that if the nth bit in the ELF HWCAP auxillary vector was
>>> set, then the nth single lettered extension was supported. There is already
>>> userspace code out there that expects this of the V bit. (I know I have
>>> written such code, and I also know others did likewise.) This is how it
>>> already works for the D and F bits.
>>
>>Yes, the V bit in ELF_HWCAP becomes vague in this series.
>
>
>>> Admittedly, upstream Linux has never ever set that bit to this day. But still,
>>> if we end up with the bit set in a process that has had V support disabled by
>>> the parent (or the sysctl), existing userspace will encounter SIGILL and
>>> break.
>>>
>>> IMO, the bit must be masked not only whence the kernel lacks V support (as
>>> PATCH 02 does), but also if the process starts with V disabled.
>>
>>This is going to change ELF_HWCAP from a macro to a function. The
>>function will turn on COMPAT_HWCAP_ISA_V iff V is supported and
>>allowed. I am going to do this in v21 If this looks sane. i.e.
>>Currently I don't see other architectures which give different
>>ELF_HWCAP values on each execve. If ELF_HWCAP is not a right place to
>>encode the information then userspace has to make the prctl() call to
>>be certain on whether V is usable.
>
> I don't think the value of an auxillary vector entry can change in an existing process nor that we need that. If an application starts with V disabled, you can keep the V bit clear even if V gets enabled later on; that won't break existing userspace code, which simply won't use vectors.
>
> What does break existing userspace is setting the V bit whilst vectors are disabled.

So maybe the right answer is to just not set V at all?  The 
single-letter extensions are sort of defunct now, there's multi-letter 
sub extensions for most things, but V got ratified with those 
sub-extensions so we could just call it extra-ambiguous?

>
>
>
>>
>>>
>>> There are two ways to achieve this:
>>> 1) V is never ever set, and userspace is forced to use hwprobe() instead.
>>> 2) V is set only in processes starting with V enabled (and it's their own
>>> fault if they disabled it in future child threads).
>>
>>The prctl() interface does not allow processes to turn off V once it
>>is enabled in its current (execve) context. The process can only
>>disable V when the next execve() happens. Then, if we implement
>>ELF_HWCAP as mentioned above, the kernel will reload a new HWCAP for
>>the process. By then, the new HWCAP will have V masked since it is not
>>allowed.
>>
>>>
>>> Br,
>>>
>>> --
>>> レミ・デニ-クールモン
>>> http://www.remlab.net/
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>>Thanks,
>>Andy
>>
