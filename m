Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172045BD8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiITAms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiITAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:42:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BF5246C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:42:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so3654362pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QkOnJGdn7K4Qwg1F/eWvHgDBxYxWqvwUhp+5H4Y8V6g=;
        b=gzRA65qhNIBk+r2s+Mrb7LTIEwxQNP3PN41Y6PpoFkTzUIEBs1Z0zidPjKEcQXz19P
         G3wwap+Zc4oC2hJho0QDQftjrBmoWENhRh9mCnQhAV1mvFPufMAhy4T9vDu67yijZSFe
         siZCUmxsakOxV9v3AWpq3MJl7YJLHAI7oihDeynO7IiMJyFVXSyU0AkgLgf/e3hKu0fr
         +Ik/gQ6Wk3FkqRaFXi83uY2yTOWygtdvs32RwHaN/Ezj/8P06QTmGjJlQfdbznf2Wnx8
         XMFziHRxObTvd05PrI6zv0qhhfZXZh5ULl2ugc8Wlr6ker+vvtgVE44Qq9WNSYMntFE9
         xrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QkOnJGdn7K4Qwg1F/eWvHgDBxYxWqvwUhp+5H4Y8V6g=;
        b=3itmjGSDMnw9dHaPCMb/3+W/gjaaYBWI9wLJThNWkF6yg6agYH1kaUhtbEun6UDVLM
         mQlM00Ohktrm4VZ6bclxyL0SGo3HHaznWqN5ytYhG0lPNa2LYl2tleXcRStigSlEPHle
         5Usj2M+9CWPlnixuDZBW9kehkqAKnsduUg+zZ5y5plzNtysIl6+quFEzpOw8DsgJIild
         0UyhKFIKncJwmZvaVqRP2nlnsZOS2Cx+IdO2Iz4tjEUX8DMLGVgOaaHUApZ1hoyc49L3
         r/E6QHOwprJBmEAzH3NxJaSQGFp3S5EBiefKbrFlo5OBHpetjO276TXxfiMGMTDtDtlp
         NDlA==
X-Gm-Message-State: ACrzQf1A0A4TxwaVFwy8GmRYDxfBIMwMv06L7KH2fbSJbc6fy0+ouz48
        MSDVLbl9gy0/aMhixGKrTA9hzg==
X-Google-Smtp-Source: AMsMyM5JxCPetBbcCQ6yAMluOOPO9UXy7QaOST+Dw1o0drbmcYOhXxooVd1ODyXbMYSNucoTnCn52g==
X-Received: by 2002:a17:902:ec87:b0:176:d549:2f28 with SMTP id x7-20020a170902ec8700b00176d5492f28mr2397070plg.12.1663634551470;
        Mon, 19 Sep 2022 17:42:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b129-20020a62cf87000000b0053640880313sm14021pfg.46.2022.09.19.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 17:42:31 -0700 (PDT)
Date:   Tue, 20 Sep 2022 00:42:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, vkuznets@redhat.com
Subject: Re: [PATCH v2 2/9] KVM: x86: remove return value of kvm_vcpu_block
Message-ID: <YykMc2NDOzvG+xoy@google.com>
References: <20220811210605.402337-1-pbonzini@redhat.com>
 <20220811210605.402337-3-pbonzini@redhat.com>
 <Yvwpb6ofD1S+Rqk1@google.com>
 <78616cf8-2693-72cc-c2cc-5a849116ffc7@redhat.com>
 <Yv0aHXcmuivyJDXw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv0aHXcmuivyJDXw@google.com>
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

On Wed, Aug 17, 2022, Sean Christopherson wrote:
> Side topic, usage of kvm_apic_accept_events() appears to be broken (though nothing
> can trigger the bug).  If kvm_apic_accept_events() were to return an -errno, then
> kvm_arch_vcpu_ioctl_run() would return '0' to userspace without updating
> vcpu->run->exit_reason.  I think an easy fix is to drop the return value entirely
> and then WARN if kvm_check_nested_events() returns something other than -EBUSY.
> 
> 	if (is_guest_mode(vcpu)) {
> 		r = kvm_check_nested_events(vcpu);
> 		if (r < 0) {
> 			WARN_ON_ONCE(r != -EBUSY);
> 			return;
> 		}

For posterity, I was wrong.  Way down the stack, vmx_complete_nested_posted_interrupt()
can return -ENXIO after filling vcpu->run->exit_reason via kvm_handle_memory_failure().
That's the entire reason why negative values from kvm_check_nested_events() and
kvm_apic_accept_events() are morphed to '0', i.e. to "exit to userspace".

