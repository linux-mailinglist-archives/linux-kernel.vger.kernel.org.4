Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80A5BB52C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIQBFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQBFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:05:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35597A3D06
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:05:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so1287534plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ms7nUAHZlOrFk0AT6URL26jPlCSp0+EaZtlB5XtXTac=;
        b=MdPgXvkJHjv61QnOF0rlU2IGMQrERLFIYrhARKY87N6z3503c1B/CnL4gzoDJIy3gm
         Jp+3rGZles/4JlQqLWf95s8astDt9vgOWmtcLw7bJbrUxuRPjCf1vWwwGKHfhxBtQdFg
         Gamv9jPOQlsFt8QFu96OGdhFPFwwpE97UeZpl4uzDQdKci7HXhcNLoY5EJYgZMj4MPHf
         8hS4YcTPB3C+ajYgM53qRKyJYM9a7H+wky3q4em1MN1pK6CEX+BIGsGTGOjSc/vCtOYI
         Z9ofnoGy3zA4mvMGobLjtiO/O3bdaaKEpIfAeYVuZdKZCU6Fn+YKOOOp3zZODs4J5VLf
         yVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ms7nUAHZlOrFk0AT6URL26jPlCSp0+EaZtlB5XtXTac=;
        b=vnMmRi5ba+TnxItDG2no1z4ziC8ZgIBXNCxei0UNZwc6w3fKBRadS3nAfXVkx/ZDqn
         HbpV1en00EP7xsglHitneitlt5SOLxWsEszfEmV0AHBbmd3ow7SvdQ5Rpi95g7bufUyC
         tOpss4R9JVcC/rSv4h5kwFdMXnoklTxfd6nNPB+uqJw4TZd68K1vX9KHCGmTu/Z5KU+l
         /Rj6qPdXM9h4ZSFZenVbUAHGx1X1sUFMV8PbnYK7ERcFr723YxNU69TeLPC9/3eI8jvD
         M1K/SAjmKrn6nR4sOJT4d9FGoX3elXNXwfmDibnHllcr2L1Vn3BoQBelcfIJLW1SLVZJ
         nSVw==
X-Gm-Message-State: ACrzQf2jWPHO35a4LhphTK9HBXrp79IY0/uaSFV8aQJntccvZ83SNwWN
        wLtjIF4z5uEar/Ewhvn09Zt+Kw==
X-Google-Smtp-Source: AMsMyM6OR2py8Li2mImtpqmauxL1OntNskkntg1zia7heScQCSXzmm8qZyu4Kr5Q+gXDXwAIVCkWPg==
X-Received: by 2002:a17:903:1c1:b0:178:1c92:e35 with SMTP id e1-20020a17090301c100b001781c920e35mr2326957plh.151.1663376743592;
        Fri, 16 Sep 2022 18:05:43 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903404a00b00172d9f6e22bsm15289975pla.15.2022.09.16.18.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:05:42 -0700 (PDT)
Date:   Sat, 17 Sep 2022 01:05:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/33] KVM: VMX: Support updated eVMCSv1 revision +
 use vmcs_config for L1 VMX MSRs
Message-ID: <YyUdYziyOfMGxf17@google.com>
References: <20220830133737.1539624-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830133737.1539624-1-vkuznets@redhat.com>
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

On Tue, Aug 30, 2022, Vitaly Kuznetsov wrote:
> Changes since "[RFC PATCH v6 00/36] KVM: x86: eVMCS rework":
> - Drop the most controversial TSC_SCALING enablement for Hyper-V on KVM:
>   - "KVM: nVMX: Enforce unsupported eVMCS in VMX MSRs for host accesses" patch dropped.
>   - "KVM: nVMX: Support TSC scaling with enlightened VMCS" patch dropped.
>   - "KVM: selftests: Enable TSC scaling in evmcs selftest" patch dropped.

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".

Note, the commit IDs are not guaranteed to be stable, and in fact they are guaranteed
to not be stable right now as I need to do some surgery.
