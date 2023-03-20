Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990A6C1D47
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCTRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjCTRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:06:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6B24CA2;
        Mon, 20 Mar 2023 10:01:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id i24so13881436qtm.6;
        Mon, 20 Mar 2023 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679331617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKvfjCV3s7QAGshsrYyQsKFcACBWLFC/raC1M6IKqYQ=;
        b=YUMyITrzlKo+Veoq7wGf7gFba0UVxYlDJ5cN7OPJfyD1qH1urjp18pi0sdro2SmFju
         m9y+Wogk4uDTHEj+RGvxrQkl8t7YLS+og7Jpv8amIx1ItWhlCkDeEHXpDv4muCe8494D
         6cO+2pTH9isEWZ8NUrzjq2vVCdGnnTgO5MzJ+vjY219/Nd4Vg4nBtWlwmx4V4zIUjlUJ
         yAHjQ98vBz4rnMC6SaHQgZGs0kmPgS/9yN0UKvGudqtg5+7cuu6QEBw6xIiN7jmFelOm
         6bFt3FjoZcXyWci8lMTwzHqXzgXOmhs+Uya99cRszuqffQiLK4ey9AW4b84n+yau/K3J
         FD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKvfjCV3s7QAGshsrYyQsKFcACBWLFC/raC1M6IKqYQ=;
        b=nE2Rz522oYEx8I+KvP9ChBZnGCcz0raz7XR+GoL08eYikfUoMO/PnLtB2QH6TO8CS4
         IWFQpFENxGOB3+vAAPVN0XjSaqq7dZr/e45K8TukRBD+JV5biYaMpmcvtsPOAmNScXgw
         MxT5RDNmtPTBTkQA6rtnHqANkX3t/GIN3IDA6ZviSWtjlqNTsMntEqWFhRjSsHVLQUWD
         Vdm/kWqa3InTOi4ZhJqZ13lPDIf/KzO/S7OfR4PlnG4ZALobYGZFhEUVvDPgaLkvB1bn
         KhzFmftRt5CZfm+Xni7S8zbKLjuBSGL3ggo7Ds0QKVx6Tt7/W3cUGGEVq/krDmqj6uhy
         HKDA==
X-Gm-Message-State: AO0yUKUM1RThdr20Na8J+bOQCvHqsfkgAkKnXE0E0ICCU0LRBG2do2p9
        NEu3+m9tw1jVGr2rbNpcmZzvLjqNQHh0o7DnJw4=
X-Google-Smtp-Source: AK7set+fm8ZHaPGunVuoHlB2HNEbmnPluTJ8MmSMKl3S4+WFIGFxy9cf+uOnT3cUlXFUDZ+0QKH7/wPe7NxPaiJeP9s=
X-Received: by 2002:a05:622a:1aa8:b0:3df:58e7:4aa5 with SMTP id
 s40-20020a05622a1aa800b003df58e74aa5mr2189686qtc.0.1679331617097; Mon, 20 Mar
 2023 10:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230320163823.886-1-clin@suse.com> <20230320163823.886-2-clin@suse.com>
In-Reply-To: <20230320163823.886-2-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 18:59:41 +0200
Message-ID: <CAHp75VeVbV8iC6J63PgnE=i7EajvrDhFnEUcq0H_fRGfMMh+7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pinctrl: s32: use of_device_get_match_data() to
 get device data
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 6:39=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> Instead of relying on of_match_device(), using of_device_get_match_data()
> can simplify implementation and avoid code duplication.

Suggested-by?

> Signed-off-by: Chester Lin <clin@suse.com>

...

> +       soc_info =3D (struct s32_pinctrl_soc_info *)
> +                       of_device_get_match_data(&pdev->dev);

Drop the ugly casting, it's not needed.

--=20
With Best Regards,
Andy Shevchenko
