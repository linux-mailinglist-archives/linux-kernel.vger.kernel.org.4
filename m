Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6885F00D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiI2WoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiI2WnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:43:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23917DC2E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:38:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gf8so79371pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uRYofiYnG47hAF2aDgziR8isJuYRbsZpgovud56j32A=;
        b=JZPVhVcSMWJOlPWPeuO7TIk2QE8xzCYuAuPJMIvNL9e/7DEG7nT1s/j0a++TuIXoJt
         W5tOkUQ3APGpHGPx2aDs0EQFmPuIgBA+4T0avm1Lg0UJhYZ3xUC1RzFzgaGhbslD+zEA
         8NgZgevTkenFB0f0XOWYHbeCZsUerfUuHJ0MRFMwXM5XuUFT0t5SADRdJ0rMU3iZnQpx
         iMve53x366pyZVcyz/wlrlsM3/1JBISjrdscSFwoyHMKAyPnzbLjIdZA8bJqQmwrTVBh
         qX5XlvQpPaLRv1P2ont+Bp7rvzNsL9me5BwcB/JytVGVWSrVmlRW7tys/zv1TCWNsOeo
         isHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uRYofiYnG47hAF2aDgziR8isJuYRbsZpgovud56j32A=;
        b=XTemdimQ6D2Rt6Y8+ShL1Yf8Gpd9XrTY+dN8YScC/vFS9ovgeOOfxJ+KuGGVJWr8cp
         nue+KXnZJe163W7awEqAMlTxPWU5fnGKua6Rv+BVs5wky6lFGVLByd0F5Qd4P96y6+4y
         o4YBd4IZ2uJ4YBvxgEO5aOBRLbepul3CxzFuiC0VTTXZEKvk6OzPpVKA/2fIbcgyF7mg
         DSP41jIEI6gtK+Nuk7LOkNOm9FXPKNp5bkN15W/oZRe6IZYvYqQSzXTPy7bFXd6T8a4k
         M6CUOJbQp+L41OLcBm8aDXwNrpYE6MLgvuEZpbXS9THvs8u5wyZaVG25yKkSIY0JFfKj
         ht6w==
X-Gm-Message-State: ACrzQf3GvD6nw8eRjPEWgL69jIAwSIHQX0DBKRvIHDTr4dowAIcDHbqF
        YZet/J+a24X8g9PSM+JAWtzJ0A==
X-Google-Smtp-Source: AMsMyM6yC6NkaBuBd+HCYZGGqRfzh1aqwwfKXWPEPMxkZ/E1X0XuzRLSKCq/ziAdT/GnArgh0pqgvg==
X-Received: by 2002:a17:903:441:b0:179:f1cc:ba89 with SMTP id iw1-20020a170903044100b00179f1ccba89mr5683259plb.146.1664491089036;
        Thu, 29 Sep 2022 15:38:09 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b0017829a3df46sm384797plg.204.2022.09.29.15.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:38:08 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:38:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: Nested AVIC design (was:Re: [RFC PATCH v3 04/19] KVM: x86: mmu:
 allow to enable write tracking externally)
Message-ID: <YzYeTCsNfQWccKJ9@google.com>
References: <20220427200314.276673-1-mlevitsk@redhat.com>
 <20220427200314.276673-5-mlevitsk@redhat.com>
 <YoZyWOh4NPA0uN5J@google.com>
 <5ed0d0e5a88bbee2f95d794dbbeb1ad16789f319.camel@redhat.com>
 <c22a18631c2067871b9ed8a9246ad58fa1ab8947.camel@redhat.com>
 <Yt6/9V0S9of7dueW@google.com>
 <7c4cf32dca42ab84bdb427a9e4862dbf5509f961.camel@redhat.com>
 <YugLc5LLPJkt89z6@google.com>
 <fe76ea902a38a10e2d8078fd9e5a71a0c7724d84.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe76ea902a38a10e2d8078fd9e5a71a0c7724d84.camel@redhat.com>
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

On Mon, Aug 08, 2022, Maxim Levitsky wrote:
> Hi Sean, Paolo, and everyone else who wants to review my nested AVIC work.

Before we dive deep into design details, I think we should first decide whether
or not nested AVIC is worth pursing/supporting.

  - Rome has a ucode/silicon bug with no known workaround and no anticipated fix[*];
    AMD's recommended "workaround" is to disable AVIC.
  - AVIC is not available in Milan, which may or may not be related to the
    aforementioned bug.
  - AVIC is making a comeback on Zen4, but Zen4 comes with x2AVIC.
  - x2APIC is likely going to become ubiquitous, e.g. Intel is effectively
    requiring x2APIC to fudge around xAPIC bugs.
  - It's actually quite realistic to effectively force the guest to use x2APIC,
    at least if it's a Linux guest.  E.g. turn x2APIC on in BIOS, which is often
    (always?) controlled by the host, and Linux will use x2APIC.

In other words, given that AVIC is well on its way to becoming a "legacy" feature,
IMO there needs to be a fairly strong use case to justify taking on this much code
and complexity.  ~1500 lines of code to support a feature that has historically
been buggy _without_ nested support is going to require a non-trivial amount of
effort to review, stabilize, and maintain.

[*] 1235 "Guest With AVIC (Advanced Virtual Interrupt Controller) Enabled May Fail
    to Process IPI (Inter-Processor Interrupt) Until Guest Is Re-Scheduled" in
    https://www.amd.com/system/files/TechDocs/56323-PUB_1.00.pdf
