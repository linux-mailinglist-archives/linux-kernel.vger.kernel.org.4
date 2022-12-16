Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192764EC5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiLPNzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:54:58 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D612639
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:54:58 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id pa22so915862qkn.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=By+/IQPqgPPEjJJWXrgipZ5yuJJPTYbNFABS6OTKF5s=;
        b=bHjcSAGQY7kXNeYz5veZFlFj/DUNsxoQASULgwecMeL7cK6B1OGaCfXga60KEPV4oW
         XnOVjl6TyD2Nb6vcyrD6QQ5cOVIu8JshV29OopLWCUB67bJZnnM0ETWui9LZgpru1iBX
         SFPASyCy17yG03cVfw6/sDtXWf7hempEPNTb24lZZJ6u++MinVBKf/773giky6cHCypV
         153d/K94KYjZ6f9na/8bpSjJFoBk+vKqwCCaNBtsLZx2gRWRU3lYr2S4ms+8uoP/FnZ9
         fi2zZwkmRCrjGR/Xffc30ODaOKtBFtPpPFEOZlk564NJl/EeLTFRLoB9nAKDubPZc/eH
         0oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By+/IQPqgPPEjJJWXrgipZ5yuJJPTYbNFABS6OTKF5s=;
        b=XzjzHul0PfSof92P6TCIjo1JOPtnAFRx5sy8QX5Ji33jRrLUc2TmbyttEgrDPHaer5
         CMUEQ2NgBQuLlbJzM4aKvyhzSoARQdFisx6jV7oG0pI3RdTq+nx5dAVtmF5vsYLaOuZQ
         lVwR6nChgHUM5gRbgWJ/7Sb60lVfvgIVyQTt7n3zbx/jX2I0sk/0Bsx8x4i6dowXaRW5
         eEYH09x17Aj6lVEShgqDKRrUSQOPNeWb4mqdKonITI1FRBe/44Jfu2DwK5XEzp1YO5XO
         qe4XrXFyYsSBL3jhkSSpDFW1YN+WNYxlycwFCvkoGBrB3zjr8NSlEVuDAbpF01e351We
         DGOQ==
X-Gm-Message-State: ANoB5pnooz7oUUMhHzIWiMAUbQfUVyrX7UEGtYuJgnz8GMJ/5WFHY7AN
        5057OYp5ou4KhN5ugcgr0zcEF0KiyboYR7F6Yl8ZgQ==
X-Google-Smtp-Source: AA0mqf5NkIIU3KTTWAgM4XyZit5z032Fhqrf4wZGTeTdSLQPJnKdlx6wNvXuW1/byc9uXuEcAjeL2J9aKAP7LoyJCGA=
X-Received: by 2002:a05:620a:222d:b0:6ff:ca94:e927 with SMTP id
 n13-20020a05620a222d00b006ffca94e927mr257559qkh.116.1671198897241; Fri, 16
 Dec 2022 05:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20221207112924.3602960-1-peternewman@google.com>
 <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com> <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
 <74cfd689-3c03-5f41-d01c-efab04ce4197@intel.com> <CALPaoChbJNYBXvOwftSxApo_ca6BLC7Ej21cDAaKdj9LOJumxw@mail.gmail.com>
 <6f0f4c45-039b-ffaf-b30a-d9e2aae0cc74@intel.com>
In-Reply-To: <6f0f4c45-039b-ffaf-b30a-d9e2aae0cc74@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 16 Dec 2022 14:54:46 +0100
Message-ID: <CALPaoCjAUOO=2wECEQF+weKsto5LNi1-8nVi_QTLs7B+fvRb5A@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        linux-kernel@vger.kernel.org, eranian@google.com,
        Babu Moger <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Reinette,

On Wed, Dec 14, 2022 at 8:17 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 12/14/2022 6:21 AM, Peter Newman wrote:
> > mbm_state is arch-independent, so I think putting it here would require
> > the MPAM version to copy this and for get_mbm_state() to be exported.
>
> You are correct, it is arch independent ... so every arch is expected to
> have it.
> I peeked at your series and that looks good also - having cleanup done in
> a central place helps to avoid future mistakes.
>
> >> am = get_arch_mbm_state(hw_dom, rmid, eventid);
> >> if (am) {
> >> memset(am, 0, sizeof(*am));
> >> /* Record any initial, non-zero count value. */
> >> ret = __rmid_read(rmid, eventid, &val);
> >> if (!ret)
> >> am->prev_msr = val;
> >> }
> >>
> >> }
> >>
> >> Having this would be helpful as reference to Babu's usage.
> >
> > His usage looks a little different.
> >
> > According to the comment in Babu's patch:
> >
> > https://lore.kernel.org/lkml/166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu/
> >
> > + /*
> > + * When an Event Configuration is changed, the bandwidth counters
> > + * for all RMIDs and Events will be cleared by the hardware. The
> > + * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> > + * every RMID on the next read to any event for every RMID.
> > + * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> > + * cleared while it is tracked by the hardware. Clear the
> > + * mbm_local and mbm_total counts for all the RMIDs.
> > + */
> > + resctrl_arch_reset_rmid_all(r, d);
> >
> > If all the hardware counters are zeroed as the comment suggests, then
> > leaving am->prev_msr zero seems correct. __rmid_read() would likely
> > return an error anyways. The bug I was addressing was one of reusing
> > an RMID which had not been reset.
>
> You are correct, but there are two things to keep in mind though:
> * the change from which you copied the above snippet introduces a new
>   _generic_ utility far away from this call site. It is thus reasonable to
>   assume that this utility should work for all use cases, not just the one
>   for which it is created. Since there are no other use cases at this time,
>   this may be ok, but I think at minimum the utility will benefit from
>   a snippet indicating the caveats of its use as a heads up to any future users.
> * the utility does not clear struct mbm_state contents. Again, this is ok
>   for this usage since AMD does not support the software controller but
>   as far as a generic utility goes the usage should be clear to avoid
>   traps for future changes.

To this end, would it help if I pulled the rr->first case into a
separate function like this:

-               resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
-               m = get_mbm_state(rr->d, rmid, rr->evtid);
-               if (m)
-                       memset(m, 0, sizeof(struct mbm_state));
+               resctrl_reset_rmid(rr->r, rr->d, rmid, rr->evtid);

I'm open to suggestions on the name.

-Peter
