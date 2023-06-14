Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08A723428
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjFFAv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjFFAvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:51:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C43102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:51:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefcbso11987187276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686012713; x=1688604713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaC1BVyiTSACOimpWYxrbewiqoPZUcVuky2w3w58ifU=;
        b=5gX+/+yCPmRKoyOpvv4Qx644IBMjX8OPyZ30BerYR6ft9ojiTI5Yf0eDv07NXMuCBD
         8kygK5apPu19nj6ZM9wZh9H7qyqxfV0RqplndC6aItojYMcf4jCEeV2OvQFcORsvb97Q
         nDzNk1mfdCHznJfYBwkxnkolKh8f5cp2usCe4koQDHjp7Bpflwnf3imWGgR21UxtyL83
         ztonG340JXI0D4rgyYc7c7DKCFPrKOUQ/d2rE/fN36E9/ox6IgrFOWTr5jZmM8ENkuli
         T9J6CZv8WKTD2eHyrZVe7oySyIc905jZs9WhVbnfGrQIglax+ItrqGPZzNbQY6KuC2a2
         5fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686012713; x=1688604713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaC1BVyiTSACOimpWYxrbewiqoPZUcVuky2w3w58ifU=;
        b=MgXavDUZWC9b+z+9Ck28oLFpDUQXFWf1Ob5NXGkBeVXmtoOTjh9p0E8YOyXK/wtyF6
         j8pipKkETwO+qgC4VHMURD8EgTLBx+d8IZUnyPK9Hbwh9m/fI1RmDzK/4BxMYRiJvoqy
         aC7zW3qaizc3yoRmbdqzw3+gQgFZe2S/s4Cyrlosg+094Lmawr2LhMXO49UfhN2FKSmj
         k4zerDwW+2Ir9e4ftwxRzYYGMU2r/Bsb+58H2wgquQYT59c6+ebhHSeR2U22Hq2I48+l
         GpBWgKuFY56H6VXPSvICjtVe00539ylpng9uwk5TApUBSeIfNS8oD+kWCTI8YMgf9JxC
         PDZA==
X-Gm-Message-State: AC+VfDy2SDGvIiPeAlhNlxovRV21UM1/Lerrtb9/RlEKpWzky5MVCf8e
        YBeQ2MQcVKHWuSIoGXQ6saHIGFRyAqM=
X-Google-Smtp-Source: ACHHUZ6iy3FTgGekRu7R4qlbm+XMy4B1g6+nEKn8HnJOc/2cdntWuI34dSn7U6uz6hk+9Y0M1vhbXIrs150=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b7ce:0:b0:bb1:569c:f381 with SMTP id
 u14-20020a25b7ce000000b00bb1569cf381mr429767ybj.1.1686012713004; Mon, 05 Jun
 2023 17:51:53 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:51:51 -0700
In-Reply-To: <20230504120042.785651-1-rkagan@amazon.de>
Mime-Version: 1.0
References: <20230504120042.785651-1-rkagan@amazon.de>
Message-ID: <ZH6DJ8aFq/LM6Bk9@google.com>
Subject: Re: [PATCH] KVM: x86: vPMU: truncate counter value to allowed width
From:   Sean Christopherson <seanjc@google.com>
To:     Roman Kagan <rkagan@amazon.de>
Cc:     kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <likexu@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Hankland <ehankland@google.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023, Roman Kagan wrote:
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 5c7bbf03b599..6a91e1afef5a 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -60,6 +60,12 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
>  	return counter & pmc_bitmask(pmc);
>  }
>  
> +static inline void pmc_set_counter(struct kvm_pmc *pmc, u64 val)
> +{
> +	pmc->counter += val - pmc_read_counter(pmc);

Ugh, not your code, but I don't see how the current code can possibly be correct.

The above unpacks to

	counter = pmc->counter;
	if (pmc->perf_event && !pmc->is_paused)
		counter += perf_event_read_value(pmc->perf_event,
						 &enabled, &running);
	pmc->counter += val - (counter & pmc_bitmask(pmc));

which distills down to

	counter = 0;
	if (pmc->perf_event && !pmc->is_paused)
		counter += perf_event_read_value(pmc->perf_event,
						 &enabled, &running);
	pmc->counter = val - (counter & pmc_bitmask(pmc));

or more succinctly

	if (pmc->perf_event && !pmc->is_paused)
		val -= perf_event_read_value(pmc->perf_event, &enabled, &running);

	pmc->counter = val;

which is obviously wrong.  E.g. if the guest writes '0' to an active counter, the
adjustment will cause pmc->counter to be loaded with a large (in unsigned terms)
value, and thus quickly overflow after a write of '0'.

I assume the intent it to purge any accumulated counts that occurred since the
last read, but *before* the write, but then shouldn't this just be:

	/* Purge any events that were acculumated before the write. */
	if (pmc->perf_event && !pmc->is_paused)
		(void)perf_event_read_value(pmc->perf_event, &enabled, &running);

	pmc->counter = val & pmc_bitmask(pmc);

Am I missing something?

I'd like to get this sorted out before applying this patch, because I really want
to document what on earth this new helper is doing.  Seeing a bizarre partial
RMW operation in a helper with "set" as the verb is super weird.
