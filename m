Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC48062EC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 05:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKREAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 23:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiKREAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 23:00:40 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42D90581
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:00:39 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i131so4287116ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sw09fBPFw1UV1I+CtkLweBcLiaK4DJnS4ZZX7Njrxc4=;
        b=NRhezJEB08sZ+d64qVBVZU2W9mD7KYwFiUZ1/hIFe54G0DWeiO5gDAMZJTm2q6zjdC
         1C3kauwzT/+KczXkl0/oGYwVcGoIeLDPFfEEN3L2VPrh2bsAHIM7eZ7pAwt+vyE/0l2p
         OikggEPFxje4PBzLq6mas2CkYAdeZL3GqS3HalsRAKNlQa33JaZGXue6IxKCvWYiyH8+
         8bkYYvhbpkJa9Ix4aBpmyGiuK+4PilNQKyzE56Ty8yIAABnLiZJo78dA4MzR9HmUX+5U
         J+i16ONn/Exp2yPHFUmChOx8Q7yBR4q2Nvd0oPURg+XfC/K5UQnrbqDKpb4B17nWBLim
         odEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw09fBPFw1UV1I+CtkLweBcLiaK4DJnS4ZZX7Njrxc4=;
        b=d2Qgm1Uk3dq8sqvCYCOO+FkV2/SsiRtPA6NyHNRKLIHv4oRy0MjBeu0Zk5aN6H/waN
         /Qhhp0/XWImA8r09Rca83HgJU1uPqb4TmH5V3XY8vMUOGyoae+0SdJVTRskRbwD9llQI
         3r9hu7Dsx2TtjUkmQ1aUzL+b9i/U6JoDa2oPnDjBo+8OnhkujVuCqXNrMDTk0qrSBr4g
         DHuVpJ0NjEIIV2Bj/enr1gUj/6C2+Gotfg/ZVxXDY18Cdu1oL5dE7hYmG/ioojCoJyDl
         NZBNtkqAHfW814JpwZglFz0JcsCI/0DiWxq6F6YvkH2i6iNAU3w0ba8Q24ZTPdrF2kpK
         ZuLA==
X-Gm-Message-State: ANoB5pkUoSDHlZFO8mwiYJd43rrc9BBmygY7QcDOme+W+QkqX9hXMdst
        B6zwoI8EwjIaLB4cBwvFiPc7bxz/8VWOUkBQ1XyGtw==
X-Google-Smtp-Source: AA0mqf7+aPyT8X7ugfwo6RaysMU54y4B01QrOVfBDPCqYmEENTcYdBpA99AqrglKRSWFGgxB/fPeeWPs5+TIPrmStP0=
X-Received: by 2002:a25:ad14:0:b0:6de:8ec8:7342 with SMTP id
 y20-20020a25ad14000000b006de8ec87342mr4626366ybi.607.1668744038312; Thu, 17
 Nov 2022 20:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20221117161449.114086-1-pbonzini@redhat.com> <2b18a49dbe946bcbea29be13f5e0f03eacf75cdc.camel@linux.intel.com>
In-Reply-To: <2b18a49dbe946bcbea29be13f5e0f03eacf75cdc.camel@linux.intel.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 17 Nov 2022 20:00:12 -0800
Message-ID: <CALzav=dEmxV1wuNjuN2rzKsNunvwbdZWqr5K6KFZruEW=oYZSQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: simplify kvm_tdp_mmu_map flow when guest
 has to retry
To:     Robert Hoo <robert.hu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Nov 17, 2022 at 5:35 PM Robert Hoo <robert.hu@linux.intel.com> wrote:
>
> On Thu, 2022-11-17 at 11:14 -0500, Paolo Bonzini wrote:
> > +
> >               if (fault->nx_huge_page_workaround_enabled)
> >                       disallowed_hugepage_adjust(fault,
> > iter.old_spte, iter.level);
> >
> And here can also be improved, I think.
>
>         tdp_mmu_for_each_pte(iter, mmu, fault->gfn, fault->gfn + 1) {
> -               if (fault->nx_huge_page_workaround_enabled)
> +               if (fault->huge_page_disallowed)
>
> in the case of !fault->exec && fault->nx_huge_page_workaround_enabled,
> huge page should be still allowed, shouldn't it?
>
> If you agree, I can send out a patch for this. I've roughly tested
> this, with an ordinary guest boot, works normally.

This check handles the case where a read or write fault occurs within
a region that has already been split due to an NX huge page. If we
recovered the NX Huge Page on such faults, the guest could end up
continuously faulting on the same huge page (e.g. if writing to one
page and executing from another within a GPA region backed by a huge
page). So instead, NX Huge Page recovery is done periodically by a
background thread.

That being said, I'm not surprised you didn't encounter any issues
when testing. Now that the TDP MMU fully splits NX Huge Pages on
fault, such faults should be rare at best. Perhaps even impossible?
Hm, can we can drop the call to disallowed_hugepage_adjust() entirely?
