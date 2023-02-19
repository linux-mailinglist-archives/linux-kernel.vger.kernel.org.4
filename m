Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E769C1C2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjBSR5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjBSR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:57:14 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A2E1026B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 09:57:12 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5369b3204daso12430857b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sscneNe11LR3WffkFyUD3z+Ja4W5fhnimf00dL+tzak=;
        b=WftmOx8+im1S7FRJ5eHmM1GLa3IimgiHInS2RR0fhJV5qHCEX0LMJ8YmJdAiHU3R84
         BVEJRRQz+YleupKdWZtxqzXlgvzgIfBHE91bxS8w40mxAIE9PC5fWc7r1mdAm4a3jciH
         TLOxb2i5aBOVkmSoeb6erf2TA7JsQEqVdV2d7LcMLLTUqGCia5bfvE6ZO/nc6d9OTrmV
         OzPT9Rwim/drYpF5ygMCVZ9UGYlDTv/I2Hn+6/wciZcgvBdcvpqpsCkMvRAogUD9jbwY
         TRVdNkOVX4ohiTVperjU+YwvJanbdE2Qc4EzE20VsKhljdjs+hnVqOnMQ45Bnpf0x4xN
         waBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sscneNe11LR3WffkFyUD3z+Ja4W5fhnimf00dL+tzak=;
        b=X/VYTO4KM54MGm6+cNIwOY/mr0qlHV8d5I0DiH+0U1L+jihCi5Iy7qoCugjZdVPSUg
         arZFkMrK8BcRtOAZyEN+lP2CwHS+UhQx1hm+1NJefT30v7/Y5z3sxgyLBeGJcbE7o/ef
         7cmNzQM9k1FWY4rcWv4bJhM8LJDGDtZQXQ53tYl0J2FFskUO75XY/ZJiRgjvoRmCnIHY
         j2S7bhrbAgmywKU7U2Mny/7jOSz/fwuib/aHGXVF0gNmvcP++px26U9qitMxU2CkeWie
         nM9PWDuRCZto7ebxvRSlfN8vNiVFypa8DBPoHdC5xJknAtgA+DoriLTXGBoDVHHGH9zf
         yULA==
X-Gm-Message-State: AO0yUKV9T1OJ/k7h3ZhMUbWCSgaSks6kLrDPZ9iITDaULWyhRB42srHQ
        r0q1hQXiTfDa48mtDMlGE+WV+VtdCKN4qRVvZGqIDw==
X-Google-Smtp-Source: AK7set+65qfecMTYI0Ahz8F1uyux6Ma918+90Z7sXd1YIA5huooyLk5OpQDe0rfdJlYabaYOSaW9Udk1FdvuioaoOvc=
X-Received: by 2002:a81:7302:0:b0:527:9fc2:66a3 with SMTP id
 o2-20020a817302000000b005279fc266a3mr11464ywc.83.1676829431453; Sun, 19 Feb
 2023 09:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20230214184606.510551-1-mizhang@google.com> <20230214184606.510551-2-mizhang@google.com>
 <Y/He1Sro3hb7Hn0h@gao-cwp>
In-Reply-To: <Y/He1Sro3hb7Hn0h@gao-cwp>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Sun, 19 Feb 2023 09:56:35 -0800
Message-ID: <CAL715WJx1bjm21JnGzbsre+OQQnsKZ+rXQDqNAp9NwixZ_zEow@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: selftests: x86: Add a working xstate data structure
To:     Chao Gao <chao.gao@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Feb 19, 2023 at 12:33 AM Chao Gao <chao.gao@intel.com> wrote:
>
> On Tue, Feb 14, 2023 at 06:46:00PM +0000, Mingwei Zhang wrote:
> >-      /* xsave data for guest_code */
> >-      xsavedata = vm_vaddr_alloc_pages(vm, 3);
> >-      memset(addr_gva2hva(vm, xsavedata), 0, 3 * getpagesize());
> >-      vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xsavedata);
> >+      /* XSAVE state for guest_code */
> >+      xstate = vm_vaddr_alloc_pages(vm, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
> >+      memset(addr_gva2hva(vm, xstate), 0, DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
>
>                                             ^ this should be the size in bytes instead of in pages. Right?

Right, thanks for catching that. I will fix it in the next version.
