Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0F6A893F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCBTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCBTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:13:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFAB462;
        Thu,  2 Mar 2023 11:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97FDDB815AA;
        Thu,  2 Mar 2023 19:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B44C4339C;
        Thu,  2 Mar 2023 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677784406;
        bh=FtcR9aIBdsTKKWp8Btl6rUSNdt+mDwclTbxn8UZFT5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jRdwj79BFpo/1FJXIJWv7JSEfNvbrmtXYgFNUEDMuMXRKatejDNGDxN2WKWGMQgbD
         fbEeIiLpp50tKciokYidWgsvmrgRwwFS92pE3ZPPuGSePkZSfcUTBgjTIF+JiHfh9n
         8TfUmRltsYTU51qZvdGuN8XZeIkcYSAG0jeEPwHQAjrHIAfTVw3BRvhMojFFWGX02l
         nedWi9oKTsGLO6H/z76/lmkoJRVJmr8D4WB7CTGgBTl7gLJ4yi5NQUeWAoeINsCNYe
         KIKFFMp/TxH6kTvUbNmrvZMHwII3UwTqjLPA8bPHPfgnOGT387OErxtf6TQKur3peN
         DK+SOuhE7S6EQ==
Received: by mail-vs1-f51.google.com with SMTP id f13so273370vsg.6;
        Thu, 02 Mar 2023 11:13:26 -0800 (PST)
X-Gm-Message-State: AO0yUKXjnTEPdJRuU9bLvhDZnScTBue/Kurosym0BDQZIiehtWFs+rLv
        fAR1PUnxCttpKtN/p7wpbqmwam1eXpGiGTRjgA==
X-Google-Smtp-Source: AK7set+KeI9Jw3J2dM5zHlcQLdCwQFRbNcDR2tw+ktWE5ZKLnQNE2nVhJ9VVFQZRpBjBTihbqllLGFMe1SU8Jx6BclY=
X-Received: by 2002:a67:d30a:0:b0:415:74b4:6067 with SMTP id
 a10-20020a67d30a000000b0041574b46067mr7557996vsj.6.1677784405177; Thu, 02 Mar
 2023 11:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20230301152239.531194-1-miquel.raynal@bootlin.com> <20230301152239.531194-4-miquel.raynal@bootlin.com>
In-Reply-To: <20230301152239.531194-4-miquel.raynal@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Mar 2023 13:13:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsYeJz4M4v_NehyDqLHOHmArNgad4HDhYGN7RucHsv+A@mail.gmail.com>
Message-ID: <CAL_JsqKsYeJz4M4v_NehyDqLHOHmArNgad4HDhYGN7RucHsv+A@mail.gmail.com>
Subject: Re: [PATCH 3/8] of: Create an of_device_request_module() receiving an
 OF node
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 9:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> of_device_request_module() currently receives a "struct device" as main
> argument, but the only use of this pointer is to access its .of_node
> member. In practice, this function only needs a "struct
> device_node". Let's move the logic into another helper which would
> receive a "struct device_node" instead, and use that new helper from the
> ancient of_device_request_module(). Exporting this new function will be
> useful to request module loading when the "struct device" is not
> available.

of_device.h is for things that operate on struct device, so
of_device_request_module() doesn't really belong here.

I wouldn't really care, but we have this ~12 year old line in of_device.h:

#include <linux/of_platform.h> /* temporary until merge */

I started working on a very churny series to fix this only to wonder
if a header split by consumer would be better. Anyways, concrete
suggestions below...

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c       | 17 +++++++++++++----
>  include/linux/of_device.h |  6 ++++++
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 3efc17de1d57..7cdf252b9526 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -284,16 +284,16 @@ static ssize_t of_device_get_modalias(struct device=
_node *np, char *str, ssize_t
>         return tsize;
>  }
>
> -int of_device_request_module(struct device *dev)
> +int of_device_node_request_module(struct device_node *np)'

We use 'device_node' pretty much nowhere in the DT APIs. Just
of_request_module() and define in of.h. There is only one user of
of_device_request_module, so remove it and update the user to use
of_request_module() (and hopefully drop of_device.h for it).

Rob
