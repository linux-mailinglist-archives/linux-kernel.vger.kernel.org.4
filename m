Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B76ACEB8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCFUAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCFUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:00:35 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF617D547;
        Mon,  6 Mar 2023 12:00:06 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bl39so3639673qkb.10;
        Mon, 06 Mar 2023 12:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678132805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOHJOzqPvQPks7ewcZEge43RgKk8xjbbGR/W6FZli4o=;
        b=n/CS1HG5g9PNCu3723xgx5TZttbLnMrfbsw+b0TMdjyaRVLYozddRpSAaKI0TiK0Yu
         RHmKKiUAB9bjrubIKG/ue281pgYg3va5N7frVWd0nFBC7f59S4XnWPg9SQQsu+TAfHg+
         XuweGm/37wlKHIMWCN8r8btL1VsPl/WBTtUW4i4wSkhIN6XZ6qVlbXTlQoCB7wLbfL46
         hDwrhl6YHfvrHEZW0QgISAwEOEmOyESvqQ6+IAntIMTZqI6eBQ+v0JjIm9k/O1gl66Tg
         N7JgRKkqPgZoftg9cEZtb9sbWsnFojknM5kFYRy9CSyDbXEuFAJzv1JdSy/aqBSSaN5y
         Nk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOHJOzqPvQPks7ewcZEge43RgKk8xjbbGR/W6FZli4o=;
        b=b73z8Lk5i03vkAiLk6dxVL3c1BMNe1bHjYHxPglcdWNoPnxZuk56hBKA6VV1LGSCMt
         V6HMRjIM6FGuRzovPHtdqo+b6D8ZuCmjaJ7AIROdF9JxseKpMQ4Hjriua07F1wzaRvkD
         5q2dFm9mp5PN3jyO1SduOCbX/1EYXGLtFPJ7QfpWNaLC7tiLrh6/8TcpfA3nIQeOOr0l
         EeMNvzomMbGACyeG1GCrCwtXSPihhrNCgVqLffV7bfGH1YF2pXBoZZa2KSY1bSvkO9eg
         2JK1SkNpaEFdoFFlkHr9B9TDxUFjlWqR1Nex/mp0uSyKn+sMwsUzo1hnxtLu6uyU2Tg+
         h3Yg==
X-Gm-Message-State: AO0yUKVzZjGZ9FFOcmvY5Ham7BOJGamvju9sjromDNlIOO+hwhFRZS/R
        yvayot/qAF9XUfZyL/FWxEnDQQIBscDBrUF0jv0=
X-Google-Smtp-Source: AK7set80n5xFsKwOyX/PqUToJxUafo7yFE3/DjxPH/ROkBXEXcxDkrr4pDX3fsHyFCEHodiU6XFkw+iu9YZlHvFtFt4=
X-Received: by 2002:ae9:eb4e:0:b0:71f:b908:7b7e with SMTP id
 b75-20020ae9eb4e000000b0071fb9087b7emr2936826qkg.10.1678132805183; Mon, 06
 Mar 2023 12:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20230306040739.51488-1-blarson@amd.com> <20230306040739.51488-11-blarson@amd.com>
 <20230306160017.ptd3ogundxvus5zm@mobilestation>
In-Reply-To: <20230306160017.ptd3ogundxvus5zm@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Mar 2023 21:59:29 +0200
Message-ID: <CAHp75VfFMiy35Q1bX3Az3HgkhK+4bfH+pCE2XwOYVpqT8UiFXA@mail.gmail.com>
Subject: Re: [PATCH v10 10/15] spi: dw: Add support for AMD Pensando Elba SoC
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Brad Larson <blarson@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 6:00 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Sun, Mar 05, 2023 at 08:07:34PM -0800, Brad Larson wrote:

...

> > -     node = of_parse_phandle(np, syscon_name, 0);
>
>         node = of_parse_phandle(dev_of_node(pdev->dev), syscon_name, 0);

Side note: I would rather see syscon_fwnode_to_regmap() instead of
this. And IIRC syscon already has an API to find by name.

> > +     if (!node)
>
> > +             return dev_err_probe(&pdev->dev, -ENODEV, "failed to find %s\n",
> > +                                  syscon_name);
>
> Hm, using dev_err_probe() with known error value seems overkill.

It's allowed use and it helps to drop a few unnecessary lines of code.

> > +     syscon = syscon_node_to_regmap(node);
> > +     if (IS_ERR(syscon))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
> > +                                  "syscon regmap lookup failed\n");

-- 
With Best Regards,
Andy Shevchenko
