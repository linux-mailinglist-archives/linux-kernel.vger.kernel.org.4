Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B531C6832FE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAaQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAaQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:47:28 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE1254207
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:47:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so14639019pjp.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKmpErsBztAzIYwJMPREBlfpnmnXGT5EliIAUHAVha8=;
        b=aY2ve4kTaeWiXizms97zK7QFQ8eGFvffQ3tGrO/q8QuStLct/49LgrU0osu23iHZJp
         DZA/07QO9+euMla8BN5BqxdoVVxL/pXtJ06FP4q51ofZO+RpEpM5YAK0MShdYywFCUIl
         lRonaougG4SsY2vrjKNP04qCV8oSSxXWsFZy1oWm9oUsm4vnqDZbsU7GGcaMZqCt6Cir
         Z0MyNePdYyAcH5lSjxfKezqp5CqmoS69ckyu4dZ5mnnglIYfVp5JQ/rYksFfq8X1k1VU
         Cl9cU7fEKjkCxJGdDZPaDqm1rbTe0gkh76XZ7lDtUK3qPsHVTYxd/vub3gZNGgfUS412
         AvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKmpErsBztAzIYwJMPREBlfpnmnXGT5EliIAUHAVha8=;
        b=xy+kLDFZ/IDYCsl7orY/+WBgfLl0khBL6wV0laOVUPFjA0h6OPE4keLca2pE4MlVXX
         gUtx0Py0RUvME3gErJ0XW84UnzuEK7ydvQ8fRQLTnX89oeNSF75o/SnFPC5s+GW0w4K8
         wRhenbrBbE6wS0xQ8qGybhh2Wrj9eGMJUqHlzsybL/Yo0NNUyjRxVVYpgog5V0aJWs3C
         W4F0Acd4s+93UMUlzhaBTtceUCKdTE4zJdOMaEWV1Tom/DhivBLnLdh7dF7c9iYwL9FA
         PBX4466mlMiFbteVcbPPQnG41c0PjJU+WlhSVYLt66j0Y0/LRTXFqPcl0ScvAZ/QnHjW
         NJIg==
X-Gm-Message-State: AO0yUKV09NIvnk7wftnD2gC2ANIn/DefsFb0L1/iLaxN7J3iicJgQaU0
        pbeP5xq2MITVfcxD1HmXjodySA==
X-Google-Smtp-Source: AK7set/zMgqWnlyKYMwTQOLYfPtPtnjLxhTVYOgIxmBwWpRjXY9vhXcJLGMcj+RQqEcCE6vHjZnqGg==
X-Received: by 2002:a05:6a20:3d16:b0:bc:3523:13c5 with SMTP id y22-20020a056a203d1600b000bc352313c5mr1600210pzi.3.1675183645112;
        Tue, 31 Jan 2023 08:47:25 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b0018911ae9dfasm10032987pli.232.2023.01.31.08.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:47:24 -0800 (PST)
Date:   Tue, 31 Jan 2023 16:47:20 +0000
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
Message-ID: <Y9lGGLWovbh4v3Oy@google.com>
References: <20230127035616.508966-1-aik@amd.com>
 <Y9OUfofjxDtTmwyV@hirez.programming.kicks-ass.net>
 <Y9OpcoSacyOkPkvl@8bytes.org>
 <b7880f0b-a592-cf2d-03b9-1ccfd83f8223@amd.com>
 <Y9QI9JwCVvRmtbr+@8bytes.org>
 <3bb3e080-caee-8bc8-7de9-f44969f16e75@amd.com>
 <38C572D7-E637-48C2-A57A-E62D44FF19BB@zytor.com>
 <Y9jX9AKYP8H34wGI@8bytes.org>
 <Y9k5g5jYA/rjIwUj@google.com>
 <Y9k7HUA85bZKCEVn@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9k7HUA85bZKCEVn@8bytes.org>
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
> On Tue, Jan 31, 2023 at 03:53:39PM +0000, Sean Christopherson wrote:
> > I don't think that is technically true.  A _well-behaved_ hypervisor will not
> > intercept DR0-DR6 accesses for SEV-ES guests, but AFAICT nothing in the SEV-ES
> > architecture enforces that behavior.
> 
> Not from the hardware architecture side, but the GHCB spec does not
> list NAE events for DR0-DR6 accesses, so a guest is not required to
> handle them in the VC handler.
> 
> Linux under SEV-ES will crash if the HV intercepts debug registers,
> except DR7.

Right, I'm just objecting to the wording of "DR0-DR6 are not intercepted".  E.g.
from a security perspective, the kernel shouldn't rely on DR0-DR6 to execute
cleanly.
