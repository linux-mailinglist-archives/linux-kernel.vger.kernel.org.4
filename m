Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D876A898E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCBTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:38:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6821FEA;
        Thu,  2 Mar 2023 11:38:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C725361642;
        Thu,  2 Mar 2023 19:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EFFC4339C;
        Thu,  2 Mar 2023 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677785888;
        bh=OwB+3XfZc2i42C5aZfJlWvgZsNqnG1TajYYk4Tqce0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dM7iCk4GESFgO7/GKgncJQ45ojgnOsk6O7X51HFcUN2QFVzFSwzjlnBM1fr3e0GKR
         zkrwIdnUzmxZmpBh45bjPRSMSjIAyKI9LmuivP84LFFAhatpJqFQJatxM5CmoAO+ZI
         q/2WEhsBTsG0el8rL4iks5IkCV+vw8kQy79X1F/NYqI3LEzrkXg9muLQ8LeoQ3jJ1j
         au2WJDs2zmRCVmF/o/9+k0E3olUF1d6Af2MqrPJjRu6q/WbgBXmjoHwcT/BoSaZEAf
         U9E8FPGCNYSNirEnXMq0bbQVfYXlNTLSY165B+4vv3UCYNwD5N/6brTWBhUUre0AlH
         Fxder5gVhWfdw==
Received: by mail-ua1-f48.google.com with SMTP id x1so82912uav.9;
        Thu, 02 Mar 2023 11:38:08 -0800 (PST)
X-Gm-Message-State: AO0yUKXfJORkk08EdDeBv525Q9ifcO61NAhvpI2S1enoiSKSmMG92PEb
        NwLnOjO5zwUTXoZGjT1LD8juwuNuQslByawf+Q==
X-Google-Smtp-Source: AK7set9lyn00Q1i05eh6fNXilq1IfTL9R/2RHvpC+p+smuMyxf3GQ5zh5P/zWXTMVD45PfuVAi9rjjGShbS50wU/j+E=
X-Received: by 2002:ab0:1059:0:b0:68b:8665:a73b with SMTP id
 g25-20020ab01059000000b0068b8665a73bmr6760746uab.1.1677785887108; Thu, 02 Mar
 2023 11:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20230301152239.531194-1-miquel.raynal@bootlin.com> <20230301152239.531194-3-miquel.raynal@bootlin.com>
In-Reply-To: <20230301152239.531194-3-miquel.raynal@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Mar 2023 13:37:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE43qfYzHUuCJsbaPPBTbYX05Q7FFmPTjPFZ3Dmz_mXg@mail.gmail.com>
Message-ID: <CAL_JsqJE43qfYzHUuCJsbaPPBTbYX05Q7FFmPTjPFZ3Dmz_mXg@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Change of_device_get_modalias() main argument
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 9:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> This function needs "struct device_node" to work, but for convenience
> the author and only user of this helper did use a "struct device". As
> this helper is a static helper, let's keep the "struct device" for
> exported methods and use the OF structure internally.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 877f50379fab..3efc17de1d57 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -248,7 +248,7 @@ const void *of_device_get_match_data(const struct dev=
ice *dev)
>  }
>  EXPORT_SYMBOL(of_device_get_match_data);
>
> -static ssize_t of_device_get_modalias(struct device *dev, char *str, ssi=
ze_t len)
> +static ssize_t of_device_get_modalias(struct device_node *np, char *str,=
 ssize_t len)

Humm, this is static so fine here, but based on my comments on patch
3, it would need to move too as base.c having a dependency on device.c
is backwards.

How about moving everything module related to drivers/of/module.c. Put
the new functions in of.h (rather than an of_module.h). Then maybe the
rest of device.c could move to inline wrappers or elsewhere.

Rob
