Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4552A72CD1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjFLRnj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjFLRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:43:35 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023C10D8;
        Mon, 12 Jun 2023 10:43:32 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-974539fd9f0so90599366b.0;
        Mon, 12 Jun 2023 10:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591810; x=1689183810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYgR5nhDdiJqEt5pcKq1yS5d2OMv5QXdG3YbAcYBSDM=;
        b=ZYLfKd33Ahmm1d17XHAx+fjFlNI9bJjS1Ob/HSGkYNLp++DniPGee7K+45UAgyojRB
         bEz3J5+zwGogw04O4oUzGJMIDPCtCjddeM0NYTMMKKSxF8V9mmEIam3xzFcsTGYv9oNX
         mGsYe7Z5C/NZyyW2EYHS9do7nyKE6Pq5CJo8BkD5OqtOn/S5XM+1qQBw/wIX3XVIgVsT
         DtmMyIkzWuSwHNbgQh0XvsDaNox7sN2Bp+EbSfUOUe0vhxUV/w5roUWdKqnsbrrYjevy
         icaTI2v8RUUGfDAq74eUwG19Ji6lUgAAbMLQh6xporbeXmqg2PXCOJETq8c4PnSeA70/
         SFMQ==
X-Gm-Message-State: AC+VfDzcvd65fktlH1EGzdsI9leirZh4FKj8Pnrx7ARoFcT3BHs6lsIT
        9RkhbVwijmbpWuTW4ZPceqdveXdCZbLNPaL+U4o=
X-Google-Smtp-Source: ACHHUZ6MMjBs8FmD68ZIaJWus2HTgfbsYkWlMOyf0sDaOjoXLWJBzjaCHTN62Mw8MBKC2rTmGyz6x8JYIUKaGP1v1r0=
X-Received: by 2002:a17:906:748a:b0:975:bb7:5dc3 with SMTP id
 e10-20020a170906748a00b009750bb75dc3mr8451381ejl.7.1686591810435; Mon, 12 Jun
 2023 10:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230609124408.3788680-1-thierry.reding@gmail.com> <3c501536-2620-0022-df93-415d490fc1a5@linaro.org>
In-Reply-To: <3c501536-2620-0022-df93-415d490fc1a5@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:43:19 +0200
Message-ID: <CAJZ5v0jwZt3HOJi3sBGR50G01K+pHSAsJd1UVBfZofpWBAvnVA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Allow selecting the bang-bang governor as default
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 11:07 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Thierry,
>
> On 09/06/2023 14:44, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > For many setups the bang-bang governor is exactly what we want. Many
> > ARM SoC-based devices use fans to cool down the entire SoC and that
> > works well only with the bang-bang governor because it uses the
> > hysteresis in order to let the fan run for a while to cool the SoC
> > down below the trip point before switching it off again.
>
> Yeah, that trip point detection is screwed up at the moment, but we are
> on the way to solve that. From there, we should be able to have the
> step_wise governor working as the bang-bang governor and remove this one.
>
> Meanwhile, the change sounds ok for me.
>
> Rafael, may I pick this change?

Please do, thank you!
