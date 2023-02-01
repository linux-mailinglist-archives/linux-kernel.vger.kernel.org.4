Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC7686F32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBATsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBATsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:48:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D4658A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:48:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gr7so30073798ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GbKw2bj7MYWmb9R9AKQkFPSCVCTf6nBSBsfonYBTpx0=;
        b=IgZVtlmpLu8K76cmIHlymzNS1y0BMQxmg8LPWlOgZreANxdb5QBAELtJADmCCDgJ1c
         RJOljtHVD0muvMOkFZqBpq5pHqILjMF2O9h8XxoKaadZ/vUubQ3PMFvVwWSaZzEQ9OFQ
         HFghC3rv07WunN/7Xj4Kw0+prXcd/XVXfjHR8W/PkZMEc+Vm4oO4/HlYLyf4M3QIHppk
         mWdiGjuibLgl4i6Btm+A7HSScAtaXHEvS+PcqJP+rDiat40oYM9309BQmk5ofyFBWVqP
         ShyBFjcgB51M3b8jHbJy3eY2rE+H3iGsACCDllnMAFhA3QibJbTpDG9Srz1M99kgqwlC
         3f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbKw2bj7MYWmb9R9AKQkFPSCVCTf6nBSBsfonYBTpx0=;
        b=DNupz3IjjqV6OBRtLUz0cbydk7DO+wAOfFOSaC9VHt8q8soUJ+N73mNIEc8cym/12n
         8DpJwuHhJgnAh+Wurg4s2fO5SE4Y0M62fMXp08/1FuDn4jeukUwiV3S9zHNKif7RIjje
         Sh5t9xMeiswLmJRQzMNCgu0nLPVoQvTY07Uzw5jJFO9iwHkPchTLTzGv90YJHHV3RPMA
         zjIRGv1j0owdZGBStDtO1bPiwWgBa58LrbTolRHIawzKVP3YqcK1pxcHek+gs17vWfU2
         MeJEWGe4T/tGMUVAOh4Cknxh+achqVJ3QEdc9QC8Vi7uTz6YjKRTMcancEj4dymq3BbD
         xm7Q==
X-Gm-Message-State: AO0yUKWv5seSnNahjmBKStwzOyUbrDo2cWIh8bi5HezWGubeDyQTjiBP
        ZPbU6ytHOndNhMV+FlXp4Pw9BLHWj9pAaMkeUd2L8Q==
X-Google-Smtp-Source: AK7set9Op0DiDjKw4XTcFVxiN3uCmIlijP4RGLcpuX/DBce7/Gn8JMuA7xa11GsJO9wnxH7ue5JE866jce75SYd3ZgY=
X-Received: by 2002:a17:906:80a:b0:878:8bd5:4bdf with SMTP id
 e10-20020a170906080a00b008788bd54bdfmr931813ejd.270.1675280909555; Wed, 01
 Feb 2023 11:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <20221221222418.3307832-2-bgardon@google.com>
 <Y9rBQAJg+ITHnVfw@google.com>
In-Reply-To: <Y9rBQAJg+ITHnVfw@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 1 Feb 2023 11:48:18 -0800
Message-ID: <CANgfPd8gAW=u6yaPkrEURZ6vi0SWDrEKASAQAanGwBQLWqo+mg@mail.gmail.com>
Subject: Re: [RFC 01/14] KVM: x86/MMU: Add shadow_mmu.(c|h)
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
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

On Wed, Feb 1, 2023 at 11:45 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Dec 21, 2022, Ben Gardon wrote:
> > diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
> > new file mode 100644
> > index 000000000000..7bce5ec52b2e
> > --- /dev/null
> > +++ b/arch/x86/kvm/mmu/shadow_mmu.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KVM Shadow MMU
> > + *
> > + * This file implements the Shadow MMU: the KVM MMU implementation which has
> > + * developed organically from hardware which did not have second level paging,
> > + * and so used "shadow paging" to virtualize guest memory. The Shadow MMU is
> > + * an alternative to the TDP MMU which only supports hardware with Two
> > + * Dimentional Paging. (e.g. EPT on Intel or NPT on AMD CPUs.) Note that the
> > + * Shadow MMU also supports TDP, it's just less scalable. The Shadow and TDP
> > + * MMUs can cooperate to support nested virtualization on hardware with TDP.
> > + */
>
> Eh, I vote to omit the comment.  For newbies, Documentation is likely a better
> landing spot for describing the MMUs, and people that are familiar with KVM x86
> MMU already know what the shadow MMU is and does.  That way we avoid bikeshedding
> this comment, at least in the conext of this series.  E.g. I'm pretty sure much
> of the shadow MMU behavior wasn't developed organically, it was stolen from Xen.
> And the line about the Shadow and TDP MMUs cooperating support nested virt is
> loaded with assumptions and qualifiers, and makes it sound like nested virt only
> works with _the_ TDP MMU as oposed to _a_ TDP MMU`.

Sounds good, I can dump the comment. I plan to send out a rebased
version of this series tomorrow, incorporating all the feedback this
series has gotten. Thanks for taking another look at it.
