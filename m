Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E006488A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLISvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLISvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:51:38 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE5C2D1EB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:51:37 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id v1so2522756ioe.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LuKRSE9yoby/BwWkd0GJdE5qj3kg3zwd3XfR3spbaTA=;
        b=TIISGhfVb5zhKSIbTnz6UHhrlr7SKCOGcmRJYkFWowH8k+2/4Z2VXtGSbNlybzUyi8
         SfHPgpvzVwFjmx2cTnKBWVXfx8/MOMgzbXts1SFnkPOaoX7gTY5NossvQq+hPfPSGy3P
         UXtgdbp84UjSABG5LlV2ppKoEiSPvbHqKMCkJtt4AyNep4XWm+Tn1etyzQJHfH6XFpYJ
         eQ7T47mEIzAd8FiNz5Ds7QCS5U00Oc/q4HKGI7mtZAO6eqfbcD9FJNs6FN85M/XFmvya
         IrxZ6EYBPDOsLve2SU1mblnUHcMrikipZMdTtbQg8MCR02HFs4io+2Q1bCUIwDsG6b8Q
         ncow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuKRSE9yoby/BwWkd0GJdE5qj3kg3zwd3XfR3spbaTA=;
        b=Jvg1ckMVnGhz1/T0jxTiZz43fdpmYHTL8lkf1fRQCwHfrS17RlvXmcjJH+NY9FtjTW
         mmzCjVWgIqnP6uHwHFrHWiV19AWsvVq3SOK9ssPmbRRr3wYgOAH8ULU0rEfs9Ds0hgBq
         ucrjsDBNkEJGquZwo4GBGr0wGsJYFjsBBxPDv3crL2Fj3gRsdtqqwUdTIObvC+h2Wd0i
         dp+EW8MnJGj9ay4cIeR4DLq4w52fVBpuFRoTsmabI1CYuSVMqICyhN7j+T3jZk+Ft2Pp
         FWx0AS6xD1trlL2lPxKaXw5UIjD+8L/95kUeJzAlQ3lFPaum4R2FfYVO6vbakG+eyrA/
         lcfg==
X-Gm-Message-State: ANoB5plBWn8X4O2AJRtNCHvBxO4fcA/69+xAFfSiQHF/D0Waen1i0ySI
        ZWyxrjRA3pPw4P+CQg2NlSUwNwXC1MglFjhYtepn8D4s8avzKg==
X-Google-Smtp-Source: AA0mqf6eMyp+kM+XdjHEWfjLHfPFofC1IpGgU57D7NSGoQTyACkmMiApe/l/rLt7/X5+E7yQJdzgjnHwsY8yZAPHHXE=
X-Received: by 2002:a05:6602:341d:b0:6de:fafb:cbab with SMTP id
 n29-20020a056602341d00b006defafbcbabmr35785589ioz.217.1670611896957; Fri, 09
 Dec 2022 10:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20221201195718.1409782-1-vipinsh@google.com> <20221201195718.1409782-3-vipinsh@google.com>
 <Y5KBDXzPFw3PaSVD@google.com>
In-Reply-To: <Y5KBDXzPFw3PaSVD@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 9 Dec 2022 10:51:00 -0800
Message-ID: <CAHVum0czjbxwme3x4o2y437gFoLx_1q5hZMvKSrwTggFtYDZeg@mail.gmail.com>
Subject: Re: [Patch v2 2/2] KVM: x86/mmu: Allocate page table pages on NUMA
 node of underlying pages
To:     David Matlack <dmatlack@google.com>
Cc:     bgardon@google.com, seanjc@google.com, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Dec 8, 2022 at 4:28 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Dec 01, 2022 at 11:57:18AM -0800, Vipin Sharma wrote:
> > Page table pages of a VM are currently allocated based on the current
> > task's NUMA node or its mempolicy. This can cause suboptimal remote
> > accesses by the vCPU if it is accessing physical pages local to its NUMA
> > node but the page table pages mapping those physcal pages were created
> > by some other vCPU which was on different NUMA node or had different
> > policy.
> >
> > Allocate page table pages on the same NUMA node where underlying
> > physical page exists. Page table at level 5, 4, and 3 might not end up
> > on the same NUMA node as they can span multiple NUMA nodes.
> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> ...
> > @@ -6284,13 +6326,16 @@ static int shadow_mmu_try_split_huge_page(struct kvm *kvm,
> >       gfn = kvm_mmu_page_get_gfn(huge_sp, spte_index(huge_sptep));
> >       level = huge_sp->role.level;
> >       spte = *huge_sptep;
> > +     nid = kvm_pfn_to_refcounted_page_nid(spte_to_pfn(spte));
> > +     if (nid == NUMA_NO_NODE)
> > +             nid = numa_mem_id();
>
> What do you think about renaming kvm_pfn_to_refcounted_page_nid() to
> kvm_pfn_to_page_table_nid() and having it return numa_mem_id() instead
> of NUMA_NO_NODE (with a comment)? I think that will clean up this patch
> quite a bit by getting rid of all the NUMA_NO_NODE checks.

Yeah, this will clean up this patch. I will make this change in the
next version.
