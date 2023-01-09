Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A1662C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbjAIRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjAIRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:25:22 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541941017
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:25:21 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-14fb7fdb977so9325358fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BfmjP2mndLDes9oQRNaJXeRDdi6D0K9ObPAqlxFeEu0=;
        b=n90Q6czpE5ApJ2gN/nhORqyIrmbjapJ05+Aff3Ztvw5ahUAcOGpKgIM6yaDv0lJO8Z
         +Mi25azRzciEp5kW6wNc8xmhvdj8UtvajbJQ1mLZy/4rtz95POVxJ9bBaWv05g2yO1yB
         1NpiAnyRFitfTzeRTk6gk7dL6msevio0pwpGakUWJusEBE/6ln9/R2Q1x/5FMJfErXIH
         aGzGU1NtQSkc8dDkz6Bstdg9nlHsXEH9p1wh9N5ociAd8ZOFGUulqZqwkYDZbcDWm4s/
         29fLrU1Z55eNQEHJsUzWeS24GerzqvBUqJM/tocu9i+0uEp6+I8EzI7VdukyCoB7Op1L
         /t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfmjP2mndLDes9oQRNaJXeRDdi6D0K9ObPAqlxFeEu0=;
        b=2sjVUdg5oBfabPBK8bVxKMOSAXBCt7AbLvZrkKKBe52faMAcKZogMZAGeVhrCfupIH
         YST2rXghpDw8OwXdAFsqUkJafVanZKF3Yf2Bkph3YGa8ThF5jhAaXl0cWCDH1q8n4kkH
         A6P1GWqkpclUTPOFge5KKtY8Yk4tYUk4In4BQOZQzbr9UwSLOYg7LBsz3YM3FQvoXQFq
         uSRUd0URiLKmChhzcpoShnovUIR1MMjcVGFHkaPHgb3C+9WOrwHUEw9obS3CbqzzDiYi
         Gqk6CCDvwt8LMeNav6aj7kOE8Kp6JbJnnrPNq+Q5tojUgt3jfBrFUBFDOwLVt17omvaK
         e9pQ==
X-Gm-Message-State: AFqh2ko69UxiYv0d/A6uvtZovqIX8gy1VtPzMjFSTVmw60ZiE6TCaqTa
        EG5BGD40YjFGWBP8b96omARUHpeDh8cuqZiKz4qUjw==
X-Google-Smtp-Source: AMrXdXtzQNFiyh4xIRzhYuKtkMcUQ2K4IiyYKYar0Jys/Q3OEqkhPu8uyjJho++He3RsqGUv1AZTzdsWHegUt+RO7OQ=
X-Received: by 2002:a05:6870:b8f:b0:153:8960:d987 with SMTP id
 lg15-20020a0568700b8f00b001538960d987mr1155220oab.103.1673285121011; Mon, 09
 Jan 2023 09:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20230107011025.565472-1-seanjc@google.com> <20230107011025.565472-6-seanjc@google.com>
In-Reply-To: <20230107011025.565472-6-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 9 Jan 2023 09:25:09 -0800
Message-ID: <CALMp9eQRc7rFruYQiaP1wUfPpvp4oVE=JX=TDtR=WZSoC6Nb2w@mail.gmail.com>
Subject: Re: [PATCH 5/6] KVM: VMX: Always intercept accesses to unsupported
 "extended" x2APIC regs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Orr <marcorr@google.com>,
        Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
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

On Fri, Jan 6, 2023 at 5:10 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Don't clear the "read" bits for x2APIC registers above SELF_IPI (APIC regs

Odd use of quotation marks in the shortlog  and here.

> 0x400 - 0xff0, MSRs 0x840 - 0x8ff).  KVM doesn't emulate registers in that
> space (there are a smattering of AMD-only extensions) and so should
> intercept reads in order to inject #GP.  When APICv is fully enabled,
> Intel hardware doesn't validate the registers on RDMSR and instead blindly
> retrieves data from the vAPIC page, i.e. it's software's responsibility to
> intercept reads to non-existent MSRs.
>
> Fixes: 8d14695f9542 ("x86, apicv: add virtual x2apic support")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
