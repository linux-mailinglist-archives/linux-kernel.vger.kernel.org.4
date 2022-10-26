Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE08960EB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiJZWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiJZWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:33:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E2127420
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:33:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jo13so12036385plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATxbuLsPogoxf2CZH0iIXaNs5A68VADAxDa5ZVNaX6w=;
        b=WaHYTzXJFGdQACiKw3DsBLhk2dCJ3bsbr3lnN2VupHdfmo30A7vGkWaIFpH32aHpuz
         G3rlZYKdk3MTH7rCZaa20HmLufUgyjhV3hRkCufSU9beptFVlR2QSkIHpNYh3Wd82FTB
         qXw+jfN1lT2XGcyzLI2828CntlqRat1cG5sUKLH9ABU/KKIYWU2NH58Hqqe2jP3DHnv+
         6yHN5W64nNqWI8RzjmXR0zn6C8fiNwf7pL8DTFcR94QK9Y12Zjdb7H8OMm5RfS/GN9pf
         c7zVvapsSck2RwNEqUkzr0ZGPUr3lVxk4hKERwm9TgYOgI/eDlgGBLVkniA/u/cr/8RC
         ZJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATxbuLsPogoxf2CZH0iIXaNs5A68VADAxDa5ZVNaX6w=;
        b=yPtQEXhxwYAJh2oXOil7ZFzZh0UxXvvphm52b8s6vIYirkGNideLMmhkGSoyJUwKhu
         iyF3LG42MzbHfyJgQGE1cXKcFz+o3rvKPu5A7mhMOsSE/YBrTSMLHsOB5tqPcAnUi0Zb
         WJSbnCpA1tc+7buCkQZw/LnGGGrCDVsgR8lPT1df1Eb7+npP4NulFp8odh6Mn0exZlem
         PTkL21uzWbI895RZRnSxIamUF1F4erq2Z3q5GLbduubD3kHLpCQH0QQiQkF4ErDxrylZ
         adUASGY+AxU4e8GhorBOMrbCH/qLG6qoAM83PRctZjIbvmxHeSX71zH4t3qBolFUrghf
         POpg==
X-Gm-Message-State: ACrzQf1KQIrLQcLUGKfGdCd3OmevjfRyiKzarqF+liowWDxUA1uACwyW
        vlg9v8GqpDXYgJGq7oO2X/6wSA==
X-Google-Smtp-Source: AMsMyM7jzRH69ZbFGDkaivaJn1ZON3zYevSy9FEHdPof6reAY6kdybskMUB3vqh5WySvTnmX2EYtLg==
X-Received: by 2002:a17:90b:4f86:b0:213:3918:f29e with SMTP id qe6-20020a17090b4f8600b002133918f29emr6475434pjb.178.1666823605415;
        Wed, 26 Oct 2022 15:33:25 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7981a000000b0056c5aee2d6esm1789591pfl.213.2022.10.26.15.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:33:24 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:33:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: Fix state restore in em_rsm
Message-ID: <Y1m1sTM9FrAAhJgl@google.com>
References: <20221026215255.1063662-1-lk@c--e.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026215255.1063662-1-lk@c--e.de>
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

On Wed, Oct 26, 2022, Christian A. Ehrhardt wrote:
> Syzkaller reports a stack-out-of-bounds access when
> emulating RSM (return from system management mode).
> 
> Assume that a 64-bit capable host (i.e. CONFIG_X86_64 is true)
> emulates a guest cpu that does not support 64-bit mode. In this case
> RSM must use the 32-bit version of the SMM state map which only
> contains space for 8 general purpose registers.
> However, NR_EMULATOR_GPRS is defined to 16 due to CONFIG_X86_64.
> 
> As a result rsm_load_state_32 will try to restore 16
> registers from the state save area which only contains 8
> registers. Manual offset calculation easily shows that
> memory beyond the end of the smstate buffer is accessed in
> this case.
> 
> Revert the relevant parts of b443183a25ab and use explicit constants
> for the number of general purpose registers, again. This
> also ensures that the code in rsm_load_state_{32,64} matches
> what is done in enter_smm_save_state_{32,64}.
> 
> Fixes: b443183a25ab ("KVM: x86: Reduce the number of emulator GPRs to '8' for 32-bit KVM")
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

A fix has already been posted[*], we've just been abysmally slow getting it merged.
I'll make sure it gets queued up for 6.1.

Thanks!

[*] https://lore.kernel.org/all/20221025124741.228045-15-mlevitsk@redhat.com
