Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D664734C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFSHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjFSHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:03:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F9D1AE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:03:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62ffc10180aso24990956d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687158233; x=1689750233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD0zn/dSyiVOCfeRhW5pho39c7q1GjuHdqlvtRu3jqA=;
        b=w4OcGG8A5Rf7WvGLN3b/lJAnbJKCrQcuVZ9HTVX1BoKvXZl63+knpSsidCVk+bAO1i
         5eOAf+3sb668V+j+R9iN/1TxwaELDHBt/ESvwlbzhwQhLRQmbZm3tTNu11Sf6zJNMCjY
         Wmo3TgS5PgYk/ZCoxlSRpeot3Nos+Fbt6MHa14ANmnz+e3dOKL9DakjoLcoxtddNSW4h
         hq6yUQz7Yk/vc9g+ExAq6w9fkPodchDJ7sbLR7E487oJ6jkgupN1gP19cav7BEtdcAiq
         3moQ8x9iT0ZzEAGHX4wuhdoGHogAfBMy2gkaGniCdeztBFZxXqP+x/locdRxtRdHT64m
         hy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687158233; x=1689750233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD0zn/dSyiVOCfeRhW5pho39c7q1GjuHdqlvtRu3jqA=;
        b=Hr0zytCuRFiEU4FXzgaKxcIPfMM9IJ8IcBxruHYSI0tt5MyGfTAnWGFHIVTg2GA/Zs
         ajOlkQ5Ntg37iBJ7pJufrYSNe/7LnSYY7RBq5hvSSB2dOIj6Eq3SfjLjvgzBzSHwCkO9
         VA4VOgYhj60bpM/KSgZIShbvSPcgrfBlWA2YpOwJsv3MOQA66WESny1qmC8h7Neji5uX
         f7pGMEiM5TtSdXNQYb+5ymhlikQRyUX0ImQd0rPl9T/vvozpIxLUxGvM3GWgVgSbHF4V
         GOVEkVl1KHvATQ9m1fyzgID1hEF9j00L5ROAfldYqmRZUVtE9KjdS8i+SCrsvp8Sa6bC
         PsVQ==
X-Gm-Message-State: AC+VfDxIn0v4mwPSV3kYOz4U95/VMe/ztpc9lmX+/WbLr5fiTG6LVcap
        X3Y3u+cuXZIMaMssGHIkeyko9K3d4WHqzZ8h0tLWfVwmXbq5Vx8s
X-Google-Smtp-Source: ACHHUZ6/AZutpaAxoSSJ5rEGLJl9sCW2hxbTF0gVbt9G2whH+uajcSBro+NPrPGt1FnuvTRrnLqoZbICzlzKJ4qZMrw=
X-Received: by 2002:a05:6214:764:b0:62d:f68a:ee2d with SMTP id
 f4-20020a056214076400b0062df68aee2dmr9751586qvz.29.1687158233535; Mon, 19 Jun
 2023 00:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <8de3aaf297931d655b9ad6aed548f4de8b85425a.1686998575.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <8de3aaf297931d655b9ad6aed548f4de8b85425a.1686998575.git.christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Jun 2023 09:03:42 +0200
Message-ID: <CACRpkdZFQxRyRzxi9E9mtJA_VHKW_k0=hzMnJNGH5RFqsBSZPQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: stmpe: Fix a corner case in stmpe_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 12:43=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> In stmpe_probe(), if some regulator_enable() calls fail, probing continue=
s
> and there is only a dev_warn().
>
> So, if stmpe_probe() is called the regulator may not be enabled. It is
> cleaner to test it before calling regulator_disable() in the remove
> function.
>
> Fixes: 9c9e321455fb ("mfd: stmpe: add optional regulators")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
