Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F06F6221
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjECXiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjECXiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:38:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF69001
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:38:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559d36a91a9so60045067b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683157084; x=1685749084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33bXKWTsrMeKsukezlTXuHQlkcPPhfXNP6e5V4bHmvI=;
        b=qM/uMsZFWYbuK2lDHRz2izJTVAAKO/SxvWHJKel6p4daomUiSzq02htji3eIEjBAKJ
         f+jD0yTDRdntw5HVKm6VgnyHcYSe2oToTzKnAgLIQu4CXKloTapegHMYuFkKuvAUs4OG
         VVuf5jsoozKGudFCoGGRNv/nvjnjDtE5woFDkQyyFOKNOMdXG2CuPmUVoCe8kRtLe8d5
         fdMA7kSCGBN1O/raWixjjoDUlblzI6XBtU8+3dy56AuVhEsWsumqQn8oybQmrNbNUmMC
         vbKhx/P65OOUp2nCUiFnxTuMVhJrvcditCJxHk2fFxRAtD2xMDI3Yz9IANGbDTAkjR2l
         h2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157084; x=1685749084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33bXKWTsrMeKsukezlTXuHQlkcPPhfXNP6e5V4bHmvI=;
        b=TQ273V4y5Db/vHPsVWJfo2t8yiH6weTfE2FAwLq0cnr6kQrgRdgBj4UUa3lNq6wQQa
         0HXisZRs2BTUxx+//8UFGYuYV6epE1/4yBupU2XVQfD7mOFmp0lB482RoqsCAZYyq2cS
         p09Rm0ETmpqIrQrjdVVtggvfdZZD/kt94DzYsC9iJYZYTCDO1u5VsjGBSrexZ10aakv3
         /7bpNTKySCDe2AwUh0cspMajdlklz8hjRXFMuOMMB6gR7FuNXQAEwtsZrZwLFeBTLsgI
         hXcVXj4ENcYMnOUOlIgd3YKFWzjYq4y/fpad/NckAFAhn6JGjS+72Hd+uOaJp6+8U+01
         g86Q==
X-Gm-Message-State: AC+VfDwoBiIeegR2aN4eCLgRoQl59VpT1vBbScTYq806e80iMIq0brWd
        WQkCAvNNsCO7Q8l+x4EW5DXRHP8RRiA=
X-Google-Smtp-Source: ACHHUZ7K4eu0EedAW9QXpxUN8SonlCYJpd+9BpnXcTcToLufihzeQkk3V1/4v85cRolNIFTlYkLbxTeldnE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:440f:0:b0:552:b607:634b with SMTP id
 r15-20020a81440f000000b00552b607634bmr172700ywa.4.1683157084710; Wed, 03 May
 2023 16:38:04 -0700 (PDT)
Date:   Wed, 3 May 2023 16:38:02 -0700
In-Reply-To: <47e0d0cd1452383646a2cc9972f765b469fc51a6.camel@intel.com>
Mime-Version: 1.0
References: <20230503182852.3431281-1-seanjc@google.com> <20230503182852.3431281-5-seanjc@google.com>
 <47e0d0cd1452383646a2cc9972f765b469fc51a6.camel@intel.com>
Message-ID: <ZFLwWtDTaiyxdjMV@google.com>
Subject: Re: [PATCH 4/5] KVM: x86: WARN if writes to PAT MSR are handled by
 common KVM code
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "guoke@uniontech.com" <guoke@uniontech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "haiwenyao@uniontech.com" <haiwenyao@uniontech.com>
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

On Wed, May 03, 2023, Kai Huang wrote:
> On Wed, 2023-05-03 at 11:28 -0700, Sean Christopherson wrote:
> > WARN and continue if a write to the PAT MSR reaches kvm_set_msr_common()
> > now that both VMX and SVM handle PAT writes entirely on their own.  Keep
> > the case statement with a WARN instead of dropping it entirely to document
> > why KVM's handling of reads and writes isn't symmetrical (reads are still
> > handled by kvm_get_msr_common().
> 
> Why not just merge this patch with the next one?

Hmm, good question.  IIRC, I originally had the last patch delete the case
statement and so wanted a bisection point, but I agree that having this as a
standalone patch is silly.  I'll squash it with patch 5 in v2.

Thanks!
