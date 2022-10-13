Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3695FD7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:51:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDD2FF8F5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oMej+kzRa21sec7MJHHUVxNEkYjFrQ8I/aiCxja5qqc=; b=mQ1tqaHLCNwG9I3Oj3G+/re7Nu
        hsF6m5VRnw9doczmn8cdjSBLI54KumZ83s4Z+vsgdklscqNrkxCDjryG6Ppf+X7NXz1+b+gq2w3/A
        9G2k0lu43KJeOjPYfe0JtZsknmQRG9KEWnzfiBCt7MbXNli1Y/K+1N/Cff+1JXONbh9oHSb9V6UKW
        HjbfADEYwEB3pYQ6sxuxy6JpCSVeRF60PrcBH3Dob+G3MfdniKNIJwag6ZiSCNU96smOUFyCaeAhz
        w7X4jFxArm6cvdH8prgrgLA4oyTJFUeUqCAJiDyuROLlGcMqjOAKK/2YbSC8TLpP+FySw3T0dgWEV
        CoRSW2Ig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34704)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oivoU-0008Fi-Vb; Thu, 13 Oct 2022 11:51:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oivoS-0004i9-6c; Thu, 13 Oct 2022 11:51:40 +0100
Date:   Thu, 13 Oct 2022 11:51:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
Message-ID: <Y0ftvEl3JAkYqkQ1@shell.armlinux.org.uk>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com>
 <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
 <1ab4c651-f0ab-1107-1784-ad255dabc33a@huawei.com>
 <CAMj1kXHn70rRaB=BgCrMoqQxRcq=HzZ0NWFYL+FqV_037PaY3w@mail.gmail.com>
 <c262c991-ad1e-81e6-4909-b8c4a1c036ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c262c991-ad1e-81e6-4909-b8c4a1c036ff@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:29:58AM +0800, Leizhen (ThunderTown) wrote:
> On 2022/10/10 19:06, Ard Biesheuvel wrote:
> > On Mon, 10 Oct 2022 at 12:58, Leizhen (ThunderTown)
> > <thunder.leizhen@huawei.com> wrote:
> >> On 2022/10/10 18:20, Ard Biesheuvel wrote:
> >>> On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>>>
> >>>> Fix the following warnings:
> >>>>  warning: incorrect type in initializer (different address spaces)
> >>>>     expected unsigned short [noderef] __user *register __p
> >>>>     got unsigned short [usertype] *
> >>>>  warning: cast removes address space '__user' of expression
> >>>>
> >>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>> ---
> >>>>  arch/arm/kernel/traps.c | 10 +++++-----
> >>>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> >>>> index 20b2db6dcd1ced7..34aa80c09c508c1 100644
> >>>> --- a/arch/arm/kernel/traps.c
> >>>> +++ b/arch/arm/kernel/traps.c
> >>>> @@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
> >>>>                         }
> >>>>                 } else {
> >>>>                         if (thumb)
> >>>> -                               bad = get_user(val, &((u16 *)addr)[i]);
> >>>> +                               bad = get_user(val, &((u16 __user *)addr)[i]);
> >>>>                         else
> >>>> -                               bad = get_user(val, &((u32 *)addr)[i]);
> >>>> +                               bad = get_user(val, &((u32 __user *)addr)[i]);
> >>>>                 }
> >>>>
> >>>>                 if (!bad)
> >>>> @@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
> >>>>         if (processor_mode(regs) == SVC_MODE) {
> >>>>  #ifdef CONFIG_THUMB2_KERNEL
> >>>>                 if (thumb_mode(regs)) {
> >>>> -                       instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> >>>> +                       instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);
> >>>
> >>> Shouldn't this be __user as well? (and below)
> >>
> >> unsigned int instr;
> >> void __user *pc;
> >>
> >> The __user can clear the warning, but a new warning will be generated.
> >>
> >> instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> >>       ^new                           ^old
> >>
> >> arch/arm/kernel/traps.c:473:33: warning: dereference of noderef expression
> >>
> > 
> > This is because dereferencing a __user pointer is not permitted.
> > 
> > So this code should be using get_kernel_nofault() here not a plain
> > dereference of PC. So better to fix that properly instead of papering
> > over it with a __force cast just to make sparse happy.
> 
> How about:
> @@ -451,9 +451,9 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
>  asmlinkage void do_undefinstr(struct pt_regs *regs)
>  {
>         unsigned int instr;
> -       void __user *pc;
> +       void *pc;
> 
> -       pc = (void __user *)instruction_pointer(regs);
> +       pc = (void *)instruction_pointer(regs);
> 
>         if (processor_mode(regs) == SVC_MODE) {
>  #ifdef CONFIG_THUMB2_KERNEL
> @@ -497,7 +497,7 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
>         }
>  #endif
>         arm_notify_die("Oops - undefined instruction", regs,
> -                      SIGILL, ILL_ILLOPC, pc, 0, 6);
> +                      SIGILL, ILL_ILLOPC, (void __user *)pc, 0, 6);
>  }
>  NOKPROBE_SYMBOL(do_undefinstr)
> 
> 
> The 'pc' may come from kernel or user. And I found that all the get_user()
> calls have already done type casts to the pc, except arm_notify_die().
> I think the above changes are reasonable.

