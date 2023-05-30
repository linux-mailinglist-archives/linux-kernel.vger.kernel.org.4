Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84351715D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjE3Ldo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjE3Ldm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:33:42 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23410B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:33:41 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565cd2fc9acso40504617b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685446420; x=1688038420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO/hEIm/6vFm+Ve2jfklUx8YwRrMLFv0UwuU9t+2qT8=;
        b=AMemBWUvnvX0G0MDmnf8f/zVF0q9PNYTQ6bTUriXGy7KkrQEgnontw/Rtf9Mdm+nKw
         neUaH++nwf7A4ncvxc5inevGIC7S/TnIYxNRnPAHuSAXyfgOp4pgUO+u8Bth0LoTiHcd
         93M2sORUXM35A4h2G54YotHEcuxq9Z0jmGtIxq5n6F3AMMYVN15L97TB5woGOoQk/dfl
         Z2ETVLE9UNJ18AvVV6ozW5UcamPts81RLcS8ZaiJt2yrv3nj4LlD/SaxHrChTv4qXCF6
         aBvSSCdzK+qBAXqwWR89gVfFH0fV44QxViYHFTmWkGvpZVxFVvj86Jw3R89tpkgA/588
         6mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446420; x=1688038420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO/hEIm/6vFm+Ve2jfklUx8YwRrMLFv0UwuU9t+2qT8=;
        b=OUSDPe4SoPBp4psK3hPfnNb4BXShzLwGUXvzm8Todqvodu9/t/9EO4yMZSFNzDaBJH
         d3fpXZ2teq+SHVRaLO6quuXi0+ZzLJi6YE2OMaj2K81rBi6A5HcB+GEBRbB+ahag3SaD
         qlSUOSHhUPcxtZwKqMiSt8E9yRDANDqgi4FCCv83y0DzJpLeIDujJq9wi4knxQjMTVl3
         9xat/x5M/qYt8TNXWZmRmr1ZE4OuJokrByb5+1NAG1ryBt1CoFnLiPbMkapIE9yBYqid
         caYVHUyHngzDOlzWoFCWZHFPwZjpirzhnh5JtDx4zyYS0FUznrT1HoGGlMHGKbx7ZWrC
         xw/w==
X-Gm-Message-State: AC+VfDyp7Ubi/2Kbqrps1h+Ua+sw/lcE6C+MwvRlCS0w2K+bVRgaQ4q9
        xnkqUJrDL2vzAokCgstEP4xUh4d9ubTJ+/N1JWEruA==
X-Google-Smtp-Source: ACHHUZ5OqCG1+FL/F18LVpp4TSjuAEWgttMpiOAuDfgIrf50Bf1rJPTXcD2dr152yi2w5mvi/Cgzm9bpg7BtykybcCI=
X-Received: by 2002:a0d:d741:0:b0:565:dff1:d1e2 with SMTP id
 z62-20020a0dd741000000b00565dff1d1e2mr2408888ywd.18.1685446420350; Tue, 30
 May 2023 04:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230315215027.30685-1-asmaa@nvidia.com> <20230315215027.30685-2-asmaa@nvidia.com>
 <CAHp75VfnNOsfcyLM-UP61CMAF9sLOwMbRkAe5Ljhs2p8F=4Pgw@mail.gmail.com> <CH2PR12MB3895BDF9D79D61420A2F2BA8D7479@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895BDF9D79D61420A2F2BA8D7479@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 13:33:29 +0200
Message-ID: <CACRpkdbN3oa=chsoh8ko74xKBPXA_yh1K07MSaghnMMk5PWYYw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
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

On Fri, May 26, 2023 at 3:49=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:

> Hi Andy, Hi Linus,
>
> I see that the pinctl-mlxbf3.c is in v6.4 kernel but I am not seeing gpio=
-mlxbf3.c, not
> even in Linux next. Do you know when this driver will be integrated?

Bartosz is applying GPIO patches, I am sure he will get around to it once
all things are reviewed, but you need to use the right email address to
him (see MAINTAINERS).

Yours,
Linus Walleij
