Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ED1611642
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ1Ptg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1Pt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:49:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208EA785B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:49:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l6so5059052pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz9f4W1u+5LowQmFLyockgzF0Sn2c69dnPpsIt58fHM=;
        b=QaMVn5zlnvJABPZ655YM9LGwSYohNg2YwDsROYVQBkBTkLQ2qniffWNofa32irCtaB
         MTNGs++gyUnAgJIZhmvCUtdG/wTaFCCF4G1o/AshfTTGoegdcjMpfU2w8cZN/zqJ0Tlk
         V0X/ON1hKghgp4gPUlcms1iD9eVkWWfFR8nppe8ySeefTTQ7Coq8ugrqiySHQT48kDC2
         fbDUuPXWsll4vfjRH5xZkKjrsD58ya/TatwUmn8FwuylMbwmxGkAvpber9W6ZDtLaReC
         /ydQWYH4FDAdQBstJX7bqLX5zY2KidZXt3LD6CXyKpygRJ951252KQbc3MijMgQoakB6
         X9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz9f4W1u+5LowQmFLyockgzF0Sn2c69dnPpsIt58fHM=;
        b=5T6d+6h4nnh62Ibt6dWmgoli8DAahTSpdjksoKWSiZ+bENO3jMli5GERTSJkgHPP14
         e1alUAeYGIQSsaIaxpxhnRBqhzmhcgAarv2GpK9Zr4dpFCUnV3MZptZ7yM9091jtAKKG
         k1xBgbUalCjMhy0WHX36nBT8R5uCjYtdwrK2cxRrhu5yL66nYKUppToq4brREWrKhrGW
         S9wFKVyD/GoCQ4lHNmNIrgz9bvdM9IDdDQjqLyin2pC/9m40JQO0s5ZMQfG+o2c9cjBi
         +qNlcIQ2R2fWKQKeKoHExV+XwCuHsgZMZ/xJajHn4mfCHNJOV2ZvGma36K4FibYPJV8m
         ckgA==
X-Gm-Message-State: ACrzQf3emH6ThaA1pZbKcr7PNraPqn/dKDBHTjOqDTqmSenc7gMGwjBY
        /PzcyOsUC2giAySjQLmnpn7JoUDp2CYAtg==
X-Google-Smtp-Source: AMsMyM5Y0IRJyyDUSr5SMT+Tz+YYgUWzK/ysdVA/J+JtYgl2o1pF+1jN7ivU/UCLPetkHLDJZ27PsQ==
X-Received: by 2002:a17:90b:1d83:b0:212:dc2f:8fc7 with SMTP id pf3-20020a17090b1d8300b00212dc2f8fc7mr16172020pjb.131.1666972164514;
        Fri, 28 Oct 2022 08:49:24 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o1-20020a635a01000000b00434760ee36asm2853580pgb.16.2022.10.28.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:49:24 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:49:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     David Matlack <dmatlack@google.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vipinsh@google.com" <vipinsh@google.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/18] KVM selftests code consolidation and cleanup
Message-ID: <Y1v6AEInngzRxSJ+@google.com>
References: <20221024113445.1022147-1-wei.w.wang@intel.com>
 <Y1mlJqKdFtlgG3jR@google.com>
 <DS0PR11MB63731F2B467D4084F5C8D9B5DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1qnWFzekT27rYka@google.com>
 <CALzav=c4-FWVrWQebuYs--vbgnyPjEwZxfjSS1aMSRL3JMbWYw@mail.gmail.com>
 <Y1rNm0E6/I5y6K2a@google.com>
 <20221028124106.oze32j2lkq5ykifj@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028124106.oze32j2lkq5ykifj@kamzik>
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

On Fri, Oct 28, 2022, Andrew Jones wrote:
> On Thu, Oct 27, 2022 at 06:27:39PM +0000, Sean Christopherson wrote:
> > On Thu, Oct 27, 2022, David Matlack wrote:
> > > On Thu, Oct 27, 2022 at 8:44 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > I like the idea in theory, but that'd be a daunting task to set up, and quite the
> > > > maintenance nightmare.  There are probably thousands of file => scope mappings
> > > > throughout the kernel, with any number of exceptions and arbitrary rules.
> > > 
> > > I was thinking about proposing this in checkpatch.pl, or in some
> > > KVM-specific check script. It seems like the following rule: If a
> > > commit only modifies files in tools/testing/selftests/kvm/*, then
> > > requires the shortlog match the regex "KVM: selftests: .*". That would
> > > handle the vast majority of cases without affecting other subsystems.
> > > 
> > > Sean are you more concerned that if we start validating shortlogs in
> > > checkpatch.pl then eventually it will get too out of hand? (i.e. not
> > > so concerned with this specific case, but the general problem?)
> > 
> > Ya, the general problem.  Hardcoding anything KVM specific in checkpatch.pl isn't
> > going to fly.  The checkpatch maintainers most definitely don't want to take on
> > the burden of maintaining subsystem rules.  Letting one subsystem add custom rules
> > effectively opens the flood gates to all subsystems adding custom rules.  And from
> > a KVM perspective, I don't want to have to get an Acked-by from a checkpatch
> > maintiainer just to tweak a KVM rule.
> > 
> > The only somewhat feasible approach I can think of would be to provide a generic
> > "language" for shortlog scope rules, and have checkpatch look for a well-known
> > file in relevant directories, e.g. add arch/x86/kvm/SCOPES or whatever.  But even
> > that is a non-trivial problem to solve, as it means coming up with a "language"
> > that has a reasonable chance of working for many subsystems without generating too
> > many false positives.
> > 
> > It's definitely doable, and likely not actually a maintenance nightmare (I wrote
> > that thinking of modifying a common rules file).  But it's still fairly daunting
> > as getting buy-in on something that affects the kernel at large tends to be easier
> > said then done.  Then again, I'm probably being pessimistic due to my sub-par
> > regex+scripting skills :-)
> 
> How about adding support for checkpatch extension plugins? If we could add
> a plugin script, e.g. tools/testing/selftests/kvm/.checkpatch, and modify
> checkpatch to run .checkpatch scripts in the patched files' directories
> (and recursively in the parent directories) when found, then we'd get
> custom checkpatch behaviors. The scripts wouldn't even have to be written
> in Perl (but I say that a bit sadly, because I like Perl).

That will work for simple cases, but patches that touch files in multiple directories
will be messy.  E.g. a patch that touches virt/kvm/ and arch/x86/kvm/ will have
two separate custom rules enforcing two different scopes.

Recursively executing plugins will also be problematic, e.g. except for KVM, arch/x86/
is maintained by the tip-tree folks, and the tip-tree is quite opinionated on all
sorts of things, whereas KVM tends to be a bit more relaxed.

Enforcing scope through plugins would also lead to some amount of duplicate code
throught subsystems.

Anyways, if someone wants to pursue this, these ideas and the "requirement" should
be run by the checkpatch maintainers.  They have far more experience and authority
in this area, and I suspect we aren't the first people to want checkpatch to get
involved in enforcing shortlog scope.
