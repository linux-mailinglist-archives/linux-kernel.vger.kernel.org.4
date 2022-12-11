Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324F64944F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiLKNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLKNEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:04:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08112E0EE;
        Sun, 11 Dec 2022 05:04:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2392CCE0B3C;
        Sun, 11 Dec 2022 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583E3C433EF;
        Sun, 11 Dec 2022 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670763872;
        bh=rjulAWcB0oewyoruaQq0t/DRG1FGCBitINMFcj8ZIA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g5o50Y7macok3FyLB64HZwwbZ0nNmAIsrM5vxMTe5Kh3j2lTKPWfyT/DPi/bwfTa2
         E1B7wjTTzHyFG0NdgjW3l0yNwdUqijl559AwMVooJtLCp8XzzImzKFm9BLpOq/z6IC
         ng7YsjJJNvpwyW9YyXxrg49wxHpOCwoEiqQ/XLkRpLSwuB0sFMxD7d5+3nQlSzEpox
         9p2y2BnTS/LHqWLJVPxLqGEXhF/M4dJCS+oHOKhp9oTVBxu9S5ZBr83n6O5pn30313
         ytR584F7STiCQg753JUaVLa21MqZ09EgS5YJU/HasLGNw70Lh4zyyGJmj6A5iJNu/I
         1r7hPyUfHhr3Q==
Date:   Sun, 11 Dec 2022 13:17:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 03/11] iio: light: tsl2563: Configure INT in one
 place
Message-ID: <20221211131727.24ac49d2@jic23-huawei>
In-Reply-To: <20221207190348.9347-3-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
        <20221207190348.9347-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Dec 2022 21:03:40 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Introduce tsl2563_configure_irq() to configure INT in one place.
> 
> While at it, make use of TSL2563_INT_LEVEL and newly introduced
> TSL2563_INT_MASK.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Ferry Toth <ftoth@exalondelft.nl>
Trivial note on a further improvement inline.

LGTM
> ---
>  drivers/iio/light/tsl2563.c | 42 ++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index d836c15ba777..d071805239ef 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -69,6 +69,7 @@
>  
>  #define TSL2563_INT_DISABLED	0x00
>  #define TSL2563_INT_LEVEL	0x10
> +#define TSL2563_INT_MASK	0x30

Better to use GENMASK etc, but given age of driver I'm not surprised no one
has made the conversion to that and FIELD_GET/ FIELD_PREP.

Nice follow up if anyone is bored enough ;)


>  #define TSL2563_INT_PERSIST(n)	((n) & 0x0F)
>  

