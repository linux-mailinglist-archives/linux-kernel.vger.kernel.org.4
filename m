Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B205E6C20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiIVTxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiIVTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:52:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C710C79E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:52:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3265834pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wMNXJ8tFxE5zdbCt/8NlY898zBIrwCziYNXTEkeFtOE=;
        b=osmH1rZrpkJ6s76hQuUAEjFLexMUXotkjlIrkAHzJLLxfMjT4VOxIIq7LsqQygOh1U
         MoPViL9Sh3S3Qf6Ig3abH0WuEvy3q7FJqIZkhBpXAk5dtG45kC6WW06TWbRtFiRcwIZA
         +/V/HjoJfQPK57rx8trhI7mrhNdKAf1dRseLhJKopMegcnOL2hYPoKiiOZZR0tGrcgUK
         S/vrE7BpLzym8cvD4FET/cPLMF8VJlHGakNccZ6Putz3DmOWcdPJWkLOuClFVeSCBlZE
         IfLPei+StKU1CMKK9+vrHZfyN+5Qv06CZ3dDS/Y6m7OFbLzYA9ARkbF6avZezHx5q+Gp
         F1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wMNXJ8tFxE5zdbCt/8NlY898zBIrwCziYNXTEkeFtOE=;
        b=WYFqrdUCaO/KUTYukOQ1REVpIVuRRT92GR5AZUHe2NtP/TM5A74GZYSQSKl03f8nMJ
         D6gWVMXnew/R7csEth0Hnov5vqHxiiNjXyS1CUFbjDOjeQRU7u//n5idgkt4UJ+PrDAJ
         /Wid05ye5V5gnqFtigjyfWz/zfD1H3snXggHZrPbG+NyOkyu0LTWsDuh0yKbHcsFVu4r
         YLUHnuibyQEBFsW+LHHHrI6RnaM/pwA4kCH1T8G8suX/686l3omaB6am1WY6NBI7rI9O
         5oa7f0FhI9l1IDWrlhfxOWoN/GEEDx4ZXGJej71e8Zphl45ilipUCol9pTJxQKKrzr4D
         okVA==
X-Gm-Message-State: ACrzQf0FIoyTWf931l4YY40FK43PmTPPUc1CBU9yeApP6UwvFnouLKwF
        zPSIq40ym6dX4rC1o3xRvXbqzA==
X-Google-Smtp-Source: AMsMyM5BdUqTDuToI93vzvlISEbaqCLJ8dQf04fko/C0BcWQFqgd8LAFO+L9G1jawdpz47TT0G+T8g==
X-Received: by 2002:a17:902:b089:b0:178:54cf:d692 with SMTP id p9-20020a170902b08900b0017854cfd692mr4732453plr.1.1663876365741;
        Thu, 22 Sep 2022 12:52:45 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u16-20020a632350000000b004277f43b736sm4180327pgm.92.2022.09.22.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:52:44 -0700 (PDT)
Date:   Thu, 22 Sep 2022 19:52:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 14/39] KVM: nSVM: Keep track of Hyper-V
 hv_vm_id/hv_vp_id
Message-ID: <Yyy9CH9CgCsZ3m3V@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-15-vkuznets@redhat.com>
 <Yyt/Nrh4aoLrNt11@google.com>
 <87y1ubn3e9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1ubn3e9.fsf@redhat.com>
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

On Thu, Sep 22, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > I'm definitely not dead set against having hyperv.{ch}, but unless there's a high
> > probability of SVM+Hyper-V getting to eVMCS levels of enlightenment, my vote is
> > to put these helpers in svm/nested.c and move then if/when we do end up accumulating
> > more SVM+Hyper-V code.
> 
> Well, there's more on the TODO list :-) There are even nSVM-only
> features like "enlightened TLB" (to split ASID invalidations into two
> stages) so I don't want to pollute 'nested.c'. In fact, I was thinking
> about renaming vmx/evmcs.{ch} into vmx/hyperv.{ch} as we're doing more
> than eVMCS there already. Also, having separate files help with the
> newly introduces 'KVM X86 HYPER-V (KVM/hyper-v)' MAINTAINERS entry.

Ya, there is that.

> Does this sound like a good enough justification for keeping hyperv.{ch}?

Your call, I'm totally ok either way.  If we do add svm/hyperv.{ch}, my vote is
to also rename vmx/evmcs.{ch} as you suggested.  I like symmetry :-)
