Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186B6E4D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjDQPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjDQPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:40:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74124976E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:40:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552f169d85eso12035247b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681746043; x=1684338043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=861p/mmeP8T3SiCwUxpewu/iS7xrVxg3F2DKk7EVi8c=;
        b=vvwCBTL53cBEQx7PhTlyquBOic72G5F32FJIl+IoAMOZ77d7Xj0GRhLwGkJ1Vk5mfE
         yQYUt4Ze6IWamyUOjghkGJ2v6lwx5uCRJcVFquJmwGoix6bIHfUigwmWm2qtsRjzQBuH
         rz2KtD5wiHsRHmT21rTsOwJ1jbPxIiatIIF3ZKpftMFLh2a/tXbb1PnJaiv3eWDuWeso
         n6UtzPPqbHcT1FOtKfvWTzH5q6osWBQ+mPI9HLlpL/GF50Em+xSU62RSuNx8+gN+baPx
         0JdnOlbC9dPlTJB2+0ipI2UHNRAnT1JHQZDM7Z2QNOZ//rwCjkP7NjmW+cSHk7ocavFg
         D4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746043; x=1684338043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=861p/mmeP8T3SiCwUxpewu/iS7xrVxg3F2DKk7EVi8c=;
        b=dVupyMGG5xBYhvK5ETN/FPkadvkU3tW4QSsbIJGqBTAYCwR1icS1MUYoZP3pj58roS
         /BcrMiI3Lrha/RctmVsU47qEDmALxDrgb70wfC76rOTXBBJEa9/+0DYbDZQorQOlaf8G
         UCq4rRiPy6LqypHntCb6bcSRYbDzQrFYA45cyhLI8qokIo0vt0u0SsmMoxr3SPLHP+68
         0uclseuwWZ/Nx9lPS3+dNCG27HXdFcX+R0Iu4tRIKpaZfcGwgewEPQpp+Sir/gyUnMDF
         xqz+8P5OrMBcgD94CJ96NBup7370ldeTH7aYYdOx6usU7eK5zWaFxtvkwLG++p+M9Xv9
         AOlg==
X-Gm-Message-State: AAQBX9cOjvzb58NsrH+ybcf1Tn74DDEv44L7kJp5/GBzY1gw3QacFdnz
        YCZicee7BN6gLHXCrTwRbOrPp3F9cPI=
X-Google-Smtp-Source: AKy350bnbpXqj2osNUQ0Zx7iijNlw+hTKOHjn3teb9i7T73pmJwEiRC/8/v8yXvZpKZy08RkGqXoAhGV9eI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e082:0:b0:b92:3917:d925 with SMTP id
 x124-20020a25e082000000b00b923917d925mr3370459ybg.8.1681746043706; Mon, 17
 Apr 2023 08:40:43 -0700 (PDT)
Date:   Mon, 17 Apr 2023 08:40:42 -0700
In-Reply-To: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
Message-ID: <ZD1oevE8iHsi66T2@google.com>
Subject: Rename restrictedmem => guardedmem? (was: Re: [PATCH v10 0/9] KVM:
 mm: fd-based approach for supporting KVM)
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, Michael Roth <michael.roth@amd.com>,
        wei.w.wang@intel.com, Mike Rapoport <rppt@kernel.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What do y'all think about renaming "restrictedmem" to "guardedmem"?

I want to start referring to the code/patches by its syscall/implementation name
instead of "UPM", as "UPM" is (a) very KVM centric, (b) refers to the broader effort
and not just the non-KVM code, and (c) will likely be confusing for future reviewers
since there's nothing in the code that mentions "UPM" in any way.

But typing out restrictedmem is quite tedious, and git grep shows that "rmem" is
already used to refer to "reserved memory".

Renaming the syscall to "guardedmem"...

  1. Allows for a shorthand and namespace, "gmem", that isn't already in use by
     the kernel (see "reserved memory above").
 
  2. Provides a stronger hint as to its purpose.  "Restricted" conveys that the
     allocated memory is limited in some way, but doesn't capture how the memory
     is restricted, e.g. "restricted" could just as easily mean that the allocation
     can be restricted to certain types of backing stores or something.  "Guarded"
     on the other hand captures that the memory has extra defenses of some form.

  3. Is shorter to type and speak.  Work smart, not hard :-)

  4. Isn't totally wrong for the KVM use case if someone assumes the "g" means
     "guest" when reading mail and whatnot.


P.S. I trimmed the Cc/To substantially for this particular discussion to avoid
     spamming folks that don't (yet) care about this stuff with another potentially
     lengthy thread.  Feel free to add (back) any people/lists.
