Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B54666257
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAKRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjAKRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:55:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D25FEC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:55:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so20851410pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7Y/8dpiTrt5XwA66qUKG1WmzZB0zeXo7IcqUJW6CPQ=;
        b=MczkQLZ8ed6AHL2OMQOdtKRAQGm0lp4zyPT4PoqgM9PtkQnELcpd3qDLIXLvCdG3h2
         4K8vLqwwOaHavSfJsui7fuj5PJwnk4FFc0w3xGvI6TP5DH1s36+dDr1Ra6PsFByduW6g
         jb9dMI/SU+HRDQTAjwvjwyrpQVeErh+7G8aXwo6ZLT10mPle+5tAXecVjxxlWymPe7CY
         e9utDW6Czu0ww0QlRo80dD/SUZSVBE/EIG7td4Tewom5dIo15jQCg5q5ABjL1KYa6Na8
         qa8d3Z3OmPQLE5t2D1DPIATNRL/yT3aiktPdUbKc/3Vn/nOi2R0nOGd3MNRgx4BQx576
         LrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7Y/8dpiTrt5XwA66qUKG1WmzZB0zeXo7IcqUJW6CPQ=;
        b=YxiF89Dra19Rp0A+sHKkO+aVsdgSC3SrntyuugPGH5yauJxlpk8gvfxSJDJ/I/SDO2
         Y7PpQJqtLBZ2VpkFOR9pdcwY+5ohO4ZRw7iCBg/QlrmEMTbTUo7ubTr26PFcvUp+iuKZ
         j6/Bu2742ITR5oxzRaZcCq6Y7Bk1CKMtQ51ZzPebGT8e3dxbXl8afSKJdhixpRBxUDik
         iab8jOGgTtd0pQ/fIHprGs41Nxs9SsY7S3z/32Pjs++vJA3abQ3ENdmxXLqIoOSgcUfa
         6MGpNNvAWL/ovL4Xcjr9u5NnQWtQuhz8rOAB/ZEcDohdtLim47h+yBgcCseCGUhkuOOH
         /63w==
X-Gm-Message-State: AFqh2krkDsDjZkychKnrNHx2ONrc5RJ3YZJ7FgE6u0gba7if0qrXYnpS
        8sPZTetQsD/SUQFAT0bdwbzwaQ==
X-Google-Smtp-Source: AMrXdXsvU/ZwNX4itatc02092RMPqShT3EdhbakJAAkdRuwYzzFKWTW7c7/5rgO8QBFQNdhstw5LwA==
X-Received: by 2002:a05:6a20:47de:b0:b3:66b7:24ff with SMTP id ey30-20020a056a2047de00b000b366b724ffmr438100pzb.1.1673459708056;
        Wed, 11 Jan 2023 09:55:08 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i131-20020a628789000000b00573eb4a775esm10591458pfe.17.2023.01.11.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:55:07 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:55:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 03/27] drm/i915/gvt: Incorporate KVM memslot info into
 check for 2MiB GTT entry
Message-ID: <Y773+EB35bAchVTC@google.com>
References: <20221223005739.1295925-1-seanjc@google.com>
 <20221223005739.1295925-4-seanjc@google.com>
 <Y6vXTcxDNovrmeVB@yzhao56-desk.sh.intel.com>
 <Y7SaklDQD0EoIs8l@google.com>
 <Y7Y+759IN2DH5h3h@yzhao56-desk.sh.intel.com>
 <Y7cLkLUMCy+XLRwm@google.com>
 <Y7e3fT8/V2NoXAUP@yzhao56-desk.sh.intel.com>
 <Y7ioYegkgKIH8uJL@google.com>
 <Y7vlOCKkJ+QyO3EM@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7vlOCKkJ+QyO3EM@yzhao56-desk.sh.intel.com>
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

