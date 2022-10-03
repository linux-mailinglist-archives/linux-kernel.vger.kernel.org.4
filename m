Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360715F3418
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJCREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJCREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:04:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5553B9B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:04:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q9so10161307pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=uQT4qnLKBJikzcGjZm0d2fhOOnumfYfnoU0Yf3hAnto=;
        b=KgKRpsNOzDQo80mo5n0UyA5HhDsXGXEctzVNgWtOidt+imVFWTZICu5gf8hdzG4IUA
         JY5jekbBlx1dl9djltqFs8u0VKvc4x76knyN34QdjpYOhhctoO/0gVxKQ8ZaHe2iq6HL
         D0Ikw0jBcyBtqc76lp91g1Hiu7upW4YVqAI4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uQT4qnLKBJikzcGjZm0d2fhOOnumfYfnoU0Yf3hAnto=;
        b=7rF/fNd3sGh+XTeeNEEnnnQ5ivzTAXy7yWk1J0KKPelqfRJTzA7wdmHTdBJJNrhsU+
         KB5i5dVowkVR8qoRe7bGSMoGHsOQ3wazhdMuJJkkmrMMinLez4wVMxs71hUOoVyGlkU3
         gySAJKylAyjV/yZRfi/+OOFDkSSv0zssC46lxjdAw6aBaA3jQXxNzSHc6IfhUgFoTAnf
         QPD0PXedcTndvZGb+wlnyavscBT/GUCa+GEnjppnZuf1vTt96EoGBaIaBH6iCYKBkI3F
         AsjnOEA+9V1kyjqYmfIcOZCbtri3EIS/IAMbfzis+1lCn9BdcF5oJ0M2axTAVOdIMbhh
         SQ4A==
X-Gm-Message-State: ACrzQf0Nih2li08t+V7qHB/LQVRMgsH32F3ATioNoBjfGOmLEyyMp6kR
        n1zBTyIjWnZzKsw2Y6ZhUQirGQ==
X-Google-Smtp-Source: AMsMyM57eSSs465fKo/PIMCHt9O/y/zY3vmojOi8BFL8tAd04lj7nGKBQe3q5nr5qg+YdWb+SzoCtw==
X-Received: by 2002:a05:6a00:2289:b0:546:8fef:1bec with SMTP id f9-20020a056a00228900b005468fef1becmr23795216pfe.17.1664816675840;
        Mon, 03 Oct 2022 10:04:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w35-20020a17090a6ba600b0020ab9b18896sm1192934pjj.42.2022.10.03.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:04:35 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:04:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
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
Message-ID: <202210030946.CB90B94C11@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:28:57PM -0700, Rick Edgecombe wrote:
> This is an overdue followup to the “Shadow stacks for userspace” CET series. 
> Thanks for all the comments on the first version [0]. They drove a decent 
> amount of changes for v2. Since it has been awhile, I’ll try to summarize the 
> areas that got major changes since last time. Smaller changes are listed in 
> each patch.

Thanks for the write-up!

> [...]
>         GUP
>         ---
>         Shadow stack memory is generally treated as writable by the kernel, but
>         it behaves differently then other writable memory with respect to GUP.
>         FOLL_WRITE will not GUP shadow stack memory unless FOLL_FORCE is also
>         set. Shadow stack memory is writable from the perspective of being
>         changeable by userspace, but it is also protected memory from
>         userspace’s perspective. So preventing it from being writable via
>         FOLL_WRITE help’s make it harder for userspace to arbitrarily write to
>         it. However, like read-only memory, FOLL_FORCE can still write through
>         it. This means shadow stacks can be written to via things like
>         “/proc/self/mem”. Apps that want extra security will have to prevent
>         access to kernel features that can write with FOLL_FORCE.

This seems like a problem to me -- the point of SS is that there cannot be
a way to write to them without specific instruction sequences. The fact
that /proc/self/mem bypasses memory protections was an old design mistake
that keeps leading to surprising behaviors. It would be much nicer to
draw the line somewhere and just say that FOLL_FORCE doesn't work on
VM_SHADOW_STACK. Why must FOLL_FORCE be allowed to write to SS?

> [...]
> Shadow stack signal format
> --------------------------
> So to handle alt shadow stacks we need to push some data onto a stack. To 
> prevent SROP we need to push something to the shadow stack that the kernel can 
> [...]
> shadow stack return address or a shadow stack tokens. To make sure it can’t be 
> used, data is pushed with the high bit (bit 63) set. This bit is a linear 
> address bit in both the token format and a normal return address, so it should 
> not conflict with anything. It puts any return address in the kernel half of 
> the address space, so would never be created naturally by a userspace program. 
> It will not be a valid restore token either, as the kernel address will never 
> be pointing to the previous frame in the shadow stack.
> 
> When a signal hits, the format pushed to the stack that is handling the signal 
> is four 8 byte values (since we are 64 bit only):
> |1...old SSP|1...alt stack size|1...alt stack base|0|

Do these end up being non-canonical addresses? (To avoid confusion with
"real" kernel addresses?)

-Kees

-- 
Kees Cook
