Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C360B8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiJXT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiJXT6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB391C77EA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:20:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g16so6121146qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lyjygEykNR38OJ1vTgQGVI0X1UOFmz3Ob64cgtLHzdw=;
        b=e/9jbHwPGLh0hMQ8MF6PTxemLy/kRsNfMrpU1PkHWaCSIwQBdSc6z3kfgHN63d7HHt
         TYL4MAHWpMtARvyuj1qiBYTdcYLmOxYuDJ8Yn+/aYlVaq0VEx9lA9Cg7cZU5v3ipr+Bt
         4YF3LqitSvQ1lJS2b3ZCyJ816BslpLLoIMeSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyjygEykNR38OJ1vTgQGVI0X1UOFmz3Ob64cgtLHzdw=;
        b=yqrJobmSa7tXdDLqM0vhJBD/3IKvdXxoIELz+zHwioeGe8P9/tIDEl9kJWnA1MsX/F
         X9TufdBfHf5/nIAn9kwAlxE8MJOo3/0Pdsa9YFoRj8gKeTFPEnA1kYbjU+qmn2lTshYq
         wWqtF3Kg+pvcCXc+vWAOk8STTXLFI1nirpPz6bcbcdrk7j6VkiXjg9l5WYzysfPdC0fT
         ShCSgI171AodD6YTcXP5vnKVLzl1d9E+dCMfpmiv4Cw0BT44J1NhA2Tjtf0j9ORydRxe
         bHQsvO+mbM1d3lvAlTCGWsGYV9FFAXgtr48KNRRcOPQiYrH8TzeWNBcaGUkWAdmPTDCj
         0uqA==
X-Gm-Message-State: ACrzQf2L/zEEJid8nbhGXIKXryarCqzRbjO8T/H3KAyJmL7wgC8+p3/X
        8OFQK1GfhsoYLDtffc9XlK8EsQ5Z5MwGxQ==
X-Google-Smtp-Source: AMsMyM5MhhCNf+sMSyRhizp5SMVfw9Rd+dBifZjJDXhvb3uL9EoxB8JSvdozn94Fprovo2m+taFr/A==
X-Received: by 2002:a05:622a:d4:b0:39c:c755:45bd with SMTP id p20-20020a05622a00d400b0039cc75545bdmr27916439qtw.112.1666635588515;
        Mon, 24 Oct 2022 11:19:48 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id z3-20020ac875c3000000b0039c37a7914csm326997qtq.23.2022.10.24.11.19.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:19:47 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id t186so11896295yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:19:47 -0700 (PDT)
X-Received: by 2002:a25:84cf:0:b0:6b3:c0c3:19d8 with SMTP id
 x15-20020a2584cf000000b006b3c0c319d8mr28320822ybm.349.1666635587201; Mon, 24
 Oct 2022 11:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221024114536.44686c83@gandalf.local.home>
In-Reply-To: <20221024114536.44686c83@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 11:19:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
Message-ID: <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
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

On Mon, Oct 24, 2022 at 8:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Adding on the kernel command line "ftrace=function" triggered:
>
> CPA detected W^X violation: 8000000000000063 -> 0000000000000063 range:

Hmm.

The cause of this actually seems to be this

        if (likely(system_state != SYSTEM_BOOTING))
                set_memory_ro((unsigned long)trampoline, npages);
        set_memory_x((unsigned long)trampoline, npages);
        return (unsigned long)trampoline;

in create_trampoline().

And that in turn is because of commit 59566b0b622e ("x86/ftrace: Have
ftrace trampolines turn read-only at the end of system boot up"),
which in turn is because of


        if (unlikely(system_state == SYSTEM_BOOTING)) {
                text_poke_early(addr, opcode, len);
                return;
        }

in text_poke_bp(). And that, in turn, is because PeterZ ended up
special-casing this all in commit 768ae4406a5c ("x86/ftrace: Use
text_poke()")

Maybe we should just strive to get rid of all these SYSTEM_BOOTING
special cases, instead of adding yet another a new one.

There's presumably "it slows down boot" reason to avoid the full
text_poke_bp() dance, but do we really care for the "ftrace=function"
case?

                  Linus
