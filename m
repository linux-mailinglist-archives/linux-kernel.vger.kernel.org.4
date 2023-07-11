Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51B674F32B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGKPRB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKPQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:16:57 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA766A0;
        Tue, 11 Jul 2023 08:16:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579e5d54e68so68961387b3.1;
        Tue, 11 Jul 2023 08:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088616; x=1691680616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rp97t0SvD8s0Who/ua4azUvnOtZZ5RKlcFsre7+/tw=;
        b=PjTePUAZDZ0OPOG0z3dRT/Fm+WDPGZQ4hmSPrpSza6zPz6IH38xFao5oNusgnJeg7t
         uJ3ocxuHhNoza+UH/nIGlPrSx5uWvWEFESDq3PjPSLeSX3wOM4RiLNawNxaIKe2S4dNw
         Ua35zTtq6s7ijfVsg6kN/xnklaW4YIFA2sgwnSCwRXRBcAa08sKcSv3GEtGdrmod8CrU
         kkcBnK8qzKZUCAM9ylByOl+8YR4nzJVRgpTuiVZR5iuprhmV1yy1kUBdPrn2H7eASa3h
         S9NkPv68Efq56GUgecHkTlASTZAakN/QmvLuj5iLavvkx3BEjwQI6qCYMSDwnmhu6x/O
         G7sA==
X-Gm-Message-State: ABy/qLYR0yCc9o42H1ctlmTxdFt7PrGy6iOhproS0nLtprFpiq+b4wC8
        6iDgkwpfUBcW8d0MNT5gwNotWtACjyjtsg==
X-Google-Smtp-Source: APBJJlFkLS2Qz62XP3sReL988oxSMjFe0SGyWYOrproFPt4U60NPM3VmCuRgEbjHdak4yeRsBinsgw==
X-Received: by 2002:a81:5303:0:b0:57a:6e41:948e with SMTP id h3-20020a815303000000b0057a6e41948emr10091943ywb.11.1689088615700;
        Tue, 11 Jul 2023 08:16:55 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id r186-20020a8181c3000000b0056d3d7a59cesm619774ywf.12.2023.07.11.08.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 08:16:55 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so6800350276.2;
        Tue, 11 Jul 2023 08:16:54 -0700 (PDT)
X-Received: by 2002:a25:cd85:0:b0:c60:fb80:99f7 with SMTP id
 d127-20020a25cd85000000b00c60fb8099f7mr13925299ybf.16.1689088612983; Tue, 11
 Jul 2023 08:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230710142227.965586663@linuxfoundation.org>
In-Reply-To: <20230710142227.965586663@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jul 2023 17:16:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcZ2W7o42ZAdMHfPYZ9d0MCRat_PKWoh=JDHK=m=dM1g@mail.gmail.com>
Message-ID: <CAMuHMdVcZ2W7o42ZAdMHfPYZ9d0MCRat_PKWoh=JDHK=m=dM1g@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/424] 6.3.13-rc4 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
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

Hi Greg,

On Mon, Jul 10, 2023 at 4:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 424 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Jul 2023 14:21:05 +0000.
> Anything received after that time might be too late.

> Zhanhao Hu <zero12113@hust.edu.cn>
>     clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe

This commit was flagged to contain a bug by two reporters almost 4 weeks
ago, but no one took any action. Hence I have sent a fix
https://lore.kernel.org/all/20230711150812.3562221-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
