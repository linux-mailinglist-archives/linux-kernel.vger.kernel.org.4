Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D6471F7DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjFBB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBB0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:26:47 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DAE6E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:26:26 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6529316508cso397609b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685669186; x=1688261186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ulcs759pXhqANTcyIz5TCUvafN5mVvEO5SIBZyF8Ng0=;
        b=nDXDigfitr4dALtYE0tnvc7jd5AMZjKVHEqr8Ywe96FxidI7ZIC0zpSZu2GIVPLfCy
         aYMQYij+0SU4DWERsNQGEsuk4vypYrGAH4jnA+8N9EPIT0i4LUD4p96gPjJh2bky6eLh
         3W+VQ3Drp9pX0PmRbpxsjDBBhgNuOW4ASn5ApYK1Lk2kbpCE1Owr1VccDQyn0etiOdyk
         kQcB1tZ4989UcUdkXJdCznnTjNxdgMPQRHe42bY3Hpgy0KqsNETHPe3Dup5kET1LatYD
         Cm3Bn1FuYE+SlrCCnMqCdRvXSq4gNrktenpqnjWVhO0VZQEGMHUF1MSGbBEtSmUtFdaK
         ro6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669186; x=1688261186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ulcs759pXhqANTcyIz5TCUvafN5mVvEO5SIBZyF8Ng0=;
        b=ahf7GjCiUkbv/QOEuRBKaw6Wk1CySvzERsGRK/6gzf0T9XTDD7LLYLxBqVZ7tRO042
         Z6uuBWHsqBws7R74NETSuSaRBoq4QKoLfJ/nYaqHYYJ+4C/OKd+SL+Za75enW8Lt/OUa
         +6IgtFRPtvDNOp7uWHTDTjucrJ5q9ekIDbObHGJ70g3nYGr9vUvhD86B+AWprwPfCwv+
         oFKLhdSKISYWlmmEVnFin0wJOWFYn0Ku9179Kv596kxCpOJ94Ick7Xt3w6DC14MwRWDN
         kmy1RwoB5lkzuecydyTSd3KcqbTHF+lY2WeupDKu0QoZUfXbsqjPlUSmK2T6UK5EnPlC
         uMLQ==
X-Gm-Message-State: AC+VfDx2M/X8AZaAtWof40TUD58odncYYt5cVijn9wyZuMAK/RrjozDb
        qF/waz6KxKyLInP9UiT0cxIeJJRKRyQ=
X-Google-Smtp-Source: ACHHUZ43qb1Xe4TUnEzYnVeeDgEOT4G1GfL3cfaEOTZYCoy/8lSeWWNEy8x5V4sTtHMw63SHRKTXt64cn4I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1903:b0:64d:2cb0:c623 with SMTP id
 y3-20020a056a00190300b0064d2cb0c623mr3826201pfi.4.1685669185965; Thu, 01 Jun
 2023 18:26:25 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:25:51 -0700
In-Reply-To: <20230410125017.1305238-1-xiaoyao.li@intel.com>
Mime-Version: 1.0
References: <20230410125017.1305238-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168513385664.2794711.2855259529365400340.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: VMX: Clean up of vmx_set_cr4()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 08:50:15 -0400, Xiaoyao Li wrote:
> Two minor patches of vmx_set_cr4() during code inspection.
> 
> Patch 1 gets rid of the direct accessing of vcpu->arch.cr4 to avoid
> stale value.
> 
> Patch 2 moves the code comment to correct place.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: VMX: Use kvm_read_cr4() to get cr4 value
      https://github.com/kvm-x86/linux/commit/334006b78ca8
[2/2] KVM: VMX: Move the comment of CR4.MCE handling right above the code
      https://github.com/kvm-x86/linux/commit/82dc11b82b00

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
