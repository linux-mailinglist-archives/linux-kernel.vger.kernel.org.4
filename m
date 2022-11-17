Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3762D3CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKQHIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiKQHIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:08:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28563657D4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:08:11 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 130so1212059pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UAu7Qq9urA/2CACA9Hh+1UR/gyDzRKpeK8exN8pGRGc=;
        b=tPom7jgm4aEV3UcuTrtkJ9WXPYx1xLs3GpHHDkKphwOmPBFKz+yATUKMk1dUX4Czj4
         9m5Z41vo7tXTj7X4CpnPP4xffZ3+eD1hoPOupmGXTUhfpccza0/QJojWLXRBN+MxesBW
         KZEcXnv6FIphs/mg4YlCNzY7DHdrlS6QVeSkGZLMgoDsYR++Us4LGtpvqaXaj5+hqdNN
         2LA9sydaeL6d283yzEM9HnUJWbNrbdbNUZkXH08AuHtpCWvJHy7hE6HSL3aJJbCpXFwI
         UD0QHIiRDU2+sHuipLJUXt8zTOxvp7n2MWM0ecdjFJKRG+6u2eNgX+75bjq4NKrmPGEK
         wCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAu7Qq9urA/2CACA9Hh+1UR/gyDzRKpeK8exN8pGRGc=;
        b=5pKfQ0VHAEbk8mQcwW0643c4SvG5tnd6Uzsm0BJWi01neJMG3feQifF4wGZNt/8rFe
         VhJ209cVH2LE6PSGdzJ8vcxYVD6erRnxDy0RjjzY8I0iYQycUJe+7Iw/PMpjcOOJ2Lx4
         DYOsMMLUHJ3mOnaoe4iFS864xnpQzGkXLrP4BoF6KlEBZoFRlhNTcFE+qa9YlwxKwO5X
         ennOwUOFjDRXy6tFUstenpChqq6GW5vUIUbfOkTQ8lg9yhW6vnJT1pCApw3JYbPZluHP
         LHoQmnWondZm8hKLGSznV4+KGGCx9crKbdvYuNSl+ckvnV0lsSGWlCaesaT+z1GEJmqS
         OYWA==
X-Gm-Message-State: ANoB5plG+u9vbmcF7Op/a1MCFhb/E18XR3Uph6k7W6wOLjMyLPJOUOp0
        tSg+hvwoFEiJ3SZInB77KnL42rktttiOBSaRrNtPig==
X-Google-Smtp-Source: AA0mqf6FeRrcOYfgd5QoCZHb7tiY6I/edy2aB82zFoI+g9lRRZuamw4/hvEK8BIr963Kkgm7Yq/eSFkC85iYBhQeVzw=
X-Received: by 2002:aa7:80d8:0:b0:56d:98e3:4df8 with SMTP id
 a24-20020aa780d8000000b0056d98e34df8mr1695579pfn.37.1668668890570; Wed, 16
 Nov 2022 23:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20221117002350.2178351-1-seanjc@google.com> <20221117002350.2178351-3-seanjc@google.com>
In-Reply-To: <20221117002350.2178351-3-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Wed, 16 Nov 2022 23:07:53 -0800
Message-ID: <CAAeT=FyKq8oeer7b0McUkGRbvmUPH4+hLnWPKZmGQ3uWgkUNcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: arm64: selftests: Disable single-step without
 relying on ucall()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
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

On Wed, Nov 16, 2022 at 4:24 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Automatically disable single-step when the guest reaches the end of the
> verified section instead of using an explicit ucall() to ask userspace to
> disable single-step.  An upcoming change to implement a pool-based scheme
> for ucall() will add an atomic operation (bit test and set) in the guest
> ucall code, and if the compiler generate "old school" atomics, e.g.
>
>   40e57c:       c85f7c20        ldxr    x0, [x1]
>   40e580:       aa100011        orr     x17, x0, x16
>   40e584:       c80ffc31        stlxr   w15, x17, [x1]
>   40e588:       35ffffaf        cbnz    w15, 40e57c <__aarch64_ldset8_sync+0x1c>
>
> the guest will hang as the local exclusive monitor is reset by eret,
> i.e. the stlxr will always fail due to the VM-Exit for the debug
> exception.
>
> Link: https://lore.kernel.org/all/20221006003409.649993-8-seanjc@google.com
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
