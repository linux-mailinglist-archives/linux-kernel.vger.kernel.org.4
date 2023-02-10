Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A269161A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBJBNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBJBNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:13:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CCC5EA07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:13:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m2so4914052plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 17:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3av9jkUvE9A6NJ/myH2LVzHPBwDhgbAq+TXm0rIoTM=;
        b=PHZQYT5oASeECsZsHRHQMGmmlRn/fh1qFIyHRbeqb6UKHavmxO4hmYGKVNZ3HXfHCP
         OC+jObRKncg1lbUI1c6zLMxOulEL4CDQTfhrHtjSFhe60xMZzvHSZKHiz04WTd812P6c
         /gmzgZGkx8I5YMNuPo9O28D4S2q+ikgRILRReal9hzuIijl6Zu4RVW6sHImTFlsiNrI3
         YVkJmEkMBeHhPbqmrRnCQuyvV8054XIVeM+4KGPkRjrFvaIx64M0S/WFnVQwX9NNiWbF
         hMWRMMEk9Iz3eHX6+Tp6StYtSqPySt+Z95pXifmRZBUzvX8dri+GKO8RUx9Sfcd1JPKs
         b1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3av9jkUvE9A6NJ/myH2LVzHPBwDhgbAq+TXm0rIoTM=;
        b=dndNRt7w0prAX/8qzNVcnQC6GqMb4OSPKUGFgh1erdO/5kE7Ag575NdvVSfY6znPSe
         uOE7Et7ktmJVLzQba3G/bc+ZqDTFBraQMwSPJBID069a9yeOfv6oInfXBvJcqvjaKy7o
         l5Po8EilfJ36pdqbZH3gnNzt7scul5OlavIdQM/rwhQWQTkPUW+qutFKSg7p/dBrgFvc
         vdaDyXTaUHpYGxhzb8nWY+knD+prFjdP9zgcf3r6IHU8GfVSo2VV1gE8y0H0MCo92MW6
         sPiD03K6IgXut396EbR7bVegLMvB0/T1qz2fWQlRc0V3dgMLtpopXaKCka1Zy/VXa1LY
         XcUA==
X-Gm-Message-State: AO0yUKXJeB9XFX31j+zOOa/Z1/xmOduwEC0i6/vrXLeAzuglI8mWO3c6
        zF4jyFgp5+hmfkJwnm50cMfY401QHugk/tjH44g=
X-Google-Smtp-Source: AK7set9pFw3J5w5r/xV/SoTgrT6GjoR14zs1JLwGP7oCVVKObwM+RL2W/uCJ6aaf3zqmyu8HS/ZqXg==
X-Received: by 2002:a17:902:ed89:b0:198:af50:e4e4 with SMTP id e9-20020a170902ed8900b00198af50e4e4mr102079plj.10.1675991613691;
        Thu, 09 Feb 2023 17:13:33 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i25-20020aa78b59000000b0059428b51220sm2040561pfd.186.2023.02.09.17.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 17:13:32 -0800 (PST)
Date:   Fri, 10 Feb 2023 01:13:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, Tom Rix <trix@redhat.com>,
        kvm@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Stub out enable_evmcs static key for
 CONFIG_HYPERV=n
Message-ID: <Y+WaN8wW1EOvPbXe@google.com>
References: <20230208205430.1424667-1-seanjc@google.com>
 <20230208205430.1424667-3-seanjc@google.com>
 <87mt5n6kx6.fsf@redhat.com>
 <1433ea0c-5072-b9d9-a533-401bb58f9a80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433ea0c-5072-b9d9-a533-401bb58f9a80@redhat.com>
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

On Thu, Feb 09, 2023, Paolo Bonzini wrote:
> On 2/9/23 14:13, Vitaly Kuznetsov wrote:
> > > +static __always_inline bool is_evmcs_enabled(void)
> > > +{
> > > +	return static_branch_unlikely(&enable_evmcs);
> > > +}
> > I have a suggestion. While 'is_evmcs_enabled' name is certainly not
> > worse than 'enable_evmcs', it may still be confusing as it's not clear
> > which eVMCS is meant: are we running a guest using eVMCS or using eVMCS
> > ourselves? So what if we rename this to a very explicit 'is_kvm_on_hyperv()'
> > and hide the implementation details (i.e. 'evmcs') inside?
> 
> I prefer keeping eVMCS in the name,

+1, IIUC KVM can run on Hyper-V without eVMCS being enabled.

> but I agree a better name could be something like kvm_uses_evmcs()?

kvm_is_using_evmcs()?
