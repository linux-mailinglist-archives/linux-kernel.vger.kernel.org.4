Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498162A205
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiKOTg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKOTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:36:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1B9FC8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:36:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id io19so14077868plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6BqLENm/h338dftUjsKFDSeM6kMWXWWN9CsVYvY8zQ=;
        b=JDgSpXGV4HWxjfdCgMqs0/0hb8b7tisv0YWnctoiIaM+k69Si4+P5wueZ0R7PgBmZl
         OSvHVLPe+ShsX3jqoQmM7TKtrr0SI7BsfcP9y4kp17OgxnHOJVTUXc2LFKa8Q4NzG3ZM
         oU7ksJ1BIw/a911UBM/hbiNDWB6oZEKdx/E5zTNR9ep9Fq7HftfQTxX9j+psCJdq1nE9
         RvlNoUvuB3fP1NVxB1e6upjb0jKAjtYxv36GhVHpbXs2F7WJBEisdcq0+hpaoTUAGUtY
         VOe5UN5GMCkuPV9NgEYBxoagmWwBXksl8+jeXzg2bIYx0s6Kss7f37ojwmR+2opHVQsp
         +0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6BqLENm/h338dftUjsKFDSeM6kMWXWWN9CsVYvY8zQ=;
        b=HAyAcV4MiQyzdTDhombA3GzLWovqObXWC1Z0vDJ6OE8VJOxVGESHw0fPxcJeyi8Czq
         D57ZETgUC+Onr9QLOxLPqxcoW925W1VTYH1eenO2XJnZ2JUAaR4COZZAhD2VJPJ+m6Jw
         PIN4OUjVIVSFa5R8+lyS6B9iAJ5LrougOy6q904jcUszGewt8kWv/4+zNloZ/tnm4DAb
         D7n7XQYHd71EtJZzVe2fuWUdniM5u0zRCVXefuXhIG2GO1dMl37CFIn2fv9gjpM8QzaH
         0YPEcq8pZiaSgeIrkYOKEL6UKkRjj7JR9BgAgFOrWOTJzCGKRZZBInS8O4+yffvKMRl4
         RxWg==
X-Gm-Message-State: ANoB5plouW59BHdjidzUt897tr2hTF7wwJKht5N8zVl5ktPjf9XsaYGH
        wO7vwbTyPiqAOQcm3nGLW22zRw==
X-Google-Smtp-Source: AA0mqf4lXPkPd95BFyQnywfA1qweD1Cy57S5Pb5IROVHDHYHCQKixgBKLjXpo1rMjUVyyFNhjmjftQ==
X-Received: by 2002:a17:902:ce83:b0:188:5698:5beb with SMTP id f3-20020a170902ce8300b0018856985bebmr5419753plg.150.1668540984403;
        Tue, 15 Nov 2022 11:36:24 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 33-20020a631661000000b0046b1dabf9a8sm8241131pgw.70.2022.11.15.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:36:24 -0800 (PST)
Date:   Tue, 15 Nov 2022 19:36:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Message-ID: <Y3PqNLW48pXaWRyA@google.com>
References: <20221114233441.3895891-1-seanjc@google.com>
 <abf9feef-443f-fcfa-952c-0123e61b280d@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf9feef-443f-fcfa-952c-0123e61b280d@igalia.com>
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

On Tue, Nov 15, 2022, Guilherme G. Piccoli wrote:
> On 14/11/2022 20:34, Sean Christopherson wrote:
> > [...]
> > v3:
> >   - Re-collect Guilherme's Tested-by.
> >   - Tweak comment in patch 1 to reference STGI instead of CLGI.
> >   - Celebrate this series' half-birthday.
> 
> Heheh
> 
> Thanks a lot for persisting with this Sean, much appreciated! I'm
> surprised on how long is taking to get these _fixes_ merged in the
> kernel, hence your effort is very valuable =)

Well, to be fair, the fixes aren't perfect.  Aside from the GIF thing, patch 2
breaks CONFIG_SMP=n.

I think there's another bug lurking too.  The emergency reboot path doesn't
VMCLEAR VMCSes.  AFAIK, Intel doesn't guarantee the VMCS caches are purged on
INIT, so if the reboot doesn't actually RESET CPUs, the new kernel could observe
memory corruption due to an old VMCS getting written back.

Argh, and I missed sysvec_reboot() + smp_stop_nmi_callback() for SVM support.

And slightly longer term, this entire mess can be cleaned up.  Once KVM's handling
of VMX/SVM initialization sucks less[*], all of the disabling logic can be moved
into KVM callbacks and the kernel can stop speculatively trying to disable VMX/SVM.

I'll send a v4 to fix all of the suspected bugs, and then work on another series to
clean up the callbacks, which will have dependencies on both the kvm_init() rework
and this series.

[*] https://lore.kernel.org/all/20221102231911.3107438-1-seanjc@google.com
