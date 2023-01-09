Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3005662DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbjAIRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjAIRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:43:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE91D1ADA8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:43:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y5so6722946pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSSXv+I+w/8fq5Yx5Ez6ORBTwPIwCfMMjmGhcpp+UqU=;
        b=g0eGXd1q88kKO1UBdVGzjP/95p/jpiFOz1tlu9gArFeF2qE16G4bVRKZnTw+XZWtP+
         EXrJCYtuU4eMsLsoIGwLHGE/k07Dndjexhtc4+89wiIh6t0htZq88FgfPeF2HiM+62gW
         6bVYPLutu6hFNdoSRn3rQ3obSPWJsZ/DaHbp0ph0JiEXjk2KMis4Qd8AW9xA1OlPRfcO
         IRE2Tydovrr2fE+hnvN0agTBvFC49yxzQWirTToKPy0kam/RY/O5O+6uTm/r2z8YrQ3h
         YOdKyhwgMJMT55xd9yRJf6srnW5aApxQjTtPOI1niagvZTpis4FDOtgy/qD+Nl8IXzWT
         vPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSSXv+I+w/8fq5Yx5Ez6ORBTwPIwCfMMjmGhcpp+UqU=;
        b=4RkI0ecefLc3wHn8mNY4nTA9eCtdMpQP9OnIzGFJzlfhrX/vI16ygTUPvVOCguL28D
         c2kgwJwOvVeQpGr5A/3Cog2cPuyncfNjjfSktVq8sk2tmHcjaW1JrV6mNF+pULCuxoY3
         aSiedBJ68K3PSWTv39WTrGukkZcesaik2ixOz8gmup/o/KT5TQUM9b0grqLUb+FfRTQB
         lmWHWnuqCuErm3A9legfSI2m+E9H8gf+QvXZ6c8Ac6pVvToCmSl7W93p0dZIN0yVSv1y
         265yBty+ZuEq4gFs0FHet072uG07xcRAbEHCYAHmpuIeE5LBenRdNU6H1Kace/c+ad/4
         kGTA==
X-Gm-Message-State: AFqh2krKg87P7+IzKzBE4dtk1mi9Fb7lV9ae8DxZFpDVXxsYrd/kBg3A
        SIf4r8uYrOkFgl49LF4Qs01SxA==
X-Google-Smtp-Source: AMrXdXuahdX5fT5IrjPkz4RnJUA4Kk4OaigXHUxhSIcCKVvee6MrvxGtSvPNdBbAdchzeYDmGAb45w==
X-Received: by 2002:aa7:9249:0:b0:576:9252:d06 with SMTP id 9-20020aa79249000000b0057692520d06mr740111pfp.0.1673286207259;
        Mon, 09 Jan 2023 09:43:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b00574b86040a4sm6350861pfd.3.2023.01.09.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:43:26 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:43:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH rcu 01/27] arch/x86: Remove "select SRCU"
Message-ID: <Y7xSO2dW1sy21RVz@google.com>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-1-paulmck@kernel.org>
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

On Wed, Jan 04, 2023, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: <x86@kernel.org>
> Cc: <kvm@vger.kernel.org>
> ---

...

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbeaa9ddef598..9306d99585188 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -46,7 +46,6 @@ config KVM
>  	select KVM_XFER_TO_GUEST_WORK
>  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>  	select KVM_VFIO
> -	select SRCU

Would it be too much trouble to bundle all of the KVM changes into a single patch?
The SRCU requirement is a generic KVM requirement that's handled in the arch Kconfigs
purely because of KVM's somewhat roundabout Kconfig setup.

>  	select INTERVAL_TREE
>  	select HAVE_KVM_PM_NOTIFIER if PM
>  	help
> -- 
> 2.31.1.189.g2e36527f23
> 
