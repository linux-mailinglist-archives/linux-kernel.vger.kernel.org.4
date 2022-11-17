Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADAC62E5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKQUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiKQUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:33:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED33880
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:33:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so1245449pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YB3Sj9J2yPSZSle7FgmIx0HIJBl+tPsB51ib93ManDM=;
        b=EMZYwrRo6hNwWAQ4DJLF6OChkoz6ckOA4oL7/dXy5kmN8VC1S64Ws9xZROds3O6vW5
         Vh+wdRFRSSbZND5l0Eg/WBf/V0M6o/QI7DI3xYXEznKvgc18n5U4xRB59FFzDPy6MZAn
         7ZL7/9Bzf1ZAjXoMj2av0at7Q+7WNFpng7FZGdildIGg3prDLoMNhtGZv2ne4F5qvg8S
         nZASUIRaNIvdihYE0yRYqZFtsHJj1WA88pevewkGPlDsHYLYBoPQ4HA/nf3JaLJColbQ
         YBW84WIwMuX3vFmCz7oRZY3E8FnHvI0IJKN8NYXhHl+rDdxzN4bOdQRGLIxgS1U5yztS
         76ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB3Sj9J2yPSZSle7FgmIx0HIJBl+tPsB51ib93ManDM=;
        b=3bzjxZ089Pom3GhbgiYwzgTd+uJ5JepXAxeYhxp61x/MEyaDfgwHCDI4dfoVkh5lGD
         6M0iSmnohp4Ej94bwelF8giQFBE2AoWic0WId7WqeVGyndqQ9I8igYdeSJ1nvt3/anb2
         TEDJhSm230H84U8nB+yHuc0T8e63k1f8bBwQjTlwFX93ecfQ5CbF9z3ZmcjNOFi4fSIB
         kQ3lOi0gJGIeYGoeXVxEG0muWhNvDo7AjKlvW//iy0xvF3KFlQ1059YRFyf7NtHerphA
         g13TaRNMdsxYSoWio5Oj++4qZxb57Uaqj+5UgJ3FEjM7CRQnRQyCw/iqWELBxrSkzD0D
         mo8A==
X-Gm-Message-State: ANoB5pl2q4Lk8+GEib6IBrlut+Z888NbTdeL/j4jiXe9pew7JdrrT/io
        /LNRjaoIywpDEjlQZj7YI+LsFA==
X-Google-Smtp-Source: AA0mqf7I8HuPFiLeqmCjqF+DbR069o4yhTQ82fEaGE1cbWg3XJ6Lit3Xhf/Xn4UiJ8RrtXmH/GidYg==
X-Received: by 2002:a17:90b:2d85:b0:213:258d:68ef with SMTP id sj5-20020a17090b2d8500b00213258d68efmr4359019pjb.235.1668717228876;
        Thu, 17 Nov 2022 12:33:48 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b00188a23098aasm1888230plh.69.2022.11.17.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 12:33:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 20:33:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sandipan Das <sandipan.das@amd.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jing Liu <jing2.liu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Babu Moger <babu.moger@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>
Subject: Re: [PATCH 06/13] KVM: SVM: Add VNMI bit definition
Message-ID: <Y3aaqJo7ckdUsyde@google.com>
References: <20221117143242.102721-1-mlevitsk@redhat.com>
 <20221117143242.102721-7-mlevitsk@redhat.com>
 <Y3ZHKVq8enyxJmVu@zn.tnic>
 <Y3Zkkc1edwYtpk+N@google.com>
 <Y3ZqOvg2mlBmXAlW@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ZqOvg2mlBmXAlW@zn.tnic>
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

On Thu, Nov 17, 2022, Borislav Petkov wrote:
> On Thu, Nov 17, 2022 at 04:42:57PM +0000, Sean Christopherson wrote:
> > Why? This is rarely run code, won't cpu_feature_enabled()
> > unnecessarily require patching?
> 
> Because we want one single interface to test X86_FEATURE flags. And
> there's no need for the users to know whether it wants patching or not -
> we simply patch *everywhere* and that's it.
> 
> > And while we're on the topic... https://lore.kernel.org/all/Y22IzA9DN%2FxYWgWN@google.com
> 
> Because static_ or boot_ is not relevant to the user - all she
> wants to know is whether a cpu feature has been enabled. Thus
> cpu_feature_enabled().
> 
> And yes, at the time I protested a little about unnecessary patching.
> And tglx said "Why not?". And I had no good answer to that. So we can
> just as well patch *everywhere*.

Ah, I missed that memo.


Paolo,

Since it sounds like static_cpu_has() is going the way of the dodo, and ditto for
boot_cpu_has() except for flows that don't play nice with patching (none of which
are in KVM), should we do a KVM-wide conversion to cpu_feature_enabled() at some
point in the near future?
