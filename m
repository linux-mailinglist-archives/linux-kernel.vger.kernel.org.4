Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C665FF2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAFKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:52:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB16DB99
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 02:52:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja17so795987wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 02:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsrOkMbC1Z1O5kGw1nU71wHaEmGZyQomQsNoKLM36G8=;
        b=qwnY2xYWk1JPIKmOCc9T02G+Hm6dipqWvFp40fsfAkMNv+79HI5cLu+icGNU3dK9Dd
         O1UICrtiS4VPRQt1IfywpZ1MRu4L8Tq9etKtfEvfvOGM/weNfCXX+2AZ/Ub1Tc1tnK0/
         iEeTOodxlX9eABvLOw1bcWn+9P89/rLXU0yt2qeqUGlm0YKkru8N1zUVex4KaqbqYPxT
         Dkq8AZnWFk4XE15NL8tWLQ2Fx5XZBhDl8vfT6zk2RWX/B9bq/Wu85awfpGYfkQbjS7JX
         BhY9Csvwvd2f0ypDfPBwYbbigJVl4tb37NvNfe06o6QbcxefyInzrXUuDc4s/230etMZ
         RzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsrOkMbC1Z1O5kGw1nU71wHaEmGZyQomQsNoKLM36G8=;
        b=tS34FZzYeNmYZvM9TRsV3W9KBQH/FNhvpcJ12vUmE0u8gmQkaT8kCiMkJmREVZ6CzZ
         ap5Uj4fh6oWeVF+0C25OZ+AUE8SOH2uFFF5XPe7TiCu9hRkfE1iCRMh07aLVv9q51TXg
         rxAsgLVxANF++Ecg2/wQXZMY5WTzMrEPExQQVoztbUhSF/SR4vbE3zS7/RPoLKcW2sCQ
         v+qwvhIr6jsLRl7niv7TgklwU4Tbg3+0LUzh39U3rJqIbsxi7Vkal3dUUwDqOYfQy1Tf
         0syOXnBiB08ZDRV57I99f1/jyPOEqd/SvgseVejeJ+E16Pa9pdnt8ie5DafCZOcm+iL2
         omCw==
X-Gm-Message-State: AFqh2krexFFdyICS7C3Ze9zTMWAhuR4fRAzlRHlRgFqubiWKCenMLXGk
        mGGJnh2jrRUKLGQ/5dO0D4k=
X-Google-Smtp-Source: AMrXdXuC9UC2xpv7kZMYI3toZ35eytqgJ4OUOXYpWI1rJE8QawgnywWd+LjnXv08utMuuV/4+krDaA==
X-Received: by 2002:a05:600c:42d5:b0:3d6:e790:c9a0 with SMTP id j21-20020a05600c42d500b003d6e790c9a0mr47082900wme.10.1673002347631;
        Fri, 06 Jan 2023 02:52:27 -0800 (PST)
Received: from gmail.com ([31.46.243.128])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003d1f3e9df3csm6295642wmo.7.2023.01.06.02.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:52:26 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Jan 2023 11:52:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jacky Li <jackyli@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Orr <marcorr@google.com>,
        Alper Gun <alpergun@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/mm/cpa: get rid of the cpa lock
Message-ID: <Y7f9ZuPcIMk37KnN@gmail.com>
References: <20221222013330.831474-1-jackyli@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221222013330.831474-1-jackyli@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jacky Li <jackyli@google.com> wrote:

> It’s true that with such old code, the cpa_lock might protect more
> race conditions than those that it was introduced to protect in 2008,
> or some old hardware may depend on the cpa_lock for undocumented
> behavior. So removing the lock directly might not be a good idea, but
> it probably should not mean that we need to keep the inefficient code
> forever. I would appreciate any suggestion to navigate this lock
> removal from the folks on the to and cc list.

> -/*
> - * Serialize cpa() (for !DEBUG_PAGEALLOC which uses large identity mappings)
> - * using cpa_lock. So that we don't allow any other cpu, with stale large tlb
> - * entries change the page attribute in parallel to some other cpu
> - * splitting a large page entry along with changing the attribute.
> - */
> -static DEFINE_SPINLOCK(cpa_lock);

Yeah, so I'm *really* tempted to just remove cpa_lock if there's no in-code 
documented uses of it - your patch provides *exhaustive* background.

The thing is, even in the worst-case if it breaks anything, it will get 
investigated, documented better and maybe reverted - which would *still* be 
an improvement over today, because we turn undocumented code into 
documented code.

We cannot indefinitely keep a global lock just because we fear it might 
have some undocumented dependencies...

But no strong feelings either way - I've added a few more Cc:s to discuss 
this more widely.

Unless there's objections I'd be inclined to give this patch a try, and 
keep an eye open for regressions, it's not difficult to revert either.

Thanks,

	Ingo
