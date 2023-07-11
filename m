Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521A974F7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGKSPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGKSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:15:49 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4A170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:15:47 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-794c5f5ae8aso2037617241.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689099347; x=1691691347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfotGvrJWw1Q4fBFpAI6RE8Xtp8q8CfVXC4ZXkRp/xM=;
        b=mGb2UnqK/ewNSnvAPeiihZoNq+zqjw0W1J9SHdq1lz5LCibCRwJPt3yZiFGS8aI9xQ
         HWccOWNzO5EmmG/W5bO2Y0Ozf7SMnPg08i8oJgJQ8E+XwRJiAdVDvR4o90NzVHhVKK2e
         CvbN9Zdm6UqPaux110crVEWjGlNcSb1sxIAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099347; x=1691691347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfotGvrJWw1Q4fBFpAI6RE8Xtp8q8CfVXC4ZXkRp/xM=;
        b=VHoya16/H5mcqvcupdDaV7ZrGEX1FaDLg5S6WZsiz1sLImuid2oaZFKtxeeCfK4Ztc
         Asmk8M/6DNGd5mgzNx/N2QpF4kxrnDiRZaCyS/r65pAORngnCu79mzsO0ZFlj3xZPvhL
         aUjAeLneOpaUn+BEkSax7EEmJriN+GozsHnrFLhu6wIzGhj+PM9dtqH89+/s2+WwRd2e
         otm7/7OAJzs4AURek8kRJrkUV8UC4Y8mTR+AKdCKov1RTZPr7Nm88JNoNWQrKRViL2kZ
         eJXHqvsW3/u7VXBSfFvwF/ulDPcGvD8lAn6jW2pA/fRAArbpChiDklOlIack1BbW8S/W
         sAXw==
X-Gm-Message-State: ABy/qLYn3drSXag1WMN5xCb5mVajZq0bRjMQVkm/CyipE4Pdo4LYNa4u
        zvHWYXRBnhGwRktwkFLIeM7ftjm3lkZa3MenL0g=
X-Google-Smtp-Source: APBJJlHiYKX2yXAPE+QWKgzOwu5PakcviV0RZIYx0L+BopzUp7Yp+qYYM5FEX+TfBkUbOEPxquCw3Q==
X-Received: by 2002:a67:ecd3:0:b0:445:1e73:3742 with SMTP id i19-20020a67ecd3000000b004451e733742mr7953495vsp.4.1689099346850;
        Tue, 11 Jul 2023 11:15:46 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id h13-20020a67b70d000000b00439320b7c23sm337006vsf.22.2023.07.11.11.15.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 11:15:46 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-47ec8c9d7a0so1031767e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:15:45 -0700 (PDT)
X-Received: by 2002:a67:ff8c:0:b0:443:7bbc:e397 with SMTP id
 v12-20020a67ff8c000000b004437bbce397mr9315911vsq.26.1689099345463; Tue, 11
 Jul 2023 11:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <20230708174832.0af1d974cf67805dfc8ad655@linux-foundation.org>
In-Reply-To: <20230708174832.0af1d974cf67805dfc8ad655@linux-foundation.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 11 Jul 2023 12:15:34 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CUjYHuP126wUtAw6iz7=qF+gUxdHYnOsg_o7XGt1MQsw@mail.gmail.com>
Message-ID: <CAHQZ30CUjYHuP126wUtAw6iz7=qF+gUxdHYnOsg_o7XGt1MQsw@mail.gmail.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 6:48=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri,  7 Jul 2023 19:17:25 -0600 Raul E Rangel <rrangel@chromium.org> w=
rote:
>
> > Right now we are proxying the `console=3DXXX` command line args to the
> > param_setup_earlycon. This is done because the following are
> > equivalent:
> >
> >     console=3Duart[8250],mmio,<addr>[,options]
> >     earlycon=3Duart[8250],mmio,<addr>[,options]
> >
> > In addition, when `earlycon=3D` or just `earlycon` is specified on the
> > command line, we look at the SPCR table or the DT to extract the device
> > options.
> >
> > When `console=3D` is specified on the command line, it's intention is t=
o
> > disable the console. Right now since we are proxying the `console=3D`
> > flag to the earlycon handler, we enable the earlycon_acpi_spcr_enable
> > variable when an SPCR table is present. This means that we
> > inadvertently enable the earlycon.
> >
> > This change makes it so we only proxy the console=3D command if it's
> > value is not empty. This way we can correctly handle both cases.
> >
>
> I hope someone understands this ;)

Is there a more specific list I should send this patch too?

>
> Please "grep -r earlycon Documentation" and check for suitable places
> to update our documentation.
>

The documentation is correct, this just makes the code match the
documentation :)
