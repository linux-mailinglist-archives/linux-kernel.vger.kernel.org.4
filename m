Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC262661A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 01:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiKLAyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 19:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiKLAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 19:54:41 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A6657C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:54:39 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13be3ef361dso7055133fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgzkdJJVzDtfUCfjBoOKWIQr0MtI60EXGo2WL5sLdD8=;
        b=WJ1Dtcx0YU6v7BVgFhOTmX5g6b5V2u81n5W+od/LZ7/ePypFpcJ3B2/cO6y5T9Hb1s
         yGLP2KzMKL2tz7tYL10UX9VT2BDESGgDfGicz6IIzTLAXbGixb0NFv+uatTxemVEh/iP
         sj51/eI+NB3Y5W0e42kxC8GeNas1/hiO1nVjDt5AZZ3o3Ub8nTGV9TSEaFCeqYs4dRQO
         BT75ccM4UwqN3Hu64t4SL7Fzqq2bZPnpCgNB8CcGojBn1Euw156C0sN6shCUgnQMXfSf
         JNT+gVM8ZJ7BtrG9jh7rcg8AeI4W2uENCEw6XEshXKW/DmLDxqNErQJ/EoZvkZZCjafN
         dnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgzkdJJVzDtfUCfjBoOKWIQr0MtI60EXGo2WL5sLdD8=;
        b=ANUYZTSCiAX4WjPcUd6z2mIq3NAC9L5Ukx4p97ka7oXKi1eRN2jglX5Pi7IRfVrN/i
         0S3YO33iMIYAIIQqu4NHj8evtWJ+79RgkIGdFwcrUWsjFuqWev8jMO3GE7jrhQN9HOjv
         Bipmf+Q+GVFxGso8fhE28AZapK01pXPjxY5BXTpK98PBzusawkTjtUH7gaKndFpU3/8m
         4h82hX/oCk/u+AyUiswcaQDNZqw3P+PbM1k2YXV9AMHmMGwKpRNz9EWM4+9hBlBeZIt4
         1S3NfQoyYZD9/kf8iD7Pn6k2f2HZgq1ELLFVrrxo1m6+NMnw0kgUdL6wKQd+zIfSH8UL
         gbQA==
X-Gm-Message-State: ANoB5pl6e3Kqcx3Sl4NEl67exbI5wrERAWJE82g2pWk5VMovU+tFf7zj
        VCX04ONNVVad2LW7uLr1hUWjIQfLF5lR6Yt76ek0Ug==
X-Google-Smtp-Source: AA0mqf6ijLfQXIUSX8tefl3g9CbymBdUGXdxWM4Kt+K4kfIGcLQ9nZanl88lLdkCxJohVixchA4ivqQsSeJrMapImFo=
X-Received: by 2002:a05:6870:2e07:b0:132:af5d:e4eb with SMTP id
 oi7-20020a0568702e0700b00132af5de4ebmr2389146oab.112.1668214478327; Fri, 11
 Nov 2022 16:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20221104213651.141057-1-kim.phillips@amd.com> <20221104213651.141057-3-kim.phillips@amd.com>
 <Y2WJjdY3wwQl9/q9@zn.tnic> <Y2ZEinL+wlIX+1Sn@hirez.programming.kicks-ass.net>
 <d413c064-ee9b-5853-9cf1-544adde22c8a@amd.com> <Y247gY9NKYi34er6@zn.tnic>
 <Y25CwmylusloNKsr@quatroqueijos.cascardo.eti.br> <fb91bbc0-7a25-2f2a-163c-517f20dff6db@amd.com>
In-Reply-To: <fb91bbc0-7a25-2f2a-163c-517f20dff6db@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 11 Nov 2022 16:54:27 -0800
Message-ID: <CALMp9eT-XHz2GyWsQt+5eeGGm-9kvCj5PxC8GibEyc9rXoUcEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/speculation: Support Automatic IBRS
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Nov 11, 2022 at 4:46 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 11/11/22 6:40 AM, Thadeu Lima de Souza Cascardo wrote:
> > On Fri, Nov 11, 2022 at 01:09:37PM +0100, Borislav Petkov wrote:
> >> On Mon, Nov 07, 2022 at 04:39:02PM -0600, Kim Phillips wrote:
> >>> I've started a version that has AUTOIBRS reuse SPECTRE_V2_EIBRS
> >>> spectre_v2_mitigation enum, but, so far, it's change to bugs.c
> >>> looks bigger: 58 lines changed vs. 34 (see below).
> >>
> >> It can be smaller. You simply do:
> >>
> >>      if (cpu_has(c, X86_FEATURE_AUTOIBRS))
> >>              setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
> >>
> >> and the rest should just work - see below.
> >>
> >> And yes, as Peter says, when the user requests something, the user
> >> should get it. No matter whether it makes sense or not.
>
> OK & thanks.
>
> >> @@ -1474,11 +1477,19 @@ static void __init spectre_v2_select_mitigation(void)
> >>              break;
> >>
> >>      case SPECTRE_V2_CMD_EIBRS_LFENCE:
> >> -            mode = SPECTRE_V2_EIBRS_LFENCE;
> >> +            if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
> >> +                    pr_err(SPECTRE_V2_EIBRS_AMD_MSG);
> >> +                    mode = SPECTRE_V2_EIBRS;
> >> +            } else
> >> +                    mode = SPECTRE_V2_EIBRS_LFENCE;
> >>              break;
> >>
> >>      case SPECTRE_V2_CMD_EIBRS_RETPOLINE:
> >> -            mode = SPECTRE_V2_EIBRS_RETPOLINE;
> >> +            if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
> >> +                    pr_err(SPECTRE_V2_EIBRS_AMD_MSG);
> >> +                    mode = SPECTRE_V2_EIBRS;
> >> +            } else
> >> +                    mode = SPECTRE_V2_EIBRS_RETPOLINE;
> >>              break;
> >>      }
> >>
> >
> > I am confused here. Isn't the agreement that the user should get what they
> > asked for? That is, instead of warning and changing the mode to
> > SPECTRE_V2_EIBRS, the kernel should still use lfence or retpoline as requested?
> >
> > The point of those options was to protect against Branch History Injection
> > attacks and Intra-Mode Branch Target Injection attacks. The first one might not
> > affect the CPUs that support AUTOIBRS, though we haven't heard that.
> >
> > The second one (IMBTI) is very likely still possible with AUTOIBRS and
> > retpolines should still protect against those attacks. So users who want to be
> > paranoid should still be able to opt for "eibrs,retpoline" and have retpolines
> > enabled.
>
> I've removed the above and have the complete diff below.  It includes patch 1/3 and
> drops 3/3 for now due to Jim Mattson's comments.  After some more testing, I'll
> resubmit.

I bought the argument that AutoIBRS => Same Mode IBRS, so L2 should
not be able to steer L1's indirect branches, even if they share a
predictor mode.
