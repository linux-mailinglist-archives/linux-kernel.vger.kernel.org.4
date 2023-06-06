Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123F8725024
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbjFFWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbjFFWtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:49:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017010FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:48:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977cc662f62so526194666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686091738; x=1688683738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=11+Fn4bWT5HyJ3ecoDvvkwIK5czC1OHLstovcMpNWzY=;
        b=xcFZ20/KI+gH9h1aswr2cXKq1khb/AkPQgQD7SPzq6sKaNG6t48qOijlqVmbkAcMVU
         RFs7rjdiIE4O9Wy+Y8AQMk5o8G3I3Fb7p7QpAvafuk7IEDDOfdGA3tMKDWEX9CRjNTrZ
         Z4SrXwPoYzdF5UJm/TRHnGPPmkuC71JZwiDk2/HhCakKGFFGDpFjmFkCYn4KhRb9AY9o
         sF5MEw0HUw0U3aJ7KokhAceEYqfdx0V5nVskcI/09ta04XaNf1RuFynMYsTorTQXPup9
         sRRCFoXdF/CwzkLg3bfBrzqWawkcYwxmcgAMO2+/J1wbUfMuI808wmmWz3b3R8SxAdx2
         knyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686091738; x=1688683738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11+Fn4bWT5HyJ3ecoDvvkwIK5czC1OHLstovcMpNWzY=;
        b=NhBtgqobjJNYR34IS2Ar9GysS3JwB5z0h+rgsbjfaswnd16LWo5iWxbv7A1Rr8T3e3
         YIWBlyjq2M5x1Iiq/a9wKRPX6FneZObuvhK/GJCf4HqLrdDSiXGr/TD5sJQtbvKMKp0r
         hcIHWyB+k7fJknpNrVFHxMWZ4x3nQfMTpolZ9wRs6oGNNlxf5dtq1BvCrR4nfaOtxdtU
         mHQtPRVvQh3zcsD8b2bLijh6A/sEVw6KaEQYhwWrlY7ZDoQiy3phRzs+UETjGXRCifcc
         rx2es1scXGGRACVZRdHQOZbfERRgsF0lT4K7lsQ+k60Ba03oSr9fy2cvlSH8aaXfyv8l
         ncig==
X-Gm-Message-State: AC+VfDzmg77D+tn7L11Ynqkh37jbesmefvw0ki/l4irjjzK8GzqUhT7P
        RA7IlBdq/V8+v1x8l6z19GpouXAef9y05mcDPpMCUA==
X-Google-Smtp-Source: ACHHUZ7xhee1qjb5EuLRWpJGvhhzLzGQuJgaZrzsesCOJRGZzNc7bWUN57xNpGt1XoyAFy14iHmF2n3zHxQnLo/XN+U=
X-Received: by 2002:a17:907:dab:b0:977:95f4:5cca with SMTP id
 go43-20020a1709070dab00b0097795f45ccamr4445607ejc.54.1686091737924; Tue, 06
 Jun 2023 15:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230605004334.1930091-1-mizhang@google.com> <CALMp9eSQgcKd=SN4q2QRYbveKoayKzuYEQPM0Xu+FgQ_Mja8-g@mail.gmail.com>
 <CAL715WJowYL=W40SWmtPoz1F9WVBFDG7TQwbsV2Bwf9-cS77=Q@mail.gmail.com>
 <ZH4ofuj0qvKNO9Bz@google.com> <CAL715WKtsC=93Nqr7QJZxspWzF04_CLqN3FUxUaqTHWFRUrwBA@mail.gmail.com>
In-Reply-To: <CAL715WKtsC=93Nqr7QJZxspWzF04_CLqN3FUxUaqTHWFRUrwBA@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 6 Jun 2023 15:48:21 -0700
Message-ID: <CAL715WKHLzpnHF+HZH_8fNkUMfHYGHAOQacUNRR0b6-WpUuFMA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Remove KVM MMU write lock when accessing indirect_shadow_pages
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > So I think this?
>
> Hmm. I agree with both points above, but below, the change seems too
> heavyweight. smp_wb() is a mfence(), i.e., serializing all
> loads/stores before the instruction. Doing that for every shadow page
> creation and destruction seems a lot.
>
typo: smp_wb() => smp_mb().
