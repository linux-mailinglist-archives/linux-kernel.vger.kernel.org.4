Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F690694C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBMQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:17:22 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D5C1C32E;
        Mon, 13 Feb 2023 08:17:21 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id qw12so33225240ejc.2;
        Mon, 13 Feb 2023 08:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA7h1JSNBcO0xfSrGGH4n2jGYQo5+0WYhkIEf3BTaPE=;
        b=vQdEookd74o0Oj+FkZdnqrVl9Iob/E6MA7S6BwF4sJhvVLr0eeBlZW2lzVefOL3jsw
         f8V45N28rdxQHlbN+Toganqn8pTnAOkeY4trzUSwCnt862B8n/yq4Q/ayLoMtRfD/u3W
         8MzsqIz8mHdJgZ/9Tyi1PIQxJNx2wMi3hYItLpXmyqQp9lVr39pXernylOy7Y6Qa1a6p
         EMkSv9PreSu2efKBJmrpf/BHpQssBPy3axsCK/41XRYagPHTZAVOQAUw+3RcnOMpSVrz
         Cbl3XQQdUUwbHIEor4rWrTOLbRejN25fkRsYl3GyftrnarP7FAiXBSuXKQEtV3lzs98c
         eFNw==
X-Gm-Message-State: AO0yUKWYgXetV3ViftFxIHFOuM9JWa3tXTEr2ANFIHiMK/wQr3+4kKIj
        uhjNeLKJ77qDTZ1ABW90buv4tXfd8oh5dWsWfa7xhJ2z
X-Google-Smtp-Source: AK7set9m0TVaY/mpY+cgnB2X1s/XFPAFuhHBOoEdnJEM9/v05ffr0h0mhjf03IDpINLVbdC1gQwzgy0i3urpG05QAYg=
X-Received: by 2002:a17:906:e28b:b0:8ad:731:592d with SMTP id
 gg11-20020a170906e28b00b008ad0731592dmr4833517ejb.5.1676305040534; Mon, 13
 Feb 2023 08:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
 <Y9L5VFPdDnsiCluu@fedora> <Y+JWd6NfhH0sAlim@fedora> <CAJZ5v0i4t=z2nSP5TraKNcqrSgFT7TgxNJnF0JT6CsrCVOS2_Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0i4t=z2nSP5TraKNcqrSgFT7TgxNJnF0JT6CsrCVOS2_Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 17:17:09 +0100
Message-ID: <CAJZ5v0gjm35J1VFY7T-mhZkdbiKJqiGwaR4ZXmhDYe7Xp19YYA@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Adrien Thierry <athierry@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 6:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 7, 2023 at 2:47 PM Adrien Thierry <athierry@redhat.com> wrote:
> >
> > Is there still something preventing this patch from being picked up?
>
> Well, I've been waiting for Daniel to do that.  Or should I pick it up
> directly?  Daniel?

Allright, applied as 6.3 material now, thanks!
