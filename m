Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AB720C96
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjFCATp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbjFCATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:19:43 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86A1BF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:19:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-652e21cc2a9so635736b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685751582; x=1688343582;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/VDyXpLLhCoIKoUhbymnoQWL77nGo+VzlGwY63nNbY=;
        b=yi830kcEXYanC8kJQwEza/HqzoQRzvbtgqN+dXDO1M7ya1qPV+lvvm5Dq4LPQccvP2
         qhh3GejC0AYSdaiHEi8kHfA7V+R8lMEVg9c79/y9TM61N85VhGjzIVRxp4O46z4WVTFR
         kcMB+WMiwlQaIdEeUALwdvS++vtsprrXUV3rpgFRZBCtrvsXlMPlxBfrtY/gRvNDrJvv
         T3r9wHAlknu6pFNkikaaH6YjZcGbR8ahO4757TrXzdcvfv/BrxOBopWdKP+xF8784VWW
         rBh5uQP3RTrn6SygQkuD6eqB0BNBKrkWwpWw3YCIgTt1bg8scpTlbo8Wk8stcXAZeFrM
         7ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751582; x=1688343582;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/VDyXpLLhCoIKoUhbymnoQWL77nGo+VzlGwY63nNbY=;
        b=ZGXFsn1SeAvIi0YwfvCavdVzEk45xqouGlMo4XFee5AM30WrLwNfZGMFi5SE7rR5Av
         yLm2NmsWI//nrS6voiEjdEl09RabCSbYGrbv9Mjh5r/c5M1emErjcF+JVqaWT0R1BtBR
         IgyAAbitqvi0ALMm9B7kbl1z8A7lShc6rZ4ouNuwPR2zq92yL5XoLyA9mG0yVHaNeSd+
         +2+loB9rogu6yiNoZJyJSO16AsS4JOpJ9p1KXzkgjl3wvX4s2AwJvEiyd5S0jTJ71Vgz
         tMVkqRA29DPIesqbcyuuN6ks8Gi6V/gV2jWbn7G4IlSmnvL2/TD8GUgE3awfx2zYG8H1
         rNQw==
X-Gm-Message-State: AC+VfDzoC1ED1gDWyV9XdohLKc7JN+q5FoH1BxCH+G8E3jZO6/bxOJt8
        vxzBM0PqtIoQK8pcBRfKYpJS4hLqN4A=
X-Google-Smtp-Source: ACHHUZ4MDaazCQLC/2OqobQ3yxxeAWFvHYIBlboquCIbt7Q1L2oHxytmPACCaryHvlWLg+hNkEzmuv5X/D0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1907:b0:650:154:8af with SMTP id
 y7-20020a056a00190700b00650015408afmr4405822pfi.1.1685751582059; Fri, 02 Jun
 2023 17:19:42 -0700 (PDT)
Date:   Fri, 2 Jun 2023 17:19:40 -0700
In-Reply-To: <20230602233250.1014316-2-seanjc@google.com>
Mime-Version: 1.0
References: <20230602233250.1014316-1-seanjc@google.com> <20230602233250.1014316-2-seanjc@google.com>
Message-ID: <ZHqHHLa2G4r0aXJt@google.com>
Subject: Re: [PATCH v3 1/3] KVM: x86: Bail from kvm_recalculate_phys_map() if
 x2APIC ID is out-of-bounds
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023, Sean Christopherson wrote:
> Bail from kvm_recalculate_phys_map() and disable the optimized map if the
> target vCPU's x2APIC ID is out-of-bounds, i.e. if the vCPU was added
> and/or enabled its local APIC after the map was allocated.  This fixes an
> out-of-bounds access bug in the !x2apic_format path where KVM would write
> beyond the end of phys_map.
> 
> Check the x2APIC ID regardless of whether or not x2APIC is enabled,
> as KVM's hardcodes x2APIC ID to be the vCPU ID, i.e. it can't change, and
> the map allocation in kvm_recalculate_apic_map() doesn't check for x2APIC
> being enabled, i.e. the check won't get false postivies.
> 
> Note, this also affects the x2apic_format path, which previously just
> ignored the "x2apic_id > new->max_apic_id" case.  That too is arguably a
> bug fix, as ignoring the vCPU meant that KVM would not send interrupts to
> the vCPU until the next map recalculation.  In practice, that "bug" is
> likely benign as a newly present vCPU/APIC would immediately trigger a
> recalc.  But, there's no functional downside to disabling the map, and
> a future patch will gracefully handle the -E2BIG case by retrying instead
> of simply disabling the optimized map.
> 
> Opportunistically add a sanity check on the xAPIC ID size, along with a
> comment explaining why the xAPIC ID is guaranteed to be "good".
> 
> Reported-by: Michal Luczaj <mhal@rbox.co>

Fixes: 5b84b0291702 ("KVM: x86: Honor architectural behavior for aliased 8-bit APIC IDs")
Cc: stable@vger.kernel.org

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
