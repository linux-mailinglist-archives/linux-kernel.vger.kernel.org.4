Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944586C86F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjCXUln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjCXUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:41:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FECF1E288
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:41:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544781e30easo29577147b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679690500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7c0elEDxGGtgZ98ipBv9YG9bKIImebaxGJ+PlUUC8zU=;
        b=mQ7hRAyFPVoiNHCCnDfThBXLCS64L7JF/OLnQv7tZjk2JaTturO9bNHKXpmrWQS9St
         0YKGbhmvzmtTNahzMngL7TJc7N1UFkvRccJ9YRCU21E+CMwgKiqZErYDzaxtZOoM/ISv
         5Dk3MRwB4SCrpgONU56QI0o8689QBjnxDlnBp/6dBMQMXaFBnuf7fvpLAcN5pek98WOp
         sQDwFL4K2d6G07ASWTtAILpG+Lp2PZR/B9SdmJ8UbWIUK9A5+O2Hjz5bLjYBFPBT5O5w
         5DtjxUicpxVAGsWos/+CU5RfKjBCuuq2IPM2XfagLBU5KnFhp4lrWRT9rxSZD1KtEvpI
         TCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c0elEDxGGtgZ98ipBv9YG9bKIImebaxGJ+PlUUC8zU=;
        b=KDziXr/7Ynl8wAeciFISMBfj+WYvcudEkbpks2OYZbWu1JjJSWDvtjDDY7HJoIeNdE
         qtFSoEUZMKSPIhzqu/GOb3OiIkx7P+zjz2N8k0TVhv4DQzfdcYUIqjplz4cCyAhQegx/
         fcqtVBB4t3+JyI2mRBavYL40b0T0PTplWFPTNyZG9JuxqS/C4NQeJBWd5xXfa71gRRxZ
         2RNCK4BB0yRP60mwn92R7IC5lvbkdu7fxLN4Zx9xDMcIDRXbj3uBnawwjZ53ERgrcujm
         Fuy9yQCaXjgDJRHf1y/SaUyyx64YX64Qcp8DjQzezCXzWCouKWXhfM0hwo0bmu51n5NH
         8Vjg==
X-Gm-Message-State: AAQBX9fXFZEMiVfSD5S8YhblEuPPT/gJguE9WjH/o++e7BkkjHFfUDcN
        bQ6V4phmRg/ETRpWpnlNStxUhJSrm2w=
X-Google-Smtp-Source: AKy350btV5WNqzErKtxiHAqBrc74aEG4o3U784IbaSpYUXuHaUKrnkflNxJZVCzDKHG61J0a7gJ//m/aT38=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cf81:0:b0:b76:ceb2:661d with SMTP id
 f123-20020a25cf81000000b00b76ceb2661dmr1699796ybg.7.1679690500564; Fri, 24
 Mar 2023 13:41:40 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:41:39 -0700
In-Reply-To: <20230221163655.920289-8-mizhang@google.com>
Mime-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-8-mizhang@google.com>
Message-ID: <ZB4LAzgNsbKdTESk@google.com>
Subject: Re: [PATCH v3 07/13] KVM: selftests: x86: Fix the checks to XFD_ERR
 using and operation
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>, g@google.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Chao Gao <chao.gao@intel.com>
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

On Tue, Feb 21, 2023, Mingwei Zhang wrote:
> Fix the checks to XFD_ERR using logical AND operation because XFD_ERR might
> contain more information in the future. According Intel SDM Vol 1. 13.14:

If that happens, then the future change is responsible for updating the check.
The test very clearly does a straight write of MSR_IA32_XFD.  If there are extra
bits set then something is broken.

	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
