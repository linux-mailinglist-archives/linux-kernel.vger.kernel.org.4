Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA596DA6A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDGAlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjDGAl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:41:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD33083D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:41:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c1e4b7e63so24291487b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 17:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680828088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnSSgZKRdvbPIrtsfog7qn4pLOiwfaQdSDWiuSpARLE=;
        b=o2OHW9/K0xbtzyHr9GqnQWipotyYMmLhxrUEZDAdlLhV7l3Rv8xdaX0WCUK4HYc7aV
         +DE9UFMpwbzj+oOOunqtG6WzIgGHk+rc1VFUdEWV9BxQEJMvraNlrjTkNt1VQs1ss7uk
         hny49017FAxeDd/2gezMIalb641PAZKXsnwMY4huIocYbnvUf+UqMmCwQmvDGvi4xQcW
         LJSM8Wdj5LhfvOtIeg+gW+2CL4Hnu2BVTL4EKY06qRgXxsdUAd5hNwZvHNz3AH4nLz/Y
         BEMqj3Asxf+KzhhFzgNduVDmqN7XOTj6uAnnZqn5/IUVHOrx4E+PT5MpENFn/zh9Uz7+
         heNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680828088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnSSgZKRdvbPIrtsfog7qn4pLOiwfaQdSDWiuSpARLE=;
        b=4LiHqLiNN836O2YoGOHMGi5hCZhVIPh+BP7QlKnpdlMeWNAeXqtL5Xg6p7ifzT1Hrv
         4X71fN1XSY7rXdf6yqrGASh32ae8RgfUkPi/TC+ZywjI+hjIawR5kO/2XdHx911nANgP
         SDZLnQIj7FhUqlYqzKbuX0CeaYVeTR8WbpJwkDJ6gpbuF6NegxnD9MPTXNvZ7/5aqTte
         ekjAELB1yWG7oQ9dl31Ubdhx2urq7wbGYl3dcVibvYY2rSYZXm3BXbt+IYjYXrq+skeE
         HRm4yXM7D7OfX3ApPMVZ3chc+fNriGyKXQMhBHNhBb/l9qA8nIDD4UBVHmWNX1Srkrzo
         7Ehw==
X-Gm-Message-State: AAQBX9cHCLxTiWMiEjb9csF2ABS3inm2bWunK3Qn9/cTFJkuz5nkdl1h
        8JUUk74JYBzTz060Ayq8wCmg+26KU/8=
X-Google-Smtp-Source: AKy350Zz5FKwxmfQDD5yYfqSgli2jvdRgU7L7OSoM6fF0+T1VLwPUZWhcVT+ru9jOJO6n6lt8LS/Aehavas=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1588:b0:b8c:ba33:462b with SMTP id
 k8-20020a056902158800b00b8cba33462bmr144970ybu.2.1680828088140; Thu, 06 Apr
 2023 17:41:28 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:41:26 -0700
In-Reply-To: <20230214050757.9623-11-likexu@tencent.com>
Mime-Version: 1.0
References: <20230214050757.9623-1-likexu@tencent.com> <20230214050757.9623-11-likexu@tencent.com>
Message-ID: <ZC9mtqxmqKAoelNO@google.com>
Subject: Re: [PATCH v4 10/12] KVM: x86/cpuid: Add X86_FEATURE_PERFMON_V2 as a
 scattered flag
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

This shortlog is flat out wrong.  This patch does not add X86_FEATURE_PERFMON_V2,
it adds a KVM-only leaf to redirect X86_FEATURE_PERFMON_V2 to its architectural
location when KVM queries the leaf, e.g. via guest_cpuid_has().

On Tue, Feb 14, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Considering that the core kernel may also want to know this flag, to avoid

Please write changelogs so that they do not depend on the shortlog for context.
I know the tip maintainers in particular like to make the changelog a continuation
of the shortlog, but I find it really annoying, especially when reviewing in mutt,
e.g. as I'm typing this, I don't even have the shortlog visible.

In the vast majority of cases, being more explicit rarely adds more than a few
chars, e.g. you'll save more by reducing the fluff in this changelog.

> confusion this needs to be a scattered flag rather than a pure KVM flag so
> that KVM can redirect it to the hardware-defined bit position, which is the
> role of __feature_translate() and KVM_X86_FEATURE_PERFMON_V2.

Like the shortlog, the changelog is best misleading, X86_FEATURE_PERFMON_V2 is
already a scattered flag.

  Define a KVM-only leaf for AMD's PerfMonV2 feature flag to redirect the
  kernel's scattered version to its architectural location, e.g. so that
  KVM can query guest support via guest_cpuid_has().
