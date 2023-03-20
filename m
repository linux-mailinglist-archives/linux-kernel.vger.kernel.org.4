Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCAF6C0C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCTIXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCTIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:23:17 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D0919C4A;
        Mon, 20 Mar 2023 01:23:14 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 99C83D25;
        Mon, 20 Mar 2023 09:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1679300591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7p3GshOWFUfQDgDGYql3a7aiSxpAejgoQOR+iS4cbU=;
        b=s2gpV8HtUhm4w+PWU7PHEwT6COKkNpdDK951SSXxFysdn4BTK/cdj7OutITFWKFgLbJm/r
        hCUo5dlxsj7hjjESNVX/moyMfBic1bcN1C1bosuNelC4+wMj8rFWJ0Zu0ZwY5ZlJhGWT8h
        6hbkFJM0xRQAFzB/ESfoSSUyBQcx+aNVevqB6GCR5Xrhj3ybxOPdKhl3lOYKNOqPkcD5/K
        rHFGgclMYqxpDmBhIMIvSCztcaiyMHMsScx7XRK5fXkxUxQrmSCuxNIiZvHEoJ990fb6yq
        M/PDTgmEMf44thm7Kq2rEGlcIOBLKQsju9BvfBx0XoQ+gXPElkGaHmC91jXzig==
MIME-Version: 1.0
Date:   Mon, 20 Mar 2023 09:23:11 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ra?= =?UTF-8?Q?fa=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH V4 3/4] nvmem: core: export nvmem_add_cells_from_of()
In-Reply-To: <20230317132620.31142-4-zajec5@gmail.com>
References: <20230317132620.31142-1-zajec5@gmail.com>
 <20230317132620.31142-4-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <01b2adc922951f7d8cd74bc7bb1b42f1@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-17 14:26, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This symbol can be cleanly re-used by the fixed NVMEM layout driver.
> Allow passing DT node as argument to make it a bit more generic.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/nvmem/core.c           | 7 ++++---
>  include/linux/nvmem-provider.h | 7 +++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 212c5ba5789f..985a42cfb0a2 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -694,7 +694,7 @@ static int nvmem_validate_keepouts(struct
> nvmem_device *nvmem)
>  	return 0;
>  }
> 
> -static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
> +int nvmem_add_cells_from_of(struct nvmem_device *nvmem, struct 
> device_node *np)

I'm not sure, how to feel about exposing an "internal" function to
the layouts module. I mean all these nvmem_add_cells_from_* are internal
to the core. Also the help text of the add_cells() callback tells you to
use nvmem_add_one_cell().

Although there is a bit of code duplication, I'd rather refactor
the nvmem_add_cells_from_of() to split it into parsing and adding.
Then re-use just the parsing from the fixed layout module and
call the appropriate nvmem_add_one_cell() yourself there.

-michael
