Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B56BBA48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCOQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjCOQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:54:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A82472D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:54:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z9-20020a170902708900b0019f271f33aeso7175847plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678899271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VfOj1PxwZtE3fiW4+Wbi4dS2kE6Vdmar5BqVI1M2z0=;
        b=BEqSBnWJskRuRBspuN6FxAXPBhQk21kw/QwpQhD+OPlE7HMQ4t4minhZOXyoQwEo3F
         tt1stwO6FYs5bIqkpXIeC3XJ7m3dYjzvRiWySWCR3r6wfBOkC/PEY+WXuc80rxFKt27c
         KOzAcFEhGzqEsuuAhRKgnxCk70qP0LpFveG9jRbnMqvf2vKnfdjPpL0HesVOOclo4OxM
         BOLJ9w1PyWUHlGa3ORpqrIvOBdmK89BmWv3pPnitmBb3dg57lPujpJr63O9FjhdqQL5K
         HCjCfb3bzmtH+GiUm5c46uiyfcwSwwsV223MDV86CcsaaHgcmDJ0bQMYtI4p/yIpPisc
         6r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VfOj1PxwZtE3fiW4+Wbi4dS2kE6Vdmar5BqVI1M2z0=;
        b=4trZLtuRlJW74U6HPkDh2nl/d+3y9POJnnC2fR7MltiyAYRMcbGVDM79dWAj30ZEbj
         4E4BEmyjUE/A2xyZ/EOamRbJ/gDc9Bkq9UQnsszxSLZAI9NujAFbNr4NCtf9xe04f+di
         agiLidJJNWcqQqiifqREcaEwl0tE3OD5f5hIh7YdlBWS/4fkCMO7y5aKPKzEMEfheXZS
         xXZh+FqtICCUqk+pdEuIomNvyDb24KUxC2TfB285hox6toN4HhZGur3NvNv2dw/plPd5
         CEv4eSXg6xQ2heSMVf1u/NDw7XTWsWkkZrpuLtKXAx+rKBw4n8K6BVUsJtiovZlMbXZz
         +5Ng==
X-Gm-Message-State: AO0yUKVv5j/Zyyh2Zn+frRaAwwIV39PSA1TUxzoUa+g9LGwmzFoHuBdM
        JQjQuFvsxImptRfz4yXvSU+EliXpIGQ=
X-Google-Smtp-Source: AK7set8uXr2sovLYtbxUeraNaTKwMoaMEQm3jr5Cs9656uq3YKkYAaDETqng8wyzyCVhZ2HsOOop/4RwRyc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:5c43:0:b0:4f1:cd3a:3e83 with SMTP id
 v3-20020a655c43000000b004f1cd3a3e83mr122328pgr.3.1678899271499; Wed, 15 Mar
 2023 09:54:31 -0700 (PDT)
Date:   Wed, 15 Mar 2023 09:54:30 -0700
In-Reply-To: <ZBGfmLuORj+ZBziv@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com> <20230311002258.852397-21-seanjc@google.com>
 <ZBGfmLuORj+ZBziv@yzhao56-desk.sh.intel.com>
Message-ID: <ZBH4RizqdigXeYte@google.com>
Subject: Re: [PATCH v2 20/27] KVM: x86/mmu: Use page-track notifiers iff there
 are external users
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, Yan Zhao wrote:
> On Fri, Mar 10, 2023 at 04:22:51PM -0800, Sean Christopherson wrote:
> > Disable the page-track notifier code at compile time if there are no
> > external users, i.e. if CONFIG_KVM_EXTERNAL_WRITE_TRACKING=n.  KVM itself
> > now hooks emulated writes directly instead of relying on the page-track
> > mechanism.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h       |  2 ++
> >  arch/x86/include/asm/kvm_page_track.h |  2 ++
> >  arch/x86/kvm/mmu/page_track.c         |  9 ++++-----
> >  arch/x86/kvm/mmu/page_track.h         | 29 +++++++++++++++++++++++----
> >  4 files changed, 33 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 1a4225237564..a3423711e403 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1265,7 +1265,9 @@ struct kvm_arch {
> >  	 * create an NX huge page (without hanging the guest).
> >  	 */
> >  	struct list_head possible_nx_huge_pages;
> > +#ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING
> >  	struct kvm_page_track_notifier_head track_notifier_head;
> > +#endif
> >  	/*
> >  	 * Protects marking pages unsync during page faults, as TDP MMU page
> >  	 * faults only take mmu_lock for read.  For simplicity, the unsync
> > diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
> > index deece45936a5..53c2adb25a07 100644
> > --- a/arch/x86/include/asm/kvm_page_track.h
> > +++ b/arch/x86/include/asm/kvm_page_track.h
> The "#ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING" can be moved to the
> front of this file?
> All the structures are only exposed for external users now.

Huh.  I've no idea why I didn't do that.  IIRC, the entire reason past me wrapped
track_notifier_head in an #ifdef was to allow this change in kvm_page_track.h.

I'll do this in the next version unless I discover an edge case I'm overlooking.

Thanks yet again!
