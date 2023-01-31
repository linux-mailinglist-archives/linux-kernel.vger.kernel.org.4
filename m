Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177C26831E7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjAaPxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjAaPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:53:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035D417154
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:53:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l4-20020a17090a850400b0023013402671so2816541pjn.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BDBGIr020TIEN48KHoXszHSY7JH31zE2b6DhwjqkpU=;
        b=i0jigBhmeRjaAtvW2bVUaQPHSOXnmtp6KW5DRBVBoMs9M95X0qKfuKWydeztA7qQ9A
         +PqS3GEUcHUGwBfRKP3Zuz3rfg+thRbu4mVBTTUBXhpE9TUVjx24IUQzns0scPtIXuMT
         ctgHAVgpKcpJ7by5c58aOPLIilAVT9b9knMJz8fqgIO1SLTBHQ7f8kLcc5QbQOpKEC9Q
         qJFBMGogqJC3mGYSXcXl1IxvbUJfJ6CHTl5z6jH2in9+Gl1URvuhstI5fQt6nPIRDK0n
         wBCdfAIvDjt2WfX6v2ee8EjsAimhl2K90y6zivnNcHzOd78Q7m/lJtG+6nBvZHCHKZmh
         iFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BDBGIr020TIEN48KHoXszHSY7JH31zE2b6DhwjqkpU=;
        b=Ori/HJITzC4lKM74OiR/s7o1etYYcreke/zCRXKTNwPOjJmf0CFokLW0f9dLrFtv4m
         wjtQ0wRIIPKgiWT6sy+pj9/jWz7EhtZ2ZWjBz8WbJlQYVHOXSM1R1+pwtizkLH2vQyNY
         hMIAkDeVFITMvBec7MTO6QgKtA/YFh1K+VzyhsgOBfVCOjP4U63ucy+XnRJOZz/L/F+v
         OQNoqZETNUSuRWc6Hf0X4GQRdrRtFaW+wsg00uscpLWnte/kbWSiBoB4tqpqp0w8vvzD
         n9oWxAn2OeGmiKDnbUThoUYRiBEUY9oQbupv8Df02MFGv2RoMJIabLhGhQqFPYoZkjeP
         L1QA==
X-Gm-Message-State: AO0yUKXFGTWAF658jHAblYDJwFbbGfHLgJ033pGtd9QbxF9nEEzM3MZM
        J+WOhTGe5SEqr4CIj6fo5aaBxg==
X-Google-Smtp-Source: AK7set86Spbju15zAbisK2mmq3j8WKEdenghpKFRQltXbuwmg9z/EBPdC24x5DEU09pf9f5AKKLB0w==
X-Received: by 2002:a17:902:b686:b0:191:4367:7fde with SMTP id c6-20020a170902b68600b0019143677fdemr1307314pls.0.1675180423267;
        Tue, 31 Jan 2023 07:53:43 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b00196768692e0sm5338448plb.86.2023.01.31.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:53:42 -0800 (PST)
Date:   Tue, 31 Jan 2023 15:53:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [Question PATCH kernel] x86/amd/sev/nmi+vc: Fix stack handling
 (why is this happening?)
Message-ID: <Y9k5g5jYA/rjIwUj@google.com>
References: <20230127035616.508966-1-aik@amd.com>
 <Y9OUfofjxDtTmwyV@hirez.programming.kicks-ass.net>
 <Y9OpcoSacyOkPkvl@8bytes.org>
 <b7880f0b-a592-cf2d-03b9-1ccfd83f8223@amd.com>
 <Y9QI9JwCVvRmtbr+@8bytes.org>
 <3bb3e080-caee-8bc8-7de9-f44969f16e75@amd.com>
 <38C572D7-E637-48C2-A57A-E62D44FF19BB@zytor.com>
 <Y9jX9AKYP8H34wGI@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9jX9AKYP8H34wGI@8bytes.org>
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

On Tue, Jan 31, 2023, Joerg Roedel wrote:
> On Mon, Jan 30, 2023 at 09:30:38AM -0800, H. Peter Anvin wrote:
> > It's somewhat odd to me that reading %dr7 is volatile, but %dr6 is
> > not... %dr6 is the status register!
> 
> The reason is that on SEV-ES only accesses to DR7 will cause #VC
> exceptions, DR0-DR6 are not intercepted.

I don't think that is technically true.  A _well-behaved_ hypervisor will not
intercept DR0-DR6 accesses for SEV-ES guests, but AFAICT nothing in the SEV-ES
architecture enforces that behavior.
