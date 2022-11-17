Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F373262E402
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiKQSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiKQSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:21:58 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B6982204
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:21:57 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g12so4194270lfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYtd7mPOImeTRH2+SdJ0kreRW9/G7mawvUUHQmB1LR8=;
        b=rHy0fc86ZwETyVYLkCBZ45hriB6D0fggo4RlbYD94XmXIZXz2eTr+pSaP+rBBe+OxZ
         TVc8kem9+BrRvsQSnYJJyQoye8KJhs9ef1+tw0+UgZP2S2rVUYfB6w5UBjKT9q6zXw8j
         yQ3s/IhArSdlsMDyaZrxaCBoSkCRddQd3ilt84Vs2caGB86lXQ+m9bWLYawwDEl9zVYJ
         mUUCX67RjwEqM/KUY+MEUXeHPcZ7qGjUNObbIlMi07qIgerjiq9NlpfQ9cfoTIsQKw+4
         sn6IPFpPRSpBSMLSHw551Ntv3cnS4+GAxTdqjgCUiWxib9AM9GvwQLh3Y7VvQ9sCMy7E
         n/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYtd7mPOImeTRH2+SdJ0kreRW9/G7mawvUUHQmB1LR8=;
        b=dgfYHmcKdg3pTl+0002wYz21CkA1O7jWj+FHPn+R38+JFC57s/xcUiKbvch7HPHpn0
         fYb30IVXH2jKnCmWyyOIYebD9ATX0Q0VicvU2IYoZYo9fbBKSUYZLbdnVexSsXN0ycBk
         Y0Ng4PM2dK6ogWbBAgbtUE42O3bSRPxKg4CXaTXt9SVk/M49V8Kjdqo6eeECgbqJ7nbo
         ytiDZeCeCDVCtjXxHrPj3lsRKm4tuc1hBnwyTmYOL4co4LTbctgZyglnpuN8SuB4j9/c
         MIw2eN0cPdmUdbU2Nv0R0bxwiynJ2vJ2BjJyCS9re564vlAqrvgrxQyoLLw9GNmmK9L0
         OqNQ==
X-Gm-Message-State: ANoB5pnDnI3KLxtaDIHOFlmI+vPj52rRITaBqm7dD2JTHOiBC0lmWeDs
        8jQBMtWYMEtVFPRBqhhV68piy1PmrSkGWftIoI5agw==
X-Google-Smtp-Source: AA0mqf7nLeDNUOq5CA3gvJCOCZJkrRkT94SDjNvt2NC3jQ3f9QVmQMIpJ8emhQQaOgn6g/EqwkbH1Qo3q9NppVkoYfI=
X-Received: by 2002:a05:6512:2250:b0:4b1:df29:b9ee with SMTP id
 i16-20020a056512225000b004b1df29b9eemr891702lfu.160.1668709315763; Thu, 17
 Nov 2022 10:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20221115213845.3348210-1-vannapurve@google.com>
 <20221115213845.3348210-2-vannapurve@google.com> <Y3UfkIQLUKDM8OLb@google.com>
In-Reply-To: <Y3UfkIQLUKDM8OLb@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 17 Nov 2022 10:21:44 -0800
Message-ID: <CAGtprH_jZwYdkL-BRUehzO9g60QEVVcn+MUEEic53g0iGSfAiA@mail.gmail.com>
Subject: Re: [V4 PATCH 1/3] KVM: selftests: move common startup logic to kvm_util.c
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 9:36 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Nov 15, 2022, Vishal Annapurve wrote:
> > Consolidate common startup logic in one place by implementing a single
> > setup function with __attribute((constructor)) for all selftests within
> > kvm_util.c.
> >
> > This allows moving logic like:
> >         /* Tell stdout not to buffer its content */
> >         setbuf(stdout, NULL);
> > to a single file for all selftests.
> >
> > This will also allow any required setup at entry in future to be done in
> > common main function.
> >
> > More context is discussed at:
> > https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/
>
> Nit,
>
>   Link: https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com
>
> is the the "standard" way to convey this information.

Noted.
