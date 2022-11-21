Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA5A63289F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKUPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiKUPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:48:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BED229D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:48:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so5239616pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2Hl0LivzAkDSQRFs0mgG3yzGfl2Pl7SIHmxNVespLA=;
        b=f/XglRcmiVP+E/uhgPyWVlmeCNdQFbhKs3No3kzkG2pmd4sdw0/6qVKMJTdEFaBAa2
         SYBMiwU/gTU1zm+0sYV7KpsaFoo7DfsR1SOLMqfNZqKbDSnnJ7auQnC3ZP0Z04HECaxN
         8CVJU48t3BusKVKEzEbeWyDbAVWKwGlaCv/7APZEm0FOC2nL23/mYF+bJwsyqfzhy9sI
         b9+rZCD1cBqcvZEZjO8dcRFEBslIVix6P/7JqV7gbadrvqp3oR2GfjxMFjeIlcyhxO9B
         FeHsf7wZ5KLcBbVso4vMTzNa9QCuTmsHpn7nELTQlxtK5Lwl6MWChmUbOqRixnmgLUUC
         NM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2Hl0LivzAkDSQRFs0mgG3yzGfl2Pl7SIHmxNVespLA=;
        b=5tdaL3J9RVC23leQ2evg62eHZOAX5aGky655NW1tE+rCzsAJWqc/WlQnfRZNwk/7hw
         kKVzhNzwJiU/OT8zUr1MHf0Mwmbw6EajQGUIAMjxQjJGFVFqmtMVAST9/0m6W5rgZCDn
         zO8JSDltOddTSd+tM963kKf75Jm5Nw8G+EtLNvvdNwOZv4KgMF3uxrOriMHjSuJ6IIVh
         GqQAMO5Sv606FbzoOegLcWXF+1O7qWRLYHt4NjTeTok9o/AjXXkRWr5Ukc21t7+MiWNx
         LPe9C/bUBZdbRWlQ1gPOnRDELUebTeGYCX3fzsCOnovRZck+mzyzNFTjCBJzZjOYegOm
         xj7w==
X-Gm-Message-State: ANoB5pmRt6yBxRP7JFMLWpdKnCv6IZH2BVrFWPk66tKhSVqDobHMBkjB
        bV5jFMO/lUX9B4y4MAOZLAKkKw==
X-Google-Smtp-Source: AA0mqf4OJ4EuJJXRbS/Igvfq2RY1H+fy+GaJxRwEtR/e+9lMCFTCBNBFZogqLX5YayyxBlSY6vR7aA==
X-Received: by 2002:a17:902:ce90:b0:186:d89d:f0aa with SMTP id f16-20020a170902ce9000b00186d89df0aamr12545041plg.50.1669045690362;
        Mon, 21 Nov 2022 07:48:10 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b0017f5ba1fffasm5425345pln.297.2022.11.21.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:48:10 -0800 (PST)
Date:   Mon, 21 Nov 2022 15:48:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jiaxi Chen <jiaxi.chen@linux.intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, ndesaulniers@google.com,
        alexandre.belloni@bootlin.com, peterz@infradead.org,
        jpoimboe@kernel.org, chang.seok.bae@intel.com,
        pawan.kumar.gupta@linux.intel.com, babu.moger@amd.com,
        jmattson@google.com, sandipan.das@amd.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, fenghua.yu@intel.com,
        keescook@chromium.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] x86: KVM: Advertise CMPccXADD CPUID to user space
Message-ID: <Y3udtm6oC7k41kaR@google.com>
References: <20221118141509.489359-1-jiaxi.chen@linux.intel.com>
 <20221118141509.489359-2-jiaxi.chen@linux.intel.com>
 <efb55727-f8bd-815c-ddfc-a8432ae5af4e@intel.com>
 <f04c2e74-87e4-5d50-579a-0a60554b83d3@linux.intel.com>
 <6d7fae50-ef3c-dc1e-336c-691095007117@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7fae50-ef3c-dc1e-336c-691095007117@intel.com>
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

On Mon, Nov 21, 2022, Dave Hansen wrote:
> On 11/21/22 06:46, Jiaxi Chen wrote:
> > Features which has been enabled in kernel usually should be added to
> > /proc/cpuinfo.
> 
> Features that the kernel *itself* is actually using always get in there.
>  Things like "smep".
> 
> But, things that the kernel "enables" but that only get used by
> userspace don't generally show up in /proc/cpuinfo.
> 
> KVM is kinda a weird case.  The kernel is making the feature available
> to guests, but it's not _using_ it in any meaningful way.  To me, this
> seems much more akin to the features that are just available to
> userspace than something that the kernel is truly using.

Actually, for these features that don't require additional KVM enabling, KVM isn't
making the feature avaiable to the guest.  KVM is just advertising to userspace
that KVM "supports" these features.  Userspace ultimately controls guest CPUID;
outside of a few special cases, KVM neither rejects nor filters unsupported bits
in CPUID.

Most VMMs will only enable features that KVM "officially" supports, but for these
features, nothing stops userspace from enumerating support to the guest without
waiting for KVM.

> Also, these feature names are just long and ugly, and the "flags" line
> is already a human-*un*readable mess.  I think we should just leave them
> out.

I have no strong opinion, either way works for me.
