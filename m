Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FC16B8142
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCMS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCMS4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:56:40 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675544232
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:56:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x15-20020a056a000bcf00b0062436f133c1so2098648pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678733796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXx+jCvFVnqiF8ZslKAMtaMytcHTldmzSYcO3RbOe10=;
        b=JIO1DBKAXENWr/6gH5UonUJtMPVFqeHx92t5eJ8UnsIhGhS4LslkaXrS4Vy2jGuYtz
         hBmcbcYVU26K/R5xRDuDp92MGe97dBwVdbegfNZgwxDpiNHI+eyxEzOeSUAH8kB5kxJT
         9sor9y1Imsxmk0ohsLRKayK8LYjS/AdaNI+VtF0mA47KixQbaB4Ppf8o6pTOvgiaiQdi
         CurypTpHTgERKM5Zx2GObOh89sRUzCe0/E6S/Omt8rS6brRY1IA35D8by66WKjPoaSjo
         +FAAiphO5RKE8yeBE9zLxWDSfaNF01jt60EELxZ2FMKe28ri9zsncwqu/JyFsza1T+RU
         CO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678733796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXx+jCvFVnqiF8ZslKAMtaMytcHTldmzSYcO3RbOe10=;
        b=mO0C+tbnBybodjLxVxCRxMKMDz4xcJwTKVDc/ZVAakEkicbz/sfH9gMBt0Na1chRG/
         5ZksIc/Htj/dhEu5fzDJCezWwtzi0ywaNBw/cxiW5kLpHcTQu5OOBNMqWWZxP5kij2qu
         UK8z6Ed7/wFi1BkOHnRGaEvsdI2LFPnmKbfoRh2v4brfn6prEa9mzIddpC84OABEygeX
         cdDAXRmEXN80HD0hSxPvXW0Z/5R+IMd/XLLol6stitB74Y1mZVa50+MO3R4NTVgMoR0h
         ZKl3X4bFJlVeHLKqGVcmCW7PhoyfjUyyOLSNnp1LFZMp0d+kgpDDBkUmUFqgMIlABzUo
         d8uQ==
X-Gm-Message-State: AO0yUKW2EJSi6vQg7kqOTMQA8fY2GWMenatKB/saKWWoJJ/w4q2MDwfV
        gefq86ORs94V0F/ew+H/wCUzViqS4+s=
X-Google-Smtp-Source: AK7set/wM5L1+yaNXvtfievXsQ3Jw5zwYOQf1g3rq47++ID+TqnBXcgh3At0w1nD01xukJbviemFvHOdy/o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4f61:0:b0:507:4737:cdb5 with SMTP id
 p33-20020a634f61000000b005074737cdb5mr9411816pgl.8.1678733795768; Mon, 13 Mar
 2023 11:56:35 -0700 (PDT)
Date:   Mon, 13 Mar 2023 18:56:34 +0000
In-Reply-To: <ZA9twqv5XQMmgXWb@thinky-boi>
Mime-Version: 1.0
References: <20230309010336.519123-1-seanjc@google.com> <20230309010336.519123-3-seanjc@google.com>
 <ZAlGeYAmvhPmVmGe@debian.me> <ZAmWefGcsBwcODxW@linux.dev> <ZAoWogdeET5N0mug@google.com>
 <ZA9eHzE5vhnXh+TA@linux.dev> <ZA9pfbhypRNPhdN8@google.com> <ZA9twqv5XQMmgXWb@thinky-boi>
Message-ID: <ZA9x4svW1C/M7kJh@google.com>
Subject: Re: [PATCH v2 2/2] Documentation/process: Add a maintainer handbook
 for KVM x86
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Shier <pshier@google.com>,
        Anish Ghulati <aghulati@google.com>,
        James Houghton <jthoughton@google.com>,
        Anish Moorthy <amoorthy@google.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Babu Moger <babu.moger@amd.com>, Chao Gao <chao.gao@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Guang Zeng <guang.zeng@intel.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jing Liu <jing2.liu@intel.com>,
        Junaid Shahid <junaids@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Leonardo Bras <leobras@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Li RongQing <lirongqing@baidu.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Luczaj <mhal@rbox.co>,
        Mingwei Zhang <mizhang@google.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Paul Durrant <pdurrant@amazon.com>,
        Peng Hao <flyingpenghao@gmail.com>,
        Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>,
        Robert Hoo <robert.hu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023, Oliver Upton wrote:
