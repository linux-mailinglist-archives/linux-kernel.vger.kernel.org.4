Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1E6AF5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCGTlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjCGTlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:41:06 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962069EF55
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:28:28 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i7-20020a626d07000000b005d29737db06so7720642pfc.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678217308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbjbgwQzeqCenuqbD9hJe0oAnAoNXCN3vGAt2JzbflU=;
        b=bqezKyV3+jMqlggrb1lI3km0jiITLq61XUEK9AxeKb2ua+/fRy+5gny/hafK0mTKhz
         4foyqEnSGNctt7jXekkCKfBq8Ke/dhkxsHAu04lRfGWMLUJunEHb4Qpb4jnr0LfD7UVJ
         yeT8LOBhHAhS5Av6kVq3fVbAGhwJc5dY5tKIBKpBGtRMe4R9TaVgzGMZGlD3/B1PlnbV
         qiaF+L42Lb0N3IxYr1EMyYlpvlyanVmQY1yGfdu+I9z8XKTdTZ21WBt0ZbyFC9+LH5OH
         lioEGF8MgN69ZM63+v7kL4B2Mu8SgHBKqFRNrd72WbPdy7++psPhDGQNNdnOehdZmy+H
         a9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678217308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbjbgwQzeqCenuqbD9hJe0oAnAoNXCN3vGAt2JzbflU=;
        b=KlMRTcv8xGhdjV5kmIa6tWt1M2tRWZ4p6tdoffutjnQonkOVVKnR/b9+sRRVKeScrp
         O/BwJHFIyNMaiaP7zD85QZL3BNcizKKNrGKbTcC47nHpekaXG1JI2tODXgnpXj/xz53s
         Jp0XsIf7o1fpxrmUCa3YMKcczR5jDktK9O0biMxMvl9UyuhLLgbRf+vJfYTU5QQnPzfP
         ulRCFYFVWoZViVE1ffDGuve+YrhSEyey/4wOu1jyFN2VR1HiSQwgm5tfPt+oNS5jrhOG
         ZsfUeFWrxCNU+whArx64oJa2aCgKtRkwxKz4PI92yzTJb3V5D45ByF5KOSd4fkRXMxUr
         aBwQ==
X-Gm-Message-State: AO0yUKUWYbVHgWZEe4helU2MD0KmNb69FSdBf2CGg8AXy77vQWDtcwoF
        oNORP0EDk3UWKNE8IoVkCmIMo/KSlj8=
X-Google-Smtp-Source: AK7set/ltNtG/I07CekrWl22IhsR1BBbAuXyKGBcj3zXvUnmL73VSXQZKgx9+Tr0hSWubIIKjp76A+VnmJ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:25d2:b0:19a:ec61:98d4 with SMTP id
 jc18-20020a17090325d200b0019aec6198d4mr6126654plb.0.1678217308066; Tue, 07
 Mar 2023 11:28:28 -0800 (PST)
Date:   Tue, 7 Mar 2023 11:28:26 -0800
In-Reply-To: <20230307185811.GEZAeJQ8U+NYySH8up@fat_crate.local>
Mime-Version: 1.0
References: <Y/5oBKi6vjZe83ac@zn.tnic> <20230228222416.61484-1-itazur@amazon.com>
 <Y/6FIeJ5KCOfKEPN@zn.tnic> <ZAZYKe4L8jhMG4An@google.com> <20230306214419.GDZAZes941k+4NPgDL@fat_crate.local>
 <25249e7d-4fd9-e1c1-8efb-31750740ec27@redhat.com> <20230306215450.GFZAZhKnr6zMCeeDNd@fat_crate.local>
 <ZAeHMgp9U7giJpHs@google.com> <20230307185811.GEZAeJQ8U+NYySH8up@fat_crate.local>
Message-ID: <ZAeQWre1PM7vsWd3@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Propagate AMD-specific IBRS bits to guests
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Takahiro Itazuri <itazur@amazon.com>,
        dave.hansen@linux.intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, zulinx86@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023, Borislav Petkov wrote:
> On Tue, Mar 07, 2023 at 10:49:22AM -0800, Sean Christopherson wrote:
> > I don't see what such a rule buys us beyond complexity and, IMO, unnecessary
> > maintenance burden.  As Paolo pointed out, when there's an existing word, the
> 
> Maybe I wasn't clear enough - I don't mind existing words. What I mind
> is adding new ones only for KVM's sake.

Ah, gotcha.  We're on the same page then.  Thanks!
