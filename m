Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D16734331
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbjFQStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFQStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2E139;
        Sat, 17 Jun 2023 11:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22BD60E05;
        Sat, 17 Jun 2023 18:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D829DC433C0;
        Sat, 17 Jun 2023 18:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027758;
        bh=juJml5zp0/KVA49PSBk/X2QkCMRvnLk1esmJD55Wk0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FybeXQwIIcJEiezzLLvi1D4S62KBiZr0uop1G77/KWtQUbF01467Svw0rqohE5JEm
         9sEBUwDDQIjNt7vddWnJIGmrBaumnWgYAbDSQQG2gTgGQFx40+cVoUdRw7nICapudh
         SWbec3puSwLEnM2X71NxRlmxy5eZj4X9EPYEYIp6W9WdMQ8ZOgZHMPUr6rRVPFc6kF
         IEVw+yiB/w8MoN9XtjfIKbobVBd5kioyG83Rys8uB0B2YeEyVhB281pZuQ5Gwik+WO
         IfE28J5YwRNr/LNLkrTQlyCipSqkth87KTZeyuKs0ikT9WCVR0AV2Lxe1zE0uK+3HE
         d1oEDndmpeVPQ==
Date:   Sat, 17 Jun 2023 19:49:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: st_sensors: Remove some redundant includes in
 st_sensors.h
Message-ID: <20230617194911.7963bd6d@jic23-huawei>
In-Reply-To: <bd7fa0b07c85172ecba384e239cb0ecf0780766a.1686600780.git.christophe.jaillet@wanadoo.fr>
References: <045ca726a9108325a3eaace807a264170895686c.1686600780.git.christophe.jaillet@wanadoo.fr>
        <bd7fa0b07c85172ecba384e239cb0ecf0780766a.1686600780.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 22:13:37 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> There is no need to include i2c.h and spi/spi.h in st_sensors.h.
> Should it be needed, st_sensors_(i2c|spi).h should be used.
Agreed these should be dropped from here.

But I don't agree with statement that i2c.h and spi/spi.h should
be gotten implicitly from st_sensors_i2c.h / st_sensors_spi.h
If they are needed the should be included directly in the files
where they are needed.

Jonathan

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Based on one of my script, this reduces the number of included files from
> 573 files to 515 files when compiling drivers/iio/accel/st_accel_buffer.c
> ---
>  include/linux/iio/common/st_sensors.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 607c3a89a647..a1d3d57d6d6e 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -10,8 +10,6 @@
>  #ifndef ST_SENSORS_H
>  #define ST_SENSORS_H
>  
> -#include <linux/i2c.h>
> -#include <linux/spi/spi.h>
>  #include <linux/irqreturn.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>

