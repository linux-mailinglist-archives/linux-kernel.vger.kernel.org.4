Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EFE743B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjF3LwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF3LwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:52:00 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307153A98
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:51:59 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57023c9be80so17976937b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688125918; x=1690717918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kxPMZoEb+z7y9xiddQ1zRKvH8TZFy8Uki9e/0Z3Fys=;
        b=rWV3TQA8uRadh+hGwmCGKrnAWcrxulnSBr4I7cgoMyxIqrcwmeaBSTiRf51qg6RfQT
         bEoBM1HulkxbBIPj0JLfCY57jVeIVAUXe5LM1DLR81IfnxYv1zk3DB6MG6soNvitNEEJ
         PsuT0X7p7S5WulHUdLiuxnx13PtM/+1vpxfLwb4sMcmLRlosbalUlKc5Ev/64bZNMta5
         THHcYSuAkwT46vNP8l5jkOB2f0LwvnlrnVtaxVeJVGZBPKPCn9fu4uDzQMzM7swDZ1Vd
         eQW524AW7As2oLup1b6UTKdX32QQFf2U93ciBWPjB7vzAwPHbs9JZh0tMweYyVcA/zJu
         unOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125918; x=1690717918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kxPMZoEb+z7y9xiddQ1zRKvH8TZFy8Uki9e/0Z3Fys=;
        b=kw/b0uBCqGDVU8nMrUMHreQ0bFBymlczKJVkycnBENLQ58e86AcnZYMXkzklSKnLGf
         uFhvV167GwXMcpUBFxNVsVeyQMPB++mbIAHHRdiUAsY/LDCnAqdn3Hpa0e1/P4v3zlH1
         RhYIBLHruohseQDNLx6SZgEU54vlAudLHyFuDWo3ZzxIMs99rv9pCY8dMgtsikEwrsH5
         L+YyJo6jJBLuWueR7lhlXGKiZtbIaucYrtAVkudoqA6dPxTWCqYgtDuExKfplwkSJkjf
         C8Sn9Z11gk94szshrAMedMLLv/D2/Nu1gWWheYyha4j0Bd039YmJbijqMBlO+rZhokHA
         fZdA==
X-Gm-Message-State: ABy/qLZLRYrf96nO25Pdw0vJ6c6iDjDQUmXuDvewgmOUOWP4qO8PXNPe
        sOxs39Rmgv3xMG+5R6B5QRxDsnq5sIzYtudRTo6A2A==
X-Google-Smtp-Source: APBJJlE76ldGEzRnOrLOgBjYmwgRtIZr3DBybBE8k4x/w+xHyhrLPHBqx3ONPQ5e7vEbf3Sd1Ln839+o2wRpXW/0ulY=
X-Received: by 2002:a25:ce8c:0:b0:c18:bbaa:754 with SMTP id
 x134-20020a25ce8c000000b00c18bbaa0754mr2301177ybe.51.1688125918415; Fri, 30
 Jun 2023 04:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com> <20230621174943.30302-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230621174943.30302-5-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jun 2023 13:51:47 +0200
Message-ID: <CACRpkdbOoDKZRF+8cys6FAf4Yy=v7UokPAmUp9mSkVnbqsH2tw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] gpiolib: Replace open coded gpiochip_irqchip_add_allocated_domain()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
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

On Wed, Jun 21, 2023 at 7:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Replace open coded variant of gpiochip_irqchip_add_allocated_domain()
> in gpiochip_add_irqchip().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

and this concludes patches 4,5 very nicely as well.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
