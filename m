Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273E70FBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjEXQi5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjEXQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:38:55 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31FE9;
        Wed, 24 May 2023 09:38:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9739440b60bso7890966b.0;
        Wed, 24 May 2023 09:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946332; x=1687538332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C02MeIwQdNrwFQOvJ+pcAUppiGgc5dW7CdevAd4vdUk=;
        b=BsjwOJLIryTIyvXhJuOuw90G8QRzlNlPJsMsoG5Gyv5LTz1WeCac43aEtfmVWkd/vc
         EIu379W3uqPHZYalAvWWasnv8IqkJAlxohGf7EppHJ2z+Al4jKfGL1OOyAd3XemijNdf
         hMgmPdQ9CpTpyfW+xR/5I9bNPYYHMC1LXG2cHyo+lGJdvAPPRQ6GK2mvFEY4DVX2a+f0
         7Sjqvaao1saTpsWwE5jRb6MX7MwcWvz8A8T61UXUqfulDP9EQDwa6PwXwtx5XrOsq2J0
         X2pFNt2bXjQL5XskS6Yn61NSWKGrUGjtHkAC9Mm88ktxvvBJnstIBFjJYKgvrvt/VA+j
         6+xQ==
X-Gm-Message-State: AC+VfDwiY6o/wQakwM4RH6y0RJq4yipBVDswQ5/733e7Eqhhk6yABTfm
        BCHG7rAUXCkoeZuiykfTNjYDAy9ZW9VmJARt+pU=
X-Google-Smtp-Source: ACHHUZ7E0a2P+VolsTST++i+uFAwZwlCSQUa6OiN8Tdhq5fOeJaXxi9FQM3qOnqgxQqZBURXj3cbAkPmJXlgoZCxa+8=
X-Received: by 2002:a17:906:5199:b0:965:9602:3ee1 with SMTP id
 y25-20020a170906519900b0096596023ee1mr15583280ejk.2.1684946331935; Wed, 24
 May 2023 09:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230418130743.67024-1-n.zhandarovich@fintech.ru> <CAPDyKFqC6eCMCjg4n_pRi9oJrkBfJuUT3Hpm=3C93dmU5E1muA@mail.gmail.com>
In-Reply-To: <CAPDyKFqC6eCMCjg4n_pRi9oJrkBfJuUT3Hpm=3C93dmU5E1muA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 18:38:40 +0200
Message-ID: <CAJZ5v0gx7bD9EZKPQWyAAZ6hSKjK4hr-nkrJu84HEK-g2AMAaw@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix integer overflow issues in genpd_parse_state()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 12:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 18 Apr 2023 at 15:07, Nikita Zhandarovich
> <n.zhandarovich@fintech.ru> wrote:
> >
> > Currently, while calculating residency and latency values, right
> > operands may overflow if resulting values are big enough.
> >
> > To prevent this, albeit unlikely case, play it safe and convert
> > right operands to left ones' type s64.
> >
> > Found by Linux Verification Center (linuxtesting.org) with static
> > analysis tool SVACE.
> >
> > Fixes: 30f604283e05 ("PM / Domains: Allow domain power states to be read from DT")
> > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 6.5 material, thanks!

And sorry for the delay.
