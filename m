Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07946E28C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjDNQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDNQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:56:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3CC49F0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:55:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m21-20020a17090ab79500b002401201f1f9so8602250pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681491355; x=1684083355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CHSlTSd3N8g44bYo+dzvuKpfboW/yvp0BrTP/tMkTE=;
        b=dV95e0sZyjnS6hOCoSmYE4HHtgh8oBiwz76SZWvJGB8ksgh3z/Hk42+hzRlELv4pY3
         eOYGg/2rRkvWAPOBAcecfJrf0UpuLLeHKlK2dG3YtTFBirK3mAxPJnIn2Qn0UBKavn8U
         vIIBNyvRHXvVJqekReX1XbAIeomHB6DC+vjJ6KG8A+AH2412vT+pkwBBmFhNQ/lRlbCr
         rt4ZtujWcy+yJtbQibYk+YjWA7QDr8ndcPmk1XBkHHurmUAb01lF3B5lOKRYNby9cK7j
         BLjrHltpt775eTCGO9Ku+YkAGUvtvJAKuuHp6MOHWqf62LY/mk4QqYhO3bVLasDciat+
         RGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491355; x=1684083355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CHSlTSd3N8g44bYo+dzvuKpfboW/yvp0BrTP/tMkTE=;
        b=B1EPDR2Lb9mtVRPkhl4YRVbsT7IZ9p+ubE+n6HF9zx4BrELKjjS0tretJbhHhoLdT3
         zNvGMdKMWo9Wg9gp1o+ZspBkAv94DSpA7KrQdD1wxPhV3dAmOwS/MIQbsPUtGsSUAetZ
         W9Pqtk8y8Um1PjRXNBy/63vjyzDhor7DDY070YOBkgkHRfZC17Cb90CmIif+bng47CDk
         eGr5RKbKq+aA7kr4RrtgLiYrlg2AmSCbv31SX0aCwM7qP/Oz+dFqseYc1HJ8Zw2a1Irl
         K8DenVHAkVoal609mme+R6SQa0CVJxXwnrUV1CW38+JeCU2Rc9mFiDZgUREO2Q2Pvfqz
         ZXaA==
X-Gm-Message-State: AAQBX9f+zDVPCKlATagYXHOv94cGZfTNZoUZm3OVVVuiw7SyvXe2gljr
        fbA30qsxQf2wtrFCadtEx4wn9aVc3xI=
X-Google-Smtp-Source: AKy350adQowQwr3yxq3+IS2GGOLLapJUyeAl/BrmgjtSTRz1FWIGg26Fs6Ub5ZHTWEJYNBqfqo6Z0of1QQk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:a619:0:b0:51b:3c11:fb17 with SMTP id
 t25-20020a63a619000000b0051b3c11fb17mr984161pge.12.1681491354873; Fri, 14 Apr
 2023 09:55:54 -0700 (PDT)
Date:   Fri, 14 Apr 2023 09:55:53 -0700
In-Reply-To: <7332d846-fada-eb5c-6068-18ff267bd37f@linux.microsoft.com>
Mime-Version: 1.0
References: <20230413231251.1481410-1-seanjc@google.com> <7332d846-fada-eb5c-6068-18ff267bd37f@linux.microsoft.com>
Message-ID: <ZDmFmfPWmGxX855M@google.com>
Subject: Re: [PATCH] KVM: x86: Preserve TDP MMU roots until they are
 explicitly invalidated
From:   Sean Christopherson <seanjc@google.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
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

On Fri, Apr 14, 2023, Jeremi Piotrowski wrote:
> On 4/14/2023 1:12 AM, Sean Christopherson wrote:
> > Preserve TDP MMU roots until they are explicitly invalidated by gifting
> > the TDP MMU itself a reference to a root when it is allocated.  Keeping a
> > reference in the TDP MMU fixes a flaw where the TDP MMU exhibits terrible
> > performance, and can potentially even soft-hang a vCPU, if a vCPU
> > frequently unloads its roots, e.g. when KVM is emulating SMI+RSM.

...

> Thank you, I just tested this and it works wonderfully! Is this still on time for 6.3?

This is too risky for 6.3, but I am comfortable applying it for 6.4.

> In case you need it:
> 
> Tested-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> 
> I'd also like to get this backported all the way back to 5.15 because the issue is
> already present there. I tried it myself, but this was before async zap and i'm
> doing something wrong with refcounts:

For 5.15, I think our best bet is to just disable the TDP MMU by default.  There
have been a _lot_ of relevant changes since 5.15, I am skeptical that this patch
can be backported to 5.15 without pulling in a big pile of changes from between
5.15 and 6.1 or so.

I added you to a related thread[*] about TDP MMU backports for 5.15, let's continue
the 5.15 discussion there.

Thanks!


[*] https://lore.kernel.org/all/ZDmEGM+CgYpvDLh6@google.com
