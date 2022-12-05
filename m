Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2544E6430BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiLESsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiLESr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:47:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA5767D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:47:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k79so12275147pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 10:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrigZB+zmGJr5Zr508QSWdYu0zn32gW/8ZNDwNQuw7g=;
        b=gSYORyZKVRjLACv6wQaHjSP9S7Pl9wLf7iQVGOXsrs0R4h5msPwAtRg2zHHoTtqHuq
         KtVURmXwLvL0R6xQiAZ9/g2oJrjFTkdmXUxs50u9XEk2ZtIGm7LeTDAt+eyuSzBhwa4D
         a2+Yv8ae6BCLyzcK1RjfKTmH6NjU0A2Fz0BMEx1QXpqeQOdugFYnNzaPCr3JJBFuuxJM
         KDtEu+kO8MYua1hWG2EfeHXI3LAAQstbjQsATz/VzJ8po1WcZMrtUu+k/6ZJijvrMc+G
         qXiI9Ft1dcXRD8o5Zh4E0M6SybmBhLLLgQWsOLyul5/5t+hwcqZawYpzLSY9GF1ulLDc
         QNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrigZB+zmGJr5Zr508QSWdYu0zn32gW/8ZNDwNQuw7g=;
        b=7T4Z3R3Tg0y/Zr5cFZzHympQso02NrIRcHfR40EFV0N16uLiugMJKDjHSgQ8aSG0cN
         mXu3p1PeP7qsdSIFRjv7aNMKOWWj9iA936Uh/oQEF2yUuOWQZIxW74aaJQoVmvwl292g
         iMIXqevWVPw/HJFjLL0jFRZGbmuhjIbGgBr5PEjirsUtUaiOZJFfog/Iqx3KLWALMTPQ
         HT2DaHjIBV/CGbr/QfiHbTMM0MAYsWoBbv3UyO7odvZOdsE/cGdTM2kKXGuVZMR8AFHZ
         GRCZad/eUXpPlrsVCtKAwlATYvb68IqmdjQiOuJNDJCDMYP/3HQNFCbRwu34v4ZdcY4J
         Covg==
X-Gm-Message-State: ANoB5pnm4Uyd59MapLv3iOaa/69zw0HAYIMNB71ipxVAG5S6z3qxzcAp
        QKNMuaBqtIKeelci/+ZNEDO4DA==
X-Google-Smtp-Source: AA0mqf7eSz+OKER6mMRXKfL3nLzDoJzbbQPyH8j5i4FRo1/xDCtpYH2euAUKt5wRJ3P7imcwMrOoSw==
X-Received: by 2002:a63:164f:0:b0:477:f9fa:2a1e with SMTP id 15-20020a63164f000000b00477f9fa2a1emr39836735pgw.87.1670266073492;
        Mon, 05 Dec 2022 10:47:53 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 129-20020a620687000000b00574ee8cfdabsm7395799pfg.148.2022.12.05.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:47:53 -0800 (PST)
Date:   Mon, 5 Dec 2022 18:47:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/2] KVM: x86/mmu: Allocate page table pages on TDP
 splits during dirty log enable on the underlying page's numa node
Message-ID: <Y4481WPLstNidb9X@google.com>
References: <20221201195718.1409782-1-vipinsh@google.com>
 <20221201195718.1409782-2-vipinsh@google.com>
 <CANgfPd_sZoW6gRNgs44BbBu4RhwqNPjUO-=biJ++L5d8LpU3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_sZoW6gRNgs44BbBu4RhwqNPjUO-=biJ++L5d8LpU3zg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Side topic, the shortlog is way, way too long.  The purpose of the shortlog is
to provide a synopsis of the change, not to describe the change in detail.

I also think this patch should be 2/2, with the more generic support added along
with the module param (or capability) in 1/2.  E.g. to yield something like

  KVM: x86/mmu: Add a module param to make per-vCPU SPTs NUMA aware
  KVM: x86/mmu: Honor NUMA awareness for per-VM page table allocations

On Mon, Dec 05, 2022, Ben Gardon wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 4736d7849c60..0554dfc55553 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -90,6 +90,9 @@ __MODULE_PARM_TYPE(nx_huge_pages_recovery_period_ms, "uint");
> >  static bool __read_mostly force_flush_and_sync_on_reuse;
> >  module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
> >
> > +static bool __read_mostly numa_aware_pagetable = true;
> > +module_param_named(numa_aware_pagetable, numa_aware_pagetable, bool, 0644);
> > +
> 
> I'm usually all for having module params to control things, but in
> this case I don't think it provides much value because whether this
> NUMA optimization is useful or not is going to depend more on VM size
> and workload than anything else. If we wanted to make this
> configurable, a VM capability would probably be a better mechanism so
> that userspace could leave it off when running small,
> non-performance-sensitive VMs

Would we actually want to turn it off in this case?  IIUC, @nid is just the
preferred node, i.e. failure to allocate for the preferred @nid will result in
falling back to other nodes, not outright failure.  So the pathological worst
case scenario would be that for a system with VMs that don't care about performance,
all of a nodes memory is allocated due to all VMs starting on that node.

On the flip side, if a system had a mix of VM shapes, I think we'd want even the
performance insensitive VMs to be NUMA aware so that they can be sequestered on
their own node(s), i.e. don't "steal" memory from the VMs that are performance
sensitive and have been affined to a single node.

> and turn it on when running large, multi-node VMs. A whole-host module
> parameter seems overly restrictive.
