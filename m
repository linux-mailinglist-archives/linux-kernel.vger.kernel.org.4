Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED765F68BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJFOEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJFOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:04:04 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47CA6C03;
        Thu,  6 Oct 2022 07:04:03 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-349c4310cf7so18641837b3.3;
        Thu, 06 Oct 2022 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15EqTCKT5KNw2vxyM6AXOBbnGd1gw8GuxW5sxffr7+4=;
        b=buofUxG7S2UPHewCG7Tc/witmJNpQEoZV14aKl0Hv2SqnRyJ4/Yw2PgdAE7g3hpfpX
         XxAJxv6Rt2ByAQn502BhxVm4f6pCsg+h/73OXz34902TOGzWqotmBxcSTg+tRiEVZUUB
         /Pp0RHaB0LKk0oIz/45ux4X+T0uJ7Jxb84daISQVSoZzB/lEVIZ9TufEtXBnjWM+pVxh
         1MyKpNuPj03TIRk/k4EKEZfvTv4aHiLdKriM0hhtOO7xptEKzsdFmlqBVN+uS/ExGTwI
         0yJIs9t7tgPej3jZDujztVVJnoNJtAaKKPm7VIHVcz1dIdLkdxpqFiizOhXC+p1BSo2A
         hWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15EqTCKT5KNw2vxyM6AXOBbnGd1gw8GuxW5sxffr7+4=;
        b=FIpSS7ozOJMB2TWYYfhCUjZIrj9t507YTyUkEbymSh3IwaFkwPhB2KGjEwf2Euztgb
         FddISH5l4Ql4A7KsqBPDmt/NLqOAVic8DV0XGbCHIWQe48u6Lce3MoGnDmT0icBWDMG6
         awcCxxzL+G8uCf9apOrkt/OvJvrq/TWQmAfytZkQ2pwarCAaQv2G+8R7lYAWRoqSX00e
         W5ztZ+A2CNSrhIpFpx61fNT/Yfnk7VJhT48Akbqr2VgEB52dcxMbrFB78vyInNamM2Po
         1rPfzSDTKt9TzGBlVF/FVofAAUGm1WmZnxfbqqeiiU+BB6ip42ZuLduaAcYtS0mssUYo
         gmvg==
X-Gm-Message-State: ACrzQf1navGko17hX8DZpDWn7VqNFLLJsQCtxmoaOa0QSZRNT3AlgbKh
        cpRlDgqxTDSXaD0TK2her2agSjbzxAACQz3KA3W4ADcn
X-Google-Smtp-Source: AMsMyM7a0pHKm+WJ1OPiSP54eW5dWK0PjJQ+JOYJQHA32chVqp1eXglFsd2lJAwGTmLT5QeDRhkWQrvw7XXmsJP5r4w=
X-Received: by 2002:a0d:fdc1:0:b0:349:c82b:b142 with SMTP id
 n184-20020a0dfdc1000000b00349c82bb142mr4432266ywf.431.1665065042348; Thu, 06
 Oct 2022 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEc3jaDLE1_+cCdL0nwUq-TPzBhoPmukGs527TokNN=iwqO5Hw@mail.gmail.com>
 <20221006133609.3839-1-hcvcastro@gmail.com>
In-Reply-To: <20221006133609.3839-1-hcvcastro@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Thu, 6 Oct 2022 07:03:51 -0700
Message-ID: <CAEc3jaALWiuHTxNz21k3d7f0BMYxCdK0qWmng=tu6w-prej7Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: hid: adjust gyro calibration data
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 6:36 AM Henry Castro <hcvcastro@gmail.com> wrote:
>
> For some reason my DualShock 4 get the calibration
> data values equal:
>
>         gyro_pitch_plus == gyro_pitch_minus
>
> Probably due to some defect in the DS4 hardware, and cause
> a CPU division exception to crash the linux kernel.
>
> At least with the patch, I can continue play Retroarch
> without using the Gyroscope :)
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>
> >> Hm, I'm not the biggest fan. Is this an official DS4 or a clone
> >> device? It sounds like it is some type of clone (some look real).
>
> Sorry it happens in my DS4 clone:
>
> I have the log values:
>
> gyro_pitch_plus = 8704
> giro_pitch_minus = 8704
>
> Then the division exception:
>
> mult_frac(x, y, 0)
>

Are it only these which are equal or are there are other funky ones?
Are all constants in general the same? I'm just trying to figure out
if some of this device would even need calibration.

Thanks,
Roderick
