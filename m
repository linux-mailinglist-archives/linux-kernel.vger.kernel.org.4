Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60C6C35EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCUPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCUPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:40:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5435B0;
        Tue, 21 Mar 2023 08:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15C82CE1840;
        Tue, 21 Mar 2023 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5A0C433AF;
        Tue, 21 Mar 2023 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679413211;
        bh=4PR9sj6dOBnQvvycf2bJCWoXgcIVXvCNTXI3u8irbUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NfoYbt7cV1cf/Ej8rnuRCJiKV5LeL2B8eI1ZM7Q++lVnlYWH23hLDGvvS7NuNCjgU
         IpiY917ikdxUC8csvPDslhRAEd73Fc5tcYYdMazucIOU1UvWj88mz382mQxeDweXeO
         jWud4VjyGA+XdtfkZnVK+dhcv3gzVO0k3nOWG45j0x0CzLvgF1mLdOWLa/+2l9Pccs
         bOviRRhTzBoLmgCAuvMmdTmYdzZwHbmQcNMCKTBxPAGRSDdIyfSiHYsGVoeFNZ7+lU
         GxWkE63y3gQEgpwqT5vpNQ0yMm1+ikSwUFsLNjPAD3bkDz2MilrNkZppLB+MWVF5iP
         t/fUHiwC60FBA==
Received: by mail-yb1-f172.google.com with SMTP id i6so17655221ybu.8;
        Tue, 21 Mar 2023 08:40:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9dq3YzpLlv029TIAJNSgXPFFvKgJdFBgg+8/p6dF1nJpoqlRRzC
        RbTvnfnm9YB0sb1dbr52Ghwe5IHv9gVLnMfC+w==
X-Google-Smtp-Source: AKy350Z6P7aO5NrByvT7rh8zp3VXUqzBD9E1d6xjhBHvPz0sHMvRFfWiM44tqXup5LqtZLP44OgpN/dkvvgqIjXYIzQ=
X-Received: by 2002:a05:6902:706:b0:b6d:9e38:1017 with SMTP id
 k6-20020a056902070600b00b6d9e381017mr1567031ybt.1.1679413210325; Tue, 21 Mar
 2023 08:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230321151642.461618-1-eajames@linux.ibm.com> <20230321151642.461618-2-eajames@linux.ibm.com>
In-Reply-To: <20230321151642.461618-2-eajames@linux.ibm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Mar 2023 10:39:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJR2BOX4sk0K3V7-12Pi7Th0G_Dqjfp_MxxoCf0qnNg0A@mail.gmail.com>
Message-ID: <CAL_JsqJR2BOX4sk0K3V7-12Pi7Th0G_Dqjfp_MxxoCf0qnNg0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] eeprom: ee1004: Enable devices on multiple busses
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
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

On Tue, Mar 21, 2023 at 10:17=E2=80=AFAM Eddie James <eajames@linux.ibm.com=
> wrote:
>
> The driver previously prevented probing devices on more than one
> bus due to locking constraints with the special page addresses. This
> constraint can be removed by allocating a reference-counted bus
> structure containing the lock, rather than using global variables.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/misc/eeprom/ee1004.c | 175 +++++++++++++++++++++--------------
>  1 file changed, 106 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index c8c6deb7ed89..950813821087 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -9,12 +9,15 @@
>   * Copyright (C) 2008 Wolfram Sang, Pengutronix
>   */
>
> +#include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>

What do you need from here? I don't see anything.

of_device.h is a mess of implicit includes which I'm currently trying
to detangle. See the ~13 year old comment in it about removing
of_platform.h include. When I'm done, pretty much only bus
implementations should include of_device.h.

Rob
