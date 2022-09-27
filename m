Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFB5ECB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiI0Rjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiI0Rix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:38:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961F1E2747
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b23so8341712iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zwWYKbkkIMXnui5gCfkJ00LzKXpPlaBP/wjajc/qT2s=;
        b=syVso9JR6664/0/8mv5Q0ETYytR/HniKXmKiH3T1jW5szdgBIeR6jrNwGL0FX2LiCm
         F4PGCPVRtW9j/nghuwf+gEtj2HzOLg+ajhiadpCHFepcUySHBDw2v1zsD7VzKKvJxyo4
         CL0j58elRqrDEmDWTSJecNQ6lX5TKYckWqFOa9PxrRmeg0dSBR+rT2vYjCYMUkI4txut
         M0c/TqRHQG+mjav8eL5QgGwTx/qw47Uz3bLYSGQHC8RyeTK0oJq1VjBWksj3kJx9zPFL
         IIt160iugt34uDrqxE1tX48P9LKN3c+EWbH/SIMBl1Vc4zDimqX1nWXB3R5IU8y84mDc
         Gymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zwWYKbkkIMXnui5gCfkJ00LzKXpPlaBP/wjajc/qT2s=;
        b=oN4Agqs9aYFGgu2Jlpod71N7eOSiccWc1TfPKe9Wg0VQzdlpDfqAMh6Oc88QZhcKig
         gVc/1v278HTfgf17nifKQBQ4xouWTHY3UuzWrEw2E+9yLZQLaZELN6Jevp0TeMYkHeAo
         mJG36XzDu5bokRMF+gE/lijNNerol6IKBaR/v1JPbhf9E1NmkPN8aJ2xiNsUoJuR6ze2
         fdP6yRYrKP7Lh2vft4OV6xwyvGBuQ2dYzLTWb0mGkk+Ibw7fLbRD68ioQcJJp6C8HXBI
         NaUvi3oQlbgGnFiq41de84pDIJgDTBlz8l9spav2anyVqlLR632Vel4W9kzcb3mWkXow
         itaQ==
X-Gm-Message-State: ACrzQf3WSMozp3AcMOLg6XYXz6NbfoJT5Y8I6jJ+72dHvjFGom0OmEY9
        1JoFGD2A1VCH7WpakEOEKgTICiRSfcNzMLnaxbCHDT5+YXA=
X-Google-Smtp-Source: AMsMyM5MfXlfh9YEbgA+gtNnYv11bP83Vk62ySUseMBdKK5z9jeJJNAuT70mC5cTy94LiccSQm6HTh24Cbmndz+QGlU=
X-Received: by 2002:a05:6638:4184:b0:35a:3eb4:f932 with SMTP id
 az4-20020a056638418400b0035a3eb4f932mr15108246jab.216.1664300314532; Tue, 27
 Sep 2022 10:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220927002715.2142353-1-mizhang@google.com> <CAAeT=FwqWkbhFLHvr12A2rYdzZuDJWBti=jKQRargvAb6bKtaA@mail.gmail.com>
In-Reply-To: <CAAeT=FwqWkbhFLHvr12A2rYdzZuDJWBti=jKQRargvAb6bKtaA@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 27 Sep 2022 10:38:22 -0700
Message-ID: <CAL715WJsp7zJ-p++TzjxAv5b0cWRKFH-2Tqws1SV34EO16Xp-g@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Cleanup the __get_fault_info() to take out
 the code that validates HPFAR
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

> > +static inline bool __hpfar_is_valid(u64 esr)
>
> Unlike what the name implies, this function returns true for some
> cases that HPFAR is not valid (i.e. SEA).  I think the function
> returns true when KVM doesn't need HPFAR, or when HPFAR is valid.
> IMHO the name might be a bit misleading, although I don't have
> a good name for this.  It would be nice to state that in the
> comment at least.
>
> Thank you,
> Reiji
>

Yeah, I agree with you Reiji that the name does not reflect the
meaning of the function. So I was thinking about other names like
__translate_hpfar_to_far_needed().
