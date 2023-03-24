Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949156C8956
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCXXge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCXXgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:36:33 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246AAEC59
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:36:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g13-20020a63f40d000000b005015be7b9faso1131164pgi.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679700987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6O8GrBusQdE9gwItMohterpiO/FhfFnJcQwSPMDplo=;
        b=efyThk8OD1Ui+mGN1aq0DwY2trMnEAqWd8Fvtdi7z9pg+Wwza3RFewsJ8t5V9fhDwc
         scgNK2SS6ohr5SyUtKnYwwJg4wdOvuXPd838/FFGLFiOVpSRy4xnm+IQOS8IywllzG0i
         sOm6VSRFGpJdF/OLBo15iHVmF9wjV1WYbI9WJ6wYCC0J8kCvTXR0zX7cN8AdPl6rBVqD
         IEzw/x5AbI+9pAYCIe36dkAqMRFoAZftaKpwAKFG63bQaIUQlvcywfW/BrzgRw9/2A16
         XKndWu6chOus4AWNjLy/bhpM4DUhsOCamqehvgilxGIuh5EbzgpUlzNe1ervnw4dpqef
         F9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6O8GrBusQdE9gwItMohterpiO/FhfFnJcQwSPMDplo=;
        b=LSXDmi9gCoM+9+2kRKsJoDOVlvEFO1tHRfxlihyQJqXeFqv/lozD5xYSvJRDWbFNxh
         SbV6mwpr83OPg6IegqRp9+HADLAvlHf6EuLyjP06AL2xfi/SCyGQ+k44weqd/BtkcwvX
         Wv1veaaqTEq5lv/9GqwNWqa4offh3R8lD86/o8TNpCbfkoh+x6/p3b87n2ytUOVWKtBy
         LsHcDhQz5xm4+yJbBrQ0ztZ1YEap+O0bl5gdnyr+w+vh9OTOGqr8AsbiiIxOKPKuQa6C
         PpiYgdSbiKp/HNpJPjVzclN9X2+K4b4eKJoc68xOTTGFMqKuqgx4RRb+NJH2rA5ljShI
         vqag==
X-Gm-Message-State: AAQBX9dnJzTCtMLQIJl8cd1udNK1MeYdXmmd+Y5EjRMmyeV9lCNNBuz7
        fYLOAeVy4lHhCekZi8fTyK/zVLbh7pY=
X-Google-Smtp-Source: AKy350a3TLlZSiuQgZzZiPiHRLvf0U5ChFmA1NUKVGv2bIFiTDKTUWiwuV+omcjmN/u+zQrsXSpNRAG644o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:795:0:b0:50f:76fb:84a2 with SMTP id
 143-20020a630795000000b0050f76fb84a2mr1077499pgh.5.1679700987585; Fri, 24 Mar
 2023 16:36:27 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:35:47 -0700
In-Reply-To: <20221213080236.3969-1-kunyu@nfschina.com>
Mime-Version: 1.0
References: <20221213080236.3969-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167961296610.2556158.130128430249357317.b4-ty@google.com>
Subject: Re: [PATCH] kvm: kvm_main: Remove unnecessary (void*) conversions
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        Li kunyu <kunyu@nfschina.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 16:02:36 +0800, Li kunyu wrote:
> void * pointer assignment does not require a forced replacement.
> 
> 

Applied to kvm-x86 generic, thanks!

[1/1] kvm: kvm_main: Remove unnecessary (void*) conversions
      https://github.com/kvm-x86/linux/commit/14aa40a1d05e

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
