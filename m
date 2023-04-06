Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C986DA65F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDFX5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDFX5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:57:17 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449F6EAB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:57:16 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id dw13-20020a17090b094d00b00244a26ca437so888160pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680825436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWtfKCd42gFRt+SU/spjs5sWyu1Aw9AdfKUOZ3ovRrU=;
        b=Zn1rzlV1v+JHO/foeERtaSTLGEHjqFpbzngg2+iJlguDiyf6MvCfJzUDQC/r8yPy38
         6gxmuka9L/Cd73aQ64l0jbEHqqxTy2/oo8RrtuVDzzuL7CD9RcpWCDQ8fjKE9Ba2Rbk8
         A+OWuepJjNRfWWxHkaCgZgVXPf3zwV/KVbojul7w3cVpRnTIcgo8vOLGGf6PypoyR+SU
         m0RjiaIitcwjOVLEHf05RoDJgZdnc7a5IdrXDIK7z1MKhjSCxFal4i76zzmQi6AwAWAm
         oh+Z0Ja40/4v0MIWKWBDSPqfNWQ33DRyehx9ZbH7TszFSulmZP5iSP4Q4tWJMZxI3wVp
         8B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWtfKCd42gFRt+SU/spjs5sWyu1Aw9AdfKUOZ3ovRrU=;
        b=enFzuZEwvCXjR6fXLCTzEVGcbMCX/gfWv/WYcJuyhUzRMHneTKQNReotT/8p9yLQ7l
         my86cUhbM3CYUHyarPRpj2IIu+pXx4bdtaf39gb8JzQcHM0f/tNHv4X3heNxqCA8tskU
         Mj/cveIbq0jpvFSZhNFgoZnXxbxfOUL5XTYCdrEppF6x1vxocRr+/JkkLzemCzkR0zzm
         yLDVfpS2u19Qq6lZJOCo8ip3m+V/hXOI0zlway8a041j4Bm+f8AXMMYT0V/bNZlnBgeb
         3/rVRMKs6rr5mktTJ/iCEmd1HaEBYSDDdQdTMe8AdiCoxeuAepCjJmTz2xldQAMsbA85
         qjlA==
X-Gm-Message-State: AAQBX9cgJ752ZzoXVGHId7DXOh8hAx9T77r/iB4JjSHIPiSi4op9Amqd
        cg3aAJ0jven3JFLgNlZ1ebRLtsH0ryA=
X-Google-Smtp-Source: AKy350YjTQ8Kz0k/3ZQBItKho5r/lj7iwCgCaRWjhu+k2V7uMSiaVuBAMtKx280D5XjV2C4aBDUDRS8ZjWQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ef96:b0:1a1:fd0d:1bb with SMTP id
 iz22-20020a170902ef9600b001a1fd0d01bbmr298172plb.13.1680825436246; Thu, 06
 Apr 2023 16:57:16 -0700 (PDT)
Date:   Thu, 6 Apr 2023 16:57:14 -0700
In-Reply-To: <20230214050757.9623-7-likexu@tencent.com>
Mime-Version: 1.0
References: <20230214050757.9623-1-likexu@tencent.com> <20230214050757.9623-7-likexu@tencent.com>
Message-ID: <ZC9cWnimsXNs8xqv@google.com>
Subject: Re: [PATCH v4 06/12] KVM: x86/pmu: Make part of the Intel v2 PMU MSRs
 handling x86 generic
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 14, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The AMD PerfMonV2 defines three registers similar to part of the Intel

Drop the "The", i.e. just "AMD PerfMonV2 defines ..."

> v2 PMU registers, including the GLOBAL_CTRL, GLOBAL_STATUS and
> GLOBAL_OVF_CTRL MSRs. For better code reuse, this specific part of
> the handling can be extracted to make it generic for X86 as a straight
> code movement.

State what the patch actually does, not what it could do, or what can be done.

> Specifically, move the kvm_pmu_set/get_msr() hanlders of GLOBAL_STATUS,

s/hanlders/handlers

> GLOBAL_CTRL, GLOBAL_OVF_CTRL defined by intel to generic pmu.c and

Intel

> remove the callback function .pmc_is_globally_enabled, which is very
> helpful to introduce the AMD PerfMonV2 code later.
> 
> The new non-prefix pmc_is_globally_enabled() works well as legacy AMD

What prefix?  It was pmc_is_globally_enabled() before and it's pmc_is_globally_enabled()
now?
