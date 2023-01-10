Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE86664CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjAJTzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjAJTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:55:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B25EC0B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:55:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v23so9430224plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQXt7KT7rQWXbK5ISzIvflXG6zBwOZWr92aCZw0pmYg=;
        b=AxQfSd4HoC4Ta45SieRRBRruVnmBLysNhQxFz6PQoT8/3pMFf/ft8rtSqAlezBlLkx
         ptD6WrG+pijPMCbSzgXXaSFiSVkLCMfpkBuZi90A2GeRTFbdowW8MbF3zYNhzsElSqC4
         cwVIEw2NMPeTWIM36QV+xv9ZdLlyYmaUoXGjuJOXLDhKVs1HLm/MFaW1icPaEL4K05S/
         tTHH4fK8yn4UmAET5BATOZmPNPmFsOvEGbkIgtUwTH7jEfqwSmfnT2hsbxyFAmur+H8X
         WElAAjOB2aNrBO7elLAjTAeuOU2TwjzvKhKBIBrsUv41rFT2j05+iadltrpygMI8WbN6
         qDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQXt7KT7rQWXbK5ISzIvflXG6zBwOZWr92aCZw0pmYg=;
        b=5b0oRgi2FPLb9QhYLMP2orEb79SMw2C3ECbs7xtuA+/f+GxmVA/fYOs7D/HCoLXbUy
         xoPgCCjPtLchXra185D+Kzbtrl6PmMKiYwVYE/U/NzbDHCW2R/tWdfaPKeH4bh0rid9X
         eAb1mcR7Ukfrgtat2R3/s2BqGP5Nj4lSMIZg4AxRD/3H3egnMhdQULbLb6MkIFfQadRZ
         ia21DV2zEWCr4qZ9IHAt8BH503BciRcOGK35XDPaC9b10R6RNGkcO+movrUHvI7JOrfr
         vajHhoDgjJjppkoL6E3nIvDGvH7pr6NbbLcBWxTQGZhagMqAdwawz34fip7ZOZC7dCyG
         3pBw==
X-Gm-Message-State: AFqh2ko5KGQpWqM3kI8/5DPyqRgIqyvaRRKyAZyhGXB9HThSEWj1/IlJ
        T8CvVXM16enKwQqRiPdnvytU+A==
X-Google-Smtp-Source: AMrXdXsefbvGgZxLIJhYtNjl4VGx8Soun/aRtqSig9NSGyZGHVW9himz33y+V1pSM+XJWnrboXQzeA==
X-Received: by 2002:a17:90b:3941:b0:225:e761:6d2b with SMTP id oe1-20020a17090b394100b00225e7616d2bmr67749pjb.1.1673380518115;
        Tue, 10 Jan 2023 11:55:18 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b00172b87d9770sm8563974plg.81.2023.01.10.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:55:17 -0800 (PST)
Date:   Tue, 10 Jan 2023 19:55:13 +0000
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
Message-ID: <Y73CoUO63TOxmmnC@google.com>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-1-paulmck@kernel.org>
 <Y7xSO2dW1sy21RVz@google.com>
 <20230109192228.GV4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230109200553.GA4154229@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109200553.GA4154229@paulmck-ThinkPad-P17-Gen-1>
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

On Mon, Jan 09, 2023, Paul E. McKenney wrote:
> On Mon, Jan 09, 2023 at 11:22:28AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 09, 2023 at 05:43:23PM +0000, Sean Christopherson wrote:
> > > On Wed, Jan 04, 2023, Paul E. McKenney wrote:
> > > > Now that the SRCU Kconfig option is unconditionally selected, there is
> > > > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > > > Kconfig statements.
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Cc: Sean Christopherson <seanjc@google.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: <x86@kernel.org>
> > > > Cc: <kvm@vger.kernel.org>
> > > > ---
> > > 
> > > ...
> > > 
> > > > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > > > index fbeaa9ddef598..9306d99585188 100644
> > > > --- a/arch/x86/kvm/Kconfig
> > > > +++ b/arch/x86/kvm/Kconfig
> > > > @@ -46,7 +46,6 @@ config KVM
> > > >  	select KVM_XFER_TO_GUEST_WORK
> > > >  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
> > > >  	select KVM_VFIO
> > > > -	select SRCU
> > > 
> > > Would it be too much trouble to bundle all of the KVM changes into a single patch?
> > > The SRCU requirement is a generic KVM requirement that's handled in the arch Kconfigs
> > > purely because of KVM's somewhat roundabout Kconfig setup.
> > 
> > No problem, and will do on my next rebase.  I might end up with a long
> > list of Cc's, but so it goes.  I will of course send the result as a
> > reply to this message.
> 
> Like this?

Ya, looks good!
