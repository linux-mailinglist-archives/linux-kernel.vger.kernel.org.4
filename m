Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4C5E6FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIVW37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:29:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CAD5E55B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:29:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u132so10650593pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Hq4VzhV1vFCPluUxov2hJ8h9q9nLgfZQccQ5ZzRz8nU=;
        b=s/iuJhWGle8z5leFKaQiBQmVbxHdv7MgGUyBM7mtqKQVjziEeSvXwL7xdx6JR714Ax
         TQJUvv18XkiRrKHSsMgR50TK1axlClW3be6xrnoRRzmFuFt2ExbMio27saM9z4sB+7Lh
         ZQRtPkjUyodiv/lDXf1cMu2Ub7v8iAAgEFnc8v5ESHO1yQT2DIPXnICGXuLPfHL2x5Mq
         rc5nLvE3wDgTKDXWPIX9RkASsSEvWoNCWHEsykeMFuaYnLu5F/CP1V8MH43sNst9Mbn6
         0fK3PWDKDvAWL6EcOwGE0tWa/BTcZ/zpmYXt+kWmXOx1m+fUokHB33zTP75PEvIebzEq
         ZiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Hq4VzhV1vFCPluUxov2hJ8h9q9nLgfZQccQ5ZzRz8nU=;
        b=65WSMpGiIDW5+on6zefWSPKwZNEbqMgmBo3wz3YKxGBPQWQ+jN94ON1/xW/RkgVJs1
         IbY9ryGMoaZwk5bxcJh9S1yqAyMaKhqvQ/ENMjfxUu/0kmgH4XytYeuzFazIaraDAQgZ
         kyoT1tdjKYs0c5DljHipn67sj25divU7XLlPckwKWqzDORqgxN2MKkfRSAAW33376ouj
         fc1wGnObFT0viRTAoi1w3GIPc7GxljKzLsPGENmizpYC3orppuFHb+loUcxJAqbiZeCM
         lins2SAUrjABBEPouWVLD8m+or2jaGB/qbM/KkoTrS4L3aIiB7cZJMAuKNN1gwQg9zTC
         2UQQ==
X-Gm-Message-State: ACrzQf3NzFIW5FYsYwV9Io/ghYlipGN5BKur+vVQftfJk0RWh3F68JP7
        JJEfyrjB6dAmQvkSgWHO7QCF6C5bcCZoug==
X-Google-Smtp-Source: AMsMyM7aVDrzLB/Eho3X+Yq41oanBi1Ibx/BwEPkvcT8tylbO+g7Gb/I1duiYRxM3hUFBKPNvT+IHg==
X-Received: by 2002:a62:fb18:0:b0:548:9dff:89da with SMTP id x24-20020a62fb18000000b005489dff89damr5698921pfm.23.1663885793547;
        Thu, 22 Sep 2022 15:29:53 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b001754e086eb3sm4604986pln.302.2022.09.22.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:29:53 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:29:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] x86/pmu: Corner cases fixes and optimization
Message-ID: <Yyzh3VD+Gji8t9OO@google.com>
References: <20220831085328.45489-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831085328.45489-1-likexu@tencent.com>
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

On Wed, Aug 31, 2022, Like Xu wrote:
> Like Xu (7):
>   KVM: x86/pmu: Avoid setting BIT_ULL(-1) to pmu->host_cross_mapped_mask
>   KVM: x86/pmu: Don't generate PEBS records for emulated instructions
>   KVM: x86/pmu: Avoid using PEBS perf_events for normal counters
>   KVM: x86/pmu: Defer reprogram_counter() to kvm_pmu_handle_event()
>   KVM: x86/pmu: Defer counter emulated overflow via pmc->prev_counter
>   KVM: x86/svm/pmu: Direct access pmu->gp_counter[] to implement
>     amd_*_to_pmc()
>   KVM: x86/svm/pmu: Rewrite get_gp_pmc_amd() for more counters
>     scalability

With a few tweaks (will respond to individual patches), pushed everything except
the "Defer" patches to to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".

Regarding the "defer" patches, your patches are ok (with one or two tweaks), but
there are existing bugs that I believe will interact poorly with using reprogram_pmi
more agressively.  Nothing major, but I'd prefer to get everything squared away
before merging, and definitely want your input on my proposed fixes.  I'll post
the patches shortly.
