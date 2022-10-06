Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E715F5F54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJFDMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJFDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:12:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D64E88DC7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:12:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so3123163pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 20:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=92cDXfMM4fhpGyG1CdFkFFkRHBmwNUF9WdoS8N63zbk=;
        b=JkB8SMSgGV8yVHuEQZ5JreBh61vQzlqF9vphrCqkRS4EszqntGT3cIzSCks80i6m3B
         cRXYvfX21nQtqPLQ/h7usKRPeBEeTWxW4irpkI5+L4JEl4XqFyscURbUgbJazTQowD0p
         FD9SuXW9xf4u1dGJVH/mBg6gsBvHhbOAYpqmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=92cDXfMM4fhpGyG1CdFkFFkRHBmwNUF9WdoS8N63zbk=;
        b=VxMFSkE0NST/e7p2sE7rPNrox10oYJCceWxKZPiGy+JPCAYxGvkvCHFNNA9CQr3svk
         8e32+zX80RTUCxzlXdpPpnBhDX+q+8GooIAIs7MYbcMUvhT6kDjpt264mIoFEpi+xM0k
         GsRr1geSb1WndJBBxT1ljD28E1XegvpXo4oPzXtqw9rhQT8c6myf6aGa8CXu+nx+7Wuw
         YwLKrjxlcl4lvAp/rQaVNeNBUIpK0AVXx6oUz3FDl8RoFzPdDPOPsH/E9a5pxoUDsRdG
         OgCsM9tqODHH2Mp25+F9NAn0Gx3+trZCLJEaC0ODxLUP/PiM4BCthzZevshDyz9Iwnb9
         nvqg==
X-Gm-Message-State: ACrzQf04PtqCc1nzx2N8EfVPX5E9rqIZ0M0jjo8D4GFmn+nwZ1tGMRjY
        eJXhQ5m4mAtU02dV/fSLu8Wcfw==
X-Google-Smtp-Source: AMsMyM4/A9tHmcS9DSMCnombql5Oosb8gPOdm0RsPlOyCIbfXteMbFXKhVWRv/a2FDuE51j+WjbkIw==
X-Received: by 2002:a17:902:d4d2:b0:17a:a33:e334 with SMTP id o18-20020a170902d4d200b0017a0a33e334mr2522782plg.17.1665025920596;
        Wed, 05 Oct 2022 20:12:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79606000000b0055fb19e27a8sm9261563pfg.121.2022.10.05.20.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 20:11:59 -0700 (PDT)
Date:   Wed, 5 Oct 2022 20:11:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Message-ID: <202210052011.C991E0B8C@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-30-rick.p.edgecombe@intel.com>
 <202210031525.78F3FA8@keescook>
 <6ea0841f-5086-9569-028b-922ec01a9196@kernel.org>
 <202210032129.44F6E027D@keescook>
 <33ee10b3d41bfa1f8cf03f87f1d13e565bea3120.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ee10b3d41bfa1f8cf03f87f1d13e565bea3120.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:38:06AM +0000, Edgecombe, Rick P wrote:
> On Mon, 2022-10-03 at 21:37 -0700, Kees Cook wrote:
> > On Mon, Oct 03, 2022 at 04:00:36PM -0700, Andy Lutomirski wrote:
> > > On 10/3/22 15:28, Kees Cook wrote:
> > > > On Thu, Sep 29, 2022 at 03:29:26PM -0700, Rick Edgecombe wrote:
> > > > > For the current shadow stack implementation, shadow stacks
> > > > > contents easily
> > > > > be arbitrarily provisioned with data.
> > > > 
> > > > I can't parse this sentence.
> > > > 
> > > > > This property helps apps protect
> > > > > themselves better, but also restricts any potential apps that
> > > > > may want to
> > > > > do exotic things at the expense of a little security.
> > > > 
> > > > Is anything using this right now? Wouldn't thing be safer without
> > > > WRSS?
> > > > (Why can't we skip this patch?)
> > > > 
> > > 
> > > So that people don't write programs that need either (shstk off) or
> > > (shstk
> > > on and WRSS on) and crash or otherwise fail on kernels that support
> > > shstk
> > > but don't support WRSS, perhaps?
> > 
> > Right, yes. I meant more "what programs currently need WRSS to
> > operate
> > under shstk? (And what is it that they are doing that needs it?)"
> > 
> > All is see currently is compiler self-tests and emulators using it?
> > 
> https://codesearch.debian.net/search?q=%5Cb%28wrss%7CWRSS%29%5Cb&literal=0&perpkg=1
> 
> Most apps that weren't just automatically compiled haven't had
> implementation effort yet. (of course glibc has had a bunch) I hope we
> would see more of that when we finally get it upstream. So I think a
> better question is, how many apps will need WRSS when they go to enable
> shadow stack. I'm thinking the answer must be some and it could be nice
> to catch them when they first investigate enabling it.
> 
> But yes, except for Mike's CRIU branch, there aren't any programs that
> use it today, and we could drop it for a first implementation. I don't
> see it as something that would only make things less safe though. It
> just lets apps that can't easily work within the stricter shadow stack
> environment, at least get access to a weaker but still beneficial one.
> 
> Kees, did you catch that it can be locked off while enabling shadow
> stack?

Yup, saw that! Looks good. Thanks. :)

-- 
Kees Cook
