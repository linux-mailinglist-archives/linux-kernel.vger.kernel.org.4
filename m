Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7266CC0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjC1NaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjC1N3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:54 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D28CB762
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:29:52 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-545ce8e77fcso152635697b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680010191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tecdx6nWRwoN0Q2Hu1krMUTcGTmyxfVrTsPRMfdDUWY=;
        b=jjdTExd0i8jgXnc251h2cJPO1q0ltzJ1t1BJls1fzGT5UHJV1YTJC1TTAhEYqJnTYh
         wWAW8UOeUdSlEiVRtl3zDGu1oy4rlOb+1nQyhQnm0Vzkg8gXZYdDo2ioCkZYMCNR/kl3
         Sv4jm/kjHah8xoNrJJiwvRHDTQ0AWK55Jg1vtqHefly1e8k/5phH0tGOH1y7rey3mNGE
         7DxaCVB7ROz/2XXuYRwUtD+PTYv0eUnbase8XsrTIErsWfsRMFfw9vne/StsgLYdmYFn
         vyj0Zh+qQRv0eopCSbq2n7IbrOcyCSxbp0MtragnPbSUBjTjN9OKIUIaISCeitIwcDHM
         bwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tecdx6nWRwoN0Q2Hu1krMUTcGTmyxfVrTsPRMfdDUWY=;
        b=l3nVhaLiwkQY5x7tv8vdcArtKtlnXXR3sm1xOH7c2b+yZU4B5PsIWLu3M+XJ/YKJZI
         3qo99++fHOa6fGg0zGDFrNzyadi0doh6eeQfrzNxDn59RnXnF2nQHTIY9S/oo/mx9tn0
         q7Xeq4REYJ+7JGhhWLlf0ZIVUpyvdY5qKQgAyxrxzah3d4BgR9UHgld0CAuVHNtW00y/
         bo8Wt+D7JUY1jc7vcTa5aRprv0gLC1A1B2GxZ9vWJFw1p864pp3AFGqdCX1OeaBGGkU8
         SVbbdE91RmBIqhwCKbiB7WPaqPEq2XGmUAZim76+gyo1Mq3ltx7XnTXIq+fM1CD8ckk0
         czQg==
X-Gm-Message-State: AAQBX9eIKSOFM0T5Cb4rsFWMXYSUuCM7trfUI7vL0lmdDtSbVdl5F/H5
        6bcXO0FNTMSHhMGX0Mk1rIjLzZrqUOEsV2sv2moTMupFGgEXSLOV
X-Google-Smtp-Source: AKy350ZvXq/h1ZTm2/g50xJmWWcThX2fK7L0G7R0ZBE2vZb/vaIA2g+UPyc+5tAHnPj8qebI1BnHCQ+CMMrQaju5mNk=
X-Received: by 2002:a81:eb02:0:b0:545:883a:544d with SMTP id
 n2-20020a81eb02000000b00545883a544dmr7414073ywm.9.1680010191720; Tue, 28 Mar
 2023 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230323122910.991148-1-d-gole@ti.com> <20230323122910.991148-2-d-gole@ti.com>
In-Reply-To: <20230323122910.991148-2-d-gole@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Mar 2023 15:29:40 +0200
Message-ID: <CACRpkdYYW-ZYnzqsHEurzwwgUvEEM64CuMb2nkRMLi=Tge57jA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] gpio: davinci: Add irq chip flag to skip set wake
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Keerthy <j-keerthy@ti.com>, Vibhore Vardhan <vibhore@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh <vigneshr@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 1:29=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:

> Add the IRQCHIP_SKIP_SET_WAKE flag since there are no special IRQ Wake
> bits that can be set to enable wakeup IRQ.
>
> Fixes: 3d9edf09d452 ("[ARM] 4457/2: davinci: GPIO support")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
