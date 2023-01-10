Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D92664753
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjAJRWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjAJRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:21:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653272F7A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:21:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m6so19526430lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BiD9HDtY677v73zD/DAwV3gxXKXHJJtF5vodMznouXI=;
        b=LtCcapEfaq7jnw+0fGg77tKfZIsc0Ia1/E/mVPvdvIeEfaUDocpq2qs66q6GPOw+JK
         Pxve+JFGST72umFROmdvgPrsqTgozMzdSDcaFCaoI1HgN98eGnYmPwCErho77OzrCd0l
         DLNCw3XmItwejeHB5US7WEj8eASOgmF6/aqG0U7Ua0YD0Moww9aHxy4rjyUyEuGrLljV
         HW2zTdvTCyJ57N8jf8aGm4sEhw5g2bqc3PYf41lorsBz2Vn69tLFRehGj5nuHhYxNFGF
         dfwiulkdAaoKjGof+vEdw0VtFxBzi3L3diD4231k+0gVkLoVA8PLU6bBwlDNdQGnujjB
         vMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiD9HDtY677v73zD/DAwV3gxXKXHJJtF5vodMznouXI=;
        b=YhFFySa2JQYbgpFbp+hOvCZMl/Ce+qpPa5HzQ3wzv6aXvsdYX/4oJLeNMxghT0p45J
         StwF0MWu4W55OrIJk0IlPDGFoarTYlcK9viMyHhmqo7If3XPQFLhKeoaifWcuRxZM/Cf
         smcrnb6+91e9VuNOAKrgyatjN8lSgaaTiyK2DVm7w0veyy4LRtUAwq/3mX8R39laA5xh
         a4GjNruzDzLfh3f1re+YCl/Qn8rk+/OBBiat1uPDgBnOSzqVuI8Z9Mcvceg5dJGJ9fZc
         D367KAC6aJf5Yz/0Ne3qBsIywOHIvRXXFe2/qEq1lgm+I/RE987X+DzFT8ig+iiQqtpA
         BM+Q==
X-Gm-Message-State: AFqh2kpJwDVoCqeyBGdGQxqc60xYz/jrwISeo9zp1HbwpA9Yj39blNLe
        RpObu1knyVS91ZCx+zCh7GkQPaQQF6jvk0cB/SI8qQ==
X-Google-Smtp-Source: AMrXdXvlEhCNddUYn/gUScAlB9NgzJOTwBVEkk8vjb8E2yu2dOexlTIBWM5iNW3SRH+747A4nRXGVYTTy+jvR2TDsAU=
X-Received: by 2002:a05:6512:22d6:b0:4cb:3ff7:f24a with SMTP id
 g22-20020a05651222d600b004cb3ff7f24amr1538148lfu.409.1673371262485; Tue, 10
 Jan 2023 09:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20230109160808.3618132-1-pgonda@google.com> <74745684-785e-71b2-288e-91fbcf1b555b@amd.com>
 <CAMkAt6q_E-+VV=KOs9LbDzawirWR7M4xL2pCF9fR2kMuBuFM-A@mail.gmail.com> <d6c2455c-aff5-a135-2610-53dd6b586b59@amd.com>
In-Reply-To: <d6c2455c-aff5-a135-2610-53dd6b586b59@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 10 Jan 2023 10:20:50 -0700
Message-ID: <CAMkAt6orqOCrOiy=kjBq=5jnP1CyM=cbaYYaVAZLDnqbRpgUCw@mail.gmail.com>
Subject: Re: [PATCH] KVM: sev: Fix int overflow in send|recieve_update_data ioctls
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, Andy Nguyen <theflow@google.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Jan 10, 2023 at 10:16 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 1/10/23 10:44, Peter Gonda wrote:
> >>>
> >>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> >>> index 273cba809328..9451de72f917 100644
> >>> --- a/arch/x86/kvm/svm/sev.c
> >>> +++ b/arch/x86/kvm/svm/sev.c
> >>> @@ -1294,7 +1294,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >>>
> >>>        /* Check if we are crossing the page boundary */
> >>>        offset = params.guest_uaddr & (PAGE_SIZE - 1);
> >>> -     if ((params.guest_len + offset > PAGE_SIZE))
> >>> +     if (params.guest_len > PAGE_SIZE || (params.guest_len + offset > PAGE_SIZE))
> >>
> >> I see the original if statement had double parentheses, which looks
> >> strange. Should this if (and the one below) be:
> >>
> >>          if (params.guest_len > PAGE_SIZE || (params.guest_len + offset) > PAGE_SIZE)
> >
> > Isn't the order of operations here: '+' and then '>'. So is the patch
> > correct and matches the old conditional? I am fine adding additional
>
> But what was the purpose of them in the old conditional? They weren't
> necessary.
>
> But, yes, that order of operations is correct and those are both before
> '||'. So the extra parentheses around the second condition check are still
> strange then, right?
>
> Given that, then:
>
>         if (params.guest_len > PAGE_SIZE || params.guest_len + offset > PAGE_SIZE)
>
> > () for clarity though.
>
> I do like the look and clarity of the parentheses around the addition.

Sounds good to me. I'll update the V2 in a couple days to wait for any
other comments.

>
> Thanks,
> Tom
