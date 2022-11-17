Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6640562E87A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKQWdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbiKQWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:32:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB2A786C7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:32:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b29so3126838pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJnX0WEos5jTRigFggqcWTgwGYoctrWx0Q/bRYwgPOw=;
        b=orjwgIe8kl6hEsdghGmcAPLmmi79K3QzB0hGVLCFUsglgQGZ8IidYAjJg/GV/FkMG7
         YB2CDLhUOoJ2G1Mxu+LekKxKsCieo31v5V6eqREZVDobQElRzRHpP1yyPiS1SIh6qc9E
         syPdIm+LBmeWIDtVfWYaqyh5WhEykp+DyFu/8QImqc/L8aTMhenEivOBPO2YDaW9MNrU
         sCQdT2+9Tz4TB/z8MFExA73zCjSbEpbuT9w2ifakvP/HYNZ8q980hn3+6fb8LMQb4gu2
         sNl6/ZRrJiDtK48TYUhTcIM5kSgFa69VE7BFzSDb8a0j0LQOg6/pTb507wWlNkEK8f0b
         kCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJnX0WEos5jTRigFggqcWTgwGYoctrWx0Q/bRYwgPOw=;
        b=AH03FXVHKbyhofBxcZnIbVh4yyNSAIB5nns70Fe8QBTAombyF7Zq4DBYsbtnfHPo4Z
         FVbZuo3P3ewS9ksXxYuthRzLY7dU7XNxDmhC5qHZ+RZl2scfpSqi/kqbRA62+d7gxET6
         QKFD7qGfUXq+ZddlVCFbGECkd+tOj/S81la4lK9xwEopdry2FEtUy0HAWtYUIKZDa74S
         7q29Uy4cZW2wOPep61YDRjYO+yPoN1yjLgWyWtssEJ/HaGWGEv0dT0C1vWGGuRW0e6PD
         lTWpuKTyCDv4aPrHBi4QdwXTgWX1iciXOAsj8Ef18rUh/z51510YccPIrw0T6gS2LqSe
         aCrg==
X-Gm-Message-State: ANoB5pmf7FDRJDY+3sOb+q2x7yDZ3CydAU/5Zl4CbtgA1USgE0zNEJ0y
        gYZXEqRltyxSD/ey+32W1w/mOQ==
X-Google-Smtp-Source: AA0mqf62hgVFP75vxpYXME1e9myoKhlSOl3NkjrteC+H66jW50x5Upfk3tLqM3B4NZYvwuXH4gz+ag==
X-Received: by 2002:a63:ff62:0:b0:476:898c:ded8 with SMTP id s34-20020a63ff62000000b00476898cded8mr4068515pgk.251.1668724376940;
        Thu, 17 Nov 2022 14:32:56 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k186-20020a6324c3000000b0046fd180640asm1561643pgk.24.2022.11.17.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:32:56 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:32:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: selftests: Disable single-step without
 relying on ucall()
Message-ID: <Y3a2lfLLys4BtET3@google.com>
References: <20221117002350.2178351-1-seanjc@google.com>
 <20221117002350.2178351-3-seanjc@google.com>
 <Y3WF8YlvFm8NGYHd@google.com>
 <Y3WMeovid9z1qOjD@google.com>
 <Y3ZQ+fCobB4DOc+S@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ZQ+fCobB4DOc+S@google.com>
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

On Thu, Nov 17, 2022, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Sean Christopherson wrote:
> > On Thu, Nov 17, 2022, Oliver Upton wrote:
> > > On Thu, Nov 17, 2022 at 12:23:50AM +0000, Sean Christopherson wrote:
> > > > Automatically disable single-step when the guest reaches the end of the
> > > > verified section instead of using an explicit ucall() to ask userspace to
> > > > disable single-step.  An upcoming change to implement a pool-based scheme
> > > > for ucall() will add an atomic operation (bit test and set) in the guest
> > > > ucall code, and if the compiler generate "old school" atomics, e.g.
> > > 
> > > Off topic, but I didn't ask when we were discussing this issue. What is
> > > the atomic used for in the pool-based ucall implementation?
> > 
> > To avoid having to plumb an "id" into the guest, vCPUs grab a ucall entry from
> > the pool on a first-come first-serve basis, and then release the entry when the
> > ucall is complete.  The current implementation is a bitmap, e.g. every possible
> > entry has a bit in the map, and vCPUs do an atomic bit-test-and-set to claim an
> > entry.
> > 
> > Ugh.  And there's a bug.  Of course I notice it after sending the pull request.
> > Depsite being defined in atomic.h, and despite clear_bit() being atomic in the
> > kernel, tools' clear_bit() isn't actually atomic.  Grr.
> > 
> > Doesn't cause problems because there are so few multi-vCPU selftests, but that
> > needs to be fixed.  Best thing would be to fix clear_bit() itself.
> 
> Ha!  And I bet when clear_bit() is fixed, this test will start failing again
> because the ucall() to activate single-step needs to release the entry _after_
> exiting to the host, i.e. single-step will be enabled across the atomic region
> again.

LOL, yep.  Test gets stuck in __aarch64_ldclr8_sync().
