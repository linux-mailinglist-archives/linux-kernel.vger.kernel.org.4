Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6A6ADC7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCGKz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCGKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:55:00 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0961D2201F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:54:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c10so7701839pfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20210112.gappssmtp.com; s=20210112; t=1678186497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Skg1SqujbdGT2zvEN7TsW4W5uZFQ0XXYH1BEmSx7ha4=;
        b=dfY8swCLI5T4bYkXxzkj+TaLog+Rqnsir/V6oYrFT9hiWGimu3y6ac8474p+yeDuVT
         yXYwrkCpxZjzGfAp9GU+Ng5hCT5r/lIwxcspd+izrr76wZQVYGKCt7txGiujwXQsuwwQ
         1g0WQvBnIKcBAYXZeOluZz3xR64PVFrnNvESmZ6pwvQua4jUH9biVfy7bUfgbd6//OA9
         j2UH3kCMZu1fwvp0RUhI1S1U661ROXcZeIYYLrK5+fAoxD38HrKR4wiFC201yh30qc5R
         d4Pz+Qv4uuMPjeKkTuSAXWOdkRVGf7Ri4PokxpZglBONZkr/Y/GjZG0iecbjUbGTrHZo
         879A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678186497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Skg1SqujbdGT2zvEN7TsW4W5uZFQ0XXYH1BEmSx7ha4=;
        b=Acpb2gBeOeIzcXcT7lxWTUrlWx9odIbyBIhJw0FymEq9iar/1DZyGVzD1eAP/1ocmY
         Brt7jl8CFhu6obIlN1jiwV3dnwSOBJe7hC1rKrsPB9iw2vHWIIhZXFHALelUzBlKa6Oz
         mRtNdi6Ch2oQkCjgZ74F+NcMqmlBQoVaG6ZUa8kF5SG6MIit5Pr09wxz4HGpgT5iP8UJ
         0GMpmdGmRFwxMnBxVLLdMWt5HA2NGPCkrkdAqAldTR5+GRMxwt6G0XQy91uWJBgJGXIT
         KSz5MJMmtdOa9H81Fw7Str15i5iMR91OVkR6L4W7Ik3NYSLs+jUd+3Q4dXHase735tyl
         7x1A==
X-Gm-Message-State: AO0yUKXqDQx0TYYmu+wtHaDgphXc448FGD+hwqi/RFUhcLftES2t1VrJ
        xw9vIzW3Bkif2lkZ1yPmqnNz6ig+ZxcWbKtre7D5DrC+uK9hSSKG
X-Google-Smtp-Source: AK7set98kZ8YyQLBgbIpmTucdSkkhukEXksTCede72SAna8hzKZ747OrfleWO2txTTwSpGQcyoOjbC3rQI5X3WDLQv4=
X-Received: by 2002:a05:6a00:2125:b0:5d9:27a5:6125 with SMTP id
 n5-20020a056a00212500b005d927a56125mr5750897pfj.6.1678186496997; Tue, 07 Mar
 2023 02:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20230306044737.862-1-honda@mechatrax.com> <6e1fe1015235ae7d7eb9ef2526fd64b6d6d628d7.camel@gmail.com>
In-Reply-To: <6e1fe1015235ae7d7eb9ef2526fd64b6d6d628d7.camel@gmail.com>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Tue, 7 Mar 2023 19:54:20 +0900
Message-ID: <CA+Tz-SHQxNzx=eS8ex=3Hps0th5bTY+K1qSWrZqWC8ryv+d0RA@mail.gmail.com>
Subject: Re: [PATCH] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 10:30=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> Hmmm this looks to be a very likely issue for any device having to
> brute force IRQ disabling by disabling the line (disable_irq()). That
> said, I think the commit message can (needs) to be improved. The
> message feels a bit confusing to me. Also, having a reference to
>
> commit e9849777d0e2 ("genirq: Add flag to force mask in
> disable_irq[_nosync]()")
>
> would be nice to give some background on why this can be an issue.
>
> Another thing that came to my mind is if the data is totally
> garbage/wrong or is it just some outstanding sample?
>
>
> Some research on this also seems to point that we should (need?) call
> irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the IRQ.
>

Thank you for your reply. I'll improve it.

> I also wonder if we should keep this out of the library and have a per
> device config? Sure, this won't make anything wrong but it will hurt
> performance. OTOH, even though no one else ever reported this before,
> it looks like this can be an issue for all of the supported sigma delta
> ADCs.
>

I'll also investigate it.
