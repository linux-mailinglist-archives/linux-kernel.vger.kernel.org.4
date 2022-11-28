Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2499963A818
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiK1MVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiK1MUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:20:51 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9C262C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:16:30 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z3so7395249iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wvH4SQX87PE0aAwrulNjYnHJk3F0ocOB3x8d5Zap0Q=;
        b=C5UrNlHX8GpmqPDgYIs6bi+Df6Dd9lbAjHP9UKPp5bx3xGYDajHNuojMFRuw9EFW9V
         OuOIBQizhzO1CKiXamHgG/v1MsiqdFqggZUq+CyiLuV3+3koDuxULEKR92vCoVDoYQl7
         tDbzI2T/B5UPaeUkMtlWNKzOVlSMRMIYpWpRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wvH4SQX87PE0aAwrulNjYnHJk3F0ocOB3x8d5Zap0Q=;
        b=dNjGvnRSUMUBKjNA1FkvLzIf0w36wAy1wQ6MJzb4hpZJs0ILIM27YeLZRkouxcpPHa
         7YDekp6sKBD0/aC7ls0eVCNaZQ4q9wUheeumbr4biSY2kau5WD8XSSvHNN/UE3FwAcNx
         73/AXitYtiD05ERvvCWvjnrydCEn33diRp5WtSWzyrK9gDM3gDSHD+1RWRLuAlH7V/x8
         Q/vDqhVLvOwIZPbMKFbR8y+mzpuhnig+mDgN8NvWxCws7XpoJS+vLtsQVlHDhqQiBUOq
         8VzH5PgoDaGfIe4J0H3z5FmKU4ukdjelatwym3HQ/e4u9GWrMHqpEux1/4Ub5OoyiCm8
         NX2A==
X-Gm-Message-State: ANoB5pmMxTMgZAR5f13VRU86vg0EL4RdgViFSkGuM5LJ9Rie5cct77NK
        9fNuBmWC3Azwl5f9pzpteNZXxt8otp077ucP
X-Google-Smtp-Source: AA0mqf7rJO8yjPVC7OedB6Wzh/P/RUrEte4XIEzKTGKDKYFyrPWlos7sqRNSmRGBKfYtX/MnP7ZlTg==
X-Received: by 2002:a6b:fe12:0:b0:6dd:e590:6628 with SMTP id x18-20020a6bfe12000000b006dde5906628mr15766997ioh.3.1669637789681;
        Mon, 28 Nov 2022 04:16:29 -0800 (PST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d80c4000000b006a49722dc6dsm4278348ior.11.2022.11.28.04.16.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 04:16:28 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id o13so4895576ilc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:16:28 -0800 (PST)
X-Received: by 2002:a92:c04f:0:b0:303:e37:21f1 with SMTP id
 o15-20020a92c04f000000b003030e3721f1mr2371879ilf.243.1669637787944; Mon, 28
 Nov 2022 04:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20221124-da9211-v2-0-1779e3c5d491@chromium.org> <Y4Sh/uFEgAxIEOs0@sirena.org.uk>
In-Reply-To: <Y4Sh/uFEgAxIEOs0@sirena.org.uk>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 13:16:17 +0100
X-Gmail-Original-Message-ID: <CANiDSCu52Qo27XAywZTnr0iUT++oL_B=DAD9A39mY8HapnWRhw@mail.gmail.com>
Message-ID: <CANiDSCu52Qo27XAywZTnr0iUT++oL_B=DAD9A39mY8HapnWRhw@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: da9211: Use irq handler when ready
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark


On Mon, 28 Nov 2022 at 12:56, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Nov 27, 2022 at 10:06:02PM +0100, Ricardo Ribalda wrote:
>
> > [    1.327829]  irq_thread+0x11c/0x234
> > [    1.327833]  kthread+0x13c/0x154
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > regulator: da9211: Fix crash when irqs are pre-enabled
> >
> > If the system does not come from reset (like when it is kexec()), the
> > regulator might have an IRQ waiting for us.
>
> You've included two entire changelogs here.


Sorry

First time that I used single-message b4 send :S. I think I have fixed it.

The extra changelog comes after ---, so it should be ignored by git.
Do you want me to resend it anyway?

Thanks!


-- 
Ricardo Ribalda
