Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8243167855C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjAWSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjAWSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:53:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842C3252F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:53:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so12555726pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbeqNDwM7PguRoxu1uJ4BvBe4RnoeTrJq9+Dcu44bdY=;
        b=oqZ8GYVYMPss17svQQtt4WX28PkyYNlkKpMlDYe/MKVnswV3wPPOpbEdTr+qFxuhtO
         91xcY14FmY7BCWgQzRFp2gP9cgHuvS5xGGBJQ3kZ7u+mQBzqAe2ubnIpkIZiZIKziX2B
         aBMZxyeXZLqWuXx0xcu88+eHyALbAYaBrcw13Vh2kBP0bL/Kzfe+GkJdettkc5hJaCap
         zyrmf1Spj8As97ZiUqpnmnF+wattpXxCdaBgiitxbCQHlK/vQ7MG3v4FsYy1Dc/cX1YH
         y7Vjz8RNUj0M0cMN44Ei8uzADy+gmLn/xw0d94cz/N+8bgix9Y6cFeJktiR4go+x5FMP
         0AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbeqNDwM7PguRoxu1uJ4BvBe4RnoeTrJq9+Dcu44bdY=;
        b=8OjTiOI8ZioT0Dthgy2jpPVFYESv41+MtYNh+rsmoH5NQBf1W7WJCysSfaBEXUWgdE
         LXgNgQJZefZd1MupfR0sJU65v7O7gI7myrPPSqPx02DVofNrGfjsqV0D7OVUvf8A4Y8K
         B2KtgkVoQ+A6CQUhK47p+o7Cl7fmq1RMDO0lC76Lcs8Kb2JYkzLuGrFQjlbOTA/WwBdB
         J7z9S4LjKIAQoqu+rAs39CNhdud/4GPXKVnJMI/L3DT3h+1yD/j408jo/8wjKU5O8MX2
         XF/Wd1SHJReqmyeMNi/aNRoaz8GL7uxAPW3RRFKrYZ/F5SpIYws74tGD6u7SGQ9hS4h/
         H1cg==
X-Gm-Message-State: AFqh2kq5mhU9NNAm/yQ3RAVKh2DGXfqrTcsmG0xL06aT8NQCheosmLHS
        gtzie9NuMTq8lLl2jc/ls+gl3Q==
X-Google-Smtp-Source: AMrXdXvMENwzNtkH6xTfJJGQ8EMJjEv4Ar7wzDxyyqftcYtq70Nxs3pSACwmfFb80I3zNA7Fk+aTgA==
X-Received: by 2002:a05:6a20:be05:b0:b8:c859:7fc4 with SMTP id ge5-20020a056a20be0500b000b8c8597fc4mr625799pzb.1.1674500001550;
        Mon, 23 Jan 2023 10:53:21 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ml21-20020a17090b361500b0022bb9f05753sm5732668pjb.48.2023.01.23.10.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:53:20 -0800 (PST)
Date:   Mon, 23 Jan 2023 18:53:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Erdem Aktas <erdemaktas@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        isaku.yamahata@intel.com, sagis@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, like.xu@linux.intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
Message-ID: <Y87XnYZx1qzZOLKR@google.com>
References: <20230121001542.2472357-1-ackerleytng@google.com>
 <20230121001542.2472357-9-ackerleytng@google.com>
 <Y8sxjppvEnm4IBWG@google.com>
 <CAAYXXYy7=ZTCZ1LQ3_Sy39ju_xG5++dTrxi+DKGcbpJ5VJ3OuQ@mail.gmail.com>
 <99a36eed-e4e5-60ec-0f88-a33d1842a0d6@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a36eed-e4e5-60ec-0f88-a33d1842a0d6@maciej.szmigiero.name>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023, Maciej S. Szmigiero wrote:
> On 23.01.2023 19:30, Erdem Aktas wrote:
> > On Fri, Jan 20, 2023 at 4:28 PM Sean Christopherson <seanjc@google.com> wrote:
> > > 
> > > On Sat, Jan 21, 2023, Ackerley Tng wrote:
> > > > Some SSE instructions assume a 16-byte aligned stack, and GCC compiles
> > > > assuming the stack is aligned:
> > > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838. This combination
> > > > results in a #GP in guests.
> > > > 
> > > > Adding this compiler flag will generate an alternate prologue and
> > > > epilogue to realign the runtime stack, which makes selftest code
> > > > slower and bigger, but this is okay since we do not need selftest code
> > > > to be extremely performant.
> > > 
> > > Huh, I had completely forgotten that this is why SSE is problematic.  I ran into
> > > this with the base UPM selftests and just disabled SSE.  /facepalm.
> > > 
> > > We should figure out exactly what is causing a misaligned stack.  As you've noted,
> > > the x86-64 ABI requires a 16-byte aligned RSP.  Unless I'm misreading vm_arch_vcpu_add(),
> > > the starting stack should be page aligned, which means something is causing the
> > > stack to become unaligned at runtime.  I'd rather hunt down that something than
> > > paper over it by having the compiler force realignment.
> > 
> > Is not it due to the 32bit execution part of the guest code at boot
> > time. Any push/pop of 32bit registers might make it a 16-byte
> > unaligned stack.
> 
> 32-bit stack needs to be 16-byte aligned, too (at function call boundaries) -
> see [1] chapter 2.2.2 "The Stack Frame"

And this showing up in the non-TDX selftests rules that out as the sole problem;
the selftests stuff 64-bit mode, i.e. don't have 32-bit boot code.
