Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5B6E9724
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjDTOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDTOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:32:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0485A3A8B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:32:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54fba72c1adso22970817b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682001137; x=1684593137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUOq6c0G5jqjvPVW9GFl6gJV//Ori6RU3kW+vvc3us=;
        b=sPIsPblMaqSS5oOmy6m8Fm+K8b7DBq1F0Z9mwCm0F0kJS9M5VWCzEjvQESI1yLYRwb
         gGtmWVaZ/4ZupaxdZURG9VmXx0AX+jA0ZikF0ChQ8b475ASbEKYjlj0VHrBRHQy2xxvb
         rOvxz1u2FrCgG6XoyLs+bHpZfi8fzvJ5UQiHuYpYQMPEPkLsUSXJuR1KoGDYki3I7RvW
         FDsOUnVnzi/WgrHRWZeDYOml8rWtTbVAkf8VjBezp1UHfQ4qSQFJkWrXNBWbDd1GFXLH
         l55Gu+YEzTFjcQolNT3lw9a29TWvtrinpmh/6ht37Ntyww3xbjB507TN7zVWZeUIbp1i
         IpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682001137; x=1684593137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUOq6c0G5jqjvPVW9GFl6gJV//Ori6RU3kW+vvc3us=;
        b=hH5RAeF7AodBryxoXzj3uM78Z2ShXgBly3nC2bBqEFjXzb/pTIycqdWCTYB+rJcrTf
         0dKE0/VqqlLtUDcYEaycvfhtJ6wOUgpBr3598eSiv4XIyOTe54W3MHqFaA0Q+javYW+4
         a8Ksm/1jAtF+5k4+4aaI6mNGVW4AijoQ52QF14RM+ZFh9lamp+XVzrGx9HSC5auAlyL7
         1ClC/kZrjv27RckON9GRRGp8zII2OI9nUUgdBrTxr3ccDb5Fq05+HretnhRmzz8jdLRi
         eNP2hevjnq8rl8asE2OgZqkcQcmfh8jfOq76fD+POQ8vFGXA7gXHhJ4/cj9kKFU69h1h
         DlaQ==
X-Gm-Message-State: AAQBX9f9U8fA38FyhmVkrM8pJ05KnF+dzfmF7y9XVu9CpgSi3kTykqwX
        AG7tz/2872FHIf+oOLoz0CR6Y8r8vB4=
X-Google-Smtp-Source: AKy350bwVF+ij/6vzk6Xo1YQlvq1IiNxEYNULh5XKnF+s57nZ8BzKbXXMFeaNKA4txq91Yz77KqQF+drZ/0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ec08:0:b0:54f:a60c:12eb with SMTP id
 q8-20020a0dec08000000b0054fa60c12ebmr765146ywn.1.1682001137266; Thu, 20 Apr
 2023 07:32:17 -0700 (PDT)
Date:   Thu, 20 Apr 2023 07:32:15 -0700
In-Reply-To: <6a0cde0a-e1a4-9119-75fd-12b7c921b5f2@amd.com>
Mime-Version: 1.0
References: <20230411125718.2297768-1-aik@amd.com> <6a0cde0a-e1a4-9119-75fd-12b7c921b5f2@amd.com>
Message-ID: <ZEFM735qNFOCGbnL@google.com>
Subject: Re: [PATCH kernel v5 0/6] KVM: SEV: Enable AMD SEV-ES DebugSwap
From:   Sean Christopherson <seanjc@google.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Borislav Petkov <bp@alien8.de>
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

On Thu, Apr 20, 2023, Alexey Kardashevskiy wrote:
> On 11/4/23 22:57, Alexey Kardashevskiy wrote:
> > This is to use another AMD SEV-ES hardware assisted register swap,
> > more detail in 5/6. In the process it's been suggested to fix other
> > things, here is the attempt, with the great help of amders.
> > 
> > The previous conversation is here:
> > https://lore.kernel.org/r/20230203051459.1354589-1-aik@amd.com
> > 
> > This is based on sha1
> > f91f9332d782 Ingo Molnar "Merge branch into tip/master: 'x86/tdx'".
> > 
> > Please comment. Thanks.
> 
> Ping?
> Or should I relax until the end of the nearest merge window (May 6th-ish)?
> :) Thanks,

Sorry, the answer is "relax".  I'm likely going to be offline for a few days in
early May, so it might be more like May 15th until you hear from me, but this is
on my todo list.
