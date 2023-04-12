Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562736DF8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjDLOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDLOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:39:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49C7D9C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:38:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m21-20020a17090ab79500b00247099b5e7dso253009pjr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681310314; x=1683902314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjNNjhvcQw4WbAW0UTAD5k66A9ANuIr45cT7T0+9r+8=;
        b=fsy2DOk/k6iHMDVFvLNU2Zl/+DZjUi+ivdp9bc9hbJvbBerPqTc01Yru8Q2zs7c3pa
         4RjgjFGYn3HNs7PUcq07LO93NKcZ6gfRfCFys28DkFkVTif7DpozMFkqyThKQAqAnpg8
         Lu/e3jC6jaxa3gX3bz/mBdEoVVGS17/d3bajni0wrwDO/N34yoNjpGxw9Etqv49Q7k9V
         MCGW9jRbCTte9pt6GgV0OGI0muzBzT7E4nZYkpl44YonurvDCqhsuPU2/v+tccWqFJN/
         qTYhWCihqEZ0rGx3OZuyAxIgQrPyzrdicnzeaLN03l0scwiM6q9nhkR9C6HZ+Bp7KzsQ
         5TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310314; x=1683902314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjNNjhvcQw4WbAW0UTAD5k66A9ANuIr45cT7T0+9r+8=;
        b=iq3H24Ot1qvmHiS4Ll/gFZHz8E2roedb5aaXl4VW1GGf8/pjhIlDDuy+B1cRk88DM9
         Ij97Ks+ym6wo8VMHEBokBJJC5x8ECe5Ipm5JiJbqgNyjQngwJdolG/w5b6BmWl7r809K
         9aPjM8AGficzXU5xm89BuYMm6IRQiX+Ao1Nje9IkOJolIyNJWGASI+MYX4NjSzdh0txz
         DTmCzXKNrV/LX2Ik/jfeNbg1RcVxQjbujYUvCKGrgu/ToZbsfC2PN9OjTxDnD/pYfYWK
         mfLdufmGvCa3iZTNGhmabdb4vYp73iH5CSiZSAzdp8qZ3d4ecRqEWJdgIfKwiTQNpfFB
         nJVw==
X-Gm-Message-State: AAQBX9f6XLNpIKOXu8x+lhFIaqHyoFnRv4LaFdN0agHKowxMAjXzaXxu
        YFAQp9TvCHF50R6fWEE5M6vgXHO5bmI=
X-Google-Smtp-Source: AKy350btSAgJtnnEe7VmMJ1nOKb8OT6YTx/yfjX3A3kRuOYjq7vzXkehc72EawYLRjMrDlnQlV6a0/hl1+0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b03:0:b0:50b:dfd4:b56f with SMTP id
 3-20020a630b03000000b0050bdfd4b56fmr647098pgl.5.1681310313640; Wed, 12 Apr
 2023 07:38:33 -0700 (PDT)
Date:   Wed, 12 Apr 2023 07:38:32 -0700
In-Reply-To: <5d537415da25ac654b332db64b4018dca0bae6a7.camel@intel.com>
Mime-Version: 1.0
References: <20230405234556.696927-1-seanjc@google.com> <20230405234556.696927-3-seanjc@google.com>
 <03504796e42badbb39d34b9e99c62ac4c2bb9b6f.camel@intel.com>
 <ZC8IsP5ehaJXQOnu@google.com> <5d537415da25ac654b332db64b4018dca0bae6a7.camel@intel.com>
Message-ID: <ZDbCaEUboTrvtwda@google.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Inject #GP, not #UD, if SGX2 ENCLS leafs
 are unsupported
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023, Kai Huang wrote:
> On Thu, 2023-04-06 at 11:00 -0700, Sean Christopherson wrote:
> > On Thu, Apr 06, 2023, Huang, Kai wrote:
> > > On Wed, 2023-04-05 at 16:45 -0700, Sean Christopherson wrote:
> > > > Per Intel's SDM, unsupported ENCLS leafs result in a #GP, not a #UD.
> > > > SGX1 is a special snowflake as the SGX1 flag is used by the CPU as a
> > > > "soft" disable, e.g. if software disables machine check reporting, i.e.
> > > > having SGX but not SGX1 is effectively "SGX completely unsupported" and
> > > > and thus #UDs.
> > > 
> > > If I recall correctly, this is an erratum which can clear SGX1 in CPUID while
> > > the SGX flag is still in CPUID?
> > 
> > Nope, not an erratum, architectural behavior.
> 
> I found the relevant section in SDM:
> 
> All supported IA32_MCi_CTL bits for all the machine check banks must be set
> for Intel SGX to be available (CPUID.SGX_Leaf.0:EAX[SGX1] == 1). Any act of
> clearing bits from '1 to '0 in any of the IA32_MCi_CTL register may disable
> Intel SGX (set CPUID.SGX_Leaf.0:EAX[SGX1] to 0) until the next reset.
> 
> Looking at the code, it seems currently KVM won't clear SGX1 bit in CPUID when
> guest disables IA32_MCi_CTL (writing 0).  Should we do that?

No, the behavior isn't strictly required: clearing bits *may* disable Intel SGX.
And there is zero benefit to the guest, the behavior exists in bare metal purely
to allow the CPU to provide security guarantees.  On the flip side, emulating the
disabling of SGX without causing problems, e.g. when userspace sets MSRs, would be
quite tricky.
