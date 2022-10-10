Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094295FA1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJJQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJJQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:18:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86CB5C37F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ahQ+98OF54Kz7CPYTtQaC2pDJITFFBkkmpWlqrKppU8=; b=WgaEd+Du5L9THoK0ff07avq0Vo
        RBL5BjmiJQI/jpx2btFYE1qY6mVm4kcfQxQTR982Oko7tdLS8pHlcXdXG42GxDcKxsWJE+9kMARv4
        atu05I6qQDbM6YIgTSw7i4Q7vriDRpCv/tqFtPQ50pKaLsGQKAVdGrfPM/rTNJ6K7wi4MAPjmUnmn
        /FfGKkUBOZrs8JAdTRFUw63JZKBhwBbcAHAzeeNc1W01puxST/qtjwGBwp+/7f2bfmzGsdU4adrR2
        RBPBTInxYzfpIQNx4lRk6RXtccKwRHS2oc6p0JyoGgRQO3olLAQynaPh09r8j6+IQasx4QVGdqQWg
        DDv/zdgw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34670)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ohvTX-0004sb-W0; Mon, 10 Oct 2022 17:17:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ohvTX-0001zA-DM; Mon, 10 Oct 2022 17:17:55 +0100
Date:   Mon, 10 Oct 2022 17:17:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
Message-ID: <Y0RFs6ltJRGWEKZw@shell.armlinux.org.uk>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
 <20221010095346.1957-2-thunder.leizhen@huawei.com>
 <CAMj1kXHOv23JY35fZ45k=Pzi=ROd6BOCxqPkfXLh2520qhoFzQ@mail.gmail.com>
 <1ab4c651-f0ab-1107-1784-ad255dabc33a@huawei.com>
 <CAMj1kXHn70rRaB=BgCrMoqQxRcq=HzZ0NWFYL+FqV_037PaY3w@mail.gmail.com>
 <Y0RDblEkJ0h+DfCB@shell.armlinux.org.uk>
 <CAMj1kXG8ZCQG-Vk1mNwmLX2emUUFqs5b8SWxz26L7FUF5Sjx0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG8ZCQG-Vk1mNwmLX2emUUFqs5b8SWxz26L7FUF5Sjx0A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 06:14:56PM +0200, Ard Biesheuvel wrote:
> On Mon, 10 Oct 2022 at 18:08, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Oct 10, 2022 at 01:06:19PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 10 Oct 2022 at 12:58, Leizhen (ThunderTown)
> > > <thunder.leizhen@huawei.com> wrote:
> > > >
> > > >
> > > >
> > > > On 2022/10/10 18:20, Ard Biesheuvel wrote:
> > > > > On Mon, 10 Oct 2022 at 11:56, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > > > >>
> > > > >> Fix the following warnings:
> > > > >>  warning: incorrect type in initializer (different address spaces)
> > > > >>     expected unsigned short [noderef] __user *register __p
> > > > >>     got unsigned short [usertype] *
> > > > >>  warning: cast removes address space '__user' of expression
> > > > >>
> > > > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > > >> ---
> > > > >>  arch/arm/kernel/traps.c | 10 +++++-----
> > > > >>  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >>
> > > > >> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> > > > >> index 20b2db6dcd1ced7..34aa80c09c508c1 100644
> > > > >> --- a/arch/arm/kernel/traps.c
> > > > >> +++ b/arch/arm/kernel/traps.c
> > > > >> @@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
> > > > >>                         }
> > > > >>                 } else {
> > > > >>                         if (thumb)
> > > > >> -                               bad = get_user(val, &((u16 *)addr)[i]);
> > > > >> +                               bad = get_user(val, &((u16 __user *)addr)[i]);
> > > > >>                         else
> > > > >> -                               bad = get_user(val, &((u32 *)addr)[i]);
> > > > >> +                               bad = get_user(val, &((u32 __user *)addr)[i]);
> > > > >>                 }
> > > > >>
> > > > >>                 if (!bad)
> > > > >> @@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
> > > > >>         if (processor_mode(regs) == SVC_MODE) {
> > > > >>  #ifdef CONFIG_THUMB2_KERNEL
> > > > >>                 if (thumb_mode(regs)) {
> > > > >> -                       instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> > > > >> +                       instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);
> > > > >
> > > > > Shouldn't this be __user as well? (and below)
> > > >
> > > > unsigned int instr;
> > > > void __user *pc;
> > > >
> > > > The __user can clear the warning, but a new warning will be generated.
> > > >
> > > > instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
> > > >       ^new                           ^old
> > > >
> > > > arch/arm/kernel/traps.c:473:33: warning: dereference of noderef expression
> > > >
> > >
> > > This is because dereferencing a __user pointer is not permitted.
> > >
> > > So this code should be using get_kernel_nofault() here not a plain
> > > dereference of PC. So better to fix that properly instead of papering
> > > over it with a __force cast just to make sparse happy.
> >
> > Why? We won't get here unless the PC can be dereferenced. If it's not
> > able to be dereferenced, then we'd be dealing with a prefetch abort.
> >
> 
> If that is guaranteed (i.e., there is no way we might be racing with a
> module unload on another CPU or something like that), then I agree
> that dereferencing PC is fine.

If we get here for an instruction in a module that's being unloaded, we
have way bigger problems. We shouldn't be executing code in a module
being unloaded in the first place. That becomes a case of "deserves to
oops".

The more likely case would be a prefetch abort when the page is
unmapped. You'd have to try pretty hard to get an undef to race with
a module unload.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
