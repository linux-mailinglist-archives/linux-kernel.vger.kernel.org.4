Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24CA6DAEFA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjDGO4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDGO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:56:17 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FEEA5CE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:56:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1a1990341f9so645765ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680879375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6mWqAen+huGMPyP+21svtQ1LsJRWj8zxdxP8oalBOY=;
        b=Qlq75cZ7kqIeRwjCavq0ViVRfhkzlCIXzjxa9eZBBBjynshERxB99MwysnxeC58UyE
         gNdwwdEhKGB6vPlTn/+vxrsLGAI7Q4bW/wWNiSV8CqqZqF+luN6dyz7PmOGbsX7k6FKM
         H4ZNdfags4nGzxsv3pOov5H72JW8mM/rK8WqPQ/JaIETVk3Ws7HfinFWyNsQaIGSx7yX
         TiBRqDzqHE750SFx1w/FcRGxv+LbvwwJIQ8Y0qcJ64z+hLvTFNf5bqbmceFZF8eWbPQP
         IhLSM4YWViEULGPX4B/tgQ7txptQO9M8p8Vnyq0Rr6LvhzZLiRUjA1zgOt5ieEMXZwjz
         4sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6mWqAen+huGMPyP+21svtQ1LsJRWj8zxdxP8oalBOY=;
        b=zGcl0oZ02yaXZvW6UytdOn65oT7hz/wdzMQa6XpEcmE1nsjKRmoBRjY7mDvM2iNoCu
         IpYdDwFMB4aY/RiGMIAiWTQi0fHgQir2L4imLC0Bdl4mWaAAu4Ptrqq0SpOGLgROQD4u
         Rt8tM1TuZy//AiVYEvg4FWMUcu+e5sDNUW+ojtp1RgP8sDU8OK4l4PwOay4tQTB5ne2e
         gGpKQweRvinILUydlMfeSpoGOUaUCCBV779OZOIghtHFzBv67Vs5qUTYcWv0IANwZat6
         glgOrp5TJ19APnQKJZ7t1qPA8faSferqTxZfWsYKeZI6azQfQcNXBMZbaFl1UpQagXHs
         thlQ==
X-Gm-Message-State: AAQBX9ddicEvXEwdUGZN7yg2kLSzBtKAjV953Q+D68kXgPsusmJwds/S
        xUOddayPHb056zMYA2hgJKjNFqZ/+rI=
X-Google-Smtp-Source: AKy350awyKr49en/mItoGtTY6vyDxsYss/X5jxjoGO/x2Toi8XDWdM4oNSMxd1pZitth4jl9RSr4wMyuv0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:802:b0:627:e180:abed with SMTP id
 m2-20020a056a00080200b00627e180abedmr1498433pfk.1.1680879375751; Fri, 07 Apr
 2023 07:56:15 -0700 (PDT)
Date:   Fri, 7 Apr 2023 07:56:14 -0700
In-Reply-To: <509b697f-4e60-94e5-f785-95f7f0a14006@gmail.com>
Mime-Version: 1.0
References: <20230310105346.12302-1-likexu@tencent.com> <20230310105346.12302-6-likexu@tencent.com>
 <ZC99f+AO1tZguu1I@google.com> <509b697f-4e60-94e5-f785-95f7f0a14006@gmail.com>
Message-ID: <ZDAvDhV/bpPyt3oX@google.com>
Subject: Re: [PATCH 5/5] KVM: x86/pmu: Hide guest counter updates from the
 VMRUN instruction
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023, Like Xu wrote:
> On 7/4/2023 10:18 am, Sean Christopherson wrote:
> > Wait, really?  VMRUN is counted if and only if it enters to a CPL0 guest?  Can
> > someone from AMD confirm this?  I was going to say we should just treat this as
> > "normal" behavior, but counting CPL0 but not CPL>0 is definitely quirky.
> 
> VMRUN is only counted on a CPL0-target (branch) instruction counter.

Yes or no question: if KVM does VMRUN and a PMC is programmed to count _all_ taken
branches, will the PMC count VMRUN as a branch if guest CPL>0 according to the VMCB?

> This issue makes a guest CPL0-target instruction counter inexplicably
> increase, as if it would have been under-counted before the virtualization
> instructions were counted.

Heh, it's very much explicable, it's just not desirable, and you and I would argue
that it's also incorrect.

AMD folks, are there plans to document this as an erratum?  I agree with Like that
counting VMRUN as a taken branch in guest context is a CPU bug, even if the behavior
is known/expected.
