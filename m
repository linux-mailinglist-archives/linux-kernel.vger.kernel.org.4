Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14E970D3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjEWGOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjEWGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:14:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E49132
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:14:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f475366514so47139455e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684822451; x=1687414451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnajTxUoiJQWeN3bk/ipx6IGatmGAm++zLeibpj6ysU=;
        b=DoUv//v/24hVrbMt6gdiY7GVF6CnF/C4EoqgswzTZcGUduJvYc13XMD7nfCNS8QoUO
         HNMI5p4+EB+dL1Aio4LmIgZjmCtODTDgaLwH9z/eCbMUIX1bxp1+ThR2r3wjwYbo/pHC
         cnkkzCsEvf/M4Jb+hYXtCkh/W/7FUt17SVT5pXyiUFq1COoZaonFRxNgiy/rn+s6moIc
         kOyBv6+7X/He++N9Owlehze0VOlwi4gWNyVpz95830vSmlpiNcvlrlB7F1IMOLZrUL6l
         wg/DVock9Qj0BFU/3uOvXveFOXACm7pUBnkkFHmnl5RoEWuU62p/v84N/ySmGROvKCBb
         kT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684822451; x=1687414451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnajTxUoiJQWeN3bk/ipx6IGatmGAm++zLeibpj6ysU=;
        b=fAcW4fQWqILDwzamx6qAgDgEQ+J8XgLE44blt3KRruJEUq56m+sKPGwmM/6i1kH+Mq
         Z1KoI738WY0Wgc8hogeYG+DtubARiVWxb7Bq5fOQ3NVx0wN+U9nHfUHHxqKVNA5bIr1E
         WH3dUcACmoiLCTpwwmqXh3TeFabwYkshmL7c5e1BiftiWkzMfxTh4SqP+40XyqefHR51
         PYKsUEUnf5Xr1GTF2Lc4h+f3T5W5eUJIG6ZMVZkuIAQVBA6pJmS5fjQwfRhPII/v0atY
         Nql4ks7KlwnwwakN8sqCYPLcdpE1A1aCTrvswZC/Mea85d9JASo7UXv2HV9hxHf1CthS
         2iFw==
X-Gm-Message-State: AC+VfDw6UD+Y3W17LKVziOnw5bv/xNG7gEuot3bDFDOwANzpGJRhzGJI
        6OOPmpihr3GvGlq49kAmI85mnt7gb0hXbtxoxsuL9uOeDJw5nS7p
X-Google-Smtp-Source: ACHHUZ6owQ+ZG8dqCP6VbRNTN0gxeqj1kSVszEEZQzN9lYWW8+LBPQLRQYOPLg1frS2IV+6NwoPuJ3ZbXKeiCWo6UI4=
X-Received: by 2002:a7b:c456:0:b0:3f6:8ef:a213 with SMTP id
 l22-20020a7bc456000000b003f608efa213mr1555834wmi.28.1684822451253; Mon, 22
 May 2023 23:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421075443.GA3136581@rayden>
In-Reply-To: <20230421075443.GA3136581@rayden>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 23 May 2023 08:14:00 +0200
Message-ID: <CAHUa44GOzp-w0vqxEqw8uVk95x+tM-H59gY0EyqjYB+H09a=LQ@mail.gmail.com>
Subject: Re: [GIT PULL] Fix uninitialized variable in OP-TEE driver for v6.3
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 21, 2023 at 9:54=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this small patch fixing an unintialized variable in the
> OP-TEE driver. The error has been reported recently by the kernel test
> robot.
>
> I realize that this is late for v6.3, please queue this for v6.4 instead
> if v6.3 isn't possible.

I noticed that this hasn't been merged yet. Perhaps it fell between
the cracks, or do you see an issue with it?

Thanks,
Jens

>
> Thanks,
> Jens
>
> The following changes since commit eeac8ede17557680855031c6f305ece2378af3=
26:
>
>   Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-a=
sync-notif-fix-for-v6.3
>
> for you to fetch changes up to 654d0310007146fae87b0c1a68f81e53ad519b14:
>
>   optee: fix uninited async notif value (2023-04-20 14:52:25 +0200)
>
> ----------------------------------------------------------------
> Fixes an uninitialized variable in OP-TEE driver
>
> ----------------------------------------------------------------
> Etienne Carriere (1):
>       optee: fix uninited async notif value
>
>  drivers/tee/optee/smc_abi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
