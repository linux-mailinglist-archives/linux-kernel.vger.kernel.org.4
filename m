Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61469FB39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjBVSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjBVSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:34 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B5443458
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:41:03 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536cb25982eso109318087b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7EPVFCA8zq4soZ+RzbgO2c4Vrmh93Mahl0HGb6+1hVw=;
        b=ITBKevfktviDnwoblHkeG2k5hgP7j1Pp557a3hRBGd+T1OxXVsckbs940zqZpOye38
         G42rQ+t1c8Zht27mH4GkPF84adsHQQXjT0yYFyAjQwyqc1Hjgdg90bTmtwzQBifJlO/4
         h0sDqg7nsg3EKE3mH8rgftzSGWUCdjy4pi8DcIUK9/3cZN5Shp4WWHqZHkZ+UtVv59hX
         fzntUwGXC+cGndEewlvGOr4ciKaqCqQI37GnaCuyiStZQ/27yQE+85Xd8euCwPhZO/B/
         6v2Vgl3PylWMN6XBb9ReNRJG4+tCBnLOckb5XYBM90c3AsZc2irt7xlCuTSZgl+rJfGt
         0xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EPVFCA8zq4soZ+RzbgO2c4Vrmh93Mahl0HGb6+1hVw=;
        b=TCYpmoGyOhVSjTL4Ivu57RP0Xmk4odkAHhcroaPbdAlAH/s8Ncj/WZYjn+N3npRnvB
         5VLIQGU3GGymQimvez04Fg8C6gsUBUaMwiuAUs2rkipVygLvm9ZYn5H7beJ290HvJjUf
         AmesvwX4Lxk7MiZXvYZoXFIkVQgkhpeUBzEIcMxIZFcu2OCxOiSezrRMKhVZ3WnJIsJX
         wr5uRwN7splnFT8HUGY6SEN8EiNUQTvO4Nt8j6bmQfTL6ItiCW0tPFjNHzGD/Fgp3WRW
         2kjXx8bpmiPlZZLslizZwc5I2przq/x3Yxfy/CFkfKDb4OZryEq53eW+ITHeYrlxBX0+
         zDkg==
X-Gm-Message-State: AO0yUKUsqwx5g4YVMZfEd4OtyCyoe/9qvzAhmM5wHbCgw7lJY9Nw9sXy
        ZS8jC/t94v0RZksFgxLwvg++nnTKAHagR9YDqKbSmQ==
X-Google-Smtp-Source: AK7set8vXpAXFVP3ZNyo2CNseXHZW++5pI6rX5j5OntCGhDRcBYHgU4ykE2BwD8kBTuYFcxRZC63gQbBIPMVVlQhY5A=
X-Received: by 2002:a25:fe02:0:b0:a14:b73e:dcdc with SMTP id
 k2-20020a25fe02000000b00a14b73edcdcmr357601ybe.135.1677091248234; Wed, 22 Feb
 2023 10:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20230221163655.920289-1-mizhang@google.com> <20230221163655.920289-2-mizhang@google.com>
 <e91b9172-8a2e-e299-a84f-1e9331c51cb7@intel.com> <87ilfum6xh.ffs@tglx>
In-Reply-To: <87ilfum6xh.ffs@tglx>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Wed, 22 Feb 2023 10:40:12 -0800
Message-ID: <CAL715WKLQxxeyFqiKbKsUmQ8bZf2f=rwADyKj1ftgROA+dhpXg@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] x86/fpu/xstate: Avoid getting xstate address of
 init_fpstate if fpstate contains the component
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

> > We have this [1]:
> >
> >       if (fpu_state_size_dynamic())
> >               mask &= (header.xfeatures | xinit->header.xcomp_bv);
> >
> > If header.xfeatures[18] = 0 then mask[18] = 0 because
> > xinit->header.xcomp_bv[18] = 0. Then, it won't hit that code. So, I'm
> > confused about the problem that you described here.
>
> Read the suggested changelog I wrote in my reply to Mingwei.
>
> TLDR:
>
>         xsave.header.xfeatures[18] = 1
>         xinit.header.xfeatures[18] = 0
>     ->  mask[18] = 1
>     ->  __raw_xsave_addr(xsave, 18)     <- Success
>     ->  __raw_xsave_addr(xinit, 18)     <- WARN
>
> Thanks,
>
>         tglx

Hi Thomas,

Thanks for the review and I will provide the next version separately
from the series, since this one is independent from the rest.

Chang: to reproduce this issue, you can simply run the amx_test in the
kvm selftest directory.

Thanks.
-Mingwei
