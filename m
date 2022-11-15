Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A143562A17F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiKOSn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKOSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:43:52 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61E65F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:43:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so2064054pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00+9Ilghhv3lntMm+1aRi6kvIbEPCefmRGEhAjVwcJw=;
        b=OZtxlOh99Bx9s9c9BOyIAwuhOJfZgo7d/mcaeLE7mxKJVeKdeFD6fM5Ks/7o9MbZhn
         Pn2LhYcnwWw18985f5iOtI1gjTuYMXf9MTEU1Kq44fEMb5O2QipDHJRW+VeivUyO2QSb
         oh+pVsMBb4skurDKdwSPDo8/2M+KyLJitjSpgUYx++8t5EO6at8ECEWKKJjtZAYRan1A
         dQktsTJnNwcaLHw6mMXc7WsfYiBcWTW31/iABj3+/ybtor2a3Lxm0Fref6r9GvBQGwpI
         mp4/AG2nJPtGj6Sg8jmPH4HCl53a286b7bN9qxGofT3M1xe2AusCSHxSwWTMjoNJ+Qd1
         NaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00+9Ilghhv3lntMm+1aRi6kvIbEPCefmRGEhAjVwcJw=;
        b=fpmBD8hDUBz5HMY0uMj9pQYM9W42z/8L7VwX7v1K1MlhrY38sPKNZO4FKqeHJV9N78
         IFn/uYx9LC9imq2pxU+9pMh4/skUnQTW9pObupxg6LHUADnPgRRZhC1S/RQIP7ywEerb
         Ed3IE+V3JIkXvpHA6N+LtAKt0TmVtmwXYSlFy/nbCSSXN/o40oJEBtIpPXCXBzudsrq+
         iyJSQBy4OwvYB4cVs7vva9g0uJndaTs1r2vgEHoA7PYcAN5NVPn1vADW08cqX7npUo48
         pxs0IUlXE6g4IXM9qHTtzqt4s5gOGCEiw+B8qa38NfYHcAo0tEpCehmewQAe79z2nstb
         CvdA==
X-Gm-Message-State: ANoB5plPvaI8tmU4/d2nLLwM4IFxR5EMkJ9gVXdELdu6NSraQ1WiDSXa
        bx7vn15BpXG35STU63AEmyOxwA==
X-Google-Smtp-Source: AA0mqf5twos0SU2IewJ7K9NEb95p/NVrr2KpeNPsORRYgK4dUVM1q4PEdD2VQ3toOdN4t6keDEkZsg==
X-Received: by 2002:a17:902:9a01:b0:185:3ecb:d464 with SMTP id v1-20020a1709029a0100b001853ecbd464mr5393170plp.78.1668537830742;
        Tue, 15 Nov 2022 10:43:50 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 132-20020a62188a000000b00571dda13fafsm6990296pfy.163.2022.11.15.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:43:50 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:43:48 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Conor.Dooley@microchip.com
Cc:     aou@eecs.berkeley.edu, jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, ajones@ventanamicro.com,
        linux-riscv@lists.infradead.org, bjorn@kernel.org,
        atishp@rivosinc.com
Subject: Re: [PATCH v3] scripts/gdb: add lx_current support for riscv
Message-ID: <20221115184348.GA1854852@debug.ba.rivosinc.com>
References: <20221115012917.1781185-1-debug@rivosinc.com>
 <20221115084923.1822572-1-debug@rivosinc.com>
 <Y3OkY6myfea00BaK@wendy>
 <CAKC1njRi9C0m3JKpu0ebAFCC25161EST=tFFWiAj1yZBbnak6A@mail.gmail.com>
 <4f293c39-6a0e-dd25-9ed2-10088bb971e1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f293c39-6a0e-dd25-9ed2-10088bb971e1@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 06:06:34PM +0000, Conor.Dooley@microchip.com wrote:
>Hey Deepak,
>
>On 15/11/2022 17:49, Deepak Gupta wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> Since I am new to all this. I've had some oversight and am still learning the flow.
>> Rest inline.
>
>No worries chief. Worth noting is that this mail came in html
>form, which the mailing lists reject. Noone outside of the
>direct CC list will see this mail. May be worth asking some
>of the other Rivos lads how they do their plain text emailing.
>
>ik Palmer's got his hand rolled stuff, so maybe he's not the
>best to ask - but try Bjorn or Atish?

Sending this time from mutt. Hopefully no bounces.

