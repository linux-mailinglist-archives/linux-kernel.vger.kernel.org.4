Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4C06C5B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCWAu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCWAu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:50:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9672A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:50:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m9-20020a17090a7f8900b0023769205928so174721pjl.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679532651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9TeeVKkErrMDSSNpFE3ne7ONBcnLKyWNyzaJuM2w0=;
        b=CvV09UaLS1MaIVXKzJLiAeUHeM59IKQp5eEgx+Zc2m2g+vLpSRhWJXdCziRLX6+ZwM
         f/GIOGBRPWGtZ6O6A1uuItZnk7pOLSjlJyt7hVvKCxqLYJxSNp9J55u15M9QHzviDI36
         iIQ8cRL/tMrksrliEsU+Jne7qj90aWMuA+Ux9CAq0o5cu2NYOsj80exFpbJaQyb6wqNZ
         LH7cXBrF40I/aw8qStOLgk9kPScVHDOa3uFto2fdJiIwrFPrupAP2Q/PIve530PzV94U
         5gaShGzvfmKjmwvrn7CxX6n74xh8MlqGm1FsnFAttfMzUIZuy6Eq5GaaP8B4GPNI20zg
         oDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679532651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg9TeeVKkErrMDSSNpFE3ne7ONBcnLKyWNyzaJuM2w0=;
        b=uaBvryuEK6ctGQyxy3VYWRwxO0aXJl6v4qagss93dXnqpWEXoDHFSImyEYpzvvFw1v
         QMHk6R/sDg1VMam/rUdSVC/5SRvfHpV0Zv3bXLYZPbFBodCxGYAQU/RowRTNFU0CBgr8
         J1dPAV90LpkeFRxDjFC9/dH29I0EyXhUusRGTl8hxpd/5qz18Je8GLgBEjClFYyIVy8K
         aHYMO+nKUKkCm2cuuvu5jrqLP5NkDvnD5mSsL02WO84Rc1paL+6sszpLPIFnZAKQRS0K
         HKLTpXthAe+hLC6f5nJgv/rcataS3J8/c943vLAxAcFxSLGR309onge9p8yQn90Bk4Fc
         RyPg==
X-Gm-Message-State: AO0yUKX7SuYHGg90ElA8m8LSWTPdo6J9TAYjdLqZqKt2G0nE1Se3nj0p
        OguhlPb1ju9sjYXnoaVILxd/ZJu71BQ=
X-Google-Smtp-Source: AK7set8mOU8bL6IapPjdKA2xGh3uPZvtLoYb4cohsTVOk1EmmY66y+kP6LMHgQpnrOii4CAlSATC7MGiuGo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:63d8:0:b0:502:e4df:5f3f with SMTP id
 n24-20020a6563d8000000b00502e4df5f3fmr1356957pgv.6.1679532651750; Wed, 22 Mar
 2023 17:50:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:50:50 -0700
In-Reply-To: <20230227084016.3368-12-santosh.shukla@amd.com>
Mime-Version: 1.0
References: <20230227084016.3368-1-santosh.shukla@amd.com> <20230227084016.3368-12-santosh.shukla@amd.com>
Message-ID: <ZBuialNlrCbDmJaX@google.com>
Subject: Re: [PATCHv4 11/11] KVM: nSVM: implement support for nested VNMI
From:   Sean Christopherson <seanjc@google.com>
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        mail@maciej.szmigiero.name, mlevitsk@redhat.com,
        thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023, Santosh Shukla wrote:
> Allows L1 to use vNMI to accelerate its injection of NMI
> to L2 by passing through vNMI int_ctl bits from vmcb12
> to/from vmcb02.
> 
> In case of L1 and L2 both using VNMI- Copy VNMI bits from vmcb12 to
> vmcb02 during entry and vice-versa during exit.
> And in case of L1 uses VNMI and L2 doesn't- Copy VNMI bits from vmcb01 to
> vmcb02 during entry and vice-versa during exit.

This changelog is again stale, as it does not match the code.  Or maybe it never
matched the code.  The code looks correct though.

    KVM: nSVM: Implement support for nested VNMI
    
    Allow L1 to use vNMI to accelerate its injection of NMI to L2 by
    propagating vNMI int_ctl bits from/to vmcb12 to/from vmcb02.
    
    To handle both the case where vNMI is enabled for L1 and L2, and where
    vNMI is enabled for L1 but _not_ L2, move pending L1 vNMIs to nmi_pending
    on nested VM-Entry and raise KVM_REQ_EVENT, i.e. rely on existing code to
    route the NMI to the correct domain.
    
    On nested VM-Exit, reverse the process and set/clear V_NMI_PENDING for L1
    based one whether nmi_pending is zero or non-zero.  There is no need to
    consider vmcb02 in this case, as V_NMI_PENDING can be set in vmcb02 if
    vNMI is disabled for L2, and if vNMI is enabled for L2, then L1 and L2
    have different NMI contexts.
