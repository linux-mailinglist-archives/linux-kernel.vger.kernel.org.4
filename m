Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977B37415F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF1QAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjF1QAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:00:14 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E41FF7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:00:13 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-47164fe4941so23927e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687968012; x=1690560012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPpb/2tnOaLvPcmNVC1FnQTKYAdbc3TLfcGD1phxugk=;
        b=SNRASh1Zsm6tbRz5f3GKr+JJaVqeig50e/xDwWncTjDVR19/GaoQmLg7PYlLSANOSf
         BSPj4JK1nkfvj1gQjj0OkKSk2W0hblpgPsWmSPzeLoXiZUSO/lp8wOENjzJNgWq6/J7l
         vBYXJTDNfeHcXvbVnYoKCGrsGSJzZu9Rse830=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687968012; x=1690560012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPpb/2tnOaLvPcmNVC1FnQTKYAdbc3TLfcGD1phxugk=;
        b=M5znOQTqbx/V1DrF9bxH6nCHiH1+FUiMdWIVY23izgK40xGAFwXk3BXBiwOA/m4yv6
         cAU3oEnkyWgF6V15iA9+xzlfagHzUAuPgf8us/fnwMWUFbEgumFkhGFx1klkTKvxcb6g
         V8gX3LYgCAl6kwRE/bDnl5PnXwixPGMWvJgk2Pq3SAFwgKNQU38KsxrmwAmBiWF90Lxd
         xTZb12KLg1rVhXw3OKMF7vS4WOFb0qtlRv4sM1g1CAXlprjo7NT0Hdu6Dpv5U3X94HZz
         REAGbip30I4Pkt/LBnDY//v5ie22lqmX2zdLUAtOVcIYhjOXhVt+TzHLJyzEyOReI0lu
         e4ug==
X-Gm-Message-State: AC+VfDwnYj9gGG8JMT9dJjl5wygIM0AVrh9PzOQmtJkQksE+lLRNot2d
        wifePB0O/Pj5zW//gm2tipZFZp1/knWHByyZEsnvMA==
X-Google-Smtp-Source: ACHHUZ6qDlk/vSg8s2EmqSTwaiB99MdxeO4WNgw8uOsw2rJRn+iLur1UIKJx8PSkzgJ0NRr2IXwK1A==
X-Received: by 2002:a1f:e784:0:b0:471:6119:95cc with SMTP id e126-20020a1fe784000000b00471611995ccmr15924726vkh.14.1687968012466;
        Wed, 28 Jun 2023 09:00:12 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id p185-20020a1f29c2000000b0047620e2e514sm1988435vkp.15.2023.06.28.09.00.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:00:11 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso1802262241.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:00:11 -0700 (PDT)
X-Received: by 2002:a67:f998:0:b0:443:6ad6:7915 with SMTP id
 b24-20020a67f998000000b004436ad67915mr5063977vsq.27.1687968010482; Wed, 28
 Jun 2023 09:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230627120058.2214509-1-matteorizzo@google.com>
 <20230627120058.2214509-2-matteorizzo@google.com> <e8924389-985a-42ad-9daf-eca2bf12fa57@acm.org>
 <CAHKB1wJANtT27WM6hrhDy_x9H9Lsn4qRjPDmXdKosoL93TJRYg@mail.gmail.com>
 <CANiDSCvjCoj3Q3phbmdhdG-veHNRrfD-gBu=FuZkmrgJ2uxiJg@mail.gmail.com> <CAHKB1w+UyOnC_rOBABVhmzG+XeePaWYgPJWxX9NUeqnAi9WcgA@mail.gmail.com>
In-Reply-To: <CAHKB1w+UyOnC_rOBABVhmzG+XeePaWYgPJWxX9NUeqnAi9WcgA@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 28 Jun 2023 17:59:59 +0200
X-Gmail-Original-Message-ID: <CANiDSCtu1OvoRe0ReqBVctzd8euZDt-h7dyx+xACWzdQeHkxBA@mail.gmail.com>
Message-ID: <CANiDSCtu1OvoRe0ReqBVctzd8euZDt-h7dyx+xACWzdQeHkxBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add a new sysctl to disable io_uring system-wide
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        jordyzomer@google.com, evn@google.com, poprdi@google.com,
        corbet@lwn.net, axboe@kernel.dk, asml.silence@gmail.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        rostedt@goodmis.org, dave.hansen@linux.intel.com,
        chenhuacai@kernel.org, steve@sk2.org, gpiccoli@igalia.com,
        ldufour@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Matteo

On Wed, 28 Jun 2023 at 17:12, Matteo Rizzo <matteorizzo@google.com> wrote:
>
> On Wed, 28 Jun 2023 at 13:44, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Have you considered that the new sysctl is "sticky like kexec_load_disabled.
> > When the user disables it there is no way to turn it back on until the
> > system is rebooted.
>
> Are you suggesting making this sysctl sticky? Are there any examples of how to
> implement a sticky sysctl that can take more than 2 values in case we want to
> add an intermediate level that still allows privileged processes to use
> io_uring? Also, what would be the use case? Preventing privileged processes
> from re-enabling io_uring?

Yes, if this sysctl is accepted, I think it would make sense to make it sticky.

For more than one value take a look to  kexec_load_limit_reboot and
kexec_load_limit_panic

Thanks!

>
> Thanks!
> --
> Matteo



-- 
Ricardo Ribalda
