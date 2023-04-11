Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9216DE5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDKUqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKUqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:46:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94BF107
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:46:41 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d204so1226687ybh.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681246001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po1MCvCf5OQxV9nwlMwg/r9Glz6To+YmkbTBIFPIgs0=;
        b=sKxLGyKycdzz5MFSp3E9IS9EFd871Flxvh5NgsRmglRJUNfboQvxQXEAgRXu72Yvhy
         fFNhYQjMTTRhOE9gg1nsJW7Wt/e2tOQjxD/3Q/mVJ0sI4oFzHI99QI0G1hBhVD85NKJW
         EUwdO/DJC4ma7K9HNSstSQ5jBNqRgo+QfF82z1c3+T9xDLmEiFMQJYobLaaF4SonVWex
         2psED3f9soFbJHgsHhhnJqs19HWpTqJfSsqioJ4+Lz4MXgv46dClH1hmQerMR3QQeIoH
         wVhuYb23x0s8GBSPj14Ehx1/mMuoscqJ1MwKLd2FkdIB4uL9WQ/jtM35/6FkEe+Gj0Mc
         5+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681246001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po1MCvCf5OQxV9nwlMwg/r9Glz6To+YmkbTBIFPIgs0=;
        b=pQKozCvDA/vynbkPLOdw4t5pUQaN+AvMr+opgdGW9GkzbowIXppCw9C9p0DuEg/0Sx
         O6JBjI4QN2XZ1r0tse06gXv/GFBMgl8UERCDiKPbb8D2lfMDbP1OGZB2a5KPli6N7wbi
         48xgpSuRVTGTblsE4q4fir9fse6aRk8UXFadDI0cx1HuC8ekj0CeKH0ezjcgZIwFnyn1
         dUbot/sn+EJudrurekdT5EMeuOVLjFwdEQwcV0hoZHGb9DTJhtHifWpdBlU1xor/gAUk
         YC+qCDjh3E8AuS+OoQKQsa2UkMwrS6XZq+vkJjUPqokUpOPpEn642RHIE5nlYBNri5JD
         E+hQ==
X-Gm-Message-State: AAQBX9fAvFjDqc0jklHYTUZaW5dZp+G+rp+kqni6FM+W37xg0wiJdRxV
        JRUF8G0OAnePX0/OkH67NajAnpZOGRDlGRQTcEQCbA==
X-Google-Smtp-Source: AKy350YMuCQT9UcSmIL1nhQvQq2Ll1FqF/WxgWvjJpN6Rile4v8m1nTnvcOubzCK97qgvWJYmwW7yO33QW3BU/M4WOQ=
X-Received: by 2002:a25:df4a:0:b0:b8b:eda6:27c7 with SMTP id
 w71-20020a25df4a000000b00b8beda627c7mr7883592ybg.4.1681246001137; Tue, 11 Apr
 2023 13:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230411134932.292287-1-korneld@chromium.org>
In-Reply-To: <20230411134932.292287-1-korneld@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 11 Apr 2023 22:46:30 +0200
Message-ID: <CACRpkdbJxU_Z=Zyc+y1mYW+D6gnqBrzMYph1DMiZKsBsGtBGJQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "pinctrl: amd: Disable and mask interrupts on resume"
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com,
        Gong Richard <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 3:49=E2=80=AFPM Kornel Dul=C4=99ba <korneld@chromiu=
m.org> wrote:

> This reverts commit b26cd9325be4c1fcd331b77f10acb627c560d4d7.
>
> This patch introduces a regression on Lenovo Z13, which can't wake
> from the lid with it applied; and some unspecified AMD based Dell
> platforms are unable to wake from hitting the power button
>
> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>

Patch applied for fixes, pushing for linux-next and will then relay
this to Torvalds.

Yours,
Linus Walleij
