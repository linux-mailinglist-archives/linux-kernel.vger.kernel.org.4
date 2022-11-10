Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAF62486A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKJRe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKJRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:34:28 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59A1A05A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:34:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so5354010pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uOheR7r7m1kjkcyZ6oyIyEKRnuu3+TLL1zhKhAvKRI=;
        b=mfo3+qZAwVGYMyvKBX3HHCLgBFY1howkNCLfeZpn90ReyRTMxtq7KEjcT7t5pd8Jur
         ccc0iuLCKk09ZO0/G0gpuNYg2DCLLdNs+zs33V7XKAt9Mljwv/kGCnVgRi9pg4+XSxH7
         /kx+2lqZkZOXOK0SfBhGvz2/UbseZh1aHhoalv9yH4Tiv3NTVHdbsn8beM9/T3x4Pqd9
         UFbD4kVgz3atWrjQ3ufz/e+gxNTaorp4BmiZmqsSi4VGUfspd1Ek7uvhChGgJjXfN1lV
         nUzeum4MuSEy4LOBm8LrVHIfQ/ADZXiOqKLnagR5qlM3NnzNRZCmYz4UsCDLLZhIRxhT
         gD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uOheR7r7m1kjkcyZ6oyIyEKRnuu3+TLL1zhKhAvKRI=;
        b=PogNjM3bWPLd4a0g7J+XB9sUdPjh7VLE46Utc3wsH8ve4xcqcNp9/f370Ijj7vmMOC
         m+744NbptsbqG+nn0kUpYYmFjyXPArPPk7y5D6WDb0TEpuGOGn8dj7k+4zl/oBij4/Bb
         iCt0d9SvF7r03Alx4xHlAVVQ1sa5TBvnB/QcgWgYNdSiLOzak2Eqw6YgDlpxDdBEnP/Q
         +WTyeXaeMRPyXWu1RhZ4LR4Ls182bV5c+BpG2u+Lu7xikvkUXO9ptz9cUsxB8btqieoo
         l2IzFYdO5SvgcIujr+y+kpsg+fLXIlUMGwtmTBK5SsPdZffDgc1k23LeBr92/fZHh0NH
         hILQ==
X-Gm-Message-State: ACrzQf1q25uDa8HgdEnp1LP3eqz68Au/fhfCBNSpK/s9FM/VKVwHNIEI
        02jdVkY2w85c1nuZz+aYF/SjCboH6Cb9Qg==
X-Google-Smtp-Source: AMsMyM5Ghv5NHHVY/JKK+E8hTrh/nqsWeFZLDQZeUl2dkUhPV7aiVhPj2m9O3qyxj0RSulo6af57yQ==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr85630126pjb.164.1668101666364;
        Thu, 10 Nov 2022 09:34:26 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p27-20020aa79e9b000000b0052d4cb47339sm10435527pfq.151.2022.11.10.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:34:25 -0800 (PST)
Date:   Thu, 10 Nov 2022 17:34:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 3/3] KVM: x86/cpuid: Add AMD CPUID ExtPerfMonAndDbg
 leaf 0x80000022
Message-ID: <Y202HcmVLa0woaCF@google.com>
References: <20220919093453.71737-1-likexu@tencent.com>
 <20220919093453.71737-4-likexu@tencent.com>
 <Y1sIHXX3HEJEXJm+@google.com>
 <948ec6a5-3f30-e8c2-9629-12235f1e1367@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948ec6a5-3f30-e8c2-9629-12235f1e1367@gmail.com>
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

On Thu, Nov 10, 2022, Like Xu wrote:
> On 28/10/2022 6:37 am, Sean Christopherson wrote:
> > I'm not a fan of perf's unions, but I at least understand the value added for
> > CPUID entries that are a bunch of multi-bit values.  However, this leaf appears
> > to be a pure features leaf.  In which case a union just makes life painful.
> > 
> > Please add a CPUID_8000_0022_EAX kvm_only_cpuid_leafs entry (details in link[*]
> > below) so that KVM can write sane code like
> > 
> > 	guest_cpuid_has(X86_FEATURE_AMD_PMU_V2)
> > 
> > and cpuid_entry_override() instead of manually filling in information.
> > 
> > where appropriate.
> > 
> > [*] https://lore.kernel.org/all/Y1AQX3RfM+awULlE@google.com
> 
> When someone is selling syntactic sugar in the kernel space, extra attention
> needs to be paid to runtime performance (union) and memory footprint
> (reverse_cpuid).

No.  Just no.

First off, this is more than syntactic sugar.  KVM has had multiple bugs in the
past due to manually querying/filling CPUID entries.  The reverse-CPUID infrastructure
guards against some of those bugs by limiting potential bugs to the leaf definition
and the feature definition.  I.e. we only need to get the cpuid_leafs+X86_FEATURE_*
definitions correct.

Second, this code is not remotely performance sensitive, and the memory footprint
of the reverse_cpuid table is laughably small.  It's literally 8 bytes per entry
FOR THE ENTIRE KERNEL.  And that's ignoring the fact that the table might even be
optimized away entirely since it's really just a switch statement that doesn't
use a helper function.

> > With a proper CPUID_8000_0022_EAX, this becomes:
> > 
> > 		entry->ecx = entry->edx = 0;
> > 		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_AMD_PMU_V2)) {
> > 			entry->eax = entry->ebx;
> > 			break;
> > 		}
> > 
> > 		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
> > 
> > 		...
> 
> Then in this code block, we will have:
> 
> 	/* AMD PerfMon is only supported up to V2 in the KVM. */
> 	entry->eax |= BIT(0);

I can't tell exactly what you're suggesting, but if you're implying that you don't
want to add CPUID_8000_0022_EAX, then NAK.  Open coding CPUID feature bit
manipulations in KVM is not acceptable.

If I'm misunderstanding and there's something that isn't handled by
cpuid_entry_override(), then the correct way to force a CPUID feature bit is:

	cpuid_entry_set(entry, X86_FEATURE_AMD_PMU_V2);

> to cover AMD Perfmon V3+, any better move ?

Huh?  If/when V3+ comes along, the above

	cpuid_entry_override(entry, CPUID_8000_0022_EAX);

will continue to do the right thing because KVM will (a) advertise V2 if it's
supported in hardware and (b) NOT advertise V3+ because the relevant CPUID bit(s)
will not be set in kvm_cpu_caps until KVM gains the necessary support.
