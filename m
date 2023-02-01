Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB69686F24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBATp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBATp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:45:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB8183480
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:45:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so3056494pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pHkm+BjU/exUkyMzkVJbkP2yS/s+JUrPnH9qzpjYLM=;
        b=MB9VdHl5MQovwwjUeW8FzfSu2L8t5qtNgWS5DdwG866AU/u4ENHAYV1xkX4l2+IHXp
         1Q55MS7UxURiLdefiU/aa2p70DomK4y1OI8S39i0qgXkWWF5aoixonyHRtpImko1Kd+I
         3/cRyQDdDI/pk+/Fzzm2cIwVtAtvYZUdtcew4/7ohF4CY9+vKcyNyyM1+eLJKZr1mImK
         jXRn38tRJiwsTl/3w4cQChzog1vIgmeGhy5E9jBeX2acdpJjekN/f3Uggp2c2R/1M/Rb
         noaNxYIQS1vp+WuV3AZgkfzNWUevNCLhHfKEzC28RApXfIHg/1FMxQ0uSzwbkeI4Yfxp
         eCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pHkm+BjU/exUkyMzkVJbkP2yS/s+JUrPnH9qzpjYLM=;
        b=T7eLWPEhzv3wu3n2j5eyRKA3tLbJzmyN5+TT4zr7fpBL1sHK45Kxtox+wl/vsWH4zv
         YB337tpcdlcSA89Z19L8xV3YWs6kcD98Jlcq4RJxji6LcLQvcnvI8yvhcVrYpILJDLr7
         07A6AsYmO5AEhXk+XoskLcRl9mt01aIG25Di+01j2OGx2fyY12HT7F5gUF3LS4OorSy7
         dp1Bc6iZRTZ5wSqoHiEv/T5Q26mQFzNW+6+cHIHdj//LIYiGDrDqwOxmMFGgxachOeGI
         /lmtPxzGagkeUOs4dtpbff1LLi49mtz3jSBA9S07TCHK28NPr5L0yBVvxDrjDTQckFVc
         Ketg==
X-Gm-Message-State: AO0yUKXjESRQbYmZPBF45lHsaU4+z4cbWZTcoI2PNmPG9K0C4tpmiKJP
        3UkP5qD0XkEY58GbFw52F2LT3gtaZEzVJytDtic=
X-Google-Smtp-Source: AK7set+PEOISZTq7r1ylp2+dARn7YrtM8rMK8aZqwj8E/E5ll/hPtvpkbGBLDzvpvfGOBDbY+FMdwA==
X-Received: by 2002:a17:902:aa49:b0:198:af4f:de10 with SMTP id c9-20020a170902aa4900b00198af4fde10mr71676plr.16.1675280707949;
        Wed, 01 Feb 2023 11:45:07 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u70-20020a638549000000b004468cb97c01sm11121652pgd.56.2023.02.01.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:45:07 -0800 (PST)
Date:   Wed, 1 Feb 2023 19:45:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
Subject: Re: [RFC 01/14] KVM: x86/MMU: Add shadow_mmu.(c|h)
Message-ID: <Y9rBQAJg+ITHnVfw@google.com>
References: <20221221222418.3307832-1-bgardon@google.com>
 <20221221222418.3307832-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221222418.3307832-2-bgardon@google.com>
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

On Wed, Dec 21, 2022, Ben Gardon wrote:
> diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
> new file mode 100644
> index 000000000000..7bce5ec52b2e
> --- /dev/null
> +++ b/arch/x86/kvm/mmu/shadow_mmu.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KVM Shadow MMU
> + *
> + * This file implements the Shadow MMU: the KVM MMU implementation which has
> + * developed organically from hardware which did not have second level paging,
> + * and so used "shadow paging" to virtualize guest memory. The Shadow MMU is
> + * an alternative to the TDP MMU which only supports hardware with Two
> + * Dimentional Paging. (e.g. EPT on Intel or NPT on AMD CPUs.) Note that the
> + * Shadow MMU also supports TDP, it's just less scalable. The Shadow and TDP
> + * MMUs can cooperate to support nested virtualization on hardware with TDP.
> + */

Eh, I vote to omit the comment.  For newbies, Documentation is likely a better
landing spot for describing the MMUs, and people that are familiar with KVM x86
MMU already know what the shadow MMU is and does.  That way we avoid bikeshedding
this comment, at least in the conext of this series.  E.g. I'm pretty sure much
of the shadow MMU behavior wasn't developed organically, it was stolen from Xen.
And the line about the Shadow and TDP MMUs cooperating support nested virt is
loaded with assumptions and qualifiers, and makes it sound like nested virt only
works with _the_ TDP MMU as oposed to _a_ TDP MMU`.
