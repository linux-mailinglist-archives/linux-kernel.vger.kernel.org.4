Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847DD743E72
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjF3PQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjF3PQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:16:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D54690
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:15:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56cf9a86277so18219527b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688138126; x=1690730126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7oJzLLPGW/Cx9f/CDqtoSXPOSWREn06ZdPTZhJC3Go=;
        b=AfsXkZXlZJPvva1bmvipN9xiFdW0LWN5Ibj64QQvTBdzXdIrAXkFx0kUhmllcfNyjr
         pAlOJ7sJPNzfIfdXxHCn+R1qQiqSw5cQGKtoSE6I6+1q8qU/HMbjfixp7a/mjyvMyoSN
         b02kSEaYdL50YI1V7wz8SUtGgKFRBMVHxhqhbre0ua4nYdt2U9kAYDTJdJqzJlwBBfYb
         Wkx8i9WsPC9wi3bibCZvTbX2brPCZKCZVckU/uqISG3uTscgkQcXTeIN9YeVJyoaCl7A
         zKj67sA93xoBdrCn5C5jXdJufo2VXCIJY2kHP7iLx/xm7YwAjcj3Z6QR/wXS39Pna9ie
         b2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138126; x=1690730126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7oJzLLPGW/Cx9f/CDqtoSXPOSWREn06ZdPTZhJC3Go=;
        b=D5LMMfZtdZUtP9iwEAhMLndpxnP5dG0ppO75/WtWEGAXxPRj2V57XqfLd1VerLCLXR
         3cgE1v5X69akDS+PtlQluUgKTpFBnHWZax9RLVNqqvCEMlWfrsVOqUemTnXKiuiOdbL7
         g0ZQ2c4CDD8owZAMiVAh4FWtHmIvpPnbnJ/Xh2oTXprOSx0pIXtOI4kbOa7vh4CQzBrd
         XzQvHKZrwP7+YY6YQtIXlyKIGxuzH0PqxXQr+CV/mwPihz3NCKBZOp9+RsSoSOzaYxjm
         V/CD3p7YB9VXUjDVF5GHuSFH0KQRu4fqwXjGX6tKqGYH3i/Vn4JdyfV6o5GB/BhKbEbb
         x8KQ==
X-Gm-Message-State: ABy/qLZubI9JHqEDmgRVa1dg8tfzzflxRI3g4vIGEvoFKEDo3Vnce6VV
        G/66hq5kHoe0ky3yZ1KmDiNOcZw1NCo=
X-Google-Smtp-Source: APBJJlHTHksxFR2/TcaLyjYYDz1o/aFwnGkFGVCI/XRMxF6grQX75vNH1cRAuBQ+JkPyf3jb4+BDxo/E2y0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ac0b:0:b0:c3f:b53e:b2c2 with SMTP id
 w11-20020a25ac0b000000b00c3fb53eb2c2mr22548ybi.0.1688138125852; Fri, 30 Jun
 2023 08:15:25 -0700 (PDT)
Date:   Fri, 30 Jun 2023 08:15:24 -0700
In-Reply-To: <CO1PR11MB5107FBC68DBA6877E390A633912AA@CO1PR11MB5107.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230511040857.6094-11-weijiang.yang@intel.com>
 <ZH73kDx6VCaBFiyh@chao-email> <21568052-eb0f-a8d6-5225-3b422e9470e9@intel.com>
 <ZIulniryqlj0hLnt@google.com> <dfdf6d93-a68c-bb07-e59e-8d888dd6ebb6@intel.com>
 <ZIywqx6xTAMFyDPT@google.com> <0a98683f-3e60-1f1b-55df-f2a781929fdf@intel.com>
 <ZJ6uKZToMPfwoXW6@chao-email> <8dec8b09-2568-a664-e51d-e6ff9f49e7de@intel.com>
 <CO1PR11MB5107FBC68DBA6877E390A633912AA@CO1PR11MB5107.namprd11.prod.outlook.com>
Message-ID: <ZJ7xjE0qMjpYIiB/@google.com>
Subject: Re: [PATCH v3 10/21] KVM:x86: Add #CP support in guest exception classification
From:   Sean Christopherson <seanjc@google.com>
To:     Gil Neiger <gil.neiger@intel.com>
Cc:     Weijiang Yang <weijiang.yang@intel.com>,
        Chao Gao <chao.gao@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>
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

On Fri, Jun 30, 2023, Gil Neiger wrote:
> Intel will not produce any CPU with CET that does not enumerate IA32_VMX_BASIC[56] as 1.
> 
> One can check that bit before injecting a #CP with error code, but it should
> not be necessary if CET is enumerated.
> 
> Of course, if the KVM may run as a guest of another VMM/hypervisor, it may be
> that the virtual CPU in which KVM operates may enumerate CET but clear the
> bit in IA32_VMX_BASIC.

Yeah, I think KVM should be paranoid and expose CET to the guest if and only if
IA32_VMX_BASIC[56] is 1.  That'll also help validate nested support, e.g. will
make it more obvious if userspace+KVM provides a  "bad" model to L1.
