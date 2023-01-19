Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E154667440B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjASVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjASVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F28A5CD0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:03:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id j1-20020aa78001000000b0057d28e11cb6so1431320pfi.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbDaaSJvobNV5Ds3Rih74TAbfU3rZrDtTb01NjKp5c8=;
        b=nlIRxtqTxEsjrzPTxiV77OKW32I7a3XK4lGJoXuRkPNkeRHdUk1m4n7TcSW07fQlKJ
         hue5f8oHh/mNJMcxjdaFlvTxSzIDL07lCF4QThggcqDgtu7HmsB+xQvucmQf5PCZFpfM
         P7NAwsFA4lcHlsKioKPMt7deX8FKBfHLKlzM/ck4dMYBN9F1Qey9Q/HgBmQbfkjRSLnG
         987eUFe4zMeRnjNOZBcg93wp7F2g4VTbOKAd5nR95MAmI4E/5uITheNAYf307CSndAbm
         xEdD7fw72/LDoG+NTTDMW+e0oJH7ITzLJfoz5ewjrvL65pDbnlb8GDJnjT/thi7+AGGo
         kIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbDaaSJvobNV5Ds3Rih74TAbfU3rZrDtTb01NjKp5c8=;
        b=mHO3HzRfmTw7tbEaTZTZlxOOlt7XDz85ymHI8YYnqXoTV73OZqVA3KwZtmYD7hF8J0
         sluP9mgk9JDx9nRdmS04WxLABVmcp/DYUqNdqCmgZviBDMRFOjGdsHqTt62TM4ZahpC9
         BUGP93wJxRt6OqQZj7e8jVoEK+PBAOyOhRA3+iHmeiFTAeT4V/kTlbnItk0Tts51jB1H
         Zmhk4W+hJHkl1QKQHGgTKJSMOymV6gkVHbtvhU0eqGGEtF0u5vgnAz2S3xlK+UEEe/fy
         HxmVFtWXp57VnznhPIwHhWv78taZABziDXsnUkkxaDSEIDxJxUee8Qwe4RWtOTwrAz3S
         5ghQ==
X-Gm-Message-State: AFqh2kpP27VfLlUA1Mz2s/v9lyZ0+FRRBwJNpfEHeb7MHxTy7BZwKiG6
        RboBWM3OiCJVZBVyHCmNwqOcWIL33O8=
X-Google-Smtp-Source: AMrXdXv/g5a++qTJuSYmiefMV47cq9t1IJPRfU1gkDEpKaCysYl+MIo7uP388svuElqQwAQez/+tE5jeFik=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8d94:b0:189:a2d4:7f5 with SMTP id
 v20-20020a1709028d9400b00189a2d407f5mr1253044plo.23.1674162204086; Thu, 19
 Jan 2023 13:03:24 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:03:10 +0000
In-Reply-To: <20221109115952.92816-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20221109115952.92816-1-likexu@tencent.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167409033032.2372165.7505423763939430005.b4-ty@google.com>
Subject: Re: [PATCH] KVM: svm/avic: Drop "struct kvm_x86_ops" for avic_hardware_setup()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Nov 2022 19:59:52 +0800, Like Xu wrote:
> Even in commit 4bdec12aa8d6 ("KVM: SVM: Detect X2APIC virtualization
> (x2AVIC) support"), where avic_hardware_setup() was first introduced,
> its only pass-in parameter "struct kvm_x86_ops *ops" is not used at all.
> Clean it up a bit to avoid compiler ranting from LLVM toolchain.
> 
> 

Applied to kvm-x86 svm, thanks!

[1/1] KVM: svm/avic: Drop "struct kvm_x86_ops" for avic_hardware_setup()
      https://github.com/kvm-x86/linux/commit/6e66dcbdfe90

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
