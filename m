Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCC629FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiKOQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKOQ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:56:37 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592C613FB5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:56:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s196so13816047pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MvxZkFo9lEKIbouBZXZPUNsK695tEo0v2VM4QMcU4oo=;
        b=Z6PsCrJqcgyXVZkJRHmJOnElMgYhxn3lnK7vNeD2wDgX/+dAOXUUqQW1eZAJb/NCmp
         A3Q4XpdE4ZCuxjmSZNtHuLYYFlyj0IOkam+DFP8Fcuo1LqiInlDex62ky/oP9fb708+A
         dpe22QvB2JIjW5pJq/S10VWpTRQQCjJn9A6F2EReZk6Kjvq32PVoW3sB4PTeoEEwzJXn
         j0A9s0hQUvErzYRVoqqzTBdKO0aecYimTfvlGG/YJLXv4uh665ZBSkke6lJyzFqP6wAI
         mlkWVHoOSusT1vNC9sK52J16zl8Jq6gm+7X0aVADQ8dj5ocCD88ITtYcoZ7Ga7NVXCqk
         u69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvxZkFo9lEKIbouBZXZPUNsK695tEo0v2VM4QMcU4oo=;
        b=uxmXWqBsvDT56Db0EQbodnuwCbc8rI9AT0pDzkPdjgB14tIdISCaRl3zctjGxBqvgp
         yjFQqIr6IL6iPswvVGhOK2SVNvRCLdsCPrMXNJ/YzMKomA/JdWfGB9XIM7SnsUNue1nD
         E2q9R7u3Yg259WbqGYIPSGtYRf8WeKVh+9v8JR6Q+jv0V9ivmbPyfs3fYjQitmFfi54h
         tug2u+Wm90+9GOG0SZB8f0HTTqIEZKaPw27Mk9j1DH6poQ96lmtwVJ4LXIkK8bjMBtxY
         CE0/pPu45PCnn/HkU9pj7Qg2vWmsjGAPzWqyyM6lGoHqeSakZLemVlskz0+WJ7GJKqIK
         dV2w==
X-Gm-Message-State: ANoB5pkuHrBcYN/7sENgV/cyVmtKA+PRAcFd52W9DqekElpI56yCA1i7
        Mvz0cIW09XGca/fd4cBgTOy92A==
X-Google-Smtp-Source: AA0mqf7r/vwNGwh6O5xwH6c88rOBA1lAKXqssPbJ/HRV28HMg1KpT8vBXrA+i1DrPjiR2HXZg16Gsw==
X-Received: by 2002:a63:c5d:0:b0:42b:87fd:1077 with SMTP id 29-20020a630c5d000000b0042b87fd1077mr17030978pgm.478.1668531395453;
        Tue, 15 Nov 2022 08:56:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l4-20020a654c44000000b00476799699e4sm4955605pgr.30.2022.11.15.08.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:56:35 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:56:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Message-ID: <Y3PEv9MmQ+y91Ir+@google.com>
References: <20221114233441.3895891-1-seanjc@google.com>
 <5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com>
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

On Tue, Nov 15, 2022, Andrew Cooper wrote:
> On 14/11/2022 23:34, Sean Christopherson wrote:
> > Tom,
> >
> > I Cc'd you this time around because the APM doesn't explicitly state that
> > GIF is set when EFER.SVME is disabled.  KVM's nSVM emulation does set GIF
> > in this case, but it's not clear whether or not KVM is making up behavior.
> > If clearing EFER.SVME doesn't set GIF, then patch 1 needs to be modified
> > to try STGI before clearing EFER.SVME, e.g. if a crash is initiated from
> > KVM between CLGI and STGI.  Responding CPUs are "safe" because GIF=0 also
> > blocks NMIs, but the initiating CPU might leave GIF=0 when jumping into
> > the new kernel.
> 
> GIF exists independently of EFER.SVME.
> 
> It is also gets set by the SKINIT instruction, which is why there is an
> asymmetry on the #UD conditions of STGI and CLGI.
> 
> STGI is also intended to be used by the DLME once critical
> initialisation is done, hence why it's dependent on EFER.SVME || SKINIT.

Gah, stupid APM.  The pseudocode states "EFER.SVME || CPUID.SKINIT", but the
description and the comment both say that SVM must be enabled to execute SKINIT,
which made me hope that disabling SVM would reset everything.

  This instruction generates a #UD exception if SVM is not enabled. See “Enabling
  SVM” in AMD64 Architecture Programmer’s Manual Volume 2: System Instructions,
  order# 24593.

...

  IF ((EFER.SVME == 0) && !(CPUID 8000_0001.ECX[SKINIT]) || (!PROTECTED_MODE))
          EXCEPTION [#UD]  // This instruction can only be executed
                           // in protected mode with SVM enabled
                                                     ^^^^^^^^^^^
