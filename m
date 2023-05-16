Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D5704F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjEPNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjEPNgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:36:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E273C06
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:36:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso7001597276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684244178; x=1686836178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kw2XhlC/7gIxELDOfYBdc9PGcEEycsb3Zy+tPUBc1s=;
        b=e0leZ4Koa7zxJ9mkmRBjcVNCMNMFj1RjbK6AJMvkxdiHH50ZM1eSzxr7fMF+QBFXxJ
         l12z5RmyyJvLcn9Agj7JQ0YxaVK3zVQ7b0miAM4+rCqx4jOeVgck/oIniiEX8V4/aCRs
         CbI7GdAoPe967LLE14IxV5AVbKmlC+q6y5s84vnCH556ioLBb3a+HMZ/NzyAzkEUZQJ+
         ZaRffcvpa40aoaub+KwLRTc6pTLB9r9O0oJ4LkKcJQE3Xd/PEkClo7+VRjHNx4hrWLJ+
         GSIGqnaCFhFjM3jABoJbxOzf6K/b74hCEbGSqrOjAU68BcssARyN0gNpxHJx/4ulqJG6
         oNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244178; x=1686836178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kw2XhlC/7gIxELDOfYBdc9PGcEEycsb3Zy+tPUBc1s=;
        b=RIPfFDQYl9RszaaqAjScChwJmvkfNxP2AMmNUCdvgZuexthNphfnT5UExvVXlZw4cD
         Ji9bOu/zSzSxCD8N/neIOPBYkkt4TCJxbKqUhj7eciFLeTvimmrp70qJo6uXCcx+BYuH
         pOQmr5QzLO/V/5OB2fTcL9pkrXOSKYc40HWhzpLEnTRFnbFh8BFVyuJ2h1xhOid5sUgs
         75jdTPDiq0MQBJiIh7ChV5ro+jZ0VXjrtsIqU99Mw7MPT3JplBCti+qeuL4IfQY6UvDT
         HZi1Ax7ahG+/zYyhMZeaSSk0Iw6ifnc1/4dSuvMH/fgoqPwyYEnMRoaEgraC0kHI4k+R
         j87w==
X-Gm-Message-State: AC+VfDwtU7DijTItyFua8ZGxHTpekkqnfHEJZbBPJebnIRsYnpzl7hus
        RyLCwv/CplHpxUOPZd4H93mk+i6ubMhWrEQrcV2kUQ==
X-Google-Smtp-Source: ACHHUZ5ZO0ESgUAWYPDk09uXubuzl17fPsG/3ycyI3b52T+XksF2qZqLzvb4Pa3utTG4VRrGHV1HvIm9pi7C90s+zOw=
X-Received: by 2002:a81:5442:0:b0:55c:edbb:8e1c with SMTP id
 i63-20020a815442000000b0055cedbb8e1cmr32245409ywb.27.1684244178250; Tue, 16
 May 2023 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174408.494811-1-afd@ti.com>
In-Reply-To: <20230515174408.494811-1-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 15:36:07 +0200
Message-ID: <CACRpkdYEpGBT+GjAdUH1fMsd3S1sd_b_FjK2i_0a5bNS4Qv7OQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: tpic2810: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 7:44=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:

> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
