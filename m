Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1F6D8A85
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjDEWZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDEWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:25:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AAD59FC;
        Wed,  5 Apr 2023 15:25:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-93071f06a94so90749566b.3;
        Wed, 05 Apr 2023 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680733539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SuiRQr1y49yLSoZiwgChN2owpYFtgpGjmGmx4+yfM=;
        b=FqSyrYZVbGTZDSwPy3MTlAwISli1dlrjSuat2laMptqutKrSxukPjFKlP+zwDVwHo+
         RFgQIrW5ZDaKqV9pg+VbUXq2lyIz6tD9CMFfTmjI3wcmcvyXK/HmrU51O4hMkx7qfTSQ
         wIuXvCpjzkDL75//VGU3zR0zf5+ko8kzGqT17Eus/Rzv3CelBiWz2m9euBsHXqnw+vHA
         ZFizIyOky1vdNiCngngPSZEUk0pTgQrjXsyTrkgtDClBrkofPaQAzHtPouJrDJmpSyA8
         THVK/Af1gnyPYSuWcnvfXOK+iJL+YXMHNsymRoRg4fn1quStLjt+SNX6OksgebX77jky
         UINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680733539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+SuiRQr1y49yLSoZiwgChN2owpYFtgpGjmGmx4+yfM=;
        b=PXEik/S7gzccQujVw73m9cQcacSrWBldRdpR8FqVbbEFVZEvTGlbOzc5Lx7QBOTBvo
         70MDPpQjZjLuWfeJlHHrStN6rYmJypF7whEp712QEf5glKscq5xwlVYDSemVGOC/e/hW
         yF3j7VIxX4Q8+/A5TEJFGaPdXB4uR/0z19lrAlT6DvHPHDa+lhVaFH4qOWpBgvWIewqY
         UJom7YtDlYoF00OTvqqZ/E72Eo2nHu3Ui7N/2k/TPsi7dVjcouVxFlepNwOy1hB22ZVn
         nRSM9cvzrIx0h8uJ6zH6oXcBqfbRducC7aabw7Hht20K38/lhZB6E0mIYGhEbA4yuh/4
         j+ug==
X-Gm-Message-State: AAQBX9dz0AQrhsDzXXRpcNXsOg5is32Bye/aTYQKyBC56sOcsjjAbSc6
        OTEaJbCo+8PH0xoAO20xCfY4vrhfdd9PdjrEIsNRLREYrG2qIg==
X-Google-Smtp-Source: AKy350ZBmygqiJIg5PdHv0Gzqj69rb1PkWDxi/MUrEmncPyRs22hMTulXR+IpwXFs7U7klpEi+IRvR1GOZoGSSAChxs=
X-Received: by 2002:a50:ff05:0:b0:500:58cb:3b05 with SMTP id
 a5-20020a50ff05000000b0050058cb3b05mr3303754edu.27.1680733538997; Wed, 05 Apr
 2023 15:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZC1S_f9nworAQpm_@dragonet> <aae10acf-7567-48e9-37b5-12db6a69719e@kernel.dk>
In-Reply-To: <aae10acf-7567-48e9-37b5-12db6a69719e@kernel.dk>
From:   "Dae R. Jeong" <threeearcat@gmail.com>
Date:   Thu, 6 Apr 2023 07:25:25 +0900
Message-ID: <CACsK=jcyHA4vWoR1tB3RQyXgtJ55LpwbGa+jCmGUDe1Ng7EiXQ@mail.gmail.com>
Subject: Re: kernel BUG in find_lock_entries
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:46=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/5/23 4:52=E2=80=AFAM, Dae R. Jeong wrote:
> > Hi,
> >
> > We observed an issue "kernel BUG in find_lock_entries". This was
> > observed a few months ago.
> >
> > Unfortunately, we have not found a reproducer for the crash yet. We
> > will inform you if we have any update on this crash.
> >
> > Detailed crash information is attached below.
> >
> > Best regards,
> > Dae R. Jeong
> >
> > -----
> > - Kernel version:
> > 6.0-rc7
>
> This is pretty old. Does it trigger on a current kernel?

I'm not sure, but I don't think I've seen it recently.
I will let you know if I observe it again.
I'm sorry for wasting your time.

> --
> Jens Axboe
>
>

Best regards,
Dae R. Jeong.
