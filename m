Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80371F75C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFBAur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjFBAup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:50:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C91E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 17:50:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568fd72993cso50412907b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 17:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685667043; x=1688259043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwDLvloBHLyRnlYV3ilTxE4DfXWJDonOEINeBkDblso=;
        b=ioyx/i5EjbogKgkMKMycd7DwDlffY7dtgmNR4/95N0IhgC40k/BLk6Q4bWmoDv+vxr
         GIolc3vF+dr9ORF0r6N6zs1JF4pmqnSWh7zryylKxB8jcVyd7alDEDyxB7pvhiPpHviG
         JHEPmGctVGXgShujLr2EVSmNDX2A1GSRimJJcDM7U1YjQpsnlHd8iPEzccplQcCqSdcx
         7Yvwdihx9U3mylWk6i3/ITuBt8+BzkwP0ZHJYNi8Yzzk3bvTnmP7n+2ZBVwqyR5mp1wC
         spnnzHQogWGIG8upOOYGiGEEuIx1FPgeRjlyqWyO6B4fLV+u41R8C91SCawHMRYo5MUE
         ho5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667043; x=1688259043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwDLvloBHLyRnlYV3ilTxE4DfXWJDonOEINeBkDblso=;
        b=iSFJ7iHLDvEuTI35fr0y6MyaX/f7eVLwWr7VM6nnacBxrvL2x2jqDat2tDfIUb44ef
         t7QSEGBIpS7rUdRVBLXyRNX+vmxhqfgJdBnAWsUzGW/z4wdLLloVOALdv4yGhaTlB1zY
         IQLDlsTOjbQGb+mV/QgJ2HA2jUscpXGnRSKDt2vlrw7VqKl7F3ArqywjoVLnUDyjDJj9
         gsf55kONTBykkrLuJK2CC7cIDHfohAZJ2H5vqQuTYI7qUVnZTqIaBdTnIQ4RpR+MdK4i
         Zuyr4FHk0nyx6fTAKWqbVJc7tc+MQ/Ubw+X66Ril2Vqiti94Gt5ufV4ERewEkqZ4khrM
         ujoQ==
X-Gm-Message-State: AC+VfDwk2VnNf4gdrmuWNw4JIpSUIx6+P9hoXmHHKR9kWcQeLaENK59H
        XkIapHqzVCJeslpnXhF+w8MJZwIy1pA=
X-Google-Smtp-Source: ACHHUZ658NqNsdViSWdcB5ZYCHZmMOFx+wxk5f24o6x1at/+KIqRTfU+iG14fzFBoHZWLvXBi2RGAiAYz/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:386:b0:561:1494:69f8 with SMTP id
 bh6-20020a05690c038600b00561149469f8mr2639416ywb.1.1685667042796; Thu, 01 Jun
 2023 17:50:42 -0700 (PDT)
Date:   Thu, 1 Jun 2023 17:50:41 -0700
In-Reply-To: <20230530060423.32361-6-likexu@tencent.com>
Mime-Version: 1.0
References: <20230530060423.32361-1-likexu@tencent.com> <20230530060423.32361-6-likexu@tencent.com>
Message-ID: <ZHk84Ts9txpz5djC@google.com>
Subject: Re: [PATCH v6 05/10] KVM: x86/pmu: Disable vPMU if the minimum num of
 counters isn't met
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023, Like Xu wrote:
> According to Intel SDM, "Intel Core Solo and Intel Core Duo processors
> support base level functionality identified by version ID of 1. Processors
> based on Intel Core microarchitecture support, at a minimum, the base
> level functionality of architectural performance monitoring." Those
> antique processors mentioned above all had at least two GP counters,
> subsequent processors had more and more GP counters, and given KVM's
> quirky handling of MSR_P6_PERFCTR0/1, the value of MIN_NR_GP_COUNTERS
> for the Intel Arch PMU can safely be 2.

Not sure what you mean by "safely", but I don't think this is correct.  KVM can,
and more importantly has up until this point, supported a vPMU so long as the CPU
has at least one counter.  Perf's support for P6/Core CPUs does appear to expect
and require 2 counters, but unless I'm misreading arch/x86/events/intel/core.c,
perf will happily chug along with a single counter when running on a modern CPU.
I doubt such a CPU exists in real silicon, but I can certainly imagine a virtual
CPU being configured with a single counter, and this change would break such a
setup.

And *if* we really want to raise the minimum to '2', that should be done in a
separate commit.  But I don't see any reason to force the issue.

No need to send v7 just for this, I can fixup when applying (planning on reviewing
the series tomorrow).
