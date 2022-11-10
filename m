Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5806245DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiKJPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiKJP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:29:47 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875037652
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:28:29 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3704852322fso18372637b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OIBkN1U3zTVCtvJ4NfOIoFNsK2btK74ZGm6LNHdcnA=;
        b=RSjTlhvhNCcFvwP7HpXXkkvupPWbO8SlUxJJVCZrFS9iLBCM8BLdeMIWB3gtBwA1uX
         0OdJnoCwb81TecXxFWo74xPKaIm8En6Ksi+9Bpz5Vvx//AflPrfRzAZPZd3Bzrkph0lX
         87lqQt8KUMt9f4fqKfNuOQjGvRuZyy1T31bu5fhZZFB1G41UkivaqPByY2oQ1G+7rSdM
         nBaWprwm4lgA4aRuwoPW9UHseDYS9MnGiyBRNF3qoR1Rl1G/sii948Y381ZEnbvgHjMD
         X4xVPFoSeN+Y2qLJouWAX7h5Cr0AbhznS5Opb9OHQhrlVO/5LzXZ+FygpRtm2nLyzEKW
         uplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OIBkN1U3zTVCtvJ4NfOIoFNsK2btK74ZGm6LNHdcnA=;
        b=t5ISJFqJY0i6Q+xq0RJFMBDrRIHLvtFzsrNr4xchQwV4s7RubuZHCWd/yUroNPXiwm
         qREcd8nfsv/2Thg/gr4sITkMJyBJ/xX8+Y3dV/uVgTsuWhRumly26/1McSmSW1clGO1a
         iUGZKsTAW+JNBcM/j91H/x7WlTQ6mGSmy2rN9ZHPl9s37px6ddLDnvSONvKHSjzGOoCp
         U0GKBQDFxcAueUObrs9Q+YZfipEOQAn3U1xH5pMP7GSGVUfa2PF6x3DiA8Q0Fdtz8TcP
         cYmf4SSzC294Lv5kJSRmtY0PoGKa8WXPaRqQn1RTje4TeMNxUUBoxbiG91nRq+Ksq3/P
         IAOQ==
X-Gm-Message-State: ACrzQf1z2YLBDp/w9gvFgfPz5K0MbsK6qj8xLol52pFKhUkkE0YeXWGu
        MTeZirTlbT/9Pi2u+ZglFT4PGWs8wUy22Ky0vLlsFg==
X-Google-Smtp-Source: AMsMyM5DMJ+1KQF/+sZyp8paGzg1YTWxCoNK0rOKlHKh8jeqMaJkgkNYSI1ZitEbn/ynaKrnFRuycQ2mO/H9Yv5jZgk=
X-Received: by 2002:a81:500a:0:b0:36c:13d5:b516 with SMTP id
 e10-20020a81500a000000b0036c13d5b516mr61871767ywb.70.1668094094752; Thu, 10
 Nov 2022 07:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20221103141641.3055981-1-peternewman@google.com> <ab6504c7-419e-b274-1cc3-c40428907edd@intel.com>
In-Reply-To: <ab6504c7-419e-b274-1cc3-c40428907edd@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 10 Nov 2022 16:28:03 +0100
Message-ID: <CALPaoCj2t8=BNG=nTs6bvZ9ed0qpFCyCertEOTyMQtzKkdjRCg@mail.gmail.com>
Subject: Re: [PATCH 0/1] x86/resctrl: fix task CLOSID update race
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, jannh@google.com, eranian@google.com,
        kpsingh@google.com, derkling@google.com, james.morse@arm.com
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

Hi Reinette,

On Tue, Nov 8, 2022 at 7:50 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> I do not see it as an either/or though. I think that using task_call_func()
> to serialize with context switching is a good idea when moving a single
> task. Sending IPIs to all CPUs in this case seems overkill. On the other hand,
> when moving a group of tasks I think that notifying all CPUs would be
> simpler. The current code already ensures that it does not modify the
> PQR register unnecessarily. I would really like to learn more about this
> from the experts but at this point I am most comfortable with such a
> solution and look forward to to learning from the experts when it is
> presented to the x86 maintainers for inclusion.

Great, that should allow me to post my mon group rename patch
independent of this one. As it is written today, it depends on this
patch to reliably notify moved tasks' CPUs.

Thanks!
-Peter
