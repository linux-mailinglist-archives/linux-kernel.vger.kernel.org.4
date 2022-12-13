Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5572F64B631
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiLMN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiLMN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:29:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB75C2;
        Tue, 13 Dec 2022 05:29:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDD0F1F8B4;
        Tue, 13 Dec 2022 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670938175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hyr4c+SKac14wkta1jaSfJl4YQdl4MmgZCTJffcE5qg=;
        b=ITNcM/OPJCUsyRzFdas/Pg/f0lW4KGl5uuFBgsWNjbWdKHS0k/RIR21Se6GDKWu9DRrWEh
        UwNhLpsGVMgrtk8DLrh/z2yIlafJRG1MESQxDTCP3PWLfUEIed0qzwv4ueMPEkVjACwiJA
        mpdm+p2jF/AWUfeTzYoYM2RFWqB28Xk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 13C4B2C141;
        Tue, 13 Dec 2022 13:29:34 +0000 (UTC)
Date:   Tue, 13 Dec 2022 14:29:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Song Liu <song@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        x86@kernel.org, joe.lawrence@redhat.com,
        linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc-part: was: Re: [PATCH v6] livepatch: Clear relocation
 targets on a module removal
Message-ID: <Y5h+PX6a1a9yjQPp@alley>
References: <20220901171252.2148348-1-song@kernel.org>
 <Y3expGRt4cPoZgHL@alley>
 <CAPhsuW4qYpX7wzHn5J5Hn9cnOFSZwwQPCjTM_HPTt_zbBS03ww@mail.gmail.com>
 <Y5Me5dTGv+GznvtO@alley>
 <CAPhsuW4pt7vfHTj8KorTRCx5zJaoUiyYUOLy8uXZDbTbur4RRA@mail.gmail.com>
 <Y5dg25LV24mBRf4t@alley>
 <CAPhsuW7y1GzT8+quk4vJEqM6SagqDqc=HXA3jtdmfTfC=Gsv-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7y1GzT8+quk4vJEqM6SagqDqc=HXA3jtdmfTfC=Gsv-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-12-13 00:13:46, Song Liu wrote:
> )() ()On Mon, Dec 12, 2022 at 9:12 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Fri 2022-12-09 11:59:35, Song Liu wrote:
> > > On Fri, Dec 9, 2022 at 3:41 AM Petr Mladek <pmladek@suse.com> wrote:
> > > > On Mon 2022-11-28 17:57:06, Song Liu wrote:
> > > > > On Fri, Nov 18, 2022 at 8:24 AM Petr Mladek <pmladek@suse.com> wrote:
> > > > > >
> > > > > > > --- a/arch/powerpc/kernel/module_64.c
> > > > > > > +++ b/arch/powerpc/kernel/module_64.c
> > > > > > > +#ifdef CONFIG_LIVEPATCH
> > > > > > > +void clear_relocate_add(Elf64_Shdr *sechdrs,
> > > > > > > +                    const char *strtab,
> > > > > > > +                    unsigned int symindex,
> > > > > > > +                    unsigned int relsec,
> > > > > > > +                    struct module *me)
> > > > > > > +{
> >
> > [...]
> >
> > > > > > > +
> > > > > > > +             instruction = (u32 *)location;
> > > > > > > +             if (is_mprofile_ftrace_call(symname))
> > > > > > > +                     continue;
> > > >
> > > > Why do we ignore these symbols?
> > > >
> > > > I can't find any counter-part in apply_relocate_add(). It looks super
> > > > tricky. It would deserve a comment.
> > > >
> > > > And I have no idea how we could maintain these exceptions.
> > > >
> > > > > > > +             if (!instr_is_relative_link_branch(ppc_inst(*instruction)))
> > > > > > > +                     continue;
> > > >
> > > > Same here. It looks super tricky and there is no explanation.
> > >
> > > The two checks are from restore_r2(). But I cannot really remember
> > > why we needed them. It is probably an updated version from an earlier
> > > version (3 year earlier..).
> >
> > This is a good sign that it has to be explained in a comment.
> > Or even better, it should not by copy pasted.
> >
> > > > > > > +             instruction += 1;
> > > > > > > +             patch_instruction(instruction, ppc_inst(PPC_RAW_NOP()));
> >
> > I believe that this is not enough. apply_relocate_add() does this:
> >
> > int apply_relocate_add(Elf64_Shdr *sechdrs,
> > [...]
> >                        struct module *me)
> > {
> > [...]
> >                 case R_PPC_REL24:
> >                         /* FIXME: Handle weak symbols here --RR */
> >                         if (sym->st_shndx == SHN_UNDEF ||
> >                             sym->st_shndx == SHN_LIVEPATCH) {
> > [...]
> >                         if (!restore_r2(strtab + sym->st_name,
> >                                                         (u32 *)location + 1, me))
> > [...]                                   return -ENOEXEC;
> >
> > --->                    if (patch_instruction((u32 *)location, ppc_inst(value)))
> >                                 return -EFAULT;
> >
> > , where restore_r2() does:
> >
> > static int restore_r2(const char *name, u32 *instruction, struct module *me)
> > {
> > [...]
> >         /* ld r2,R2_STACK_OFFSET(r1) */
> > --->    if (patch_instruction(instruction, ppc_inst(PPC_INST_LD_TOC)))
> >                 return 0;
> > [...]
> > }
> >
> > By other words, apply_relocate_add() modifies two instructions:
> >
> >    + patch_instruction() called in restore_r2() writes into "location + 1"
> >    + patch_instruction() called in apply_relocate_add() writes into "location"
> >
> > IMHO, we have to clear both.
> >
> > IMHO, we need to implement a function that reverts the changes done
> > in restore_r2(). Also we need to revert the changes done in
> > apply_relocate_add().
> 
> I finally got time to read all the details again and recalled what
> happened with the code.
> 
> The failure happens when we
> 1) call apply_relocate_add() on klp load (or module first load,
>    if klp was loaded first);
> 2) do nothing when the module is unloaded;
> 3) call apply_relocate_add() on module reload, which failed.
> 
> The failure happens at this check in restore_r2():
> 
>         if (*instruction != PPC_RAW_NOP()) {
>                 pr_err("%s: Expected nop after call, got %08x at %pS\n",
>                         me->name, *instruction, instruction);
>                 return 0;
>         }
> 
> Therefore, apply_relocate_add only fails when "location + 1"
> is not NOP. And to make it not fail, we only need to write NOP to
> "location + 1" in clear_relocate_add().

Yes, this should be enough to pass the existing check.

> IIUC, you want clear_relocate_add() to undo everything we did
> in apply_relocate_add(); while I was writing clear_relocate_add()
> to make the next apply_relocate_add() not fail.
> 
> I agree that, based on the name, clear_relocate_add() should
> undo everything by apply_relocate_add(). But I am not sure how
> to handle some cases. For example, how do we undo
> 
>                 case R_PPC64_ADDR32:
>                         /* Simply set it */
>                         *(u32 *)location = value;
>                        break;
>
> Shall we just write zeros? I don't think this matters.

I guess that it would be zeros as we do in x86_64.


> I think this is the question we should answer first:
> What shall clear_relocate_add() do?
> 1) undo everything by apply_relocate_add();
> 2) only do things needed to make the next
>    apply_relocate_add succeed;
> 3) something between 1) and 2).

Good question.

Hmm, the commit a443bf6e8a7674b86221f49 ("powerpc/modules: Add REL24
relocation support of livepatch symbols") suggests that all symbols
in the section SHN_LIVEPATCH have the type R_PPC_REL24. AFAIK, the
kernel livepatches are the only user of the clear_relocate_add()
feature.

If the above is correct then it might be enough to clear only
R_PPC_REL24 type. And it might be enough to warn when clear_relocate_add()
is called for another type so that we know when the relocations
were not cleared properly.

Good question.  We might need some input from people familiar
with the architecture and creating the livepatches.

Best Regards,
Petr