If we're going to do that, lets do it properly - I think the above would
need some __force usage to stop sparse complaining, whereas I don't
think this will (untested):

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3f468ac98592..827cbc022900 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -449,36 +449,45 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 asmlinkage void do_undefinstr(struct pt_regs *regs)
 {
 	unsigned int instr;
-	void __user *pc;
+	unsigned long pc;
 
-	pc = (void __user *)instruction_pointer(regs);
+	pc = instruction_pointer(regs);
 
 	if (processor_mode(regs) == SVC_MODE) {
-#ifdef CONFIG_THUMB2_KERNEL
-		if (thumb_mode(regs)) {
-			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
+		if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && thumb_mode(regs)) {
+			u16 *tpc = (u16 *)pc;
+
+			instr = __mem_to_opcode_thumb16(tpc[0]);
 			if (is_wide_instruction(instr)) {
 				u16 inst2;
-				inst2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
+
+				inst2 = __mem_to_opcode_thumb16(tpc[1]);
 				instr = __opcode_thumb32_compose(instr, inst2);
 			}
-		} else
-#endif
-			instr = __mem_to_opcode_arm(*(u32 *) pc);
+		} else {
+			u32 *apc = (u32 *)pc;
+
+			instr = __mem_to_opcode_arm(*apc);
+		}
 	} else if (thumb_mode(regs)) {
-		if (get_user(instr, (u16 __user *)pc))
+		u16 __user *tpc = (u16 __user *)pc;
+
+		if (get_user(instr, tpc))
 			goto die_sig;
 		instr = __mem_to_opcode_thumb16(instr);
 		if (is_wide_instruction(instr)) {
 			unsigned int instr2;
-			if (get_user(instr2, (u16 __user *)pc+1))
+			if (get_user(instr2, tpc + 1))
 				goto die_sig;
 			instr2 = __mem_to_opcode_thumb16(instr2);
 			instr = __opcode_thumb32_compose(instr, instr2);
 		}
 	} else {
-		if (get_user(instr, (u32 __user *)pc))
+		u32 __user *apc = (u32 __user *)pc;
+
+		if (get_user(instr, apc))
 			goto die_sig;
+
 		instr = __mem_to_opcode_arm(instr);
 	}
 
@@ -495,7 +504,7 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 	}
 #endif
 	arm_notify_die("Oops - undefined instruction", regs,
-		       SIGILL, ILL_ILLOPC, pc, 0, 6);
+		       SIGILL, ILL_ILLOPC, (void __user *)pc, 0, 6);
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