> On Mon, Mar 13, 2023 at 11:20:45AM -0700, Sean Christopherson wrote:
> > On Mon, Mar 13, 2023, Oliver Upton wrote:
> > > On Thu, Mar 09, 2023 at 09:25:54AM -0800, Sean Christopherson wrote:
> > > > On Thu, Mar 09, 2023, Oliver Upton wrote:
> > > > > On Thu, Mar 09, 2023 at 09:37:45AM +0700, Bagas Sanjaya wrote:
> > > > > > On Wed, Mar 08, 2023 at 05:03:36PM -0800, Sean Christopherson wrote:
> > > > > > > +As a general guideline, use ``kvm-x86/next`` even if a patch/series touches
> > > > > > > +multiple architectures, i.e. isn't strictly scoped to x86.  Using any of the
> > > > > > > +branches from the main KVM tree is usually a less good option as they likely
> > > > > > > +won't have many, if any, changes for the next release, i.e. using the main KVM
> > > > > > > +tree as a base is more likely to yield conflicts.  And if there are non-trivial
> > > > > > > +conflicts with multiple architectures, coordination between maintainers will be
> > > > > > > +required no matter what base is used.  Note, this is far from a hard rule, i.e.
> > > > > > > +use a different base for multi-arch series if that makes the most sense.
> > > > > 
> > > > > I don't think this is the best way to coordinate with other architectures.
> > > > > Regardless of whether you intended this to be prescriptive, I'm worried most
> > > > > folks will follow along and just base patches on kvm-x86/next anyway.
> > > > 
> > > > Probably, but for the target audience (KVM x86 contributors), that's likely the
> > > > least awful base 99% of the time.
> > > 
> > > Sorry, I follow this reasoning at all.
> > > 
> > > If folks are aiming to make a multi-arch contribution then the architecture
> > > they regularly contribute to has absolutely zero relevance on the series
> > > itself.
> > 
> > There's disconnect between what my brain is thinking and what I wrote.
> > 
> > The intent of the "use kvm-x86/next" guideline is aimed to address series that
> > are almost entirely x86 specific, and only superficially touch common KVM and/or
> > other architectures.  In my experience, the vast, vast majority of "multi-arch"
> > contributions from x86 fall into this category, i.e. aren't truly multi-arch in
> > nature.
> > 
> > If I replace the above paragraph with this, does that address (or at least mitigate
> > to an acceptable level) your concerns?  Inevitably there will still be series that
> > are wrongly based on kvm-x86, but I am more than happy to do the policing.  I
> > obviously can't guarantee that I will be the first to run afoul of a "bad" series,
> > but I do think I can be quick enough to avoid shifting the burden to other
> > maintainers.  And if I'm wrong on either front, you get to say "told you so" and
> > make me submit a patch of shame ;-)
> > 
> >   The only exception to using ``kvm-x86/next`` as the base is if a patch/series
> >   is a multi-arch series, i.e. has non-trivial modifications to common KVM code
> >   and/or has more than superficial changes to other architectures's code.  Multi-
> 
> nit: Maybe 'to another architecture's code', since English is an annoying
> language :)

Gah, was supposed to be just "architectures'".  I don't want to limit the wording
to just one other architecture, because then I'll get nitpicked on what to do if
a series touches _two_ architectures.

> >   arch patch/series should instead be based on a common, stable point in KVM's
> >   history, e.g. the release candidate upon which ``kvm-x86 next`` is based.  If
> >   you're unsure whether a patch/series is truly multi-arch, err on the side of
> >   caution and treat it as multi-arch, i.e. use a common base.
> 
> LGTM, and sorry for whining without getting across the net effect I was hoping
> for in the language.

No need to apologize, the whole point of this doc is to try to make everyone's
lives easier, not just my own.  But mostly my own :-D
