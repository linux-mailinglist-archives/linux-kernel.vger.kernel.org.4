Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EDF686ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjBATUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBATUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:20:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF77AE78
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:20:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v23so19491618plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3aJxkFjia0TG0Zw0pJke9K17wju5Se/TaQW6+Ae14k=;
        b=XwZbyhIp0OuYZyo9xcqBh+P2rODjCpd3IsgZPNGgJrZcAU9R0QOr76mypm5GR1vkSZ
         fsE01uLzqnqyXMI/rLvvTmYCFPnACj5UDlOOgzzC7XoB+7WE24CEPlxhCTm83l8QDvfv
         tqP0/PZgeq47vv+88irhObpAIwcYrzXOUbFd9q5qpg3NJhl1ok949kn1Tvr80r0AeQEn
         lccaQ3yxraUuUK3lojLi8QAb+oJTWGxcRDw195V5Mehcz2CV32fF04ivMKajyCAMl2Ku
         eq+U8PY8UHYXBVDNcP+pm844YYL9qV0YYW8rd7U1XmUiNgYxoalfYyrOwbmzvmmHEvXG
         sC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3aJxkFjia0TG0Zw0pJke9K17wju5Se/TaQW6+Ae14k=;
        b=TEIIzUtAqbwaYeyp7YASSMTAvMbJax8wOaKglPlqB7kUU6bV7qWpB4BielH9D61xfF
         SJH0vY/WoGmZFExo8m5fmih2X6ttkYq+RjxnPtLXf4Q64pHWOhC/yJGYGW8/R/ubZJ30
         tmBt/uGXG5JcA1rWnw8I1xyoZ9BoRtQqgqIt4EIaTZD8HVMKsN2cDRFxSqNZI/XR1zVF
         3jRhDpiKn3nTtCO9TXdSnyON6JHdq1rsROmDB7Mjb1BOSGDVN6UeqkrRF8rnSupLpqOT
         ILygXsLRhGQZx1/DODVVLV10LsI5hkIMyrHGWbezxv88koR7CefiPS/tr0roVC5h7Uvp
         qtSQ==
X-Gm-Message-State: AO0yUKXJeMD8JGy62CaNkZAAZS3BzakRYq9ns3PbcmHqT1zBI+1B0uUo
        C2YSqtTk5HdV2ts/aDC0R/JUXw==
X-Google-Smtp-Source: AK7set/d3D8AsFkSrakWSJ8TPNgYvflhAFxzYv278HPao7EaPtrAx6LS4oH2E1mmhjA1QO8zSQEyDw==
X-Received: by 2002:a17:902:ce08:b0:198:af50:e4e5 with SMTP id k8-20020a170902ce0800b00198af50e4e5mr57671plg.11.1675279204063;
        Wed, 01 Feb 2023 11:20:04 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u34-20020a056a0009a200b00593225b379dsm9764805pfg.106.2023.02.01.11.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:20:02 -0800 (PST)
Date:   Wed, 1 Feb 2023 19:19:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: x86/mmu: Remove FNAME(is_self_change_mapping)
Message-ID: <Y9q7XwWAGUpFrzqZ@google.com>
References: <20221213125538.81209-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213125538.81209-1-jiangshanlai@gmail.com>
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

On Tue, Dec 13, 2022, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> FNAME(is_self_change_mapping) has two functionalities.
> 
>   If the fault is on a huge page but at least one of the pagetable on
>   the walk is also on the terminal huge page, disable the huge page
>   mapping for the fault.
> 
>   If the fault is modifying at least one of the pagetable on the walk,
>   set something to tell the emulator.

This should be two patches, one to move the arch.write_fault_to_shadow_pgtable
handling and one to drop the hugepage adjustment.

I also want to rework the handling of write_fault_to_shadow_pgtable as prep work.
Every time I look at that flag it takes me an eternity to remember exactly how
KVM guarantees x86_emulate_instruction() won't get false positives.  I.e. I always
forget why it's ok to not clear vcpu->arch.write_fault_to_shadow_pgtable after
every VM-Exit.

Unless I've missed something, we can use an EMULTYPE flag to communicate to the
emulator that the #PF emulation is on a self-referential write to a shadow page.
That allows dropping write_fault_to_shadow_pgtable from vcpu->arch and sidesteps
the whole "how do we avoid false positives?" question.

Testing now, if everything looks good, I'll post v2 with all three patches.
