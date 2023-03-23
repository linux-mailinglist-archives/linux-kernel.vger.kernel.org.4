Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838D76C7349
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCWWq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:46:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CEB75A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:46:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s11-20020a170902a50b00b001a1f8fc0d2cso128696plq.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679611613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNHBl3QczA2duBiLkiqIakCr9NDsSlzl00Etwe/x6AA=;
        b=nL4uDHT5LN/KzWrSdMVEP4XYVi62HDk1HQdumZO+SeJ01dVjDn9KXeH7sxgu9tN2Ih
         RQQcFcuMC2vmrq8CPwa2zJ/d5RXHOZIm0FZWzAhKQIq6n+2wWsoLdQb5LyBdnkh/XCR3
         LtelyBK6rrQ7Wl8BO8gKq9k6opsrbtRKnW+b3lr/tsBptbz8VcqOOX0SpuaQVweCq8Bt
         Ri/yPZwY5ilgL9UQPYNCu1WlZwlnlXh2mY+oVNh1ALHtmbXijZOJe7xRulULIa+f81kc
         iBSejLd+0rarVjncxsXJjQJmAvi3xW3ecUq/dhtcqRMYksgYeR4S9ZF9hAXyCgsPwIEn
         1JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNHBl3QczA2duBiLkiqIakCr9NDsSlzl00Etwe/x6AA=;
        b=mas8B8MH7fMspi1Gyr4OhyupXJZ9wf7sWpsSME7uEcp0LQUuMZGdrNVAAYkgY0IETJ
         GTDmfburBC9NaIPtA7AWllAKxT0fD117EOUFGII4bSxfUA3tRkW1DMmrpTvis7na9po/
         bvtbz8KY/pZuoeA4pJ6nky8tf0vGf1DXx6KiNbey2qcfCQt6aHCCM2as6LtODqzxYVN3
         imckKjzKxUG3mI9A8t919WJdqGi0sgzAaXADpMLmyO4zNGPXSDxm60SKBEqEYg3wnvVL
         ixrdvn1nwZLz6qvuliWg86f8byLlpKWmW4AH4iZ9eefEhh1d6rIrkRGU6nuVZW4eNqdj
         RIPA==
X-Gm-Message-State: AAQBX9enL3HL+yu0k6u3ACcpgllW9c3UNkcVDdoC4ghOGexS9Qe0gdjd
        p+a1iCN84eV7ACy/5aHSUybR4NH2zV4=
X-Google-Smtp-Source: AKy350b/PgUg+gxiOE/h70oYz151S5aJduuVjb8pRCIi0/IS8Bc+b+9UPB0ti6SDk5DSK+SHTuxsCHRMcOI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:89:0:b0:4fc:7e60:d0c with SMTP id
 131-20020a630089000000b004fc7e600d0cmr19725pga.11.1679611613647; Thu, 23 Mar
 2023 15:46:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 15:46:32 -0700
In-Reply-To: <20230322011440.2195485-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167949671616.2217955.7836409047320878527.b4-ty@google.com>
Subject: Re: [PATCH 0/6] KVM: x86: Unhost the *_CMD MSR mess
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 18:14:34 -0700, Sean Christopherson wrote:
> Revert the FLUSH_L1D enabling, which has multiple fatal bugs, clean up
> the existing PRED_CMD handling, and reintroduce FLUSH_L1D virtualization
> without inheriting the mistakes made by PRED_CMD.
> 
> The last patch hardens SVM against one of the bugs introduced in the
> FLUSH_L1D enabling.
> 
> [...]

Applied to a one-off branch, kvm-x86 cmd_msrs, so that I can get this into
kvm-x86 next and onto linux-next asap.  I'll drop the branch if Paolo wants
to do something else, or if there are issues with the series.

[1/6] KVM: x86: Revert MSR_IA32_FLUSH_CMD.FLUSH_L1D enabling
      https://github.com/kvm-x86/linux/commit/e9c126917c09
[2/6] KVM: VMX: Passthrough MSR_IA32_PRED_CMD based purely on host+guest CPUID
      https://github.com/kvm-x86/linux/commit/4f9babd37df0
[3/6] KVM: SVM: Passthrough MSR_IA32_PRED_CMD based purely on host+guest CPUID
      https://github.com/kvm-x86/linux/commit/5ac641dff621
[4/6] KVM: x86: Move MSR_IA32_PRED_CMD WRMSR emulation to common code
      https://github.com/kvm-x86/linux/commit/584aeda90bd9
[5/6] KVM: x86: Virtualize FLUSH_L1D and passthrough MSR_IA32_FLUSH_CMD
      https://github.com/kvm-x86/linux/commit/5bdebd246db5
[6/6] KVM: SVM: Return the local "r" variable from svm_set_msr()
      https://github.com/kvm-x86/linux/commit/8a16ed8c673c

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
