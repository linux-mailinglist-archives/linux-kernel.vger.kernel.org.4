Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9965F3C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJDFBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDFBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:01:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8341F62F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 22:01:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v186so12198563pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=YCIEsQmqe2GU/op8ELVIz10eFCT8qx7jrOh827aE4ak=;
        b=fdSA9xmIbaXZOFK29VojFiNPE/Ng3cLgMgO04lzffde9cZ0Aj70ulu+cOZLSn4HMID
         ZcBnoO4BZD2KT85KEtfcmtPUO7G4u94DJbCG9gFWmQE4pvn0lIL6/Lc9NZX3JtjxD3+c
         pQ6fyzv5HBKm5oOgaBDxztjBkP/mkKSY/Ry5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YCIEsQmqe2GU/op8ELVIz10eFCT8qx7jrOh827aE4ak=;
        b=YqScTz5dP3cWNKYdcL8cBf12rDwKbKboK2RZxqiu5CdmCwoC+Lux8F/mu2qgH9oNfW
         bDmd2cmSROv3pn1PZhs3uDFbL0JTdTAh53ia3UNl3QHMFiYi/GGJ2/gqu5/NZRmf2eSY
         7x6cdtCcayoFNpN+bSbEN2z6Q/4BMXNS+gKATxbrdedyyhcX5vrKBHfUGZmREFYFDYTZ
         lN5CTfCo1i4jWId2opMJlZ7XSv8KO67OnDCPdvd/0a4Mf1gBeglXnE1k/Nozfc7Dg/U/
         mXMsEg9CtA5gm9RXyEwx6/IJnZ09NdsB/R/0CuiHmXIHDMIQPJb2BkNKWILZj6wqGmWz
         qEbA==
X-Gm-Message-State: ACrzQf3iPy+w2sVfpZSPGGn4rSelhLqBC6rldYTR/M5dLO/5iEHlSTB1
        wduqHCADnzEE1QaAUOxoHVghug==
X-Google-Smtp-Source: AMsMyM5PzL11modUqno6f/hvls5hZpn+KK4uhST+ROirabQr+EJiNbMAuTappoTzvGAyPi9jEbjxMQ==
X-Received: by 2002:a63:da12:0:b0:43a:18ce:f959 with SMTP id c18-20020a63da12000000b0043a18cef959mr21506613pgh.386.1664859669373;
        Mon, 03 Oct 2022 22:01:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y83-20020a626456000000b005386b58c8a3sm5814207pfb.100.2022.10.03.22.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 22:01:08 -0700 (PDT)
Date:   Mon, 3 Oct 2022 22:01:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 00/39] Shadowstacks for userspace
Message-ID: <202210032158.CE0941C4D@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <202210030946.CB90B94C11@keescook>
 <CAG48ez2TGdwcr-jUPm1EL1D6X2a-wbx+gXLZUq46qxO-FTctHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2TGdwcr-jUPm1EL1D6X2a-wbx+gXLZUq46qxO-FTctHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 07:25:03PM +0200, Jann Horn wrote:
> On Mon, Oct 3, 2022 at 7:04 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 29, 2022 at 03:28:57PM -0700, Rick Edgecombe wrote:
> > > This is an overdue followup to the “Shadow stacks for userspace” CET series.
> > > Thanks for all the comments on the first version [0]. They drove a decent
> > > amount of changes for v2. Since it has been awhile, I’ll try to summarize the
> > > areas that got major changes since last time. Smaller changes are listed in
> > > each patch.
> >
> > Thanks for the write-up!
> >
> > > [...]
> > >         GUP
> > >         ---
> > >         Shadow stack memory is generally treated as writable by the kernel, but
> > >         it behaves differently then other writable memory with respect to GUP.
> > >         FOLL_WRITE will not GUP shadow stack memory unless FOLL_FORCE is also
> > >         set. Shadow stack memory is writable from the perspective of being
> > >         changeable by userspace, but it is also protected memory from
> > >         userspace’s perspective. So preventing it from being writable via
> > >         FOLL_WRITE help’s make it harder for userspace to arbitrarily write to
> > >         it. However, like read-only memory, FOLL_FORCE can still write through
> > >         it. This means shadow stacks can be written to via things like
> > >         “/proc/self/mem”. Apps that want extra security will have to prevent
> > >         access to kernel features that can write with FOLL_FORCE.
> >
> > This seems like a problem to me -- the point of SS is that there cannot be
> > a way to write to them without specific instruction sequences. The fact
> > that /proc/self/mem bypasses memory protections was an old design mistake
> > that keeps leading to surprising behaviors. It would be much nicer to
> > draw the line somewhere and just say that FOLL_FORCE doesn't work on
> > VM_SHADOW_STACK. Why must FOLL_FORCE be allowed to write to SS?
> 
> But once you have FOLL_FORCE, you can also just write over stuff like
> executable code instead of writing over the stack. I don't think
> allowing FOLL_FORCE writes over shadow stacks from /proc/$pid/mem is
> making things worse in any way, and it's probably helpful for stuff
> like debuggers.
> 
> If you don't want /proc/$pid/mem to be able to do stuff like that,
> then IMO the way to go is to change when /proc/$pid/mem uses
> FOLL_FORCE, or to limit overall write access to /proc/$pid/mem.

Yeah, all reasonable. I just wish we could ditch FOLL_FORCE; it continues
to weird me out how powerful that fd's side-effects are.

-- 
Kees Cook
