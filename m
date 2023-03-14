Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5126B9CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjCNROQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCNROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:14:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F4A5680
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:14:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5417f156cb9so92891777b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678814040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=82+4kn0WzOMA+pL+/2ulEiwUoPfQ6iWm426J0EFz0Qk=;
        b=U8QabPjpj3tRB1alKWIulERmrKeo4fPI/DLtEa2FoBKUcXyofw17LgF2Y5SFLCS1GJ
         RhXoBMfkErMQVwBXSxDp2YsbmM+Uis7X/e0lTCv3DqVzG6TEzx35PhKPr27+0oteywq5
         UIJ4JEDcaF2TgxDXuIyx06tB+Hr/FqPC5i6kHRO6208NDHTjNZRSa6RctBiuUa9+3R84
         YrD5bWapXhlHnzQ7ruDUjhDw0qObni4RGId7NFERVEvBCTC1OEoaeNdEvTUtxtovx+2H
         5seJLaAsBy2LVNOXSPuyD4CS9K2lwhOs+Q2wtYDAlnlrg9Xrq5tFWyGJphA77EfAYRyY
         51dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678814040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82+4kn0WzOMA+pL+/2ulEiwUoPfQ6iWm426J0EFz0Qk=;
        b=MoX1s9vvTL9MvtPCJez5qLaKGTE0pSwIaCGwWTU7EK4WELcbbmpQxPqI+DZ2eZy9m3
         4ETps4nA7KeKY8jNA+XuYSbhy/MYGFRYvhVdSPTH7TrQdGhSq0ICOjdOh1a7AT/RFyKf
         xKK6gHIvupYQKFQX5kKsFeCSzk2db3lmlExN+F6rxK1dZBIm4/01wzqCPy5PCg0cBz28
         q7UfhnFWEO1jmEFeofwaohl6CXqRizgZsPmLL9gPCD4NXwtXY7H0ef9mLZUYufMHickb
         6SIK0u5PISmPBZ466SEDv6AEgXb4gqdX1wlLa7HE/rGHLR2cd8v/cPtHsVxDaVr1LHqU
         k66Q==
X-Gm-Message-State: AO0yUKVS2lh1BvriyH5hNqe+wsZjCzZGOXk4B5pIfb5LiknlLJSDTqCw
        /DDDE2MBtHDivju7YTV2PjxcFn8s6e8=
X-Google-Smtp-Source: AK7set8MGdiy3EJyAGeWv8DcIrjpzWmMqnisR9EmRMRknRhqatoCmUkjpg17ULR4ykMvQ1ab8uiWTwZSXa4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:400c:0:b0:540:62be:42b with SMTP id
 l12-20020a81400c000000b0054062be042bmr8649700ywn.6.1678814039855; Tue, 14 Mar
 2023 10:13:59 -0700 (PDT)
Date:   Tue, 14 Mar 2023 10:13:58 -0700
In-Reply-To: <ZA/lYL7dsv7xBA01@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com> <20230311002258.852397-5-seanjc@google.com>
 <ZA/lYL7dsv7xBA01@yzhao56-desk.sh.intel.com>
Message-ID: <ZBCrVkDjaFAIP5vc@google.com>
Subject: Re: [PATCH v2 04/27] drm/i915/gvt: Incorporate KVM memslot info into
 check for 2MiB GTT entry
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023, Yan Zhao wrote:
> On Fri, Mar 10, 2023 at 04:22:35PM -0800, Sean Christopherson wrote:
> > Honor KVM's max allowed page size when determining whether or not a 2MiB
> > GTT shadow page can be created for the guest.  Querying KVM's max allowed
> > size is somewhat odd as there's no strict requirement that KVM's memslots
> > and VFIO's mappings are configured with the same gfn=>hva mapping, but
> > the check will be accurate if userspace wants to have a functional guest,
> > and at the very least checking KVM's memslots guarantees that the entire
> > 2MiB range has been exposed to the guest.
> >
> hi Sean,
> I remember in our last discussion, the conclusion was that
> we can safely just use VFIO ABI (which is intel_gvt_dma_map_guest_page()
> introduced in patch 7) to check max mapping size. [1][2]

Gah, my apologies.  I completely forgot about dropping KVM's mapping size check.
I was pretty sure I was forgetting something, but couldn't figure out what I was
forgetting.  I'll drop this in the next version.

Thanks!
