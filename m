Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E742E626AE9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKLRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:37:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292DBBF;
        Sat, 12 Nov 2022 09:37:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71CBDB80989;
        Sat, 12 Nov 2022 17:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC8C433C1;
        Sat, 12 Nov 2022 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668274660;
        bh=qFlagUlNT8sMkPJSQL0Q9To0a6qPqsLDFfKwQFSbbxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ox0U/r7vY0S3/KbbCfr/6X8PjV/w1zIdCcTJRwsQrlKpzsjNtwQJnY3zu6xxGyLKx
         NrJZbjmDNuBkRORZeR/k3k9zPejWhMH0rpSNDhB3Y34DAMf7y3JbVX8Ptv2A1qSunK
         8koFxdav2JjNt5kvlgHQRzTPX7GGtMdYylfg4ZOBhF6nr/5xGYbfoBASXYhLmRJEk1
         gp9ne92qqDkgH6LujmadHkoPGge/O/+72U3I64lan4RilcRN+QdHzyksGfyCRPjNaT
         I3Rt3M3TZ9veg0C/2392Tp246hW34qA+GBsDjEjRU83PasgEYC4MtiOp6F30/yuNK0
         7OSaxoadxg6Iw==
Date:   Sat, 12 Nov 2022 17:49:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dong Chenchen <dongchenchen2@huawei.com>, dan@dlrobertson.com,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuehaibing@huawei.com
Subject: Re: [Patch] iio: accel: bma400: Fix memory leak in
 bma400_get_steps_reg()
Message-ID: <20221112174955.2d1d294a@jic23-huawei>
In-Reply-To: <CAM+2EuLVr3ncC3FomFMxQnBzdVnEU+gcjJ9Q9cKwz6W8OX5H=w@mail.gmail.com>
References: <20221110010726.235601-1-dongchenchen2@huawei.com>
        <CAM+2EuLVr3ncC3FomFMxQnBzdVnEU+gcjJ9Q9cKwz6W8OX5H=w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 23:12:32 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> On Thu, Nov 10, 2022 at 6:37 AM Dong Chenchen <dongchenchen2@huawei.com> wrote:
> >
> > When regmap_bulk_read() fails, it does not free steps_raw,
> > which will cause a memory leak issue, this patch fixes it.
> >
> > Fixes: d221de60eee3 ("iio: accel: bma400: Add separate channel for step counter")
> > Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>  
> 
> Reviewed-by: Jagath Jog J <jagathjog1996@gmail.com>
> 
> Thanks for catching this

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> Regards,
> Jagath
> 
> > ---
> >  drivers/iio/accel/bma400_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index ad8fce3e08cd..43976cf5a91b 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -805,8 +805,10 @@ static int bma400_get_steps_reg(struct bma400_data *data, int *val)
> >
> >         ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
> >                                steps_raw, BMA400_STEP_RAW_LEN);
> > -       if (ret)
> > +       if (ret) {
> > +               kfree(steps_raw);
> >                 return ret;
> > +       }
> >         *val = get_unaligned_le24(steps_raw);
> >         kfree(steps_raw);
> >         return IIO_VAL_INT;
> > --
> > 2.25.1
> >  

