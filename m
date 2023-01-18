Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6AA67245C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjARRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjARRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:01:23 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AD45BDA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:01:22 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15f64f2791dso5829088fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJBZdN4kSLIlLl8kPVsTumsNteLxan9/Bu7rB/h9NIk=;
        b=ecAOyczQCTbiITKL2h/jHtACGOR0iJ2EQF7lthUuPAgymOdRLiYelJAF++vP6TGAOc
         MXa0wIhKP64NJxuPY6hUpfJY50pLqfUviyFQgxwmkZDdvvVY7y4piI+iuclZDGar5zvO
         hxbZlC4EfpSx2dm9/weoMEVNjOuSothO2LjCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJBZdN4kSLIlLl8kPVsTumsNteLxan9/Bu7rB/h9NIk=;
        b=aQc9l873VsdIzVrpqk1L1DizIDOrxJ1SDYICWxd4OgbwJ9XbBjfwK7Vfro66B54MMz
         okzs13VHMdeDzAdf0vfrEUjlvCCcaEfJGYMES0py2NloA933OUdyp2K/e2EvAujoSVNM
         crocyhEmNr5eI4qcDJoTkjOO2j9h+eMHvWrBGHjhplgy7KqORbZ4g/wHYQLwfXQh8H8x
         Eteq9i/l69FvcH9akmVReLPa7nuGMaO6g8sdsGFpgPqRrFQ3CJFjQztsqPo1WmWcikL0
         RmqrzeSsQUcvhzsdW51xaPXDsbb7ymCX3tn8JY92ZI6srJRvu8XRVnsoZ1iWQvJAKG7c
         tpEQ==
X-Gm-Message-State: AFqh2krchPZ0p0AJ8tV9QPW+0wzC7CnbwOU2qzr2pkqnFgjEt7WgL/yh
        Wxd4ZAj2T9zO7ZNchIKynhxkRPhxfFpjNbzy
X-Google-Smtp-Source: AMrXdXums2QA/bUwPK7TpSTwP9ELAXyhEFonaJZ14pVVsbRfYrjPfCGe6TopbYTi0oBuuxxM27/CdA==
X-Received: by 2002:a05:6870:3b0f:b0:15f:9ab4:a308 with SMTP id gh15-20020a0568703b0f00b0015f9ab4a308mr162452oab.7.1674061281153;
        Wed, 18 Jan 2023 09:01:21 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b007054feab4aesm22506939qki.27.2023.01.18.09.01.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:01:20 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id d13so24157279qvj.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:01:20 -0800 (PST)
X-Received: by 2002:a05:6214:5f82:b0:534:252f:b091 with SMTP id
 ls2-20020a0562145f8200b00534252fb091mr343909qvb.130.1674061280149; Wed, 18
 Jan 2023 09:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-2-kirill.shutemov@linux.intel.com> <Y8gVJUDEFE5U7xAq@hirez.programming.kicks-ass.net>
 <CAHk-=wj4PDt_73n5rG9obkXrRQFcxN8vUhG6T9DipxozybH9_w@mail.gmail.com> <Y8gi+/Y0qcjtRf6m@hirez.programming.kicks-ass.net>
In-Reply-To: <Y8gi+/Y0qcjtRf6m@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jan 2023 09:01:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjtUnjYSttxsYtXu2VtsTeBjoaL8Je8cjWqFMJzw1-MhQ@mail.gmail.com>
Message-ID: <CAHk-=wjtUnjYSttxsYtXu2VtsTeBjoaL8Je8cjWqFMJzw1-MhQ@mail.gmail.com>
Subject: Re: [PATCHv14 01/17] x86/mm: Rework address range check in get_user()
 and put_user()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 8:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > We'll still return -EFAULT, of course, we're just getting rid of the
> >
> >         WARN_ONCE(trapnr == X86_TRAP_GP,
> >                 "General protection fault in user access.
> > Non-canonical address?");
> >
> > issue that comes from not being so exact about the address limit any more.
>
> Ah indeed, so for !LAM we'd now print the message were we would not
> before (the whole TASK_SIZE_MAX+ range).

Yeah.

We could just remove that warning entirely, but it has been useful for
syzbot catching random user addresses that weren't caught by
"access_ok()" when people did bad bad things (ie using the
non-checking "__copy_from_user()" and friends).

I'm not sure how much that warning is worth any more - and for
get_user() and put_user() itself it buys us nothing, since by
definition _those_ do the range checking. Christoph getting rid of the
set_fs() model simplified a lot of our user address checking.

But I think it's easier to just keep that existing warning about "how
did you get a non-canonical address here" for other user accesses, and
just make get/put_user() use that _ASM_EXTABLE() version that doesn't
do it.

               Linus
