Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5331733D20
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 02:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjFQAKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 20:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjFQAKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 20:10:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D2435AD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:10:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b52e2517b1so7353375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686960649; x=1689552649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UeqVdKe6bdrLTszAcsIOc38lSLL4ZAgZjYYxToPygM=;
        b=rTKceqLLPgIl7ZUYL15qW3Yi5ys9AAeNA+qUmla4SNjZlR/PO8q+kHXeZZa1pKLPff
         FTM1wnlTry3f7OXrHVR+v8Edtpz4DNCNyG0gTRU0CtT7i/oYsPFhrv3iKqbHuIa4UgO5
         NOUi+L97Ii6d8ecLPCgpofBROT249ou8KAM47GGFWDOkY3giqZrsQ9aQj3oQd8aJT7c/
         SLux6dAwocZe3vXEFAdKrglYwU5E47cAiG4PpUAcwliFsPpKvXqZuNyW9Hhn/elqf6Wk
         kRNAuyqOtTs5ChdDru11971HKwelnR4v2POaZFLNgoApEp2fMQs8COTWeg7BmZqE/+Vl
         qlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686960649; x=1689552649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UeqVdKe6bdrLTszAcsIOc38lSLL4ZAgZjYYxToPygM=;
        b=khIKqOpDiG27C0e8DOZVzqgIBw7sDASmb7ulQC1OAkN75stn1UmAJlVgQmBOpZT6Zz
         hDPon13MlqjmUgXeSKJRiC5X++EYe4Sma6WeRDzEi16z5mERvZozJvdDJ0Z+lkuC1X/U
         N14NA/gf+jnuOIy8WPTzIQozE2KjHhecRgLKRb4UEf3caN8oJDk9f3i/A4/s4magtgTZ
         mbEy8vlLdv0cJx8QH16avMLMPwjjNLmy5F6Ne1g1blhl+WAgw3AUcavoGZE/3+RJYCBY
         YN8Sq7lj1vxKPWSFRQNBdHAekhoF1YWeRNO6AIeRhB8+9Bql/wB72rzjb2WFGCDLeq5M
         a1mA==
X-Gm-Message-State: AC+VfDx4dsO2A54D9kJ/N51Dj/IWnIkA4tnHRAPaSZrpTHYJ1fi/UZab
        HOR50S3Ais2KXxIrP+jUkdxYh1aSagA=
X-Google-Smtp-Source: ACHHUZ6o1LvghvP5AYfQrXjXfett8BYdRv7M4VDj45rWIpWqUoGiCEPeU5cSBpp78Mi6eMGRXsXGMDH9Rn0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c1c6:b0:1b5:2871:cd1 with SMTP id
 c6-20020a170902c1c600b001b528710cd1mr496513plc.0.1686960648818; Fri, 16 Jun
 2023 17:10:48 -0700 (PDT)
Date:   Fri, 16 Jun 2023 17:10:41 -0700
In-Reply-To: <20230616150233.83813-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
References: <20230616150233.83813-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168695521296.2510281.11357175395569915776.b4-ty@google.com>
Subject: Re: [PATCH v1 1/1] KVM: x86: Remove PRIx* definitions as they are
 solely for user space
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 18:02:33 +0300, Andy Shevchenko wrote:
> In the Linux kernel we do not support PRI.64 specifiers.
> Moreover they seem not to be used anyway here. Drop them.
> 
> 

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Remove PRIx* definitions as they are solely for user space
      https://github.com/kvm-x86/linux/commit/fb1273635f8c

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
