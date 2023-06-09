Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC4729173
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbjFIHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbjFIHno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:43:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7222697
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:43:37 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-569386b7861so38427937b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296616; x=1688888616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n22j43EkOQDg32COrHKfr3M00AZ/0ZWY6HKFgde4cL8=;
        b=xigE4Ds2RloULZ1O7n6QdIj7g5n2MHKcla3NMyQcPNgn5oDy4jmszVsyLksPsHVQ2A
         pdTgGqULLsN/GWX785OV8mjaD9L5iIIbCf1o2AOgNYz/kpjdiquJcXhSBq/KlSlfCHMD
         FVE+ue6kL2EzWZnfjSkN1Zh0QzWQQuBmr30bqi9Sv+tSN7kzZl8ekeDQkNacQYhA6IKO
         0rHZuBXwAke6tqomTNYQsdThwDv1LBeb1x7hDit7QKtvi6nwfoc3BAYGUrVXwg9QNVwU
         6vYIEMjYU17LaHu0SAsyVKCP85LRm6VlMrbsXuCaVYuwSDzadNNSdruuUbIcUxM0FPoc
         rlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296616; x=1688888616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n22j43EkOQDg32COrHKfr3M00AZ/0ZWY6HKFgde4cL8=;
        b=UYIN89IV/YWVGPhEPTKd+1XzpegxgLvObqa1hBdTs1FLoskGP4YQjDmDaPdeyx2EnM
         fEh8MAmhd8qPXgRPivcyHYw0T2kl+hVGH9lUmSfkvcQzIyYkz2XW5D1Uwqi1fdRRTZb0
         d/heLDL1q9/LaA0cexhPSBXb0byXVscsiKW/4DRDYcBZoKzAOAHQyCmXDEEkR56KH0dg
         wRzi8YMgtBiPoeviUS+DxdaHyms6iSJAVwpmcVomfpIM841FieLTsOMiGMmbF9GUVzFf
         jsTx8GIhOZBPK2GNJ4O96EszcGYjF7n76t7a4NGG4N0gm+esXFoyfl0vEcOZB7nGL+Ml
         /+Dw==
X-Gm-Message-State: AC+VfDzATJgytRMwXn3lfqkpaxWfMI9Q8QN9qhN1s1lyoGNXJQZPN7Uo
        ihafNPgISrF+S/hWS05rJxHaeJY1YK/L+5fTZV5ERQ==
X-Google-Smtp-Source: ACHHUZ4eBEjlmR18fNbl1nW/1npGfZv+hNlwu8HcpRXvf1ldNl8UG0FvJt/6U1xP960RjSZ6O50bzJ9dAxYnYf2TcFA=
X-Received: by 2002:a25:11c6:0:b0:bac:ada7:140e with SMTP id
 189-20020a2511c6000000b00bacada7140emr1128433ybr.9.1686296616503; Fri, 09 Jun
 2023 00:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230607095829.1345-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230607095829.1345-1-jiasheng@iscas.ac.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:43:25 +0200
Message-ID: <CACRpkdYtQVcR_uw=wqeVtF+emDjS6rbFqB0RWPvNm8V7gB74Pw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: npcm7xx: Add missing check for ioremap
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 11:58=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.c=
n> wrote:

> Add check for ioremap() and return the error if it fails in order to
> guarantee the success of ioremap().
>
> Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driv=
er")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Patch applied as nonurgent fix.

Yours,
Linus Walleij