On Mon, Jan 09, 2023, Yan Zhao wrote:
> On Fri, Jan 06, 2023 at 11:01:53PM +0000, Sean Christopherson wrote:
> > On Fri, Jan 06, 2023, Yan Zhao wrote:
> > > On Thu, Jan 05, 2023 at 05:40:32PM +0000, Sean Christopherson wrote:
> > > > On Thu, Jan 05, 2023, Yan Zhao wrote:
> > > > I'm totally fine if KVMGT's ABI is that VFIO is the source of truth for mappings
> > > > and permissions, and that the only requirement for KVM memslots is that GTT page
> > > > tables need to be visible in KVM's memslots.  But if that's the ABI, then
> > > > intel_gvt_is_valid_gfn() should be probing VFIO, not KVM (commit cc753fbe1ac4
> > > > ("drm/i915/gvt: validate gfn before set shadow page entry").
> > > > 
> > > > In other words, pick either VFIO or KVM.  Checking that X is valid according to
> > > > KVM and then mapping X through VFIO is confusing and makes assumptions about how
> > > > userspace configures KVM and VFIO.  It works because QEMU always configures KVM
> > > > and VFIO as expected, but IMO it's unnecessarily fragile and again confusing for
> > > > unaware readers because the code is technically flawed.
> > > >
> > > Agreed. 
> > > Then after some further thought, I think maybe we can just remove
> > > intel_gvt_is_valid_gfn() in KVMGT, because
> > > 
> > > (1) both intel_gvt_is_valid_gfn() in emulate_ggtt_mmio_write() and
> > > ppgtt_populate_spt() are not for page track purpose, but to validate bogus
> > > GFN.
> > > (2) gvt_pin_guest_page() with gfn and size can do the validity checking,
> > > which is called in intel_gvt_dma_map_guest_page(). So, we can move the
> > > mapping of scratch page to the error path after intel_gvt_dma_map_guest_page().
> > 
> > IIUC, that will re-introduce the problem commit cc753fbe1ac4 ("drm/i915/gvt: validate
> > gfn before set shadow page entry") solved by poking into KVM.  Lack of pre-validation
> > means that bogus GFNs will trigger error messages, e.g.
> > 
> > 			gvt_vgpu_err("vfio_pin_pages failed for iova %pad, ret %d\n",
> > 				     &cur_iova, ret);
> > 
> > and
> > 
> > 			gvt_vgpu_err("fail to populate guest ggtt entry\n");
> 
> Thanks for pointing it out.
> I checked this commit message and found below original intentions to introduce
> pre-validation:

...

> (I actually found that the original code will print "invalid entry type"
> warning which indicates it's broken for a while due to lack of test in
> this invalid gfn path)
> 
> 
> > One thought would be to turn those printks into tracepoints to eliminate unwanted
> > noise, and to prevent the guest from spamming the host kernel log by programming
> > garbage into the GTT (gvt_vgpu_err() isn't ratelimited).
> As those printks would not happen in normal conditions and printks may have
> some advantages to discover the attack or bug, could we just convert
> gvt_vgpu_err() to be ratelimited ?

That's ultimately a decision that needs to be made by the GVT maintainers, as the
answer depends on the use case.  E.g. if most users of KVMGT run a single VM and
the guest user is also the host admin, then pr_err_ratelimited() is likely an
acceptable/preferable choice as there's a decent chance a human will see the errors
in the host kernel logs and be able to take action.

But if there's unlikely to be a human monitoring the host logs, and/or the guest
user is unrelated to the host admin, then a ratelimited printk() is less useful.
E.g. if there's no one monitoring the logs, then losing messages due to
ratelimiting provides a worse debug experience overall than having to manually
enable tracepoints.   And if there may be many tens of VMs (seems unlikely?), then
ratelimited printk() is even less useful because errors for a specific VM may be
lost, i.e. the printk() can't be relied upon in any way to detect issues.

FWIW, in KVM proper, use of printk() to capture guest "errors" is strongly discourage
for exactly these reasons.