>
>>
>> On Tue, Nov 15, 2022 at 6:38 AM Conor Dooley <conor.dooley@microchip.com <mailto:conor.dooley@microchip.com>> wrote:
>>
>>     Hey Deepak,
>>
>>     On Tue, Nov 15, 2022 at 12:49:23AM -0800, Deepak Gupta wrote:
>>     > csr_sscratch CSR holds current task_struct address when hart is in
>>     > user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
>>     > register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
>>     > "tp" with expected user mode value and place current task_struct address
>>     > again in csr_scratch CSR.
>>     >
>>     > This patch assumes "tp" is pointing to task_struct. If value in
>>     > csr_scratch is numerically greater than "tp" then it assumes csr_scratch
>>
>>     nit: s/scratch/sscratch/ ?
>>
>>
>> Will fix it.
>>  
>>
>>
>>     > is correct address of current task_struct. This logic holds when
>>     >    - hart is in user space, "tp" will be less than csr_scratch.
>>     >    - hart is in kernel space but not in trap handler, "tp" will be more
>>     >      than csr_scratch (csr_scratch being equal to 0).
>>     >    - hart is executing trap handler
>>     >        - "tp" is still pointing to user mode but csr_scratch contains
>>     >           ptr to task_struct. Thus numerically higher.
>>     >        - "tp" is  pointing to task_struct but csr_scratch now contains
>>     >           either 0 or numerically smaller value (transiently holds
>>     >           user mode tp)
>>     >
>>     > Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py
>>     >
>>     > Signed-off-by: Deepak Gupta <debug@rivosinc.com <mailto:debug@rivosinc.com>>
>>
>>     I noticed when looking into patchwork complaining about checkpatch
>>     errors in v2, that b4 had actually downloaded v3 but I could not see
>>     this patch on the RISC-V list.
>>
>>  
>> I'll make sure to add the risc-v list on the next spin up.
>>
>>
>>     I don't see a changelog anywhere here
>>     from v2 either
>>
>>
>> I had been taking inputs and squashing commits on my end.
>> You want me to send a changelog of changes between versions of patches.
>
>Yeah, it's nice to say something like:
>v2 -> v3:
>- reworded commit message
>- fixed compile error in bar.c if !CONFIG_FOO
>
>Makes it easier for reviewers to see what changed between
>versions.
>
>>  
>>
>>     , nor did you pick up Drew's Reviewed-by.
>>
>>
>> I should've done that. My mistake and apologize.
>> I'll fix it in my next submission.
>>  
>>
>>
>>     What's the story there?
>>
>>     One really minor thing below. Should be able to fix it up trivially up
>>     & submit a v4, CCing the linux-riscv list.
>>
>>     > ---
>>     >  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
>>     >  scripts/gdb/linux/utils.py |  5 +++++
>>     >  2 files changed, 20 insertions(+)
>>     >
>>     > diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
>>     > index 15fc4626d236..ca5215a660c7 100644
>>     > --- a/scripts/gdb/linux/cpus.py
>>     > +++ b/scripts/gdb/linux/cpus.py
>>     > @@ -173,6 +173,21 @@ def get_current_task(cpu):
>>     >           else:
>>     >               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>>     >                                  "while running in userspace(EL0)")
>>     > +    elif utils.is_target_arch("riscv"):
>>     > +         current_tp = gdb.parse_and_eval("$tp")
>>     > +         scratch_reg = gdb.parse_and_eval("$sscratch")
>>     > +
>>     > +         # by default tp points to current task
>>     > +         current_task = current_tp.cast(task_ptr_type)
>>     > +
>>     > +         # scratch register is set 0 in trap handler after entering kernel.
>>     > +         # When hart is in user mode, scratch register is pointing to task_struct.
>>     > +         # and tp is used by user mode. So when scratch register holds larger value
>>     > +         # (negative address as ulong is larger value) than tp, then use scratch register.
>>     > +         if (scratch_reg.cast(utils.get_ulong_type()) >  current_tp.cast(utils.get_ulong_type())):
>>                                                               ^^
>>     extra space here?
>>
>>
>> I don't see the space in the patch. Can you clarify which space you're talking about here?
>
>There's a double space between the > and current_tp.
>I put a ^^ under it, but if you've not got a monospace font, which since
>you're replying in html you probably don't, it may not align for you.
>
>Hope that helps,
>Conor.

Yes can see it now.

>
>>
>>      
>>
>>
>>     > +             current_task = scratch_reg.cast(task_ptr_type)
>>     > +
>>     > +         return current_task.dereference()
>>     >      else:
>>     >          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>>     >                             "supported with this arch")
>>     > diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
>>     > index 1553f68716cc..ddaf3089170d 100644
>>     > --- a/scripts/gdb/linux/utils.py
>>     > +++ b/scripts/gdb/linux/utils.py
>>     > @@ -35,12 +35,17 @@ class CachedType:
>>     > 
>>     > 
>>     >  long_type = CachedType("long")
>>     > +ulong_type = CachedType("ulong")
>>     >  atomic_long_type = CachedType("atomic_long_t")
>>     > 
>>     >  def get_long_type():
>>     >      global long_type
>>     >      return long_type.get_type()
>>     > 
>>     > +def get_ulong_type():
>>     > +    global ulong_type
>>     > +    return ulong_type.get_type()
>>     > +
>>     >  def offset_of(typeobj, field):
>>     >      element = gdb.Value(0).cast(typeobj)
>>     >      return int(str(element[field].address).split()[0], 16)
>>     > --
>>     > 2.25.1
>>
>
